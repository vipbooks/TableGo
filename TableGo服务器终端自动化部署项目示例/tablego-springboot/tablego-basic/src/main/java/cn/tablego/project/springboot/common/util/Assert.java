package cn.tablego.project.springboot.common.util;

import java.util.Collection;
import java.util.Map;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.BooleanUtil;
import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.tablego.project.springboot.common.exception.BizException;

/**
 * 断言，用于业务判断，不符合业务要求将抛出业务异常
 *
 * @author bianj
 * @version 1.0.0 2021-09-23
 */
public class Assert {
    /**
     * 检查布尔值是否为True，不为True断言失败
     *
     * @param bool    要检查的布尔值
     * @param message 错误消息
     */
    public static void isTrue(Boolean bool, String message) {
        if (BooleanUtil.isFalse(bool)) {
            failed(message);
        }
    }

    /**
     * 检查布尔值是否为False，不为False断言失败
     *
     * @param bool    要检查的布尔值
     * @param message 错误消息
     */
    public static void isFalse(Boolean bool, String message) {
        if (BooleanUtil.isTrue(bool)) {
            failed(message);
        }
    }

    /**
     * 检查字符串是否为空，不为空断言失败
     *
     * @param str     要检查的字符串
     * @param message 错误消息
     */
    public static void isBlank(String str, String message) {
        if (StrUtil.isNotBlank(str)) {
            failed(message);
        }
    }

    /**
     * 检查字符串是否不为空，为空断言失败
     *
     * @param str     要检查的字符串
     * @param message 错误消息
     */
    public static void isNotBlank(String str, String message) {
        if (StrUtil.isBlank(str)) {
            failed(message);
        }
    }

    /**
     * 检查字符串是否为空，不为空断言失败
     *
     * @param str     要检查的字符串
     * @param message 错误消息
     */
    public static void isEmpty(String str, String message) {
        if (StrUtil.isNotEmpty(str)) {
            failed(message);
        }
    }

    /**
     * 检查字符串是否不为空，为空断言失败
     *
     * @param str     要检查的字符串
     * @param message 错误消息
     */
    public static void isNotEmpty(String str, String message) {
        if (StrUtil.isEmpty(str)) {
            failed(message);
        }
    }

    /**
     * 检查集合是否为空，不为空断言失败
     *
     * @param collection 要检查的集合
     * @param message    错误消息
     */
    public static void isEmpty(Collection<?> collection, String message) {
        if (CollUtil.isNotEmpty(collection)) {
            failed(message);
        }
    }

    /**
     * 检查集合是否不为空，为空断言失败
     *
     * @param collection 要检查的集合
     * @param message    错误消息
     */
    public static void isNotEmpty(Collection<?> collection, String message) {
        if (CollUtil.isEmpty(collection)) {
            failed(message);
        }
    }

    /**
     * 检查Map是否为空，不为空断言失败
     *
     * @param map     要检查的Map
     * @param message 错误消息
     */
    public static void isEmpty(Map<?, ?> map, String message) {
        if (MapUtil.isNotEmpty(map)) {
            failed(message);
        }
    }

    /**
     * 检查集合是否不为空，为空断言失败
     *
     * @param map     要检查的Map
     * @param message 错误消息
     */
    public static void isNotEmpty(Map<?, ?> map, String message) {
        if (MapUtil.isEmpty(map)) {
            failed(message);
        }
    }

    /**
     * 检查对象是否为Null，不为Null断言失败
     *
     * @param obj     要检查的对象
     * @param message 错误消息
     */
    public static void isNull(Object obj, String message) {
        if (ObjectUtil.isNotNull(obj)) {
            failed(message);
        }
    }

    /**
     * 检查对象是否不为Null，为Null断言失败
     *
     * @param obj     要检查的对象
     * @param message 错误消息
     */
    public static void isNotNull(Object obj, String message) {
        if (ObjectUtil.isNull(obj)) {
            failed(message);
        }
    }

    /**
     * 检查对象是否为空，不为空断言失败
     *
     * @param obj     要检查的对象
     * @param message 错误消息
     */
    public static void isEmpty(Object obj, String message) {
        if (ObjectUtil.isNotEmpty(obj)) {
            failed(message);
        }
    }

    /**
     * 检查对象是否不为空，为空断言失败
     *
     * @param obj     要检查的对象
     * @param message 错误消息
     */
    public static void isNotEmpty(Object obj, String message) {
        if (ObjectUtil.isEmpty(obj)) {
            failed(message);
        }
    }

    /**
     * 检查字符串是否是数字，非数字断言失败
     *
     * @param str     要检查的字符串
     * @param message 错误消息
     */
    public static void isNumber(String str, String message) {
        if (!NumberUtil.isNumber(str)) {
            failed(message);
        }
    }

    /**
     * 检查整数是否大于0，小于等于0断言失败
     *
     * @param number  要检查的整数
     * @param message 错误消息
     */
    public static void gtZero(Number number, String message) {
        if (number == null || number.intValue() <= 0) {
            failed(message);
        }
    }

    /**
     * 检查整数是否大于等于0，小于0断言失败
     *
     * @param number  要检查的整数
     * @param message 错误消息
     */
    public static void gteZero(Number number, String message) {
        if (number == null || number.intValue() < 0) {
            failed(message);
        }
    }

