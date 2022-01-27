package com.lloydsbanking.fraud.mqtest.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import springfox.documentation.annotations.ApiIgnore;

@Controller
@Api(value = "doc", hidden = true)
@ApiIgnore
public class HomeController {

    @ApiOperation(httpMethod = "GET", value = "Swagger Definition")
    @GetMapping(value = "/")
    public String index() {
        return "redirect:swagger-ui.html";
    }
}
