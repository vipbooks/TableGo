package ${jsonParam.packagePath}

import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.baomidou.mybatisplus.core.metadata.IPage;

import cn.hutool.core.lang.Console;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>condition.${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Service;

<#if tableInfo.pkIsNumericType>
    <#if tableInfo.pkColumnSize &gt; 6>
        <#assign id = FtlUtils.getRandomString19(6) />
    <#elseif tableInfo.pkColumnSize &gt; 1>
        <#assign id = FtlUtils.getRandomString19(tableInfo.pkColumnSize - 1) />
    <#else>
        <#assign id = FtlUtils.getRandomString19(1) />
    </#if>
    <#if tableInfo.pkJavaType == "Long">
        <#assign id = id + "L" />
    </#if>
<#elseif tableInfo.pkIsStringType>
    <#if tableInfo.pkColumnSize &gt; 6>
        <#assign id = StringUtils.join("\"", FtlUtils.getRandomStringAz(6), "\"") />
    <#elseif tableInfo.pkColumnSize &gt; 1>
        <#assign id = StringUtils.join("\"", FtlUtils.getRandomStringAz(tableInfo.pkColumnSize - 1), "\"") />
    <#else>
        <#assign id = StringUtils.join("\"", FtlUtils.getRandomStringAz(1), "\"") />
    </#if>
</#if>
/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}Service接口测试
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@SpringBootTest
public class ${tableInfo.upperCamelCase}ServiceTest {
    @Autowired
    private ${tableInfo.upperCamelCase}Service ${tableInfo.lowerCamelCase}Service;

    /** 测试分页查询${tableInfo.simpleRemark}列表 */
    @Test
    public void testFind${tableInfo.upperCamelCase}Page() {
        Instant begin = Instant.now();

        ${tableInfo.upperCamelCase}Condition condition = ${tableInfo.upperCamelCase}Condition.builder().build();

        IPage<${tableInfo.upperCamelCase}> page = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}Page(condition);
        Console.log("Records: {}", page.getRecords());

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试查询${tableInfo.simpleRemark}列表 */
    @Test
    public void testFind${tableInfo.upperCamelCase}List() {
        Instant begin = Instant.now();

        ${tableInfo.upperCamelCase}Condition condition = ${tableInfo.upperCamelCase}Condition.builder().build();

        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}List(condition);
        Console.log("List: {}", list);

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }
<#if tableInfo.pkLowerCamelName??>

    /** 测试根据主键ID查询${tableInfo.simpleRemark} */
    @Test
    public void testGet${tableInfo.upperCamelCase}ById() {
        Instant begin = Instant.now();

        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}Service.get${tableInfo.upperCamelCase}ById(${id});
        Console.log("${tableInfo.upperCamelCase}: {}", ${tableInfo.lowerCamelCase});

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }
</#if>

    /** 测试新增${tableInfo.simpleRemark} */
    @Test
    public void testAdd${tableInfo.upperCamelCase}() {
        Instant begin = Instant.now();

        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.upperCamelCase}.builder().build();

        boolean bool = ${tableInfo.lowerCamelCase}Service.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        if (bool) {
            Console.log("新增${tableInfo.simpleRemark}成功");
        } else {
            Console.error("新增${tableInfo.simpleRemark}失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }
<#if tableInfo.pkLowerCamelName??>

    /** 测试修改${tableInfo.simpleRemark} */
    @Test
    public void testUpdate${tableInfo.upperCamelCase}() {
        Instant begin = Instant.now();

        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}Service.get${tableInfo.upperCamelCase}ById(${id});
        if (${tableInfo.lowerCamelCase} == null) {
            Console.log("${tableInfo.simpleRemark}不存在");
            return;
        }
        boolean bool = ${tableInfo.lowerCamelCase}Service.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        if (bool) {
            Console.log("修改${tableInfo.simpleRemark}成功");
        } else {
            Console.error("修改${tableInfo.simpleRemark}失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试根据主键ID删除${tableInfo.simpleRemark} */
    @Test
    public void testDelete${tableInfo.upperCamelCase}ById() {
        Instant begin = Instant.now();

        boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ById(${id});
        if (bool) {
            Console.log("删除${tableInfo.simpleRemark}成功");
        } else {
            Console.error("删除${tableInfo.simpleRemark}失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试根据主键ID列表批量删除${tableInfo.simpleRemark} */
    @Test
    public void testDelete${tableInfo.upperCamelCase}ByIds() {
        Instant begin = Instant.now();

        List<${tableInfo.pkJavaType}> idList = new ArrayList<>();

        boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList);
        if (bool) {
            Console.log("批量删除${tableInfo.simpleRemark}成功");
        } else {
            Console.error("批量删除${tableInfo.simpleRemark}失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }
</#if>
}