<#-- 用于生成从Excel中纵向复制过来的数据生成JavaBean的自定义模板例示 -->
<#--
临时参数配置说明：
临时参数1：Id,Name,Code,PaperType,paper_number,paperAddress,departmentId
临时参数2：true,true,true,true,TRUE,FALSE,否
临时参数3：long,string,String,int,string,string,long
临时参数4：人员ID,人员姓名,人员编码,证件类型,证件号码,证件地址,部门ID
-->
package ${jsonParam.packagePath}

import java.io.Serializable;

import lombok.Data;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.experimental.Accessors;

/**
 * 
 * 
 * @author ${paramConfig.author}
 * @since ${dateTime}
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
public class JavaBean implements Serializable {
    /** 版本号 */
    private static final long serialVersionUID = ${FtlUtils.getSerialVersionUID()}L;
<#if tempParamList?has_content>
    <#list tempParamList as param>

    /** ${param.tempParam4}<#if param.tempParam2?has_content>，是否必填：<#if StringUtils.equalsIgnoreCase(param.tempParam2, "true")>是<#elseif StringUtils.equalsIgnoreCase(param.tempParam2, "false")>否<#else>${param.tempParam2}</#if></#if> */    
    private <#if StringUtils.equalsIgnoreCase(param.tempParam3, "int")>Integer<#elseif StringUtils.equalsIgnoreCase(param.tempParam3, "boolean")>Boolean<#elseif StringUtils.equalsIgnoreCase(param.tempParam3, "float")>Float<#elseif StringUtils.equalsIgnoreCase(param.tempParam3, "long")>Long<#elseif StringUtils.equalsIgnoreCase(param.tempParam3, "array")>List<#elseif StringUtils.equalsIgnoreCase(param.tempParam3, "date")>Date<#else>String</#if> ${FtlUtils.fieldToLowerName(param.tempParam1)};
    </#list>
</#if>
}