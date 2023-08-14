package com.hospital.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	public HomeController() {
	}
	
	@GetMapping("/")
	public String home() {
		return "home";
	}
	
	@GetMapping("/accessDenied")
	public String accessDenied() {
		return "accessError";
	}
}
