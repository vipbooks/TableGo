package ${jsonParam.packagePath}

import java.sql.Statement;
import java.time.Duration;
import java.time.Instant;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.ParameterMode;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.type.TypeHandlerRegistry;
import org.springframework.stereotype.Component;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * MyBatis SQL 日志拦截器, 用于打印SQL相关信息（例如：实际执行SQL语句，SQL执行时间，查询记录数等）
 * <p>
 * 关于 @Intercepts注解说明：
 * 为了让拦截器能够精确地拦截特定的方法，需要使用 @Intercepts 注解来声明拦截的方法和参数类型
 * 该注解包含一个参数，即一个 @Signature 类型的数组，用于指定要拦截的方法。每个 @Signature 注解表示一个要拦截的方法签名，其中包括以下属性：
 * <p>
 * type：被拦截的目标类或接口。在这里，StatementHandler.class 表示拦截 MyBatis 中的 StatementHandler 类。
 * method：被拦截的方法名。可以通过字符串指定方法名或使用方法引用。
 * args：被拦截方法的参数类型数组。用于指定被拦截方法的参数类型及顺序。
 * 在以下代码中的注解示例中，拦截器指定了对 StatementHandler 类中的三个方法进行拦截，分别是：
 * <p>
 * query(Statement.class, ResultHandler.class)：拦截 StatementHandler 类中的 query 方法，该方法有两个参数，分别是 Statement 和 ResultHandler。
 * update(Statement.class)：拦截 StatementHandler 类中的 update 方法，该方法有一个参数，即 Statement。
 * batch(Statement.class)：拦截 StatementHandler 类中的 batch 方法，该方法也有一个参数，即 Statement。
 * 通过使用 @Intercepts 注解和 @Signature 注解，可以精确地指定要拦截的方法和参数类型，从而实现对特定方法的拦截和处理。
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Slf4j
@Component
@Intercepts({
        @Signature(type = StatementHandler.class, method = "query", args = {Statement.class, ResultHandler.class}),
        @Signature(type = StatementHandler.class, method = "update", args = {Statement.class}),
        @Signature(type = StatementHandler.class, method = "batch", args = {Statement.class})
})
public class MyBatisSqlLoggerInterceptor implements Interceptor {
    /** 最小时间 */
    private static final String MIN_TIME = "00:00:00";

    /** SQL占位符 */
    private static final char SQL_PLACEHOLDER = '?';

    /** 单引号 */
    private static final String SINGLE_QUOTATION_MARK = "'";

    /** 换行表达式 */
    private static final String ENTER_REGEX = "[\n\r ]+";

    /** 定义一个包含需要添加单引号括起来的参数类型集合 */
    private static final Set<String> NEED_BRACKETS =
            Collections.unmodifiableSet(new HashSet<>(Arrays.asList("String", "Date", "Time", "LocalDate", "LocalTime", "LocalDateTime", "BigDecimal", "Timestamp")));

    /** MyBatis的配置对象 */
    private Configuration configuration = null;

