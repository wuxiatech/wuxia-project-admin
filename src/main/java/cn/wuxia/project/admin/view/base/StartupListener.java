package cn.wuxia.project.admin.view.base;

import javax.servlet.ServletContext;

import cn.wuxia.project.basic.core.conf.service.GenerateStaticPageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

@Component("StartupListener")
public class StartupListener implements ApplicationContextAware, ServletContextAware, InitializingBean, ApplicationListener<ContextRefreshedEvent> {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    ServletContext context;

    @Autowired
    private GenerateStaticPageService generateStaticPageService;

    @Override
    public void setApplicationContext(ApplicationContext ctx) throws BeansException {
        logger.info("\r\n\r\n\r\n\r\n1 => StartupListener.setApplicationContext");
    }

    @Override
    public void setServletContext(ServletContext context) {
        this.context = context;
        logger.info("\r\n\r\n\r\n\r\n2 => StartupListener.setServletContext");
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        logger.info("\r\n\r\n\r\n\r\n3 => StartupListener.afterPropertiesSet");
    }

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        logger.info("\r\n\r\n\r\n\r\n4.1 => MyApplicationListener.onApplicationEvent");
        logger.info("\r\n\r\n\r\n\r\n4.1 => " + event.getApplicationContext().getParent());
        logger.info("\r\n\r\n\r\n\r\n4.1 => " + event.getApplicationContext().getDisplayName());

        if (event.getApplicationContext().getParent() == null) {
            logger.info("\r\n\r\n\r\n\r\n4.2 => MyApplicationListener.onApplicationEvent");
        } else {
            logger.info("\r\n\r\n\r\n\r\n4.4 => " + event.getApplicationContext().getParent().getDisplayName());
            //String sourceUrl = DConstants.CTX_ADMIN_SERVICE_NAME + "/menubuild";
            String toDistLocation = "/WEB-INF/layouts_admin";
            String fileName = "menu.jsp";
            String path = context.getRealPath("/") + toDistLocation;
            Thread thread = new Thread(() -> {
                try {
                    //ServletUtils.requestToFile(fileName, path, sourceUrl);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            });
            thread.start();
            if (event.getApplicationContext().getDisplayName().equals("Root WebApplicationContext")) {
                logger.info("\r\n\r\n\r\n\r\n4.3 => MyApplicationListener.onApplicationEvent");
            }
        }
    }
}
