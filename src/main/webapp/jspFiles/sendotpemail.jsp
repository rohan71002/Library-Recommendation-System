	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
	<%@ page import="java.sql.*" %>
	
	<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*, javax.activation.*" %>
	
	<!DOCTYPE html>
	
	<html>
	
	<head>
	
	<meta charset="UTF-8">
	
	<title>Send OTP</title>
	
	</head>
	
	<body>
	
	<%
	
		// Retrieve the email address from the request
	
	String recipient = request.getParameter("mail");
	
	String url = "jdbc:mysql://localhost:3306/lib_recommend_sys";
	
	String user = "root";
	
	String password = "7410";
	
	String connect="com.mysql.cj.jdbc.Driver";
	
	
			// JDBC variables for opening, closing, and managing a connection
	Connection connection = null;
					
	Statement statement = null;
					
	boolean log=false;
	
			// Your Gmail credentials
				
	String from = "demowork7410@gmail.com";
			
	String host = "smtp.gmail.com";
	
	String userr = "demowork7410@gmail.com"; // Replace with your Gmail username
	
	String passwordd = "hhqvxocbxzuwegrv"; // Replace with your Gmail password
	
	String result = "";
	
	String data_password="";
	
	String oldotp="";	
	
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
	
	
			// Output retrieved data to the web page
			
	data_password=data_pass;
			
	if(data_email.equals(recipient)){	
		
	log=true;
	
	break;
	
	}
	
	}
	
	if (log) {
	
	Random random = new Random();
        
	int otpLength = 6; // OTP length
	
	StringBuilder otp = new StringBuilder(otpLength);
	
	for(int i = 0; i < otpLength; i++) {
		
	otp.append(random.nextInt(10));
	
	}
	
	String otpString = otp.toString();
	
	
	System.out.println("Generated OTP: " + otpString);
	
        MimeMessage message = new MimeMessage(Session);
        
        message.setFrom(new InternetAddress(from));
        
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        
        message.setSubject("OTP for verify email");
        		
        message.setText("Your one-time password is " + otpString);
        		
        // Send message
        
        Transport.send(message);
        
        session.setAttribute("OTP", otpString);

        // Compare entered OTP with generated OTP
        
    } else {
        // Send response if email does not exist
        response.getWriter().println("EmailExists");
    }
	
	// Create a default MimeMessage object
		} catch (MessagingException mex) {
		    mex.printStackTrace();	    
		}
		%>
	</body>
	</html>