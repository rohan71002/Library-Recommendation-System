<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONObject" %>

<%
    String url = "jdbc:mysql://localhost:3306/lib_recommend_sys";

    String user = "root";

    String password = "7410";
     
    String connect = "com.mysql.cj.jdbc.Driver";
    
    Connection connection = null;
    
    String mail = (String) session.getAttribute("email");
    System.out.println(mail);
    
    Statement statement = null;
try {
	Class.forName(connect);
    
    connection = DriverManager.getConnection(url, user, password);
     
    statement = connection.createStatement();
    // Assuming you have a table named 'users' with columns 'id' and 'selected_genre'
    String query = "SELECT genre FROM signup WHERE email = '" + mail + "'";
    ResultSet resultSet = statement.executeQuery(query);
    

    JSONObject userData = new JSONObject();
    if (resultSet.next()) {
        String selectedGenre = resultSet.getString("genre");
        System.out.println(selectedGenre);
        
        userData.put("genre", selectedGenre);
        System.out.println(userData);
    }

    // Set response type to JSON
    response.setContentType("application/json");
    // Write JSON data to response
    response.getWriter().print(userData.toJSONString());
} catch (Exception e) {
    e.printStackTrace();
} %>