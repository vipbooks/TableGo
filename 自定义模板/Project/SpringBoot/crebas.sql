-- DROP DATABASE IF EXISTS test;
-- CREATE DATABASE test;
-- USE test;

DROP TABLE IF EXISTS T_USER;

DROP TABLE IF EXISTS T_SYS_PARAM;

DROP TABLE IF EXISTS T_DEPARTMENT;

DROP TABLE IF EXISTS T_DICT_TYPE;

DROP TABLE IF EXISTS T_DICTIONARY;

DROP TABLE IF EXISTS T_PROVINCE;

DROP TABLE IF EXISTS T_CITY;

DROP TABLE IF EXISTS T_AREA;

/*==============================================================*/
/* Table: T_USER                                                */
/*==============================================================*/
CREATE TABLE T_USER (
   ID                   VARCHAR(36) NOT NULL COMMENT '主键ID',
   USERNAME             VARCHAR(64) NOT NULL COMMENT '用户名',
   FULL_NAME            VARCHAR(36) NOT NULL COMMENT '姓名',
   MOBILE_PHONE         VARCHAR(36) NOT NULL COMMENT '移动电话',
   ID_CARD              VARCHAR(36) DEFAULT NULL COMMENT '身份证',
   EMAIL                VARCHAR(36) DEFAULT NULL COMMENT '电子邮箱',
   BIRTHDAY             DATE DEFAULT NULL COMMENT '出生日期',
   TENANT_CODE          VARCHAR(64) COMMENT '租户编码',
   CREATED_BY           VARCHAR(36) COMMENT '创建人',
   CREATED_TIME         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   LAST_UPDATED_BY      VARCHAR(36) COMMENT '最后修改人',
   LAST_UPDATED_TIME    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
   DELETE_FLAG          SMALLINT NOT NULL DEFAULT 1 COMMENT '删除标记，0：已删除、1：未删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_USERNAME_UNIQUE (USERNAME)
);

ALTER TABLE T_USER COMMENT '用户';

/*==============================================================*/
/* Table: T_SYS_PARAM                                           */
/*==============================================================*/
CREATE TABLE T_SYS_PARAM
(
   ID                   VARCHAR(36) NOT NULL COMMENT '主键ID',
   PARAM_NAME           VARCHAR(64) NOT NULL COMMENT '参数名称',
   PARAM_CODE           VARCHAR(36) NOT NULL COMMENT '参数编码',
   PARAM_TYPE           VARCHAR(36) NOT NULL COMMENT '参数类型',
   PARAM_VALUE1         VARCHAR(500) COMMENT '参数值1',
   PARAM_VALUE2         VARCHAR(500) COMMENT '参数值2',
   PARAM_VALUE3         VARCHAR(500) COMMENT '参数值3',
   REMARK               VARCHAR(1000) COMMENT '备注',
   TENANT_CODE          VARCHAR(64) COMMENT '租户编码',
   CREATED_BY           VARCHAR(36) COMMENT '创建人',
   CREATED_TIME         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   LAST_UPDATED_BY      VARCHAR(36) COMMENT '最后修改人',
   LAST_UPDATED_TIME    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
   DELETE_FLAG          SMALLINT NOT NULL DEFAULT 1 COMMENT '删除标记，0：已删除、1：未删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_PARAM_CODE_UNIQUE (PARAM_CODE)
);

ALTER TABLE T_SYS_PARAM COMMENT '系统参数';

/*==============================================================*/
/* Table: T_DEPARTMENT                                          */
/*==============================================================*/
CREATE TABLE T_DEPARTMENT
(
   ID                   VARCHAR(36) NOT NULL COMMENT '主键ID',
   PARENT_ID            VARCHAR(36) NOT NULL COMMENT '父ID',
   DEPT_NAME            VARCHAR(64) NOT NULL COMMENT '部门名称',
   DEPT_CODE            VARCHAR(64) NOT NULL COMMENT '部门编码',
   SORT_NO              INT DEFAULT 1 COMMENT '排序',
   TENANT_CODE          VARCHAR(64) COMMENT '租户编码',
   CREATED_BY           VARCHAR(36) COMMENT '创建人',
   CREATED_TIME         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   LAST_UPDATED_BY      VARCHAR(36) COMMENT '最后修改人',
   LAST_UPDATED_TIME    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
   DELETE_FLAG          SMALLINT NOT NULL DEFAULT 1 COMMENT '删除标记，0：已删除、1：未删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_DEPT_CODE_UNIQUE (DEPT_CODE)
);

ALTER TABLE T_DEPARTMENT COMMENT '部门';

