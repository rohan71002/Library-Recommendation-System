<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.concurrent.TimeUnit" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<% 
        // JDBC URL, username, and password of MySQL server
        String url = "jdbc:mysql://localhost:3306/lib_recommend_sys";
        String user = "root";
        String password = "7410";
		String connect="com.mysql.cj.jdbc.Driver";
        // JDBC variables for opening, closing, and managing a connection
        Connection connection = null;
        Statement statement = null;
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String pass=request.getParameter("pword");
        String cnfpassword = request.getParameter("cnfpword");
        String role = request.getParameter("role");
        String genre= null;
        boolean log=false;
       
        try {
            // Load the JDBC driver
            Class.forName(connect);
            // Establish a connection
            connection = DriverManager.getConnection(url, user, password);
            // Create a statement
            statement = connection.createStatement();
            String selectQuery = "SELECT email FROM signup WHERE email = '" + email + "'";
            ResultSet resultSet = statement.executeQuery(selectQuery);
            while (resultSet.next()) {
                // Retrieve data from the result set
                String data_email = resultSet.getString("email");
                
                // Output retrieved data to the web page
                if(data_email.equals(email)){	
                	log=true;
                	break;
                }
            }
      
            if(!log)
            {
            	String insertQuery = "INSERT INTO signup VALUES ('" + email + "','" + pass + "','" + role + "','" + name + "','" + phone + "','"+ genre +"');";
                statement.executeUpdate(insertQuery);
                response.getWriter().println("success");
            }
          
            // Execute a SELECT query
            
        } catch (SQLException | ClassNotFoundException e) {
            // Handle the exception more gracefully, either redirect to an error page or display a user-friendly message
            response.getWriter().println("Error connecting to the database: " + e.getMessage());
        } finally {
            // Close resources in the finally block to ensure they are always closed
            try {
                if (statement != null && !statement.isClosed()) {
                    statement.close();
                }
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                response.getWriter().println("Error closing the database connection: " + e.getMessage());
            }
        }
    %>
    <script src="../script/signup.js"></script>
</body>
</html>