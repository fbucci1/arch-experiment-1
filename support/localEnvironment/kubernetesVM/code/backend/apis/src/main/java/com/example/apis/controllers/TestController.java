package com.example.apis.controllers;

import java.util.Date;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

	@GetMapping("/")
	String root() {
		return "Welcome to the root! " + new Date() ;
	}

	@GetMapping("/error")
	String error() {
		return "This is an error! " + new Date() ;
	}

	@GetMapping("/api/test")
	String test() {
		return "Hi there at " + new Date() ;
	}
}