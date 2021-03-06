package com.gridsampleproject.application.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class MailUtil {
	@Autowired
    public JavaMailSender emailSender;
	
	@Value("${spring.mail.username}")
	private String senderMail;
	
	public void sendSimpleMessage(String to, String name) {
		System.out.println("to: " + to + "/ name: " + name);
		
		SimpleMailMessage message = new SimpleMailMessage();
		
        message.setTo(to);
        message.setFrom(senderMail);
        message.setSubject("[" + name +"] Hello - Dreaming developer");
        message.setText("test email");
        
        emailSender.send(message);
	}
}
