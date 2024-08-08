package ${jsonParam.packagePath}

import java.util.concurrent.Executor;
import java.util.concurrent.ThreadPoolExecutor;

import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import cn.hutool.core.text.StrPool;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 异步线程池配置，修改@Async注解的默认线程池
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Slf4j
@EnableAsync
@SpringBootConfiguration
public class AsyncThreadPoolConfig implements AsyncConfigurer {

    /** 线程池执行器配置 */
    @Override
    public Executor getAsyncExecutor() {
        // Java虚拟机可用的处理器数
        int processors = Runtime.getRuntime().availableProcessors();
        // 计算线程池核心线程数
        int corePoolSize = Math.max(2, Math.min(processors - 1, 4));
        // 计算线程池最大线程数
        int maxPoolSize = processors * 2 + 1;

        ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();
        // 线程池核心线程数
        taskExecutor.setCorePoolSize(corePoolSize);
        // 线程池最大线程数，默认：40000
        taskExecutor.setMaxPoolSize(maxPoolSize);
        // 线程队列最大线程数，默认：80000
        taskExecutor.setQueueCapacity(1000);
        // 线程最大空闲(存活)时间，单位：秒，默认：60秒
        taskExecutor.setKeepAliveSeconds(60);
        // 线程名称前缀
        taskExecutor.setThreadNamePrefix("Async-ThreadPool-");
        // 核心线程是否允许超时，默认:false
        taskExecutor.setAllowCoreThreadTimeOut(false);
        // IOC容器关闭时是否阻塞等待剩余的任务执行完成，默认:false
        taskExecutor.setWaitForTasksToCompleteOnShutdown(false);
        // 阻塞IOC容器关闭时线程的超时时间，单位：秒，默认：0无限时间
        taskExecutor.setAwaitTerminationSeconds(10);
        /*
         * 拒绝策略，默认是AbortPolicy
         * AbortPolicy：丢弃任务并抛出RejectedExecutionException异常
         * DiscardPolicy：丢弃任务但不抛出异常
         * DiscardOldestPolicy：丢弃最旧的处理程序，然后重试，如果执行器关闭，这时丢弃任务
         * CallerRunsPolicy：执行器执行任务失败，则在策略回调方法中执行任务，如果执行器关闭，这时丢弃任务
         */
        taskExecutor.setRejectedExecutionHandler(new ThreadPoolExecutor.AbortPolicy());
        // 初始化线程池
        taskExecutor.initialize();
        return taskExecutor;
    }

    /** 异步方法执行过程中抛出的异常捕获 */
    @Override
    public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
        return (throwable, method, params) -> {
            if (ObjectUtil.isNotEmpty(params)) {
                log.warn("Async Method Params: {}", StrUtil.join(StrPool.COMMA, params));
            }
            log.error(throwable.getMessage(), throwable);
        };
    }
}
