<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Your Results</title>
	<meta charset="UTF-8">
</head>
<div Class = "topleftcorner">
	<a href="index.jsp">Log out</a>
	</div>
<body>

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
		String str = "";
		String message = "";
		String queryTitle = "";
		Statement stmt = null;
		ResultSet result;
		stmt = dbConnection.createStatement();
		ArrayList<String> columns = new ArrayList<String>();
		
	 	//--------------------------------------------------------------------
	 	//	Use Parameters found to determine the appropriate query
	 	//--------------------------------------------------------------------
	 	
	 	
		if (request.getParameter("addUser") != null){
			// Adding user
			String addUser = request.getParameter("addUser");
			String addPassword = request.getParameter("addPassword");
			String addName = request.getParameter("addName");
			String button = request.getParameter("addUserButton");
			
			// add Customer Rep user
			if (button.equals("customerRep")){	

				// Query the database to see if user exists
			 	str = "SELECT userID " +
			 			"FROM user " +
			 			"WHERE userID= \"" + addUser + "\"";
				
			 	//Returns a ResultSet object to check query
			 	result = stmt.executeQuery(str);
			 	
			 	if (result.next()) { 
					// User exists: should display some time of error message
			    	response.sendRedirect("admin.jsp");
			 	}
			 	
			 	else {	 
					//Make an insert statement to add user
					str = "INSERT INTO user(userID, password, name, isEmployee)" + 
					"VALUES (\"" + addUser + "\", \"" + addPassword + "\", \"" + addName + "\", \"1\")";

					//Create a Prepared SQL statement
					stmt.executeUpdate(str);		
			    	response.sendRedirect("admin.jsp");
			    
			 	}
			 
			 // add Customer user	
			} else {
				
				// Query the database to see if user exists
			 	str = "SELECT userID " +
			 			"FROM user " +
			 			"WHERE userID= \"" + addUser + "\"";;
			 	
			 	//Returns a ResultSet object to check query
			 	result = stmt.executeQuery(str);
			 	
			 	if (result.next()) { 
					// User exists: should display some time of error message
			    	response.sendRedirect("admin.jsp");
			 	}
			 	
			 	else {	 
					//Make an insert statement to add user
					str = "INSERT INTO user(userID, password, name, isEmployee) " 
						+ "VALUES (\"" + addUser + "\", \"" + addPassword + "\", \"" + addName + "\", \"0\")";

					//Create a Prepared SQL statement
					stmt.executeUpdate(str);			     
			    	response.sendRedirect("admin.jsp");
			    
			 	}
			}
			
		}
		
		else if (request.getParameter("editUser") != null){
			// Editing user
			// Does not check for errors
			String editUser = request.getParameter("editUser");
			String editAttribute = request.getParameter("editAttribute");
			String editValue = request.getParameter("editValue");
			// Query Statement
			
			str = "UPDATE user SET " + editAttribute + " = \"" + editValue + "\" " +
					"WHERE userID = \"" + editUser + "\"";
			
			stmt.executeUpdate(str);
	    	response.sendRedirect("admin.jsp");
			
		}
		
		else if (request.getParameter("deleteUser") != null){
			// Deleting user
			String deleteUser = request.getParameter("deleteUser");
			// Remove Statement
			str = "DELETE FROM user WHERE userID = \"" + deleteUser + "\"";
			
			stmt.executeUpdate(str);
	    	response.sendRedirect("admin.jsp");
		}
		
		//--------------------------------------------------------------------
	 	//	Obtain sales report for a particular month
	 	//--------------------------------------------------------------------
		else if (request.getParameter("month") != null){
			String month = request.getParameter("month");
			
			//Get last two char to determine year
			String year = "20" + month.substring(3,5);
					
			// Get first two char of month string to determine month
			month = month.substring(0,2);
			
			String firstDay = year + "-" + month + "-01 00:00:00";
			String lastDay = year + "-" + month + "-31 23:59:59";
					
			// Query Statement
			str = "SELECT * " +
				"FROM ticket " +
				"WHERE DATE (purchaseDateTime) >= \'" + firstDay + "\' AND DATE (purchaseDateTime) <= \'" + lastDay + "\'";
			
			stmt.executeQuery(str);
			message = "First day is: " + firstDay + "\nLast day is: " + lastDay;
			isQuery = true;
			queryTitle = "Sales Report for Month";
			columns.add("purchaseDateTime");
			columns.add("ticketNumber");
			columns.add("userID");
			columns.add("flightNumberA");
			columns.add("totalFare");
		}
		
		//--------------------------------------------------------------------
	 	// Show flight reservations based on flight number or customer name
	 	//--------------------------------------------------------------------
		else if (request.getParameter("showFlights") != null){
			
			String showFlights = request.getParameter("showFlights");
			String button = request.getParameter("showFlightButton");
			
			// Show flights based on flight number
			if (button.equals("flightNumber")){ 
				// Query Statement											
				str = "SELECT * " +
						"FROM ticket t, flight f , user u " +
						"WHERE t.flightNumberA = f.flightNumber " +
						"AND t.userID = u.userID " +
						"AND f.flightNumber = \"" + showFlights + "\"";

				

				
				// Show flights based on customer name	
			} else {	
				// Query Statement					
				str = "SELECT * " +
						"FROM ticket t, flight f, user u " +
						"WHERE t.flightNumberA = f.flightNumber " +
						"AND t.userID = u.userID " +
						"AND u.name = \"" + showFlights + "\"";
				
				
	
			}
			
			stmt.executeQuery(str);
			isQuery = true;
			queryTitle = "Flight Reservations";
			
			columns.add("name");
			columns.add("flightNumber");
			columns.add("threeLetterID_Departs");
			columns.add("threeLetterID_Arrives");
			columns.add("flightNumber");
			columns.add("currentCapacity");
			columns.add("daysOfWeek");
			columns.add("departsDateTime");
			columns.add( "arrivesDateTime");
			columns.add( "totalFare");
		}
		
		//--------------------------------------------------------------------
	 	// Show summary of Revenue based on: Flight Number, Airline, or userID
	 	//--------------------------------------------------------------------
		else if (request.getParameter("showRevenue") != null) {
			
			String showRevenue = request.getParameter("showRevenue");
			String button = request.getParameter("showRevenueButton");
			
			// Show revenue based on flight number 
			if (button.equals("flightNum")){
				// Query Statement					
				str = "SELECT * " +
						"FROM ticket t, flight f , user u , aircraft a " +
						"WHERE t.flightNumberA = f.flightNumber " +
						"AND t.userID = u.userID " +
						"AND f.FAAID = a.FAAID " +
						"AND f.flightNumber = \"" + showRevenue + "\"";
				
			}
			
			// Show revenue based on airline
			else if (button.equals("airline")){
				// Query Statement
				str = "SELECT * " +
						"FROM ticket t, flight f , user u , aircraft a " +
						"WHERE t.flightNumberA = f.flightNumber " +
						"AND t.userID = u.userID " +
						"AND f.FAAID = a.FAAID " +
						"AND a.ownedBy = \"" + showRevenue + "\"";
				
			// Show revenue based on userID	
			} else {
				// Query Statement
				str = "SELECT * " +
						"FROM ticket t, flight f , user u , aircraft a " +
						"WHERE t.flightNumberA = f.flightNumber " +
						"AND t.userID = u.userID " +
						"AND f.FAAID = a.FAAID " +
						"AND t.userID = \"" + showRevenue + "\"";
				
			}
			
			stmt.executeQuery(str);
			isQuery = true;
			queryTitle = "Flight Reservations";
			
			columns.add("userID");
			columns.add("flightNumber");
			columns.add("ownedBy");
			columns.add("threeLetterID_Departs");
			columns.add("threeLetterID_Arrives");
			columns.add("flightNumber");
			columns.add( "totalFare");
			
		}
		//--------------------------------------------------------------------
	 	// The Customer who has generated the most total revenue is:
	 	//--------------------------------------------------------------------
		else if (request.getParameter("popularityButton") != null){
		    
			String button = request.getParameter("popularityButton");
			if (button.equals("customer")){
			
		    // The Customer who has generated the most total revenue:
		    String customersTotalFare = "(SELECT t.userID, SUM(totalFare) total " +
		    						"FROM ticket t " + 
		    						"GROUP BY t.userID) s ";
		    
		    str = "SELECT s.userID " +
		    		"FROM " + customersTotalFare +
		    		"HAVING MAX(total) ";
		    
		    
		    stmt.executeQuery(str);
		    isQuery = true;
		    queryTitle = "Flight Reservations";
		    
		    columns.add("userID");
		   	
		  	//--------------------------------------------------------------------
			// The most actively booked flight is:
			//--------------------------------------------------------------------
			} else {
				
			str = "SELECT f.flightNumber " +
					"FROM flight f " +
					"WHERE f.currentCapacity = (SELECT MAX(f.currentCapacity) " +
												"FROM flight f)";
			
			stmt.executeQuery(str);
		    isQuery = true;
		    queryTitle = "Flight Reservations";
		    
		    columns.add("flightNumber");
				
			}

		}
	 	
		
		//--------------------------------------------------------------------
	 	// Show all flights based on Airport
	 	//--------------------------------------------------------------------
		else if (request.getParameter("airport") != null) {
			
			String airport = request.getParameter("airport");
			
			str = "SELECT * " +
					"FROM flight " +
					"WHERE threeLetterID_Departs =\"" + airport + "\"";
			
			stmt.executeQuery(str);
			isQuery = true;
			queryTitle = "Flights based on Airport";
			columns.add("flightNumber");
			columns.add("threeLetterID_Departs");
			columns.add("threeLetterID_Arrives");
			columns.add("flightNumber");
			columns.add("currentCapacity");
			columns.add("daysOfWeek");
			columns.add("departsDateTime");
			columns.add( "arrivesDateTime");
			
		}
	 	
		
		
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
	<form action="admin.jsp" method="POST">
	<div class="wrap-input">
	</div>
		<input type="submit" value="Go Back"/>	
	</form>
</body>
</html>