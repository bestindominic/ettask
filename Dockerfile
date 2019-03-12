FROM bestind/job-task:javabaseimage

WORKDIR /app

ADD . /app

ENV MAVEN_HOME /opt/maven

RUN cd /app && mvn package

EXPOSE 8080
RUN ls -lrth /app/target/hello-dropwizard-1.0-SNAPSHOT.jar

CMD ["java","-jar","/app/target/hello-dropwizard-1.0-SNAPSHOT.jar","server","example.yaml"]
