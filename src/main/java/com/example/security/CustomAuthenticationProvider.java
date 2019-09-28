package com.example.security;

import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

/**
 * @author deepakk
 * @date Sep 9, 2019
 */
public class CustomAuthenticationProvider extends DaoAuthenticationProvider {

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// process additional request parameters here
		final String verificationCode = ((CustomWebAuthenticationDetails) authentication.getDetails())
				.getVerificationCode();
		System.out.println(verificationCode);
		return super.authenticate(authentication);
	}
}
