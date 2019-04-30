package cn.wuxia.project.admin.api;


import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import cn.wuxia.common.util.PropertiesUtils;
import cn.wuxia.common.util.StringUtil;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

//@Configuration
//@EnableWebMvc
//@EnableSwagger2
//@ComponentScan(basePackages = {"cn.funmeet.news.api"})
public class SwaggerConfig {


//    @Bean
    public Docket petApi() {
        return new Docket(DocumentationType.SWAGGER_2).apiInfo(apiInfo()).select()
                .apis(RequestHandlerSelectors.basePackage("cn.funmeet.news.api"))
                //.paths(PathSelectors.regex("/api/.*"))
                .paths(PathSelectors.any())
                .build();
    }

    Properties properties = PropertiesUtils.loadProperties("classpath:properties/security.properties", "classpath:/security.properties");

    private ApiInfo apiInfo() {
        String serviceName = properties.getProperty("cas.service");
        String[] url = StringUtil.split(serviceName, "/", 3);
        return new ApiInfoBuilder().title("管理系统系统API").description("").termsOfServiceUrl(url[0] + "//" + url[1] + "/api"
        ).version("1.0").contact(new Contact("songlin.li", "", "lsl@wuxia.tech")).build();
    }
}
