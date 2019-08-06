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
<body>

 <%
 
 	//try {

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
				"WHERE purchaseDateTime BETWEEN \"" + firstDay + "\" AND \"" + lastDay + "\" " +
				"ORDER BY purchaseDateTime";
			
			stmt.executeQuery(str);
			message = "First day is: " + firstDay + "\nLast day is: " + lastDay;
			isQuery = true;
			queryTitle = "Sales Report for Month";
			columns.add("purchaseDateTime");
			columns.add("ticketNumber");
			columns.add("userID");
			columns.add("name");
			columns.add("flightNumber");
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
						"FROM ticket t, flight f " +
						"WHERE t.userID = f.userID" +
						"AND t.flightNumberA = \"" + showFlights + "\"";

				columns.add("flightNumber");

				
				// Show flights based on customer name	
			} else {	
				// Query Statement					
				str = "SELECT * " +
						"FROM ticket, flight " +
						"WHERE ticket.userID = flight.userID" +
						"AND flightNumber = \"" + showFlights + "\"";
				
				columns.add("name");
	
			}
			
			stmt.executeQuery(str);
			isQuery = true;
			queryTitle = "Flight Reservations";
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
			
			if (button.equals("flightNum")){
				// Query Statement					// Show revenue based on flight number 
				
				isQuery = true;
			}
			else if (button.equals("airline")){
				// Query Statement					// Show revenue based on airline
				
				isQuery = true;
			} else {
				// Query Statement					// Show revenue based on userID
				
				isQuery = true;
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
			tuples = help.showQuery(result, columns);

			stmt.close();
		    dbConnection.close();
		    
		    out.print("<h1>" + queryTitle + "</h1>");
		    out.print(message);
		    
			out.print("<table border=\"1\"><thead><tr>");
			
			for (int i = 0; i < columns.size() ; i++){
				out.println("<th>" + columns.get(i) + "</th>");
			}
			out.println("</tr></thead><tbody>");
						
			for (int i=0; i < tuples.size(); i++){
				out.print("<tr>");
				for (int j = 0; j < tuples.get(i).size(); j++){
					if (tuples.get(i).get(j) != null){
						String data = (String) tuples.get(i).get(j);
						out.print("<td>" + data + "</td>");
					}	
				}
				out.print("</tr>");
			}
			out.print("</tbody></table>");
			
		} else {
			// Can write html to print message here verifying admin function.
		}

 	//}
 
	//catch (Exception ex) {
	//	out.print(ex);
	//} 	

%>
	<form action="admin.jsp" method="POST">
	<div class="wrap-input">
	</div>
		<input type="submit" value="Go Back"/>	
	</form>
</body>
</html>