	<%@ page import="java.sql.*" %>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
	<head>
	    <meta charset="UTF-8">
	    <title>Login</title>
	</head>
	<body>
	<%
	    String url = "jdbc:mysql://localhost:3306/lib_recommend_sys";
		
	    String user = "root";
	    
	    String password = "7410";
		    
	    String connect = "com.mysql.cj.jdbc.Driver";
		    
	    Connection connection = null;
		    
	    Statement statement = null;
		    
	    String email = request.getParameter("mail");
		    
	    String pass = request.getParameter("pass");
	    
	    boolean loggedIn = false;
		    
	    boolean surveyRequired = false;
		    
		   
		   try {
		       Class.forName(connect);
		        
		       connection = DriverManager.getConnection(url, user, password);
		        
		       statement = connection.createStatement();
		        
		       String selectQuery = "SELECT email , password , genre  FROM signup WHERE email = '" + email + "'";
		       
		       ResultSet resultSet = statement.executeQuery(selectQuery);
		        
		       while (resultSet.next()) {
		        	
		           String data_email = resultSet.getString("email");
		            
		           String data_pass  = resultSet.getString("password");
		            
		           String data_genre = resultSet.getString("genre");
		            
		           if (data_email.equals(email) && data_pass.equals(pass)) {  
		            	
		               loggedIn = true;  
		               
		               session.setAttribute("email", data_email);
		                
		               if (data_genre.equals("null") || data_genre.equals(" ")) {
		                	
		                   surveyRequired = true;  
		                }
		               
		               break;
		            }
		        }  
		        if (loggedIn) {
		        	
		            if (surveyRequired) 
		            {
		            	
		                response.getWriter().println("survey");
		            } 
		            else
		            {
		            	
		            	response.getWriter().println("Survey");
		            }
		        } 
		        else 
		        {
		            response.getWriter().println("Invalid email or password");
		        }
		    } 
		    catch (SQLException e)
		    {
		        response.getWriter().println("Error connecting to the database: " + e.getMessage());
		    } 
		    catch (ClassNotFoundException e)
		    {
		        response.getWriter().println("Error loading database driver: " + e.getMessage());
		    }
		%>
		</body>
		</html>
