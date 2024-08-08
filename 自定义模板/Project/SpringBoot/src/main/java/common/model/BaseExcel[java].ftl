package ${jsonParam.packagePath}

import java.io.Serializable;

import lombok.Data;

/**
 * Excel公共字段基础类，用于实体JavaBean继承
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Data
public abstract class BaseExcel implements Serializable {
    /** 版本号 */
    private static final long serialVersionUID = ${FtlUtils.getSerialVersionUID()}L;

    /** 行号 */
    private Integer rowNumber;

}
