<#-- 用于生成主菜单SQL的自定义模板 -->
-- ${jsonParam.description}主菜单 SQL
insert into sys_menu (menu_id, menu_name, parent_id, order_num, url, menu_type, visible, icon, create_by, create_time, update_by, update_time, remark)
values('5', '${jsonParam.description}', '0', '5', '#', 'M', '0', 'fa fa-briefcase', 'admin', sysdate(), null, null, '${jsonParam.description}目录');
