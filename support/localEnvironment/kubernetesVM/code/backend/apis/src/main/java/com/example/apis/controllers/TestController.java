package com.example.apis.controllers;

import java.security.Principal;
import java.util.Date;
import java.util.Set;

import org.keycloak.KeycloakPrincipal;
import org.keycloak.KeycloakSecurityContext;
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
		KeycloakPrincipal<KeycloakSecurityContext> kp = (KeycloakPrincipal<KeycloakSecurityContext>) principal;
		return kp.getKeycloakSecurityContext().getToken().getResourceAccess("myclient").getRoles();
	}

}