package com.example.apis.controllers;

import java.security.Principal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.keycloak.adapters.springsecurity.token.KeycloakAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

	@GetMapping("/")
	String root() {
		return "Welcome to the root! You don't need any special permission to view this. It is " + new Date();
	}

	@GetMapping("/api/test")
	String test(Principal principal) {
		return "Hi there " + principal.getName()
				+ ". You must have the client role:user, otherwise you woldn't have been able to see this. In fact, your roles are: "
				+ getRoles(principal) + ". It is " + new Date();
	}

	@GetMapping("/api/editor/test")
	String editorTest(Principal principal) {
		return "Hi there " + principal.getName()
				+ ". You must have the client role:editor, otherwise you woldn't have been able to see this. In fact, your roles are: "
				+ getRoles(principal) + ". It is " + new Date();
	}

	private Set<String> getRoles(Principal principal) {
		KeycloakAuthenticationToken kp = (KeycloakAuthenticationToken) principal;
		HashSet<String> hashSet = new HashSet<String>();
		for (GrantedAuthority a: kp.getAuthorities()) {
			hashSet.add(a.getAuthority());
		}
		return hashSet;
	}

}