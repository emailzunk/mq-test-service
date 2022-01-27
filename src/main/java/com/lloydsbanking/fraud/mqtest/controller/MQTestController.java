package com.lloydsbanking.fraud.mqtest.controller;


import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;



@RestController
@Configuration
public class MQTestController {

    @GetMapping("sendMessage")
    public String sendMessage(){
        return "OK";
    }

    @GetMapping("getMessage")
    public String getMessage(){
        return "TEST MESSAGE NOT FROM QUEUE!";
    }
}