    /**
     * 拦截器的核心方法，用于拦截并处理SQL语句执行前后的逻辑。
     *
     * @param invocation Invocation 类是 MyBatis 框架提供的一个接口，定义了用于描述方法执行的信息和操作的方法。
     *                   在方法拦截时，MyBatis 将被拦截的方法封装成 Invocation 对象，并作为参数传递给拦截器。
     *                   <p>
     *                   Invocation 接口中定义了以下几个重要的方法：
     *                   <p>
     *                   Object getTarget()：获取目标对象，即被拦截的对象。
     *                   Method getMethod()：获取被拦截的方法对象。
     *                   Object[] getArgs()：获取被拦截方法的参数列表。
     *                   Object proceed() throws Throwable：继续执行被拦截的方法。
     *                   Object proceed(Object[] args) throws Throwable：继续执行被拦截的方法，并使用指定的参数列表。
     *                   Object getThis()：获取代理对象，即拦截器生成的代理对象。
     *                   通过 Invocation 对象，我们可以获取被拦截方法的相关信息，如目标对象、方法名称、参数列表等。拦截器可以根据这些信息对方法进行额外的处理，比如记录日志、性能监控、权限验证等。最后，通过调用 proceed() 方法，可以继续执行被拦截的方法。
     *                   <p>
     *                   在代码中，Invocation invocation 参数被用于执行被拦截方法，并在方法执行前后进行一些额外的操作。
     * @return 执行SQL返回的结果
     * @throws Throwable
     */
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        Object target = invocation.getTarget();
        Object returnValue;
        // 获取格式化好的带值的SQL语句
        String sql = this.getSql(target);
        // 执行完SQL返回结果数量
        int returnValueSize = 0;
        // 先记录执行SQL语句前的时间
        Instant begin = Instant.now();
        try {
            // 执行原始方法，并获取返回结果
            returnValue = invocation.proceed();
            // 如果返回结果为集合，则统计行数
            if (returnValue instanceof Collection<?>) {
                returnValueSize = CollUtil.size(returnValue);
            }
        } catch (Exception e) {
            log.error("==> SQL: {}", sql);
            throw e;
        }
        // 记录执行SQL语句后的时间
        Instant end = Instant.now();
        // 获取执行SQL语句消耗的时间，单位：毫秒
        long timeCost = Duration.between(begin, end).toMillis();
        // 输出拼好参数的SQL语句
        log.debug("==> SQL: {}", sql);
        // 输出执行SQL语句消耗的时间和执行完SQL返回结果数量
        if (returnValueSize > 0) {
            log.debug("<== SQL Executed time: {} ms, Total: {}", timeCost, returnValueSize);
        } else {
            log.debug("<== SQL Executed time: {} ms", timeCost);
        }
        // 返回值，如果是多条记录，那么此对象是一个list，如果是一个bean对象，那么此处就是一个对象，也有可能是一个map
        return returnValue;
    }

    /**
     * 获取拼好参数，实际执行的SQL语句
     *
     * @param target 获取目标对象，即被拦截的对象。
     * @return 实际执行SQL语句
     */
    private String getSql(Object target) {
        try {
            // 获取 StatementHandler 对象
            StatementHandler statementHandler = (StatementHandler) target;
            // 获取 BoundSql 对象
            BoundSql boundSql = statementHandler.getBoundSql();
            if (configuration == null) {
                // 通过反射获取 Configuration 对象
                final ParameterHandler parameterHandler = statementHandler.getParameterHandler();
                this.configuration = (Configuration) ReflectUtil.getFieldValue(parameterHandler, "configuration");
            }
            // 格式化 SQL 语句并返回
            return formatSql(boundSql, configuration);
        } catch (Exception e) {
            // 异常处理，打印警告日志
            log.warn("获取 SQL 语句失败：{}", target, e);
            return "无法解析的 SQL 语句";
        }
    }

    /**
     * 格式化SQL语句，并把SQL中的参数占位符替换成实际参数
     *
     * @param boundSql      绑定的 SQL 对象，包含 SQL 语句和参数信息
     * @param configuration MyBatis 的配置信息对象，用于获取配置信息
     * @return 格式化后的 SQL 字符串
     */
    private String formatSql(BoundSql boundSql, Configuration configuration) {
        // 获取原始 SQL 语句
        String sql = boundSql.getSql();
        // 获取参数映射列表
        List<ParameterMapping> parameterMappings = boundSql.getParameterMappings();
        // 获取参数对象
        Object parameterObject = boundSql.getParameterObject();
        // 判断是否为空
        if (StrUtil.isEmpty(sql) || Objects.isNull(configuration)) {
            return StrUtil.EMPTY;
        }

        // 移除 SQL 字符串中的空格、换行符等
        sql = sql.replaceAll(ENTER_REGEX, StrUtil.SPACE);
        // 过滤掉输出参数的参数映射
        if (parameterMappings == null) {
            return sql;
        }
        parameterMappings = parameterMappings.stream()
                .filter(it -> it.getMode() != ParameterMode.OUT)
                .collect(Collectors.toList());

        // 获取 TypeHandlerRegistry 对象
        TypeHandlerRegistry typeHandlerRegistry = configuration.getTypeHandlerRegistry();
        // 使用 StringBuilder 保存格式化后的 SQL
        StringBuilder result = new StringBuilder(sql);
        // 解析问号并替换参数
        for (int i = result.length(); i > 0; i--) {
            if (result.charAt(i - 1) != SQL_PLACEHOLDER) {
                continue;
            }
            ParameterMapping parameterMapping = parameterMappings.get(parameterMappings.size() - 1);
            Object value;
            String propertyName = parameterMapping.getProperty();
            // 判断绑定的附加参数中是否有对应的属性名
            if (boundSql.hasAdditionalParameter(propertyName)) {
                value = boundSql.getAdditionalParameter(propertyName);
            } else if (parameterObject == null) {
                value = null;
            } else if (typeHandlerRegistry.hasTypeHandler(parameterObject.getClass())) {
                value = parameterObject;
            } else {
                // 使用 MetaObject 获取属性值
                MetaObject metaObject = configuration.newMetaObject(parameterObject);
                value = metaObject.getValue(propertyName);
            }
            if (value != null) {
                if (value instanceof Date) {
                    String time = DateUtil.formatTime((Date) value);
                    if (StrUtil.equals(time, MIN_TIME)) {
                        value = DateUtil.formatDate((Date) value);
                    } else {
                        value = DateUtil.formatDateTime((Date) value);
                    }
                }
                // 判断参数类型，如果是需要添加括号的类型，则添加单引号
                String type = value.getClass().getSimpleName();
                if (NEED_BRACKETS.contains(type)) {
                    result.replace(i - 1, i, SINGLE_QUOTATION_MARK + value + SINGLE_QUOTATION_MARK);
                } else {
                    result.replace(i - 1, i, value.toString());
                }
            } else {
                // 参数值为空时，替换为 "null"
                result.replace(i - 1, i, StrUtil.NULL);
            }
            // 移除已处理的参数映射
            parameterMappings.remove(parameterMappings.size() - 1);
        }
        return result.toString();
    }
}