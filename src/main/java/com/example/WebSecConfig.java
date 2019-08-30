package com.example;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

/**
 * @author deepakk
 *
 */
@EnableWebSecurity
@Configuration
public class WebSecConfig extends WebSecurityConfigurerAdapter {

}
