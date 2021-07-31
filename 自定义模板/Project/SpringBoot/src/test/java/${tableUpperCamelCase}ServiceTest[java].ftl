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
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Service;

<#if tableInfo.pkIsNumericType>
    <#assign id = RandomStringUtils.randomNumeric(tableInfo.pkColumnSize) />
<#elseif tableInfo.pkJavaType == "String">
    <#assign id = StringUtils.join("\"", RandomStringUtils.randomNumeric(tableInfo.pkColumnSize), "\"") />
</#if>
/**
 * ${tableInfo.simpleRemark}Service接口测试
 *
* @author ${paramConfig.author}
* @version 1.0.0 ${today}
 */
@SpringBootTest
public class ${tableInfo.upperCamelCase}ServiceTest {
    @Autowired
    private ${tableInfo.upperCamelCase}Service ${tableInfo.lowerCamelCase}Service;

    /** 测试根据参数分页查询${tableInfo.simpleRemark}列表 */
    @Test
    public void testFind${tableInfo.upperCamelCase}Page() {
        Instant begin = Instant.now();

        ${tableInfo.upperCamelCase}Condition condition = ${tableInfo.upperCamelCase}Condition.newInstance();

        IPage<${tableInfo.upperCamelCase}> page = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}Page(condition);
        Console.log("Records: {}", page.getRecords());

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试根据${tableInfo.simpleRemark}ID查询${tableInfo.simpleRemark} */
    @Test
    public void testGet${tableInfo.upperCamelCase}ById() {
        Instant begin = Instant.now();

        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}Service.get${tableInfo.upperCamelCase}ById(${id});
        Console.log("${tableInfo.upperCamelCase}: {}", ${tableInfo.lowerCamelCase});

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试新增${tableInfo.simpleRemark} */
    @Test
    public void testAdd${tableInfo.upperCamelCase}() {
        Instant begin = Instant.now();

        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.upperCamelCase}.newInstance();

        boolean bool = ${tableInfo.lowerCamelCase}Service.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        if (bool) {
            Console.log("新增${tableInfo.simpleRemark}成功");
        } else {
            Console.log("新增${tableInfo.simpleRemark}失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

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
            Console.log("修改${tableInfo.simpleRemark}失败");
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
            Console.log("删除${tableInfo.simpleRemark}失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }

    /** 测试根据主键ID集合批量删除${tableInfo.simpleRemark} */
    @Test
    public void testDelete${tableInfo.upperCamelCase}ByIds() {
        Instant begin = Instant.now();

        List<String> idList = new ArrayList<>();

        boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList);
        if (bool) {
            Console.log("批量删除${tableInfo.simpleRemark}成功");
        } else {
            Console.log("批量删除${tableInfo.simpleRemark}失败");
        }

        Instant end = Instant.now();
        Console.log("代码执行消耗时间: {} 毫秒", Duration.between(begin, end).toMillis());
    }
}