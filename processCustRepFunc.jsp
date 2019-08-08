<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.*"%>

 <%

		//Get the database connection
		Connection dbConnection = null;
		String url = "jdbc:mysql://Mydatabase.cputfd1eymsx.us-east-1.rds.amazonaws.com:3306/MirandaDatabase";
		Properties info  = new Properties();
		info.put("user", "MirandaDatabase"); //stores the username and password
		info.put("password", "miranda19");
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //The mysql connector
		
		dbConnection = DriverManager.getConnection(url, info); //Get the connection
		
		// Variable delcarizations and initializations
		boolean isQuery = false;
		boolean isMesage = false;
		boolean isAddFlight = false;
		String str = "";
		String message = "";
		String queryTitle = "";
		Statement stmt = null;
		ResultSet result;
		stmt = dbConnection.createStatement();
		ArrayList<String> columns = new ArrayList<String>();
		
	 	//--------------------------------------------------------------------
	 	//	Use Parameters found to determine the appropriate action
	 	//--------------------------------------------------------------------
	 	
	 	//--------------------------------------------------------------------
	 	//	Make a flight reservation on behalf of user
	 	//--------------------------------------------------------------------
		if (request.getParameter("bookUser") != null){
			// Adding user
			String userID = request.getParameter("bookUser");
	    	
	    	// Query the database to see if user exists
			 str = "SELECT userID " +
			 		"FROM user " +
			 		"WHERE userID= \"" + userID + "\"";
				
			//Returns a ResultSet object to check query
		 	result = stmt.executeQuery(str);
			 	
		 	if (result.next() != true) { 
				// User Does not exsitexists: should display some time of error message
		    	response.sendRedirect("custRep.jsp");
		 		// User exists
		 	} else {	 
    	
		 		boolean custRepAdd = true;
				session.setAttribute("isCustRepAdd", custRepAdd);
				session.setAttribute("custRepUserID", userID);
		    	response.sendRedirect("homepage.jsp");
			}
			
		}
	 	
		//--------------------------------------------------------------------
	 	//	Edit a flight reservation for a customer:
	 	//--------------------------------------------------------------------
		else if (request.getParameter("editUser") != null){
			
			String user = request.getParameter("editUser");
			String ticket = null;
			int meal = -1;
			int classType = -1;
			
			// Check for Paramaters, and set as attributes
			if (request.getParameter("editTicket") != null){
				ticket = request.getParameter("editTicket");
			}
			// 1 : premium, 0 : no meal
			if (request.getParameter("mealButton") != null){
				if (String.valueOf((String)request.getParameter("mealButton")) == "premium"){
					meal = 1;
				} else {
					meal = 0;
				}
			} // 2: first class, 1: business, 0 : economy
			if (request.getParameter("classButton") != null){
				if (String.valueOf((String)request.getParameter("classButton")) == "first"){
					classType = 2;
				} else if (String.valueOf((String)request.getParameter("classButton")) == "business"){
					classType = 1;
				} else {
					classType = 0;
				}
			} 
			
			//session.setAttribute("editTicket", ticket);
			if (meal != -1){
				session.setAttribute("custRepMeal", meal);
			}
			
			if (classType != -1){
				session.setAttribute("custRepClass", classType);
			}
			
	    	response.sendRedirect("summary.jsp");
			
		}
		
		
		else if (request.getParameter("informationButton") != null ){
			
			String button = request.getParameter("informationButton");
			String action = request.getParameter("actionButton");
			
			//--------------------------------------------------------------------
		 	//	Add, Edit, or Delete Aircraft
		 	//--------------------------------------------------------------------
			if (button.equals("aircraft")){
				
				
				
			}
			//--------------------------------------------------------------------
		 	//	Add, Edit, or Delete Airport
		 	//--------------------------------------------------------------------
			else if (button.equals("airport")){
				
			}
			//--------------------------------------------------------------------
		 	//	Add, Edit, or Delete Flight
		 	//--------------------------------------------------------------------
			else {
				
			}
			
		}
		
		//------------------------------------------------------------------------------
	 	// Retrieve a list of all passengers on the waiting list of a particular flight
	 	//------------------------------------------------------------------------------
		else if (request.getParameter("flightNumber") != null){
			
			out.print("Testing");
			
			String flightNumber = request.getParameter("flightNumber");
			
			str = "SELECT Distinct w.userID " +
					"FROM waitingList w " +
					"WHERE w.flightNumber = \"" + flightNumber + "\"";
			
			stmt.executeQuery(str);
			isQuery = true;
			queryTitle = "Passengers waiting";
			columns.add("userID");
		
		}
		
		//*******************************************************************************
	 	
		
		
		if (isQuery == true) {
			//Returns a ResultSet object to check query
		 	result = stmt.executeQuery(str);
			
			session = request.getSession();
			ArrayList<ArrayList<String>> tuples = new ArrayList<ArrayList<String>>();
			HelperFunctions help = new HelperFunctions();
			tuples = help.getQuery(result, columns);

			stmt.close();
		    dbConnection.close();
		    
		    
		    out.print("<h1>" + queryTitle + "</h1>");
		    
			out.print(help.printQuery(tuples, columns));
			
			
		} else {
			// Can write html to print message here verifying admin function.
		}
	

%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Your Results</title>
	<meta charset="UTF-8">
</head>
<body>
	<form action="custRep.jsp" method="POST">
	<div class="wrap-input">
	</div>
		<input type="submit" value="Go Back"/>	
	</form>
</body>
</html>
