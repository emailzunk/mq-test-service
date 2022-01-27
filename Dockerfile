FROM combined-registry.sbx.zone/websphere-liberty:21.0.0.12-kernel-java8-ibmjava

# Copy server binaries
COPY target/liberty/wlp/lib /opt/ibm/wlp/lib
COPY target/liberty/wlp/dev /opt/ibm/wlp/dev

# Copy app
COPY target/liberty/wlp/usr/servers/defaultServer /config/

EXPOSE 9080
