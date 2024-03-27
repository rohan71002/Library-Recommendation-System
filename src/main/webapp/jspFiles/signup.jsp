<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // JDBC URL, username, and password of MySQL server
    String url = "jdbc:mysql://localhost:3306/lib_recommend_sys";
    String user = "root";
    String password = "7410";
    String connect = "com.mysql.cj.jdbc.Driver";
    
    // Variables to store form data
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String pass = request.getParameter("password");
    String role = request.getParameter("role");
    
    // Initialize JSON object for response
    JSONObject jsonResponse = new JSONObject();
    
    // JDBC variables for opening, closing, and managing a connection
    Connection connection = null;
    Statement statement = null;
    
    try {
        // Load the JDBC driver
        Class.forName(connect);

        // Establish a connection
        connection = DriverManager.getConnection(url, user, password);

        // Create a statement
        statement = connection.createStatement();
        String selectQuery = "SELECT email FROM signup WHERE email = '" + email + "'";
        ResultSet resultSet = statement.executeQuery(selectQuery);
        boolean emailExists = resultSet.next();
        
        if(emailExists) {
            // Email already exists
            jsonResponse.put("success", false);
        } else {
            // Email does not exist, insert into database
            String insertQuery = "INSERT INTO signup (email, password, role, name, phone) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, pass);
            preparedStatement.setString(3, role);
            preparedStatement.setString(4, name);
            preparedStatement.setString(5, phone);
            preparedStatement.executeUpdate();
            jsonResponse.put("success", true);
        }
    } catch (SQLException | ClassNotFoundException e) {
        // Handle the exception
        e.printStackTrace();
        // Set error response
        jsonResponse.put("error", "An error occurred while processing your request");
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
            e.printStackTrace();
            // Set error response
            jsonResponse.put("error", "An error occurred while closing database connection");
        }
    }
    
    // Set content type and write JSON response
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(jsonResponse.toString());
%>
