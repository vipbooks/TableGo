<#-- 用于生成菜单和按钮SQL的自定义模板 -->
<#-- 初始化需要导入导出Excel的字段 -->
<#assign importAndExportFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.importAndExportFields) />
-- <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>菜单和按钮 SQL

-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, update_by, update_time, remark)
values('${tableInfo.simpleRemark!tableInfo.tableName}', '5', '1', '/${jsonParam.moduleName}/${tableInfo.lowerCamelCase}', 'C', '0', '${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:view', '#', 'admin', sysdate(), null, null, '${tableInfo.simpleRemark!tableInfo.tableName}菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, update_by, update_time, remark)
values('${tableInfo.simpleRemark!tableInfo.tableName}查询', @parentId, '1', '#', 'F', '0', '${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:list', '#', 'admin', sysdate(), null, null, null);

insert into sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, update_by, update_time, remark)
values('${tableInfo.simpleRemark!tableInfo.tableName}新增', @parentId, '2', '#', 'F', '0', '${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:add', '#', 'admin', sysdate(), null, null, null);

insert into sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, update_by, update_time, remark)
values('${tableInfo.simpleRemark!tableInfo.tableName}修改', @parentId, '3', '#', 'F', '0', '${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:edit', '#', 'admin', sysdate(), null, null, null);

insert into sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, update_by, update_time, remark)
values('${tableInfo.simpleRemark!tableInfo.tableName}删除', @parentId, '4', '#', 'F', '0', '${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:remove', '#', 'admin', sysdate(), null, null, null);
<#if FtlUtils.fieldAtListExisted(tableInfo, importAndExportFields)>

insert into sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, update_by, update_time, remark)
values('${tableInfo.simpleRemark!tableInfo.tableName}导入', @parentId, '5',  '#',  'F', '0', '${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:import', '#', 'admin', sysdate(), null, null, null);

insert into sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, update_by, update_time, remark)
values('${tableInfo.simpleRemark!tableInfo.tableName}导出', @parentId, '6',  '#',  'F', '0', '${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:export', '#', 'admin', sysdate(), null, null, null);
</#if>