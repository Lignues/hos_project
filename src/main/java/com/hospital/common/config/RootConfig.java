package com.hospital.common.config;

import java.io.IOException;
import java.util.Properties;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan(value = {"com.hospital.member.repository", "com.hospital.board.repository"})
@PropertySource(value = {"classpath:/database/oracleDB.properties", "classpath:/database/emailDB.properties"}) // emailDB ignore해놨으니 파일 만들어서 사용
@EnableTransactionManagement
public class RootConfig {

	@Value("${db.driver}")
	private String driverClassName;
	
	@Value("${db.url}")
	private String jdbcUrl;
	
	@Value("${db.username}")
	private String userName;
	
	@Value("${db.password}")
	private String password;
	
	@Value("${email.id}")
	private String emailId;
	
	@Value("${email.password}")
	private String emailPassword;
	
	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		HikariConfig config= new HikariConfig(); 
		config.setDriverClassName(driverClassName);
		config.setJdbcUrl(jdbcUrl);
		config.setUsername(userName);
		config.setPassword(password);
		return new HikariDataSource(config); 
	}
	
	@Bean
	public SqlSessionFactoryBean sessionFactoryBean() throws IOException {
		SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
		factory.setDataSource(dataSource());
		factory.setMapperLocations(new PathMatchingResourcePatternResolver()
				.getResources("classpath:mappers/**/*Mapper.xml"));
		factory.setTypeAliasesPackage("com.hospital.member.domain, com.hospital.board.domain");
		return factory;
	}
	
	@Bean
	public SqlSessionTemplate sessionTemplate() throws Exception {
		return new SqlSessionTemplate(sessionFactoryBean().getObject());
	}
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer placeholderConfigurer() {
		return new PropertySourcesPlaceholderConfigurer();
	}
	
	@Bean
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
	
	@Bean
	public JavaMailSenderImpl mailSender() {
	    JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
	    mailSender.setHost("smtp.naver.com");
	    mailSender.setPort(465);
	    mailSender.setUsername(emailId);
	    mailSender.setPassword(emailPassword);

	    Properties properties = new Properties();
	    properties.put("mail.transport.protocol", "smtp");
	    properties.put("mail.smtp.auth", "true");
	    properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	    properties.put("mail.smtp.starttls.enable", "true");
	    properties.put("mail.debug", "true");
	    properties.put("mail.smtp.ssl.trust", "smtp.naver.com");
	    properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
	    mailSender.setJavaMailProperties(properties);
	    return mailSender;
	}
	
}
