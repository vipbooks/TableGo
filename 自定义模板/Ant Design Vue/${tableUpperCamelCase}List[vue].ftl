<#-- 用于生成 Ant Design Vue 列表管理页面的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFeilds = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFeilds) />
<#-- 初始化列表显示的字段 -->
<#assign listFeilds = FtlUtils.getJsonFieldList(tableInfo, jsonParam.listFeilds) />
<#if tableInfo.simpleRemark?has_content><!-- ${tableInfo.simpleRemark}列表管理页面 --></#if>
<template>
  <a-card :bordered="false">
<#if searchFeilds?has_content>
    <div class="table-page-search-wrapper">
      <a-form layout="inline">
        <a-row :gutter="48">
    <#assign loopCount = 0>
    <#list searchFeilds as fieldName>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
                <#if loopCount == jsonParam.advancedIndex!2>

          <template v-if="advanced">
                </#if>
                <#if fieldInfo.isDictType || fieldInfo.javaType?contains("Enum")>
          <a-col :md="${jsonParam.mdSize!8}" :sm="24">
            <a-form-item label="${fieldInfo.simpleRemark}">
              <a-select
                  allowClear
                  style="width: 100%"
                  placeholder="请选择${fieldInfo.simpleRemark}"
                  v-model="queryParam.${fieldInfo.proName}"
              >
                <!-- // TODO: 下拉框数据 -->
              </a-select>
            </a-form-item>
          </a-col>
                <#elseif fieldInfo.isNumericType>
          <a-col :md="${jsonParam.mdSize!8}" :sm="24">
            <a-form-item label="${fieldInfo.simpleRemark}">
              <a-input-number placeholder="请输入${fieldInfo.simpleRemark}" v-model="queryParam.${fieldInfo.proName}" />
            </a-form-item>
          </a-col>
                <#elseif fieldInfo.javaType == "Date">
          <a-col :md="${jsonParam.mdSize!8}" :sm="24">
            <a-form-item label="${fieldInfo.simpleRemark}">
              <a-date-picker
                  style="width: 100%"
                  placeholder="请选择${fieldInfo.simpleRemark}"
                  format="YYYY-MM-DD"
                  v-model="queryParam.${fieldInfo.proName}"
              />
            </a-form-item>
          </a-col>
                <#else>
          <a-col :md="${jsonParam.mdSize!8}" :sm="24">
            <a-form-item label="${fieldInfo.simpleRemark}">
              <a-input placeholder="请输入${fieldInfo.simpleRemark}" v-model="queryParam.${fieldInfo.proName}" />
            </a-form-item>
          </a-col>
                </#if>
                <#assign loopCount = loopCount + 1>
            </#if>
        </#list>
    </#list>
    <#if loopCount &gt;= jsonParam.advancedIndex!2>
          </template>
    </#if>

          <a-col :md="!advanced && ${24 - (jsonParam.advancedIndex!2%(24/jsonParam.mdSize!8)) * jsonParam.mdSize!8} || ${24 - (searchFeilds?size%(24/jsonParam.mdSize!8)) * jsonParam.mdSize!8}" :sm="24">
            <span class="table-page-search-submitButtons" style="float: right; overflow: hidden;">
              <a-button type="primary" @click="onSearch">查询</a-button>
              <a-button style="margin-left: 8px" @click="clearQueryParam">重置</a-button>
              <a @click="toggleAdvanced" style="margin-left: 8px">
                {{ advanced ? '收起' : '展开' }}
                <a-icon :type="advanced ? 'up' : 'down'" />
              </a>
            </span>
          </a-col>
        </a-row>
      </a-form>
    </div>
</#if>

    <div class="table-operator">
      <!-- // TODO: 配置新增的路由 -->
      <router-link to="/${tableInfo.lowerCamelCase}/Add">
        <a-button type="primary" icon="plus">新增</a-button>
      </router-link>
    </div>

    <s-table
        ref="table"
        rowKey="id"
        :columns="columns"
        :data="loadData"
        class="pro-table ellipsis nowrap fixed"
    >
      <!-- // TODO: 是否需要自定义列 -->
    </s-table>

  </a-card>
</template>

<script>

import store from '@/store'
import { STable } from '@/components'
import { list${tableInfo.upperCamelCase}Page } from '@/api/${jsonParam.basePath}/${tableInfo.lowerCamelCase}'

export default {
  name: '${tableInfo.upperCamelCase}List',
  components: {
    STable
  },
  data () {
    return {
      // 高级搜索 展开/关闭
      advanced: false,
      // 查询参数
      queryParam: {},
      // 表头
      columns: [
<#if listFeilds?has_content>
    <#list searchFeilds as fieldName>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if StringUtils.equalsIgnoreCase(fieldInfo.colName, fieldName)>
        {
          title: '${fieldInfo.simpleRemark}',
          dataIndex: '${fieldInfo.proName}',
          width: 120
        }<#if fieldName_has_next>,</#if>
            </#if>
        </#list>
    </#list>
</#if>
      ],
      // 加载数据方法 必须为 Promise 对象
      loadData: parameter => {

        // 设置查询缓存
        store.dispatch('SetPageQueryParam', { path: this.$route.path, queryParam: this.queryParam })
        const params = Object.assign(parameter, this.queryParam)

        // TODO: 是否处理查询数据

        return list${tableInfo.upperCamelCase}Page(params).then(res => {
          return res.data
        }).catch(err => {
          console.error('list${tableInfo.upperCamelCase}Page catch ', err)
        })
      }
    }
  },
  created () {
    //初始化组件获取查询缓存
    if (store.getters.pageQueryParam.has(this.$route.path)) {
      this.queryParam = store.getters.pageQueryParam.get(this.$route.path)
    }
  },
  methods: {
    /**
     * 查询
     */
    onSearch () {
      this.$refs.table.refresh(true)
    },
    /**
     * 清空查询参数
     */
    clearQueryParam () {
      this.queryParam = {}
      this.$refs.table.refresh(true)
    },
    /**
     * 切换展开
     */
    toggleAdvanced () {
      this.advanced = !this.advanced
    }
  }
}
</script>

<style scoped>

</style>
