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
	
	public void sendSimpleMessage(String to, String subject, String text) {
		System.out.println("to: " + to + "/ subject: " + subject + "/ text: " + text);
		
		SimpleMailMessage message = new SimpleMailMessage();
		
        message.setTo(to);
        message.setFrom(senderMail);
        message.setSubject(subject);
        message.setText(text);
        
        emailSender.send(message);
	}
}
