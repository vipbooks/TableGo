package ${jsonParam.packagePath}

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.actuate.autoconfigure.endpoint.web.CorsEndpointProperties;
import org.springframework.boot.actuate.autoconfigure.endpoint.web.WebEndpointProperties;
import org.springframework.boot.actuate.autoconfigure.web.server.ManagementPortType;
import org.springframework.boot.actuate.endpoint.ExposableEndpoint;
import org.springframework.boot.actuate.endpoint.web.EndpointLinksResolver;
import org.springframework.boot.actuate.endpoint.web.EndpointMapping;
import org.springframework.boot.actuate.endpoint.web.EndpointMediaTypes;
import org.springframework.boot.actuate.endpoint.web.ExposableWebEndpoint;
import org.springframework.boot.actuate.endpoint.web.WebEndpointsSupplier;
import org.springframework.boot.actuate.endpoint.web.annotation.ControllerEndpointsSupplier;
import org.springframework.boot.actuate.endpoint.web.annotation.ServletEndpointsSupplier;
import org.springframework.boot.actuate.endpoint.web.servlet.WebMvcEndpointHandlerMapping;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;
import org.springframework.util.StringUtils;

import com.spring4all.swagger.EnableSwagger2Doc;

/**
 * 解决问题：Failed to start bean 'documentationPluginsBootstrapper'; nested exception is java.lang.NullPointerException
 * 问题原因：
 * 1、在SpringBoot2.6之后，Spring MVC 处理程序映射匹配请求路径的默认策略已从 AntPathMatcher 更改为 PathPatternParser。如果需要切换为 AntPathMatcher，官方给出的方法是配置 spring.mvc.pathmatch.matching-strategy=ant_path_matcher
 * 2、但是 actuator endpoints 在2.6之后也使用基于 PathPattern 的 URL 匹配，而且 actuator endpoints 的路径匹配策略无法通过配置属性进行配置，如果同时使用 Actuator 和 Springfox，会导致程序启动失败，所以只是进行上面的设置是不行的。
 *    <a href="https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-2.6-Release-Notes">Spring-Boot-2.6-Release-Notes</a>
 * 解决方案：
 * 1、添加配置：spring.mvc.pathmatch.matching-strategy=ant_path_matcher
 * 2、编写 WebMvcEndpointHandlerMapping 覆盖掉 spring-boot-actuator-autoconfigure 中默认的 WebMvcEndpointManagementContextConfiguration，actuator endpoints 就是在这里使用了 PathPatternParser
 * 通过上述两个步骤使 Spring 和 Spring Actuator 不设置默认的 MatchingStrategy.PATH_PATTERN_PARSER，而是使用 MatchingStrategy.ANT_PATH_MATCHER
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@EnableSwagger2Doc
@SpringBootConfiguration
public class SwaggerConfig {
    @Bean
    public WebMvcEndpointHandlerMapping webEndpointServletHandlerMapping(WebEndpointsSupplier webEndpointsSupplier,
                                                                         ServletEndpointsSupplier servletEndpointsSupplier, ControllerEndpointsSupplier controllerEndpointsSupplier,
                                                                         EndpointMediaTypes endpointMediaTypes, CorsEndpointProperties corsProperties,
                                                                         WebEndpointProperties webEndpointProperties, Environment environment) {
        List<ExposableEndpoint<?>> allEndpoints = new ArrayList<>();
        Collection<ExposableWebEndpoint> webEndpoints = webEndpointsSupplier.getEndpoints();
        allEndpoints.addAll(webEndpoints);
        allEndpoints.addAll(servletEndpointsSupplier.getEndpoints());
        allEndpoints.addAll(controllerEndpointsSupplier.getEndpoints());
        String basePath = webEndpointProperties.getBasePath();
        EndpointMapping endpointMapping = new EndpointMapping(basePath);
        boolean shouldRegisterLinksMapping =
                webEndpointProperties.getDiscovery().isEnabled() && (StringUtils.hasText(basePath)
                        || ManagementPortType.get(environment).equals(ManagementPortType.DIFFERENT));
        return new WebMvcEndpointHandlerMapping(endpointMapping, webEndpoints, endpointMediaTypes,
                corsProperties.toCorsConfiguration(), new EndpointLinksResolver(allEndpoints, basePath),
                shouldRegisterLinksMapping, null);  // 把 pathPatternParser 参数设置为 null
    }
}