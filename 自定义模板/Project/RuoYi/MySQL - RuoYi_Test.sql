/*==============================================================*/
/*                        若依项目测试SQL脚本                      */
/*==============================================================*/

DROP TABLE IF EXISTS T_AREA;

DROP TABLE IF EXISTS T_CITY;

DROP TABLE IF EXISTS T_PROVINCE;

DROP TABLE IF EXISTS T_SYS_PARAM;

/*==============================================================*/
/* Table: T_AREA                                                */
/*==============================================================*/
CREATE TABLE T_AREA
(
   ID                   BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '主键ID',
   AREA_CODE            VARCHAR(36) NOT NULL COMMENT '地区编码',
   AREA_NAME            VARCHAR(64) NOT NULL COMMENT '地区名称',
   PARENT_CODE          VARCHAR(36) NOT NULL COMMENT '父编码',
   CREATE_BY            VARCHAR(36) COMMENT '创建人',
   CREATE_TIME          DATETIME COMMENT '创建时间',
   UPDATE_BY      	 	VARCHAR(36) COMMENT '修改人',
   UPDATE_TIME     		DATETIME COMMENT '修改时间',
   DEL_FLAG          	SMALLINT NOT NULL DEFAULT 0 COMMENT '删除标记，0代表存在；2代表删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_AREA_CODE_UNIQUE (AREA_CODE)
);

ALTER TABLE T_AREA COMMENT '地区';

/*==============================================================*/
/* Table: T_CITY                                                */
/*==============================================================*/
CREATE TABLE T_CITY
(
   ID                   BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '主键ID',
   CITY_CODE            VARCHAR(36) NOT NULL COMMENT '市区编码',
   CITY_NAME            VARCHAR(64) NOT NULL COMMENT '市区名称',
   PARENT_CODE          VARCHAR(36) NOT NULL COMMENT '父编码',
   CREATE_BY           	VARCHAR(36) COMMENT '创建人',
   CREATE_TIME        	DATETIME COMMENT '创建时间',
   UPDATE_BY      		VARCHAR(36) COMMENT '修改人',
   UPDATE_TIME     		DATETIME COMMENT '修改时间',
   DEL_FLAG          	SMALLINT NOT NULL DEFAULT 0 COMMENT '删除标记，0代表存在；2代表删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_CITY_CODE_UNIQUE (CITY_CODE)
);

ALTER TABLE T_CITY COMMENT '市区';

/*==============================================================*/
/* Table: T_PROVINCE                                            */
/*==============================================================*/
CREATE TABLE T_PROVINCE
(
   ID                   BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '主键ID',
   PROVINCE_CODE        VARCHAR(36) NOT NULL COMMENT '省份编码',
   PROVINCE_NAME        VARCHAR(64) NOT NULL COMMENT '省份名称',
   CREATE_BY           	VARCHAR(36) COMMENT '创建人',
   CREATE_TIME     	  	DATETIME COMMENT '创建时间',
   UPDATE_BY      		VARCHAR(36) COMMENT '修改人',
   UPDATE_TIME     		DATETIME COMMENT '修改时间',
   DEL_FLAG         	SMALLINT NOT NULL DEFAULT 0 COMMENT '删除标记，0代表存在；2代表删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_PROVINCE_CODE_UNIQUE (PROVINCE_CODE)
);

ALTER TABLE T_PROVINCE COMMENT '省份';

/*==============================================================*/
/* Table: T_SYS_PARAM                                           */
/*==============================================================*/
CREATE TABLE T_SYS_PARAM
(
   ID                   BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '主键ID',
   PARAM_NAME           VARCHAR(64) NOT NULL COMMENT '参数名称',
   PARAM_CODE           VARCHAR(36) NOT NULL COMMENT '参数编码',
   PARAM_TYPE           VARCHAR(36) NOT NULL COMMENT '参数类型',
   PARAM_VALUE          VARCHAR(500) COMMENT '参数值',
   REMARK               VARCHAR(1000) COMMENT '备注',
   CREATE_BY           	VARCHAR(36) COMMENT '创建人',
   CREATE_TIME        	DATETIME COMMENT '创建时间',
   UPDATE_BY      		VARCHAR(36) COMMENT '修改人',
   UPDATE_TIME     		DATETIME COMMENT '修改时间',
   DEL_FLAG          	SMALLINT NOT NULL DEFAULT 0 COMMENT '删除标记，0代表存在；2代表删除',
   PRIMARY KEY (ID),
   UNIQUE KEY AK_PARAM_CODE_UNIQUE (PARAM_CODE)
);

ALTER TABLE T_SYS_PARAM COMMENT '系统参数';