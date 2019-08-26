FROM openjdk:8
MAINTAINER sathish vasu 
VOLUME /tmp
EXPOSE 9098 9099

RUN mkdir -p /opt/cdbg
RUN wget -qO- https://storage.googleapis.com/cloud-debugger/compute-java/debian-wheezy/cdbg_java_agent_gce.tar.gz | \
    tar xvz -C /opt/cdbg  


ADD ./target/schoolservice-0.0.1-SNAPSHOT.jar schoolservice-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java","-agentpath:/opt/cdbg/cdbg_java_agent.so==--logtostderr=1", "-Dcom.google.cdbg.module=schoolservice","-Dcom.google.cdbg.version=0.0.1-SNAPSHOT","-jar","schoolservice-0.0.1-SNAPSHOT.jar"]




#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","schoolservice-0.0.1-SNAPSHOT.jar"]


#ARG DEPENDENCY=target/dependency
#COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
#COPY ${DEPENDENCY}/META-INF /app/META-INF
#COPY ${DEPENDENCY}/BOOT-INF/classes /app
#ENTRYPOINT ["java","-cp","app:app/lib/*","com.schoolservice.SchoolServiceApplication"]
