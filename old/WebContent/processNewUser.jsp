<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

 <%
 
 	Connection dbConnection = null;
 
 	try {

		//Get the database connection
		String url = "jdbc:mysql://Mydatabase.cputfd1eymsx.us-east-1.rds.amazonaws.com:3306/MirandaDatabase";
		Properties info  = new Properties();
		info.put("user", "MirandaDatabase"); //stores the username and password
		info.put("password", "miranda19");
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //The mysql connector
		
		dbConnection = DriverManager.getConnection(url, info); //Get the connection
		
	 	// Query the database to see if user exists
		
	 	String query = "SELECT userID " +
	 					"FROM user " +
	 					"WHERE userID=?";
	 	String newUser = request.getParameter("newusername");
	 	
	 	//Create a Prepared SQL statement to check if the userID to be added already exists
	 	PreparedStatement ps = dbConnection.prepareStatement(query);
	 	ps.setString(1, newUser);
	 	
	 	//Returns a ResultSet object to check query
	 	ResultSet result = ps.executeQuery();
	 	
	 	// result,next() returns true if there is a next value
	 	if (result.next()) {
			// Creates session object
	 		session = request.getSession();
			Boolean userExists = new Boolean(true);
		 	session.setAttribute("userExists", userExists);
		 	
		 	ps.close();
		 	dbConnection.close();
			response.sendRedirect("createAccount.jsp"); //go back to Create Account page
	 	}
	 	
	 	else {	 
			//Make an insert statement for the Users table:
			String insert = "INSERT INTO user(userID, password, name)" + "VALUES (?, ?, ?)";

			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ps = dbConnection.prepareStatement(insert);

			String newPass = request.getParameter("newpass");
			String name = request.getParameter("name");
	    	
	    	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	    	ps.setString(1, newUser);
	    	ps.setString(2, newPass);
	    	ps.setString(3, name);
	     
	    	ps.executeUpdate();
	    	ps.close();
	    	dbConnection.close();
	    	response.sendRedirect("index.jsp"); //go back to login page
	    
	 	}
	 	
	 	
	 
 	}
 
	catch (Exception ex) {
		out.print(ex);
	} 	
 	
%>


