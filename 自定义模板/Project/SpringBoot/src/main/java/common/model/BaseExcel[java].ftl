package ${jsonParam.packagePath}

import java.io.Serializable;

import lombok.Data;

/**
 * Excel公共字段基础类，用于实体JavaBean继承
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Data
public abstract class BaseExcel implements Serializable {
    /** 版本号 */
    private static final long serialVersionUID = 1861822204456898866L;

    /** 行号 */
    protected Integer rowNumber;

}
