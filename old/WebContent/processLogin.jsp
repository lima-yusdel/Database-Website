<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<%
	try {

		Connection dbConnection = null;
	
		String url = "jdbc:mysql://Mydatabase.cputfd1eymsx.us-east-1.rds.amazonaws.com:3306/MirandaDatabase";
		Properties info  = new Properties();
		info.put("user", "MirandaDatabase"); //stores the username and password
		info.put("password", "miranda19");
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //The mysql connector
	
		dbConnection = DriverManager.getConnection(url, info); //Get the connection
	
		
		//Check if User exists
		String query = "SELECT * " +
						"FROM user " + 
						"WHERE userID=?";
	
 		String user = request.getParameter("username");
 		session.setAttribute("UserID", user);
 		String password = request.getParameter("pass");
 		
 		PreparedStatement ps = dbConnection.prepareStatement(query);
 		
 		ps.setString(1, user);	
 		
 		ResultSet result = ps.executeQuery();
 		
 		//session = request.getSession();

 		//If user exists, check password
		if (result.next()){
			String storedPassword = result.getString("password");
			//If password is correct, grant access
 			if (storedPassword.equals(password)){
 			// Also, check for isAdmin to determine if Admin should be granted.
 				int isAdmin = result.getInt("isAdmin");
 				int isEmployee = result.getInt("isEmployee");
 				if (isAdmin == 1){
 					ps.close();
 		    		dbConnection.close();
 					response.sendRedirect("admin.jsp");
 				}
 				else if (isEmployee == 1){
 					ps.close();
 					dbConnection.close();
 					response.sendRedirect("custRep.jsp");
 				} else {
 					ps.close();
 		    		dbConnection.close();
 					response.sendRedirect("homepage.jsp"); //go to main page after login
 				}
 			}
 			else {
 				// wrong password
 				Boolean wrongPassword = new Boolean(true);
 			 	session.setAttribute("wrongPassword", wrongPassword);
 			 	ps.close();
 		    	dbConnection.close();
 			 	response.sendRedirect("index.jsp"); //return to login page
 			}
		}
 		else {
 			// User does not exist
  			Boolean wrongUser = new Boolean(true);
 			session.setAttribute("wrongUser", wrongUser);	
 			ps.close();
	    	dbConnection.close();
 			response.sendRedirect("index.jsp"); //return to login page
 		}
	}

	catch (Exception ex) {
		out.print(ex);
	}
    	
    	
%>