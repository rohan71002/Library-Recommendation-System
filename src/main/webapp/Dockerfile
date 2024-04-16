# Use the OpenJDK image as the base
FROM openjdk:latest

# Create a directory to store your application files in the container
RUN mkdir -p /usr/src/app

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the application JAR file into the container
COPY lib_book_recommendation_sys.war /lib_recomend_sys/src/main/webapp/

# Command to run the application
CMD ["java", "-jar", "lib_book_recommendation_sys.war"]
