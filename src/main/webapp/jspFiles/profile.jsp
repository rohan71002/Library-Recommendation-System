<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject" %>

<%
String url = "jdbc:mysql://localhost:3306/lib_recommend_sys";
String user = "root";
String password = "7410";
String connect = "com.mysql.cj.jdbc.Driver";
Connection connection = null;
Statement statement = null;
String mail = (String) session.getAttribute("email");

try {
    Class.forName(connect);
    connection = DriverManager.getConnection(url, user, password);
    statement = connection.createStatement();
    String selectQuery = "SELECT Name , phone , role  FROM signup WHERE email = '" + mail + "'";
    ResultSet resultSet = statement.executeQuery(selectQuery);
    
    JSONObject userData = new JSONObject();
    
    while (resultSet.next()) {
        String dataName = resultSet.getString("Name");
        String dataRole  = resultSet.getString("role");
        String dataPhone = resultSet.getString("phone");
        
        userData.put("name", dataName);
        userData.put("role", dataRole);
        userData.put("phone", dataPhone); 
    }
    
    response.setContentType("application/json");
    response.getWriter().print(userData.toJSONString());
    
} catch (SQLException e) {
    e.printStackTrace();
    response.getWriter().println("Error connecting to the database: " + e.getMessage());
} catch (ClassNotFoundException e) {
    e.printStackTrace();
    response.getWriter().println("Error loading database driver: " + e.getMessage());
} finally {
    try {
        if (statement != null) {
            statement.close();
        }
        if (connection != null) {
            connection.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
