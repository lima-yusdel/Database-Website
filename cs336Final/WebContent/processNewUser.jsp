<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

 <%
 Connection dbConnection = null;
 
 try {

		//Get the database connection
		String url = "jdbc:mysql://Mydatabase.cputfd1eymsx.us-east-1.rds.amazonaws.com:3306/MirandaDatabase";  //this looks complicated
		Properties info  = new Properties();
		info.put("user", "MirandaDatabase"); //stores the username and password
		info.put("password", "miranda19");
		Class.forName("com.mysql.jdbc.Driver"); //The mysql connector
		
		dbConnection = DriverManager.getConnection(url, info); //Get the connection
		
		//Create a SQL statement
		Statement stmt = dbConnection.createStatement();
		} 
	catch (Exception ex)
		{
		out.print(ex);
		}
 
    //Make an insert statement for the Users table:
      String insert = "INSERT INTO user(userID, password)" + "VALUES (?, ?)";
    //Create a Prepared SQL statement allowing you to introduce the parameters of the query
      PreparedStatement ps = dbConnection.prepareStatement(insert);

    	String newUser = request.getParameter("username");
    	String newPass = request.getParameter("pass");
    	
    //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
    ps.setString(1, newUser);
    ps.setString(2, newPass);
     
    ps.executeUpdate();
    dbConnection.close();
    %>
<%

    response.sendRedirect("index.jsp"); //go back to login page
%>
