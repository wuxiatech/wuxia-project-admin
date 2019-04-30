package cn.wuxia.project.test;


import cn.wuxia.project.security.core.user.service.AdminUserService;
import com.google.common.collect.Maps;
import org.aspectj.lang.annotation.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.mock.jndi.SimpleNamingContextBuilder;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.naming.NamingException;
import javax.sql.DataSource;
import java.util.Date;
import java.util.Map;

/**
 * @author songlin.li
 */
@DirtiesContext
@RunWith(SpringJUnit4ClassRunner.class)
@ActiveProfiles(value = {"location"})
@ContextConfiguration(locations = {"classpath*:/applicationContext.ut-test.xml"})
public class ServiceTest {

    @BeforeClass
    public static void init() throws IllegalStateException, NamingException {
        String url = "jdbc:mysql://39.105.135.208/news_admin?serverTimezone=GMT&useSSL=false&pinGlobalTxToPhysicalConnection=true";
        String username = "dbuser";
        String password = "newsDbPw2018";
        DataSource ds = new SimpleDriverDataSource(BeanUtils.instantiateClass(com.mysql.cj.jdbc.Driver.class), url, username, password);
        SimpleNamingContextBuilder builder = new SimpleNamingContextBuilder();
        builder.bind("java:comp/env/jdbc/baseDataSource", ds);
        builder.activate();
    }

    @Before("")
    public void setUp() {
    }

    @Autowired
    private AdminUserService adminUserService;
    @Test
    public void test() {
        adminUserService.findAll();
    }
}
