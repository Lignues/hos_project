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
	
	@GetMapping("/introduce/howToCome")
	public void howToGo() {}
	
	@GetMapping("/introduce/docIntroduce")
	public void docIntroduce() {}
	
	@GetMapping("/introduce/hosIntroduce")
	public void hosIntroduce() {}
	
	@GetMapping("/introduce/subjects")
	public void hosSubjects() {}
	
	@GetMapping("/accessDenied")
	public String accessDenied() {
		return "accessError";
	}
}
