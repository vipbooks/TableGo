package ${jsonParam.packagePath}

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.bean.BeanUtil;

/**
 * 查询条件的基础类，用于继承
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public abstract class BaseCondition extends BasePagingCondition {
    /** 版本号 */
    private static final long serialVersionUID = 8030810384199964818L;

    /**
     * 创建查询条件构造器，将对象或Map转Bean对象，
     * 并把对象或Map中的值拷贝给Bean对象，拷贝进来的这些值会自动生成查询条件
     *
     * @param clazz 目标的Bean类型
     * @return 查询条件构造器
     */
    public <T> QueryWrapper<T> buildQueryWrapper(Class<T> clazz) {
        T entity = BeanUtil.toBean(this, clazz);
        return new QueryWrapper<>(entity);
    }

    /**
     * 创建查询条件构造器，不会自动生成查询条件
     *
     * @return 查询条件构造器
     */
    public <T> QueryWrapper<T> buildQueryWrapper() {
        return new QueryWrapper<>();
    }

    /**
     * 创建查询条件构造器，将对象或Map转Bean对象，
     * 并把对象或Map中的值拷贝给Bean对象，拷贝进来的这些值会自动生成查询条件
     *
     * @param clazz 目标的Bean类型
     * @return 查询条件构造器
     */
    public <T> LambdaQueryWrapper<T> buildLambdaQueryWrapper(Class<T> clazz) {
        T entity = BeanUtil.toBean(this, clazz);
        return Wrappers.lambdaQuery(entity);
    }

    /**
     * 创建查询条件构造器，不会自动生成查询条件
     *
     * @return 查询条件构造器
     */
    public <T> LambdaQueryWrapper<T> buildLambdaQueryWrapper() {
        return Wrappers.lambdaQuery();
    }
}