package com.gridsampleproject.application.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class MainController {
	@Value("${session.name}")
	private String name;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
    public ModelAndView main(ModelAndView mv){
		System.out.println("normal home page");
		System.out.println("name: " + name);
		
		mv.setViewName("main");
		
		return mv;
    }
}
