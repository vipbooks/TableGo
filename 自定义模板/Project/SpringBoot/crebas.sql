-- drop database if exists demo;
-- create database demo;
-- use demo;

drop table if exists t_user;

drop table if exists t_sys_param;

drop table if exists t_department;

drop table if exists t_dict_type;

drop table if exists t_dictionary;

drop table if exists t_province;

drop table if exists t_city;

drop table if exists t_area;

/*==============================================================*/
/* table: t_user                                                */
/*==============================================================*/
create table t_user (
   id                   varchar(36) not null comment '主键ID',
   username             varchar(64) not null comment '用户名',
   full_name            varchar(36) not null comment '姓名',
   mobile_phone         varchar(36) not null comment '移动电话',
   id_card              varchar(36) default null comment '身份证',
   email                varchar(36) default null comment '电子邮箱',
   birthday             date default null comment '出生日期',
   tenant_code          varchar(64) comment '租户编码',
   created_by           varchar(36) comment '创建人',
   created_time         datetime not null default current_timestamp comment '创建时间',
   last_updated_by      varchar(36) comment '最后修改人',
   last_updated_time    datetime not null default current_timestamp on update current_timestamp comment '最后修改时间',
   is_deleted           tinyint not null default 0 comment '是否删除，0：未删除；1：已删除',
   primary key (id),
   unique key uk_user_username (username)
);

alter table t_user comment '用户';

/*==============================================================*/
/* table: t_sys_param                                           */
/*==============================================================*/
create table t_sys_param
(
   id                   varchar(36) not null comment '主键ID',
   param_name           varchar(64) not null comment '参数名称',
   param_code           varchar(36) not null comment '参数编码',
   param_type           varchar(36) not null comment '参数类型',
   param_value1         varchar(500) comment '参数值1',
   param_value2         varchar(500) comment '参数值2',
   param_value3         varchar(500) comment '参数值3',
   remark               varchar(1000) comment '备注',
   tenant_code          varchar(64) comment '租户编码',
   created_by           varchar(36) comment '创建人',
   created_time         datetime not null default current_timestamp comment '创建时间',
   last_updated_by      varchar(36) comment '最后修改人',
   last_updated_time    datetime not null default current_timestamp on update current_timestamp comment '最后修改时间',
   is_deleted           tinyint not null default 0 comment '是否删除，0：未删除；1：已删除',
   primary key (id),
   unique key uk_param_code (param_code)
);

alter table t_sys_param comment '系统参数';

/*==============================================================*/
/* table: t_department                                          */
/*==============================================================*/
create table t_department
(
   id                   varchar(36) not null comment '主键ID',
   parent_id            varchar(36) not null comment '父ID',
   dept_name            varchar(64) not null comment '部门名称',
   dept_code            varchar(64) not null comment '部门编码',
   sort_no              int default 1 comment '排序',
   tenant_code          varchar(64) comment '租户编码',
   created_by           varchar(36) comment '创建人',
   created_time         datetime not null default current_timestamp comment '创建时间',
   last_updated_by      varchar(36) comment '最后修改人',
   last_updated_time    datetime not null default current_timestamp on update current_timestamp comment '最后修改时间',
   is_deleted           tinyint not null default 0 comment '是否删除，0：未删除；1：已删除',
   primary key (id),
   unique key uk_dept_code (dept_code)
);

alter table t_department comment '部门';

/*==============================================================*/
/* table: t_dict_type                                           */
/*==============================================================*/
create table t_dict_type
(
   id                   varchar(36) not null comment '主键ID',
   type_name            varchar(64) not null comment '类型名称',
   type_code            varchar(64) not null comment '类型编码',
   remark               varchar(1000) comment '备注',
   created_by           varchar(36) comment '创建人',
   created_time         datetime not null default current_timestamp comment '创建时间',
   last_updated_by      varchar(36) comment '最后修改人',
   last_updated_time    datetime not null default current_timestamp on update current_timestamp comment '最后修改时间',
   is_deleted           tinyint not null default 0 comment '是否删除，0：未删除；1：已删除',
   primary key (id),
   unique key uk_dicttype_type_code (type_code)
);

alter table t_dict_type comment '字典类型';

/*==============================================================*/
/* table: t_dictionary                                          */
/*==============================================================*/
create table t_dictionary
(
   id                   varchar(36) not null comment '主键ID',
   dict_type_id         varchar(64) not null comment '字典类型ID',
   dict_name            varchar(64) not null comment '字典名称',
   dict_code            varchar(64) not null comment '字典编码',
   dict_value           varchar(64) not null comment '字典值',
   sort_no              int default 1 comment '排序',
   remark               varchar(1000) comment '备注',
   created_by           varchar(36) comment '创建人',
   created_time         datetime not null default current_timestamp comment '创建时间',
   last_updated_by      varchar(36) comment '最后修改人',
   last_updated_time    datetime not null default current_timestamp on update current_timestamp comment '最后修改时间',
   is_deleted           tinyint not null default 0 comment '是否删除，0：未删除；1：已删除',
   primary key (id),
   unique key uk_dictionary (dict_type_id, dict_code)
);

alter table t_dictionary comment '字典项';

/*==============================================================*/
/* table: t_province                                            */
/*==============================================================*/
create table t_province
(
   id                   varchar(36) not null comment '主键ID',
   province_code        varchar(36) not null comment '省份编码',
   province_name        varchar(64) not null comment '省份名称',
   tenant_code          varchar(64) comment '租户编码',
   created_by           varchar(36) comment '创建人',
   created_time         datetime not null default current_timestamp comment '创建时间',
   last_updated_by      varchar(36) comment '最后修改人',
   last_updated_time    datetime not null default current_timestamp on update current_timestamp comment '最后修改时间',
   is_deleted           tinyint not null default 0 comment '是否删除，0：未删除；1：已删除',
   primary key (id),
   unique key uk_province_code (province_code)
);

alter table t_province comment '省份';

/*==============================================================*/
/* table: t_city                                                */
/*==============================================================*/
create table t_city
(
   id                   varchar(36) not null comment '主键ID',
   city_code            varchar(36) not null comment '市区编码',
   city_name            varchar(64) not null comment '市区名称',
   parent_code          varchar(36) not null comment '父编码',
   tenant_code          varchar(64) comment '租户编码',
   created_by           varchar(36) comment '创建人',
   created_time         datetime not null default current_timestamp comment '创建时间',
   last_updated_by      varchar(36) comment '最后修改人',
   last_updated_time    datetime not null default current_timestamp on update current_timestamp comment '最后修改时间',
   is_deleted           tinyint not null default 0 comment '是否删除，0：未删除；1：已删除',
   primary key (id),
   unique key uk_city_code (city_code)
);

alter table t_city comment '市区';

/*==============================================================*/
/* table: t_area                                                */
/*==============================================================*/
create table t_area
(
   id                   varchar(36) not null comment '主键ID',
   area_code            varchar(36) not null comment '地区编码',
   area_name            varchar(64) not null comment '地区名称',
   parent_code          varchar(36) not null comment '父编码',
   tenant_code          varchar(64) comment '租户编码',
   created_by           varchar(36) comment '创建人',
   created_time         datetime not null default current_timestamp comment '创建时间',
   last_updated_by      varchar(36) comment '最后修改人',
   last_updated_time    datetime not null default current_timestamp on update current_timestamp comment '最后修改时间',
   is_deleted           tinyint not null default 0 comment '是否删除，0：未删除；1：已删除',
   primary key (id),
   unique key uk_area_code (area_code)
);

alter table t_area comment '地区';
