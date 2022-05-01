<#-- 用于生成 Ant Design Vue 编辑页面的自定义模板 -->
<#-- 初始化Form表单字段 -->
<#assign formFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.formFields) />
<#if tableInfo.simpleRemark?has_content><!-- ${tableInfo.simpleRemark}编辑页面 --></#if>
<template>
  <a-card>
    <a-form :form="form">
      <a-row :gutter="48">
    <#list formFields as fieldName>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
                <#if fieldInfo.isDictType || fieldInfo.javaType?contains("Enum")>
        <a-col :md="${jsonParam.mdSize!8}" :sm="24">
          <a-form-item label="${fieldInfo.simpleRemark}">
            <a-select
                allowClear
                style="width: 100%"
                placeholder="请选择${fieldInfo.simpleRemark}"
                v-decorator="['${fieldInfo.proName}', {rules: [{ required: <#if fieldInfo.isNotNull>true<#else>false</#if>, message: '请选择${fieldInfo.simpleRemark}' }]}]"
            >
              <!-- // TODO: 下拉框数据 -->
            </a-select>
          </a-form-item>
        </a-col>
                <#elseif fieldInfo.isNumericType>
        <a-col :md="${jsonParam.mdSize!8}" :sm="24">
          <a-form-item label="${fieldInfo.simpleRemark}">
            <a-input-number
                style="width: 100%"
                :min="0"
                placeholder="请输入${fieldInfo.simpleRemark}"
                v-decorator="['${fieldInfo.proName}', {rules: [{ required: <#if fieldInfo.isNotNull>true<#else>false</#if>, message: '请输入${fieldInfo.simpleRemark}' }]}]"
            />
          </a-form-item>
        </a-col>
                <#elseif fieldInfo.javaType == "Date">
        <a-col :md="${jsonParam.mdSize!8}" :sm="24">
          <a-form-item label="${fieldInfo.simpleRemark}">
            <a-date-picker
                style="width: 100%"
                placeholder="请选择${fieldInfo.simpleRemark}"
                format="YYYY-MM-DD"
                v-decorator="['${fieldInfo.proName}', {rules: [{ required: <#if fieldInfo.isNotNull>true<#else>false</#if>, message: '请选择${fieldInfo.simpleRemark}' }]}]"
            />
          </a-form-item>
        </a-col>
                <#elseif fieldInfo.isMultiLineType>
        <a-col :md="${jsonParam.mdSize!8}" :sm="24">
          <a-form-item label="${fieldInfo.simpleRemark}">
            <a-textarea
                placeholder="请输入${fieldInfo.simpleRemark}"
                :rows="3"
                v-decorator="['${fieldInfo.proName}', {rules: [{ required: <#if fieldInfo.isNotNull>true<#else>false</#if>, message: '请输入${fieldInfo.simpleRemark}' }]}]" />
          </a-form-item>
        </a-col>
                <#else>
        <a-col :md="${jsonParam.mdSize!8}" :sm="24">
          <a-form-item label="${fieldInfo.simpleRemark}">
            <a-input
                placeholder="请输入${fieldInfo.simpleRemark}"
                v-decorator="['${fieldInfo.proName}', {rules: [{ required: <#if fieldInfo.isNotNull>true<#else>false</#if>, message: '请输入${fieldInfo.simpleRemark}' }]}]"
            />
          </a-form-item>
        </a-col>
                </#if>
            </#if>
        </#list>
    </#list>
      </a-row>
    </a-form>
    <footer-tool-bar
        :style="{ width: isSideMenu() && isDesktop() ? `calc(100% - ${"$"}{sidebarOpened ? 256 : 80}px)` : '100%'}"
    >
      <div class="pro-button-group">
        <a-button
            type="primary"
            @click="handleSubmit"
            :loading="loading"
        >提交
        </a-button>
        <a-button @click="handleGoBack">返回</a-button>
      </div>
    </footer-tool-bar>
  </a-card>
</template>

<script>

import moment from 'moment'
import FooterToolBar from '@/components/FooterToolbar'
import { mixin, mixinDevice } from '@/utils/mixin'
import { pick } from '@/utils/util'
import { get${tableInfo.upperCamelCase}ById, update${tableInfo.upperCamelCase} } from '@/api/${jsonParam.basePath}/${tableInfo.lowerCamelCase}'

export default {
  name: '${tableInfo.upperCamelCase}Add',
  mixins: [mixin, mixinDevice],
  components: {
    FooterToolBar
  },
  data () {
    return {
      form: this.$form.createForm(this),
      loading: false,
      moment
    }
  },
  created () {
    this.loadData()
  },
  methods: {
    /**
     * 加载数据
     */
    loadData () {
      let {${tableInfo.pkLowerCamelName}} = this.$route.query;
      if (${tableInfo.pkLowerCamelName}) {
        get${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName}).then(res => {
          if (res.data) {
            // TODO: 处理数据

            this.form.setFieldsValue(pick(res.data, [
                <#list formFields as fieldName><#list tableInfo.fieldInfos as fieldInfo><#if StringUtils.equalsIgnoreCase(fieldInfo.colName, fieldName)>'${fieldInfo.proName}'<#if fieldName_has_next>, </#if></#if></#list></#list>
            ]))
          }
        })
      }
    },
    /**
     * 处理返回
     */
    handleGoBack () {
      this.$router.back()
    },
    /**
     * 处理表单提交
     */
    handleSubmit () {
      const {
        form: { validateFields }
      } = this
      validateFields((err, values) => {
        if (!err) {
          // TODO: 提交前处理数据

          update${tableInfo.upperCamelCase}(values).then(res => {
            // TODO: 处理结果数据

            this.loading = false
            this.handleGoBack()
          }).finally(err => {
            this.loading = false
          }).catch(e => {
            console.error('update${tableInfo.upperCamelCase}', e)
          })
        }
      })
    }
  }
}
</script>

<style scoped>
</style>
