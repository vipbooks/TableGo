<#-- DEMO用户表生成插入随机数据的标准SQL -->
-- 用户表随机数据
-- TRUNCATE TABLE t_user;
<#list 1..1000 as i>
<#assign randomNum6 = FtlUtils.getRandomString19(6) />
INSERT INTO t_user(id,username,full_name,mobile_phone,id_card,email,birthday,tenant_code,created_by,created_time,last_updated_by,last_updated_time,is_deleted) VALUES ('${randomNum6}','test${randomNum6}','测试用户${randomNum6}','186${FtlUtils.getRandomString19(8)}','430${FtlUtils.getRandomString19(15)}','test${randomNum6}@163.com','${DateUtils.getRandomDate("2000-01-01")}','test','-1',NOW(),'-1',NOW(),0);
</#list>
