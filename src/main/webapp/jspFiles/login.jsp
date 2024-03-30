<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MySQL Connection Example</title>
</head>
<body>
 
    <% 
        // JDBC URL, username, and password of MySQL server
        String url = "jdbc:mysql://localhost:3306/lib_recommend_sys";
        String user = "root";
        String password = "7410";
		String connect="com.mysql.cj.jdbc.Driver";
        // JDBC variables for opening, closing, and managing a connection
        Connection connection = null;
        Statement statement = null;
        String email = request.getParameter("mail");
        System.out.println("email"+email);
        String pass =  request.getParameter("pass");
        System.out.println("pass"+pass);
        boolean log=false;
        

        try {
            // Load the JDBC driver
            Class.forName(connect);

            // Establish a connection
            connection = DriverManager.getConnection(url, user, password);

            // Create a statement
            statement = connection.createStatement();

            // Execute a SELECT query
            String selectQuery = "SELECT email, password FROM signup WHERE email = '" + email + "'";
ResultSet resultSet = statement.executeQuery(selectQuery);


            // Process the ResultSet
	            while (resultSet.next()) {
	                // Retrieve data from the result set
	                String data_email = resultSet.getString("email");
	                String data_pass = resultSet.getString("password");
	                System.out.println("data_email"+data_email);
	                System.out.println("data_pass"+data_pass);
	                // Output retrieved data to the web page
	                if(data_email.equals(email) && data_pass.equals(pass) ){	
	                	
	                	log=true;
	                	break;
	                }
	            }
	            System.out.println(log);
	                if(log){
	                	response.getWriter().println("success");
	                
	                }

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

</body>
</html>
