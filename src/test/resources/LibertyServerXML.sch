<?xml version="1.0" encoding="UTF-8"?>




<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

    <sch:title>Early Gateway Liberty Server.xml validator</sch:title>
    <sch:pattern>
        <sch:rule context="/server">
            <!-- Check httpEndpoint configuration -->

		<sch:assert test="count(featureManager|webContainer|keyStore|sslDefault|ssl|httpEndpoint|pluginConfiguration|httpDispatcher|webAppSecurity|httpSession|applicationManager|requestTiming|eventLogging|logging|applicationMonitor|library|messagingEngine|jmsQueue|jmsActivationSpec|jmsQueueConnectionFactory|connectionManager|dataSource|managedExecutorService|enterpriseApplication|wasJmsEndpoint|executor|application|webApplication|sslOptions|jaasLoginContextEntry|jaasLoginModule) = count(*)">
			Only "featureManager|webContainer|keyStore|sslDefault|ssl|httpEndpoint|pluginConfiguration|httpDispatcher|webAppSecurity|httpSession|applicationManager|requestTiming|eventLogging|logging|applicationMonitor|library|messagingEngine|jmsQueue|jmsActivationSpec|jmsQueueConnectionFactory|connectionManager|dataSource|managedExecutorService|enterpriseApplication|wasJmsEndpoint|executor|application|webapplication|sslOptions|jaasLoginContextEntry|jaasLoginModule" elements are allowed as children of "server".
		</sch:assert>


			<sch:let name="ID" value="@id"/>
			
            <sch:assert test="count(httpEndpoint[@id='defaultHttpEndpoint'])=1">
                [ERROR] defaultEndpoint must exist once.  &lt;httpEndpoint id="defaultEndpoint"&gt;
            </sch:assert>

            <sch:assert test="count(logging)>=1">
                [ERROR] The logging element must exist at least once.  &lt;logging&gt;
            </sch:assert>
            <!-- Check featureManager configuration -->
            <sch:assert test="boolean(featureManager/feature[contains(., 'ssl-1.0')])">
                [ERROR] ssl feature must be enabled &lt;feature&gt; ssl-1.0 &lt;/feature&gt;
            </sch:assert>
            <sch:assert test="boolean(featureManager/feature[contains(., 'monitor-1.0')])">
                [ERROR] monitor feature must be enabled &lt;feature&gt; monitor-1.0 &lt;/feature&gt;
            </sch:assert>
            
            <sch:assert test="boolean(featureManager/feature[contains(., 'requestTiming-1.0')])">
                [ERROR] requestTiming feature must be enabled &lt;feature&gt; requestTiming-1.0 &lt;/feature&gt;
            </sch:assert>
            <sch:assert test="count(requestTiming)=1">
                [ERROR] The requestTiming element must exist once.  &lt;requestTiming&gt;
            </sch:assert>
            
            <sch:assert test="not (boolean(featureManager/feature[contains(., 'eventLogging-1.0')]))">
                [ERROR] eventLogging feature must be enabled through overrides &lt;feature&gt; eventLogging-1.0 &lt;/feature&gt;
            </sch:assert>
            
            <sch:assert test="not(boolean(featureManager/feature[contains(., 'adminCenter-1.0')]))">
                [ERROR] adminCenter feature must NOT be enabled 
            </sch:assert>
                        
            <sch:assert test="not(count(eventLogging)=1)">
                [ERROR] The eventLogging element must not exist.  This feature will be enabled by the UC process.  &lt;eventLogging&gt;
            </sch:assert>
            

            <sch:assert test="(httpDispatcher/@enableWelcomePage) = 'false'">
                 [CRITICAL][SECURITY] enableWelcomePage should be false. &lt;httpDispatcher enableWelcomePage="false"/&gt;
            </sch:assert>
            <sch:assert test="count(httpSession)=1">
                 [CRITICAL][SECURITY] httpSession element is required once
            </sch:assert>    
            <sch:assert test="count(webAppSecurity) = 1">
                 [CRITICAL][SECURITY] Element webAppSecurity is required once
            </sch:assert>  
              
            <sch:assert test="(applicationMonitor/@dropinsEnabled) = 'false'">
                 [ERROR] dropins directory should be disabled. &lt;applicationMonitor dropinsEnabled="false"/&gt;
            </sch:assert>    
            
            <sch:assert test="boolean(sslDefault)">
                 [ERROR] Element sslDefault must be enabled
            </sch:assert>   
            
               
            
            <sch:assert test="(ssl/@id) = 'defaultSSLConfig'">
                 [CRITICAL][SECURITY] ssl id='defaultSSLConfig' does not exist
            </sch:assert>       
            
            <sch:assert test="count(basicRegistry) = 0">
                 [CRITICAL][SECURITY] the application should not set the Basic Registry
            </sch:assert>   

            
            <sch:assert test="count(administrator-role) = 0">
                 [CRITICAL][SECURITY] the application should not set the administrator-role
            </sch:assert>     
                        
           <sch:assert test="count(pluginConfiguration) = 1">
                 [WARN] pluginConfiguration should be set once
            </sch:assert>   

            <sch:assert test="count(keyStore[@id='defaultTrustStore']) = 1">
                 [CRITICAL][SECURITY] Element defaultTrustStore is required once
            </sch:assert>  

            <sch:assert test="count(keyStore[@id='defaultKeyStore']) = 1">
                 [CRITICAL][SECURITY] Element defaultKeyStore is required once
            </sch:assert>  
            
        </sch:rule>
        
        

    
  
       <!-- Check mqtt configuration -->  
        <sch:rule context="featureManager/feature[contains(., 'rtcomm-1.0')]">
        	<sch:assert test="count(mqttTcpEndpoint) = 1">
            	     [CRITICAL][SECURITY] The rtcomm feature is enabled.  The mqttTcpEndpoint element should be defined once
            </sch:assert>  
    
        </sch:rule>    
  
  
       <!-- Check orb configuration -->  
        <sch:rule context="featureManager/feature[contains(., 'ejbRemote-3.2')]">
        	<sch:report test="count(//orb) &lt; 1">
            	     [CRITICAL][SECURITY] The ejbRemote feature is enabled.  The orb element should be defined once.  This should be handled in the overrides file setup in UC
            </sch:report>  
    
        </sch:rule>    
    
       <!-- Check orb configuration -->  
        <sch:rule context="featureManager/feature[contains(., 'ejb-3.2')]">
        	<sch:report test="count(//orb) = 1">
            	     [CRITICAL][SECURITY] The ejb feature is enabled.  The orb element should be defined once
            </sch:report>  
    
        </sch:rule>
        
        <sch:rule context="featureManager/feature[contains(., 'javaee-7.0')]">
        	<sch:report test="count(//orb) = 1">
            	     [CRITICAL][SECURITY] The orb element should be defined once
            </sch:report>  
    
        </sch:rule>
        
        
        <sch:rule context="featureManager/feature[contains(., 'wasJmsServer-1.0')]">
        	<sch:assert test="count(//wasJmsEndpoint) = 1">
            	     [CRITICAL][SECURITY] The wasJmsServer-1.0 is enabled.  The wasJmsEndpoint element must be defined
            </sch:assert>  
    
        </sch:rule>          
    
        
          <!-- Check plugin configuration -->  
        <sch:rule context="pluginConfiguration">
       
            <sch:assert test="@connectTimeout[matches(.,'([1-5]$)')]">
                [ERROR][PERFORMANCE] pluginConfiguration connectTimeout should be set &lt; 5s
            </sch:assert>
            
			<sch:assert test="@serverIOTimeout[matches(.,'([1-9]|[1-9][0-9]|[1-2][0-9][0-9]|300)($)')]">
                [ERROR][PERFORMANCE] pluginConfiguration sererIOTimeout should be set &lt; 300s
            </sch:assert>            
        </sch:rule>
        

      <!-- Check mqtt configuration -->  
        <sch:rule context="mqttTcpEndpoint">
          <sch:assert test="(@id)='defaultMqttEndpoint'">
                [ERROR]  mqttTcpEndpoint must have id defaultMqttEndpoint
            </sch:assert>
            <sch:assert test="(@mqttTcpPort)=-1">
                [ERROR]  mqttTcpEndpoint must have mqttTcpPort = -1
            </sch:assert>
            <sch:assert test="(@mqttSslPort)>10000">
                [ERROR]  mqttTcpEndpoint must have mqttSslPort > 10000
            </sch:assert>
            <sch:assert test="(@sslRef)='memberConnectionConfig'">
                [ERROR]  mqttTcpEndpoint must have sslRef='memberConnectionConfig'
            </sch:assert>
       </sch:rule>        
        
      <!-- Check jmsServer configuration -->  
        <sch:rule context="wasJmsEndpoint">
          <sch:assert test="((sslOptions/@sslRef) = 'memberConnectionConfig') or ((@wasJmsSSLPort)=-1)">
                [CRITICAL][SECURITY] wasJmsEndpoint sslOptions sslRef must be configured to use memberConnectionConfig ssl setup.
            </sch:assert>
            <sch:assert test="(@wasJmsPort)=-1">
                [ERROR]  wasJmsEndpoint wasJmsPort must = -1
            </sch:assert>
       </sch:rule>                
            
      <!-- Check iiopEndpoint configuration -->  
        <sch:rule context="orb">
          <sch:assert test="(boolean(//iiopEndpoint[@id=@iiopEndpointRef]) or (iiopEndpoint)) and count(//iiopEndpoint)=1">
                [ERROR]  orb iiop endpoint must be configured with an iiopEndpoint.
            </sch:assert>
       </sch:rule>        
        
        
      <!-- Check iiopEndpoint configuration -->  
        <sch:rule context="iiopEndpoint">
        <sch:let name="ID" value="@id"/>
            <sch:assert test="(iiopsOptions/@sslRef) = 'memberConnectionConfig'">
                [ERROR] ID=<sch:value-of select="$ID"/>: orb iiop endpoint must be configured to use memberConnectionConfig ssl setup.
            </sch:assert>
            
            <sch:assert test="(iiopsOptions/@iiopsPort) > 10000">
                [ERROR] ID=<sch:value-of select="$ID"/>: orb iiopsPort must be defined
            </sch:assert>
        </sch:rule>        
        
                
      <!-- Check httpEndpoint configuration -->  
        <sch:rule context="httpEndpoint[@id='defaultHttpEndpoint']">
        <sch:let name="ID" value="@id"/>
            <!-- Check httpEndpoint configuration -->
            <sch:assert test="(@host) = '*'">
                [ERROR] ID=<sch:value-of select="$ID"/>: host should be set to * &lt;httpEndpoint host="*"/&gt;
            </sch:assert>
            <sch:assert test="(@httpPort) = -1  or (@httpPort) = '9080' or (@httpPort) = '${env.PORT}' ">
                [ERROR] ID=<sch:value-of select="$ID"/>: httpPort should be disabled with -1 &lt;httpEndpoint httpPort="-1"/&gt;
            </sch:assert>
            <sch:assert test="@httpsPort = -1  or (@httpsPort) >= 10000">
                [ERROR] ID=<sch:value-of select="$ID"/>: httpsPort should be >= 10000
            </sch:assert>
            <sch:assert test="boolean(//httpOptions[@id=@httpOptionsRef]) or (httpOptions)">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: httpEndpoint must reference a httpOptionsRef or contain a httpOptions element &lt;httpEndpoint /&gt;
            </sch:assert>
            <sch:assert test="@sslOptionsRef=//sslOptions/@id and @sslOptionsRef = 'memberSSLOptions'">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: httpEndpoint must reference a sslOptionsRef &lt;httpEndpoint /&gt;
            </sch:assert>            
        </sch:rule>
        
          <!-- Check memberSSLOptions configuration -->  
        <sch:rule context="sslOptions[@id='memberSSLOptions']">
        	<sch:let name="ID" value="@id"/>
            <sch:assert test="@sslRef=//ssl/@id">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: sslOptions must reference a sslRef &lt;sslOptions sslRef="xxxxx"/&gt;
            </sch:assert>            
        </sch:rule>


        

        
        <!-- default SSL Config -->
        <sch:rule context="sslDefault">
        	<sch:let name="ID" value="@id"/>        
            <sch:assert test="(@sslRef='defaultSSLConfig') and (@sslRef=//ssl/@id)">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: sslDefault element must reference a valid ssl configuration.
            </sch:assert>         
        </sch:rule>
        
        
        
        <!-- Check defaultSSLConfig configuration -->  
        <sch:rule context="ssl[@id='defaultSSLConfig']">
        	<sch:let name="ID" value="@id"/>
        	
            <sch:report test="not(@sslProtocol='TLSv1.2')">
                [WARN][SECURITY] ID=<sch:value-of select="$ID"/>: sslProtocol SHOULD be TLSv1.2.  Has the application justified not using TLSv1.2
            </sch:report>           
           <sch:assert test="(@keyStoreRef='defaultKeyStore') and (@keyStoreRef=//keyStore/@id)">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: keyStoreRef must be named 'defaultKeyStore' and a keyStore must exist. 
            </sch:assert>                                              
           <sch:assert test="@trustStoreRef='defaultTrustStore' and (@trustStoreRef=//keyStore/@id)">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: trustStoreRef must be 'defaultKeyStore' and a keystore must exist.
            </sch:assert>
            <sch:report test="not(@securityLevel='HIGH')">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: security Level must be HIGH
            </sch:report>                                       
        </sch:rule>
        

        
        <!-- Check defaultkeyStore configuration -->
        <sch:rule context="keyStore[@id='defaultKeyStore']">
        	<sch:let name="ID" value="@id"/>
            <sch:assert test="@id=//ssl/@keyStoreRef">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: default keyStore must reference a ssl keyStoreRef 
            </sch:assert>            
            <sch:assert test="@location='${server.config.dir}/resources/security/default_key.jks'">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: keyStore must be located at: ${server.config.dir}/resources/security/default_key.jks
            </sch:assert>  
        </sch:rule> 

        <!-- Check defaulttrustStore configuration -->
        <sch:rule context="keyStore[@id='defaultTrustStore']">
        	<sch:let name="ID" value="@id"/>
            <sch:assert test="@id=//ssl/@trustStoreRef">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: trustStore must reference a ssl trustStoreRef 
            </sch:assert>            
            <sch:assert test="@location='${server.config.dir}/resources/security/default_trust.jks'">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: Trust Store must be located at: ${server.config.dir}/resources/security/default_trust.jks
            </sch:assert>  
        </sch:rule>
        
        
        <!-- Check httpSession configuration -->
        <sch:rule context="httpSession">
            <sch:assert test="(@allowOverflow) = 'false'">
                [ERROR] http session must not overflow
            </sch:assert>            
            <sch:assert test="(@maxInMemorySessionCount) &lt;= 1000 and (@maxInMemorySessionCount) > 500">
                [ERROR] maxInMemorySessionCount should be set to &lt;= 1000 and &gt;= 500
            </sch:assert>                        
            <sch:assert test="(@cookieSecure) = 'true'">
                [ERROR] http JSESSIONID must be set secure
            </sch:assert>                                    
        </sch:rule>

        <!-- Check webAppSecurity configuration -->
        <sch:rule context="webAppSecurity">
            <sch:assert test="(@ssoRequiresSSL) = 'true'">
                [CRITICAL][SECURITY] ssoRequireSSL must be true
            </sch:assert>            
        </sch:rule>

        
        <!-- Check httpOptions configuration -->
        <sch:rule context="httpOptions">
        <sch:let name="ID" value="@id"/>
            <sch:assert test="(@readTimeout[matches(.,'([1-9])(s$)')])">
                [ERROR] readTimeout should be set to &lt; 10 &lt;httpOptions readTimeout="5"/&gt;
            </sch:assert>            
            <sch:assert test="(@writeTimeout[matches(.,'([1-9])(s$)')])">
                [ERROR] writeTimeout should be set to &lt; 10 &lt;httpOptions writeTimeout="5"/&gt;
            </sch:assert>
            <sch:assert test="(@removeServerHeader) = 'true'">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: httpEndpoint must remove ServerHeader &lt;httpEndpoint removeServerHeader="true"/&gt;
            </sch:assert>                        
        </sch:rule>
        
        
        <!-- Check eventLogging configuration -->
        <sch:rule context="eventLogging">
            <sch:assert test="(@minDuration) = '5000ms'">
                [ERROR] minDuration should be 500ms &lt;eventLogging minDuration="5000ms"/&gt;
            </sch:assert>            
            <sch:assert test="(@includeContextInfo)='true'">
                [ERROR] includeContextInfo &lt;eventLogging includeContextInfo="true"/&gt;
            </sch:assert>
            <sch:assert test="(@sampleRate)='1'">
                [ERROR] sampleRate should be 1 &lt;eventLogging sampleRate="1"/&gt;
            </sch:assert>            
            <sch:assert test="(@logMode) = 'exit'">
                [ERROR] logMode should be exit &lt;eventLogging logMode="exit"/&gt;
            </sch:assert>
        </sch:rule>
        
        
        <!-- Check requestTiming configuration -->        
        <sch:rule context="requestTiming">
        <sch:let name="ID" value="@id"/>
            <sch:assert test="(@includeContextInfo)='true'">
                [ERROR] ID=<sch:value-of select="$ID"/>: includeContextInfo &lt;requestTiming includeContextInfo="true"/&gt;
            </sch:assert>        
            <sch:assert test="(@slowRequestThreshold)='10s'">
                [ERROR] slowRequestThreshold must be 10s &lt;requestTiming slowRequestThreshold="10s"/&gt;
            </sch:assert>
            <sch:assert test="(@hungRequestThreshold)='50s'">
                [ERROR] hungRequestThreshold must be 50s &lt;requestTiming hungRequestThreshold="50s"/&gt;
            </sch:assert>
            <sch:assert test="(@sampleRate)='1'">
                [ERROR] sampleRate should be 1 &lt;requestTiming sampleRate="1"/&gt;
            </sch:assert>      
        </sch:rule>

        <sch:rule context="logging">
        <!-- Check httpEndpoint configuration -->
            <sch:assert test="(@maxFiles)=50">
                [ERROR] maxFiles should be 50 &lt;logging maxFiles="50"/&gt;
            </sch:assert>
        <!--    <sch:assert test="@logDirectory[matches(.,'^/logs/.')]">
                [ERROR] logDirectory must be set &lt;logging logDirectory="/logs/."/&gt;
            </sch:assert>  -->          
            <sch:assert test="(@maxFileSize) = 20">
                [ERROR] maxFileSize should be 20 &lt;logging maxFileSize="20"/&gt;
            </sch:assert>
            <sch:assert test="(@copySystemStreams) = 'false' or (@copySystemStreams) = 'true'">
                [ERROR] copySystemStreams should be set to false.  (this may be set in the bootstrap.properties file: com.ibm.ws.logging.copy.system.streams=false)
            </sch:assert>            
        </sch:rule>     

        

        
        
        <!-- Check dataSource configuration -->
        <sch:rule context="dataSource">
        
        <sch:let name="ID" value="@id"/>
        <sch:let name="connectionProperties" value="properties.oracle/@connectionProperties"/>
        
                        
        <sch:assert test="@queryTimeout &lt;= 120">
        
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: datasource should have a queryTimeout.  
                The queryTimeout must NOT exceed the oracle.jdbc.ReadTimeout.  This is NOT checked by this tool!
            </sch:assert>                        

            <sch:assert test="count(properties.oracle/@userName)=0">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: datasource should NOT have a userName.  Use a Authentication Alias instead&gt;
            </sch:assert>
            
            <sch:assert test="count(properties.oracle/@password)=0">
                [CRITICAL][SECURITY] ID=<sch:value-of select="$ID"/>: datasource should NOT have a password.  Use a Authentication Alias instead&gt;
            </sch:assert>

       		<sch:assert test="(boolean(//connectionManager[@id=@connectionManagerRef]) or connectionManager) and (count(//connectionManager[@id=@connectionManagerRef]) + count(connectionManager) = 1 )">
                [ERROR][PERFORMANCE] ID=<sch:value-of select="$ID"/>: The datasource connectionManager configuration is incorrect.  It either does not use a connection manager or specifies both a connectionManagerRef and a connectionManager.
            </sch:assert>

       		<sch:assert test="boolean(properties.oracle/@connectionProperties[matches(.,'oracle\.jdbc\.ReadTimeout=([1-9]|[1-9][0-9]|1[0-1][1-9])(000;|000$)')])">
                [ERROR][PERFORMANCE] ID=<sch:value-of select="$ID"/>: oracle.jdbc.ReadTimeout=[1-120] must be set;
                     <sch:value-of select="$connectionProperties"/>
            </sch:assert>

       		<sch:assert test="boolean(properties.oracle/@loginTimeout[matches(.,'([1-5])(s$)')])">
                [ERROR][PERFORMANCE] ID=<sch:value-of select="$ID"/>: loginTimeout=[1-5]s must be set;
                     <sch:value-of select="$connectionProperties"/>
            </sch:assert>  

        </sch:rule>    
        
        

                
    </sch:pattern>
    
    

</sch:schema>


