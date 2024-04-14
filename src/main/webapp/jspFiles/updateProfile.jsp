<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String url = "jdbc:mysql://localhost:3306/lib_recommend_sys";
String user = "root";
String password = "7410";
String connect = "com.mysql.cj.jdbc.Driver";
Connection connection = null;
Statement statement = null;
String mail = (String) session.getAttribute("email");
String name=request.getParameter("name");
String phone = request.getParameter("phone");

try {
    Class.forName(connect);
    connection = DriverManager.getConnection(url, user, password);
    statement = connection.createStatement();
    String updateQuery = "UPDATE signup SET name = '" + name + "',phone = '" + phone + "'  WHERE email = '" + mail + "'";
    
    int rowsAffected = statement.executeUpdate(updateQuery);
    
    if (rowsAffected > 0) {
    	response.getWriter().println("change");
        System.out.println(rowsAffected + " row(s) updated successfully.");
    } else {
    	response.getWriter().println("Change");
        System.out.println("No rows updated.");
    }
    
} catch (SQLException | ClassNotFoundException e) {
    // Handle the exception more gracefully, either redirect to an error page or display a user-friendly message
    response.getWriter().println("Error connecting to the database: " + e.getMessage());
} finally {
   
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