/*==============================================================*/
/* Table: T_DICT_TYPE                                           */
/*==============================================================*/
CREATE TABLE T_DICT_TYPE
(
   ID                   VARCHAR(36) NOT NULL COMMENT '主键ID',
   TYPE_NAME            VARCHAR(64) NOT NULL COMMENT '类型名称',
   TYPE_CODE            VARCHAR(64) NOT NULL COMMENT '类型编码',
   REMARK               VARCHAR(1000) COMMENT '备注',
   CREATED_BY           VARCHAR(36) COMMENT '创建人',
   CREATED_TIME         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   LAST_UPDATED_BY      VARCHAR(36) COMMENT '最后修改人',
   LAST_UPDATED_TIME    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
   DELETE_FLAG          SMALLINT NOT NULL DEFAULT 1 COMMENT '删除标记，0：已删除、1：未删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_TYPE_CODE_UNIQUE (TYPE_CODE)
);

ALTER TABLE T_DICT_TYPE COMMENT '字典类型';

/*==============================================================*/
/* Table: T_DICTIONARY                                          */
/*==============================================================*/
CREATE TABLE T_DICTIONARY
(
   ID                   VARCHAR(36) NOT NULL COMMENT '主键ID',
   DICT_TYPE_CODE       VARCHAR(64) NOT NULL COMMENT '字典类型编码',
   DICT_NAME            VARCHAR(64) NOT NULL COMMENT '字典名称',
   DICT_CODE            VARCHAR(64) NOT NULL COMMENT '字典编码',
   DICT_VALUE           VARCHAR(64) NOT NULL COMMENT '字典值',
   SORT_NO              INT DEFAULT 1 COMMENT '排序',
   REMARK               VARCHAR(1000) COMMENT '备注',
   CREATED_BY           VARCHAR(36) COMMENT '创建人',
   CREATED_TIME         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   LAST_UPDATED_BY      VARCHAR(36) COMMENT '最后修改人',
   LAST_UPDATED_TIME    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
   DELETE_FLAG          SMALLINT NOT NULL DEFAULT 1 COMMENT '删除标记，0：已删除、1：未删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_DICTIONARY_UNIQUE (DICT_TYPE_CODE, DICT_CODE)
);

ALTER TABLE T_DICTIONARY COMMENT '字典项';

/*==============================================================*/
/* Table: T_PROVINCE                                            */
/*==============================================================*/
CREATE TABLE T_PROVINCE
(
   ID                   VARCHAR(36) NOT NULL COMMENT '主键ID',
   PROVINCE_CODE        VARCHAR(36) NOT NULL COMMENT '省份编码',
   PROVINCE_NAME        VARCHAR(64) NOT NULL COMMENT '省份名称',
   TENANT_CODE          VARCHAR(64) COMMENT '租户编码',
   CREATED_BY           VARCHAR(36) COMMENT '创建人',
   CREATED_TIME         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   LAST_UPDATED_BY      VARCHAR(36) COMMENT '最后修改人',
   LAST_UPDATED_TIME    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
   DELETE_FLAG          SMALLINT NOT NULL DEFAULT 1 COMMENT '删除标记，0：已删除、1：未删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_PROVINCE_CODE_UNIQUE (PROVINCE_CODE)
);

ALTER TABLE T_PROVINCE COMMENT '省份';

/*==============================================================*/
/* Table: T_CITY                                                */
/*==============================================================*/
CREATE TABLE T_CITY
(
   ID                   VARCHAR(36) NOT NULL COMMENT '主键ID',
   CITY_CODE            VARCHAR(36) NOT NULL COMMENT '市区编码',
   CITY_NAME            VARCHAR(64) NOT NULL COMMENT '市区名称',
   PARENT_CODE          VARCHAR(36) NOT NULL COMMENT '父编码',
   TENANT_CODE          VARCHAR(64) COMMENT '租户编码',
   CREATED_BY           VARCHAR(36) COMMENT '创建人',
   CREATED_TIME         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   LAST_UPDATED_BY      VARCHAR(36) COMMENT '最后修改人',
   LAST_UPDATED_TIME    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
   DELETE_FLAG          SMALLINT NOT NULL DEFAULT 1 COMMENT '删除标记，0：已删除、1：未删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_CITY_CODE_UNIQUE (CITY_CODE)
);

ALTER TABLE T_CITY COMMENT '市区';

/*==============================================================*/
/* Table: T_AREA                                                */
/*==============================================================*/
CREATE TABLE T_AREA
(
   ID                   VARCHAR(36) NOT NULL COMMENT '主键ID',
   AREA_CODE            VARCHAR(36) NOT NULL COMMENT '地区编码',
   AREA_NAME            VARCHAR(64) NOT NULL COMMENT '地区名称',
   PARENT_CODE          VARCHAR(36) NOT NULL COMMENT '父编码',
   TENANT_CODE          VARCHAR(64) COMMENT '租户编码',
   CREATED_BY           VARCHAR(36) COMMENT '创建人',
   CREATED_TIME         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   LAST_UPDATED_BY      VARCHAR(36) COMMENT '最后修改人',
   LAST_UPDATED_TIME    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
   DELETE_FLAG          SMALLINT NOT NULL DEFAULT 1 COMMENT '删除标记，0：已删除、1：未删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_AREA_CODE_UNIQUE (AREA_CODE)
);

ALTER TABLE T_AREA COMMENT '地区';
