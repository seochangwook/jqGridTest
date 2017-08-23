package com.gridsampleproject.application;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class GridSampleProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(GridSampleProjectApplication.class, args);
		
		System.out.println("Server Start...");
	}
}
