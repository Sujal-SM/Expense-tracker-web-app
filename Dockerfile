#first stage building jar files
FROM maven:3.8.3-openjdk-17 AS builder

#working dir
WORKDIR /app

#copying from local to container
COPY . .

#installing maevn package so there's no issue
RUN mvn clean install -DskipTests=true

#2nd stage 
FROM openjdk:17-alpine 

#creating work dir
WORKDIR /app

#copy from builder cuz all the files containing jar file are in /app/target we copy this in current directory
COPY --from=builder /app/target/*.jar /app/expensesapp.jar

#exposing port
EXPOSE 8000

#making it executable or run
CMD [ "java" , "-jar", "expensesapp.jar"]