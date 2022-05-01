<#-- 用于生成 Ant Design Vue 详情页面的自定义模板 -->
<#-- 初始化Form表单字段 -->
<#assign formFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.formFields) />
<#if tableInfo.simpleRemark?has_content><!-- ${tableInfo.simpleRemark}详情页面 --></#if>
<template>
  <a-card :bordered="false">
    <detail-list>
    <#list formFields as fieldName>
        <#list tableInfo.fieldInfos as fieldInfo>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
      <detail-item-list term="${fieldInfo.simpleRemark}">{{ data.${fieldInfo.proName} }}</detail-item-list>
            </#if>
        </#list>
    </#list>
    </detail-list>
    <footer-tool-bar
        :style="{ width: isSideMenu() && isDesktop() ? `calc(100% - ${"$"}{sidebarOpened ? 256 : 80}px)` : '100%'}">
      <a-button style="margin-left: 8px" @click="handleGoBack">返回</a-button>
    </footer-tool-bar>
  </a-card>
</template>

<script>

import { DetailList } from '@/components'
import { mixin, mixinDevice } from '@/utils/mixin'
import FooterToolBar from '@/components/FooterToolbar'
import { get${tableInfo.upperCamelCase}ById } from '@/api/${jsonParam.basePath}/${tableInfo.lowerCamelCase}'

export default {
  name: '${tableInfo.upperCamelCase}Detail',
  mixins: [mixin, mixinDevice],
  components: {
    DetailList,
    DetailItemList: DetailList.Item,
    FooterToolBar
  },
  data () {
    return {
      data: {}
    }
  },
  mounted () {
    this.loadData()
  },
  methods: {
    /**
     * 加载数据
     */
    loadData () {
      let {${tableInfo.pkLowerCamelName}} = this.$route.query
      if (${tableInfo.pkLowerCamelName}) {
        get${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName}).then(res => {
          if (res.data) {

            // TODO: 处理数据

            this.data = res.data
          }
        })
      }
    },

    /**
     * 处理返回
     */
    handleGoBack () {
      this.$router.back()
    }
  }
}
</script>

<style scoped>

</style>
