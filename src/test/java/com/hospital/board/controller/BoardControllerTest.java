package com.hospital.board.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hospital.board.appTest;

import lombok.extern.log4j.Log4j;

@Log4j
public class BoardControllerTest extends appTest{

	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	ObjectMapper objectMapper;
	
	@Before
	public void setUp() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
		objectMapper = Jackson2ObjectMapperBuilder.json().build();
	}
	
	@Test
//	@Ignore
	public void testList() throws Exception {
		ModelAndView modelAndView = mockMvc.perform(get("/board/list")).andReturn().getModelAndView();
		Map<String, Object> model = modelAndView.getModel();
//		log.info(model);
		System.out.println(model);
	}

}
