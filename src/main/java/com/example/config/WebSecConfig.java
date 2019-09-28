package com.example.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.example.security.CustomAuthenticationProvider;
import com.example.security.CustomJdbcUserDetailManager;
import com.example.security.CustomWebAuthenticationDetailsSource;

/**
 * @author deepakk
 * @date Sep 9, 2019
 */
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true, jsr250Enabled = true)
public class WebSecConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private DataSource dataSource;

	@Autowired
	private CustomWebAuthenticationDetailsSource customWebAuthenticationDetailsSource;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(daoAuthenticationProvider());
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/favicon.ico/**");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().anyRequest().authenticated().and().formLogin()
				.authenticationDetailsSource(customWebAuthenticationDetailsSource);
	}

	// Expose the UserDetailsService as a Bean
	@Bean(BeanIds.USER_DETAILS_SERVICE)
	@Override
	public UserDetailsService userDetailsServiceBean() throws Exception {
		CustomJdbcUserDetailManager userDetailsServiceBean = new CustomJdbcUserDetailManager();
		userDetailsServiceBean.setDataSource(dataSource);
		userDetailsServiceBean.setRolePrefix("ROLE_");
		userDetailsServiceBean.setAuthenticationManager(authenticationManagerBean());
		return userDetailsServiceBean;
	}

	@Bean(BeanIds.AUTHENTICATION_MANAGER)
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public DaoAuthenticationProvider daoAuthenticationProvider() throws Exception {
		final CustomAuthenticationProvider authProvider = new CustomAuthenticationProvider();
		authProvider.setUserDetailsService(userDetailsServiceBean());
		authProvider.setPasswordEncoder(passwordEncoder());
		return authProvider;
	}

	@Bean
	public JdbcTemplate jdbcTemplate() {
		return new JdbcTemplate(dataSource);
	}

}
