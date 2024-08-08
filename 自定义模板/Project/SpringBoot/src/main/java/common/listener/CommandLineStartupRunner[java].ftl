package ${jsonParam.packagePath}

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.lang.Console;
import cn.hutool.core.text.StrPool;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;

/**
 * 应用启动监听，监听应用是否启动完成
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Component
public class CommandLineStartupRunner implements CommandLineRunner {
    @Autowired
    private Environment environment;

    @Override
    public void run(String... args) throws Exception {
        String activeProfile = null;
        if (environment != null && ArrayUtil.isNotEmpty(environment.getActiveProfiles())) {
            activeProfile = CollUtil.join(CollUtil.toList(environment.getActiveProfiles()), StrPool.COMMA);
        }
        if (StrUtil.isNotBlank(activeProfile)) {
            Console.log("Started Application, profile is active:", activeProfile);
        } else {
            Console.log("Started Application.");
        }
    }
}
