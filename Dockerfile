FROM ubuntu AS builder
RUN apt update
RUN apt install openjdk-11-jre-dcevm -y 
RUN apt install maven -y && apt install git -y 
RUN git clone https://github.com/Pritam-Khergade/onlinebookstore.git
WORKDIR /java
COPY ./onlinebookstore /java
RUN mvn clean package


FROM tomcat
COPY --from=builder /java/target/*.war /usr/local/tomcat/webapps/
CMD ["catalina.sh","run"]
