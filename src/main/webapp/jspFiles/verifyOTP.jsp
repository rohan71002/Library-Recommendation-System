	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ page import="java.sql.*" %>
	<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*, javax.activation.*" %>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body><% 
	
	String recipient = request.getParameter("mail");
	
	String enteredOTP = request.getParameter("otp");
	
	System.out.println("enteredOTP"+enteredOTP);
	
	String url = "jdbc:mysql://localhost:3306/lib_recommend_sys";
	
	String user = "root";
	
	String password = "7410";
	
	String connect="com.mysql.cj.jdbc.Driver";
	
	//JDBC variables for opening, closing, and managing a connection
	
		Connection connection = null;
			
		Statement statement = null;
			
		boolean log=false;
			
		String from = "demowork7410@gmail.com";
		
		String host = "smtp.gmail.com";
		
		String userr = "demowork7410@gmail.com"; // Replace with your Gmail username
		
		String passwordd = "hhqvxocbxzuwegrv"; // Replace with your Gmail password
		
		String result = "";
		
		String data_password="";
		
		// Email properties
			
			Properties properties = System.getProperties();
		
			properties.setProperty("mail.smtp.host", host);
			
			properties.setProperty("mail.smtp.auth", "true"); // Enable SMTP authentication
			
			properties.setProperty("mail.smtp.starttls.enable", "true"); // Enable TLS encryption
			
			properties.setProperty("mail.smtp.port", "587"); // Set the SMTP port for TLS
				
			// Create a Session object with authentication
			
			javax.mail.Session Session = javax.mail.Session.getInstance(properties, new javax.mail.Authenticator() {
				
			protected PasswordAuthentication getPasswordAuthentication() {
				
			return new PasswordAuthentication(userr, passwordd);
			
			}
			
			});
			
			try {
				
				
				Class.forName(connect);
				
				connection = DriverManager.getConnection(url, user, password);
				
				statement = connection.createStatement();
				
				String selectQuery = "SELECT email,password FROM signup WHERE email = '" + recipient + "'";
				
				ResultSet resultSet = statement.executeQuery(selectQuery);
				
				
				while (resultSet.next()) {
					
						// Retrieve data from the result set
						
				String data_email = resultSet.getString("email");
						
				String data_pass = resultSet.getString("password");
				
				System.out.println("Email from database: "+data_email);
				
				System.out.println("password from database: "+data_pass);
				
						// Output retrieved data to the web page
				data_password=data_pass;
				
				}
				
				String otp = (String) session.getAttribute("OTP");
				
				System.out.println("otpgetfromforgotjsp"+otp);
				
				String backupotp=otp;
				
				if (backupotp.equals(enteredOTP)) {
					
			        // Send password if OTP is correct
			        
			        MimeMessage passwordMessage = new MimeMessage(Session);
			        
			        passwordMessage.setFrom(new InternetAddress(from));
			        
			        passwordMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
			        
			        passwordMessage.setSubject("Password");
			        
			        passwordMessage.setText("Your password for " + recipient + " is " + data_password);
			        		
			        // Send password message
			        Transport.send(passwordMessage);
			        		
			        		
			    } else {
			        // Send response if OTP is incorrect
			    	response.getWriter().println("IncorrectOTP");
			    }
				// Create a default MimeMessage object
				
					} catch (MessagingException mex) {
						
					    mex.printStackTrace();	    
					}
			
	%>
	</body>
	</html>