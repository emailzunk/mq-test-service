# mq-test-service

[![Build Status](https://jenkins.fraud.secfraud.sbx.zone/buildStatus/icon?job=inbound-events-service/master)](https://jenkins.fraud.secfraud.sbx.zone/job/inbound-events-service/job/master/)

### Requirements
* Java 1.8
* Maven 3.3.1 or higher
  * We use [Maven Wrapper](https://github.com/takari/takari-maven-plugin) to ensure projects can have their own versions of Maven and not rely on the operating system
* Maven settings.xml to your ~/.m2/ folder

### Build

Use Maven to install dependencies and build the artifact:
```
./mvnw clean package
```

## Run

Run the application locally:

```
./mvnw liberty:run-server
```

View the application here: [http://localhost:9080](http://localhost:9080)

### JRecord POC

Run the main application to generate the java client files - update the line to your own machine - 

C:/Users/8519657/code/mq-test-service/src/main/resources/cobolfiles/NEW.COBCOPY

Once generated, you can use the file ReadNew.java to read in a data file (specified in the class) and output the contents to console

