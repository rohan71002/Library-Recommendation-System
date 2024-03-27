<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*, javax.activation.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
</head>
<body>
<%
String recipient = request.getParameter("mail");
String from = "demowork7410@gmail.com";
String host = "smtp.gmail.com";
String user = "demowork7410@gmail.com"; // Replace with your Gmail username
String password = "hhqvxocbxzuwegrv"; // Replace with your Gmail password
Random random = new Random();
int otpLength = 6; // OTP length
StringBuilder otp = new StringBuilder(otpLength);
for(int i = 0; i < otpLength; i++) {
    otp.append(random.nextInt(10));
}
System.out.println(otp);

Properties properties = System.getProperties();
properties.setProperty("mail.smtp.host", host);
properties.setProperty("mail.smtp.auth", "true"); // Enable SMTP authentication
properties.setProperty("mail.smtp.starttls.enable", "true"); // Enable TLS encryption
properties.setProperty("mail.smtp.port", "587"); // Set the SMTP port for TLS

// Create a Session object with authentication
javax.mail.Session Session = javax.mail.Session.getInstance(properties, new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(user, password);
    }
});

try {
    // Create a default MimeMessage object
    MimeMessage message = new MimeMessage(Session);
    message.setFrom(new InternetAddress(from));
    message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
    message.setSubject("OTP for Forgot Password");
    message.setText("Your one time password is"+otp);

    // Send message
    Transport.send(message);
   %>
   <script>
    Swal.fire({
             title: 'Success',
             text: 'OTP Sent Successfully',
             icon: 'Success',
              confirmButtonText: 'OK'
                    });
   </script><%
String enteredOTP = request.getParameter("otp");
    
    // Verify OTP
    if (enteredOTP != null && enteredOTP.equals(otp)) {
        // OTP is verified, show success message or redirect to a success page
%>
        <script>
    Swal.fire({
             title: 'Success',
             text: 'OTP Sent Successfully',
             icon: 'Success',
              confirmButtonText: 'OK'
                    });
   </script>
<%
    } else {
        // OTP verification failed, show error message or redirect to a failure page
%>
        <script>
    Swal.fire({
             title: 'Verification Failed',
             icon: 'error',
              confirmButtonText: 'OK'
                    });
   </script>
<%
    }

} catch (MessagingException mex) {
    mex.printStackTrace();
}
%>
</body>
</html>
