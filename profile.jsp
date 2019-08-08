<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>
</head>
<div Class = "topleftcorner">
	<a href="index.jsp">Log out</a>
	</div>


<%
//Show tickets based on userID	
		
	//Get the database connection
	Connection dbConnection = null;
	String url = "jdbc:mysql://Mydatabase.cputfd1eymsx.us-east-1.rds.amazonaws.com:3306/MirandaDatabase";
	Properties info  = new Properties();
	info.put("user", "MirandaDatabase"); //stores the username and password
	info.put("password", "miranda19");
	Class.forName("com.mysql.jdbc.Driver").newInstance(); //The mysql connector
	
	dbConnection = DriverManager.getConnection(url, info); //Get the connection
		
	// Variable delcarizations and initializations

	String str = "";
	String message = "";
	String queryTitle = "";
	Statement stmt = null;
	ResultSet result;
	stmt = dbConnection.createStatement();
	ArrayList<String> columns = new ArrayList<String>();

	// Get userID
	session = request.getSession();
	String userID = (String) session.getAttribute("UserID");
	
	// Query Statement
	str = "SELECT * " +
			"FROM ticket t " +
			"WHERE t.userID = \"" + userID + "\"";
	
	stmt.executeQuery(str);
	queryTitle = "Your Reservations";
	
	columns.add("name");
	columns.add("ticketNumber");
	columns.add("flightNumberA");
	columns.add("flightNumberB");
	columns.add( "totalFare");
	columns.add("class");
	
	//Returns a ResultSet object to check query
 	result = stmt.executeQuery(str);
	
	session = request.getSession();
	ArrayList<ArrayList<String>> tuples = new ArrayList<ArrayList<String>>();
	HelperFunctions help = new HelperFunctions();
	tuples = help.getQuery(result, columns);

	stmt.close();
    dbConnection.close();
    
    out.print("<h1>" + queryTitle + "</h1>");
    out.print(message);
    
	out.print(help.printQuery(tuples, columns));

%>
<body>
<h2>Cancel reservation:</h2>
<form method="post" action="profile.jsp">
		<table>
		<tr>    
		<td>Ticket number <input type="text" name="cancelRes"></td>
		</tr>
		<tr>    
		<td>Warning: Once you click 'Cancel Reservation' your flight will be cancelled with no further confirmation.</td>
		</tr>
		</table>
		<input type="submit" value="Cancel Reservation">
	</form>
	</body>
</html>

<%

//Get userID

	session = request.getSession();
	dbConnection = DriverManager.getConnection(url, info);
	stmt = dbConnection.createStatement();

	if (request.getParameter("cancelRes") != null){
		// First check that user belongs to flight num
		String ticketNum = request.getParameter("cancelRes");
	
		str = "SELECT * " +
		"FROM ticket t " +
		"WHERE t.userID = \"" + userID + "\" " +
		"AND t.ticketNumber = \"" + ticketNum + "\"";
	
		stmt.executeQuery(str);
		result = stmt.executeQuery(str);
	
	
		if (result.next()){  //If flight number does belong to user
	
		// Remove Statement
		str = "DELETE FROM ticket WHERE userID = '" + userID + "' " +
				"AND ticketNumber = " + ticketNum;
	
		stmt.executeUpdate(str);
		
		
		stmt.close();
	    dbConnection.close();
		
		response.sendRedirect("homepage.jsp");
	}
}


%>
	