    /**
     * 检查整数是否小于0，大于等于0断言失败
     *
     * @param number  要检查的整数
     * @param message 错误消息
     */
    public static void ltZero(Number number, String message) {
        if (number == null || number.intValue() >= 0) {
            failed(message);
        }
    }

    /**
     * 检查整数是否小于等于0，大于0断言失败
     *
     * @param number  要检查的整数
     * @param message 错误消息
     */
    public static void lteZero(Number number, String message) {
        if (number == null || number.intValue() > 0) {
            failed(message);
        }
    }

    /**
     * 检查整数1是否大于整数2，否则断言失败
     *
     * @param number1 要检查的整数1
     * @param number2 要检查的整数2
     * @param message 错误消息
     */
    public static void gt(Number number1, Number number2, String message) {
        if (number1 == null || number2 == null || number1.longValue() <= number2.longValue()) {
            failed(message);
        }
    }

    /**
     * 检查整数1是否大于等于整数2，否则断言失败
     *
     * @param number1 要检查的整数1
     * @param number2 要检查的整数2
     * @param message 错误消息
     */
    public static void gte(Number number1, Number number2, String message) {
        if (number1 == null || number2 == null || number1.longValue() < number2.longValue()) {
            failed(message);
        }
    }

    /**
     * 检查整数1是否小于整数2，否则断言失败
     *
     * @param number1 要检查的整数1
     * @param number2 要检查的整数2
     * @param message 错误消息
     */
    public static void lt(Number number1, Number number2, String message) {
        if (number1 == null || number2 == null || number1.longValue() >= number2.longValue()) {
            failed(message);
        }
    }

    /**
     * 检查整数1是否小于等于整数2，否则断言失败
     *
     * @param number1 要检查的整数1
     * @param number2 要检查的整数2
     * @param message 错误消息
     */
    public static void lte(Number number1, Number number2, String message) {
        if (number1 == null || number2 == null || number1.longValue() > number2.longValue()) {
            failed(message);
        }
    }

    /**
     * 检查整数1是否等于整数2，否则断言失败
     *
     * @param number1 要检查的整数1
     * @param number2 要检查的整数2
     * @param message 错误消息
     */
    public static void eq(Number number1, Number number2, String message) {
        if (number1 == null || number2 == null || number1.longValue() != number2.longValue()) {
            failed(message);
        }
    }

    /**
     * 检查整数1是否不等于整数2，否则断言失败
     *
     * @param number1 要检查的整数1
     * @param number2 要检查的整数2
     * @param message 错误消息
     */
    public static void notEq(Number number1, Number number2, String message) {
        if (number1 == null || number2 == null || number1.longValue() == number2.longValue()) {
            failed(message);
        }
    }

    /**
     * 检查对象1是否等于对象2，否则断言失败
     *
     * @param obj1    要检查的对象1
     * @param obj2    要检查的对象2
     * @param message 错误消息
     */
    public static void eq(Object obj1, Object obj2, String message) {
        if (!ObjectUtil.equal(obj1, obj2)) {
            failed(message);
        }
    }

    /**
     * 检查对象1是否不等于对象2，否则断言失败
     *
     * @param obj1    要检查的对象1
     * @param obj2    要检查的对象2
     * @param message 错误消息
     */
    public static void notEq(Object obj1, Object obj2, String message) {
        if (ObjectUtil.equal(obj1, obj2)) {
            failed(message);
        }
    }

    /**
     * 检查字符串1是否等于字符串2，否则断言失败，不区分大小写
     *
     * @param str1    要检查的字符串1
     * @param str2    要检查的字符串2
     * @param message 错误消息
     */
    public static void eqIc(String str1, String str2, String message) {
        if (!StrUtil.equalsIgnoreCase(str1, str2)) {
            failed(message);
        }
    }

    /**
     * 检查字符串1是否不等于字符串2，否则断言失败，不区分大小写
     *
     * @param str1    要检查的字符串1
     * @param str2    要检查的字符串2
     * @param message 错误消息
     */
    public static void notEqIc(String str1, String str2, String message) {
        if (StrUtil.equalsIgnoreCase(str1, str2)) {
            failed(message);
        }
    }

    /**
     * 检查对象1中是否包含有对象2，否则断言失败
     *
     * @param obj1    要检查的对象1
     * @param obj2    要检查的对象2
     * @param message 错误消息
     */
    public static void contains(Object obj1, Object obj2, String message) {
        if (!ObjectUtil.contains(obj1, obj2)) {
            failed(message);
        }
    }

    /**
     * 检查对象1中是否不包含对象2，否则断言失败
     *
     * @param obj1    要检查的对象1
     * @param obj2    要检查的对象2
     * @param message 错误消息
     */
    public static void notContains(Object obj1, Object obj2, String message) {
        if (ObjectUtil.contains(obj1, obj2)) {
            failed(message);
        }
    }

    /**
     * 断言失败并设置错误消息
     *
     * @param message 错误消息
     */
    public static void failed(String message) {
        throw new BizException(message);
    }

    /**
     * 断言失败并设置错误消息和错误编码
     *
     * @param message 错误消息
     * @param code    错误编码
     */
    public static void failed(String message, Integer code) {
        throw new BizException(message, code);
    }
}
