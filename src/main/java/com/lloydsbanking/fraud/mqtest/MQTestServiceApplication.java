package com.lloydsbanking.fraud.mqtest;


import net.sf.JRecord.cg.Generate;
import net.sf.JRecord.cg.details.ArgumentOption;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;


@SpringBootApplication
@ComponentScan(basePackages = {"com.lloydsbanking.*"})
public class MQTestServiceApplication extends SpringBootServletInitializer {


    public static void main(String[] args) throws Exception {
        //SpringApplication.run(MQTestServiceApplication.class, args);
        System.out.println("Converting from cobol byte stream to Java");

        String[] arguments1 = {
                ArgumentOption.OPT_TEMPLATE, "pojoWithInterface",
                ArgumentOption.OPT_PACKAGE, "com.lbg",
                ArgumentOption.OPT_SCHEMA, "C:/Users/8519657/code/mq-test-service/src/main/resources/cobolfiles/NEW.COBCOPY",
                ArgumentOption.OPT_FILE_ORGANISATION, "FixedWidth",
                ArgumentOption.OPT_DROP_COPYBOOK_NAME, "true",
                ArgumentOption.OPT_OUTPUT_DIR, "C:/Users/8519657/code/mq-test-service/gen"
        };
        Generate.main(arguments1);


        System.out.println("Finished");

        System.out.println("Parsing Data File");

        //ReadFi12002i reader = new ReadFi12002i();
    }



    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {

        return application.sources(MQTestServiceApplication.class);
    }

}
