package ${jsonParam.packagePath}

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

/**
 * 跨域请求配置
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Configuration
public class CorsConfig {
    /**
     * 配置跨域请求参数
     *
     * @return CorsConfiguration
     */
    private CorsConfiguration buildConfig() {
        CorsConfiguration corsConfiguration = new CorsConfiguration();
        // 配置允许访问的源，如: http://localhost，*表示允许全部的域名
        corsConfiguration.addAllowedOriginPattern("*");
        // 配置允许的自定义请求头，用于预检请求
        corsConfiguration.addAllowedHeader("*");
        // 配置跨域请求支持的方式，如：GET、POST，且一次性返回全部支持的方式
        corsConfiguration.addAllowedMethod("*");
        // 配置是否允许发送Cookie，用于凭证请求，默认不发送Cookie
        corsConfiguration.setAllowCredentials(true);
        // 配置预检请求的有效时间，单位是秒，表示：在多长时间内，不需要发出第二次预检请求
        corsConfiguration.setMaxAge(86400L);
        // 配置响应头信息，在其中可以设置其他的头信息，不进行配置时，默认可以获取到Cache-Control、Content-Language、Content-Type、Expires、Last-Modified、Pragma字段
        // corsConfiguration.addExposedHeader("Content-Disposition");

        return corsConfiguration;
    }

    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", buildConfig());
        return new CorsFilter(source);
    }
}