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
	
		String query = "SELECT price " +
					"FROM flight f " +
					"Where f.flightNumber = ? " +
					"union " +
					"SELECT price " +
					"FROM flight f " +
					"Where f.flightNumber = ? ";
		
		
		int flightNumberA = Integer.valueOf((String)request.getParameter("flightA"));
		int flightNumberB = 0;
		if(request.getParameter("flightB") != null)
		{
			flightNumberB = Integer.valueOf((String)request.getParameter("flightB"));
		}
		
		
		
		//Create a Prepared SQL statement to check if the userID to be added already exists
		PreparedStatement ps = dbConnection.prepareStatement(query);
		
		ps.setInt(1, flightNumberA);
		ps.setInt(2, flightNumberB);
		
		//Returns a ResultSet object to check query
		ResultSet result = ps.executeQuery();
		
		session = request.getSession();
		
		String[] priceArray;
		priceArray = null;
		priceArray = new String[2];
		
		int i = 0;
		while (result.next()) {
            // Read values using column name
        priceArray[i] = result.getString("price");
            i++;
  
		}
		session.setAttribute("price", priceArray);
    	ps.close();
    	dbConnection.close();
	}

catch (Exception ex) {
	out.print(ex);
} 	
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Registration</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>	
	<div class="limiter">
		<div class="container-login">
			<div class="wrap-login p-l-55 p-r-55 p-t-65 p-b-50">
			<a href="index.jsp">Log out</a>
			<br>
			<br>
			<span class="login-form-title p-b-33">
				Select Options
			</span>
			<form action="summary.jsp" method="POST">
			<b>
			<%  String flightNumberA = request.getParameter("flightA");
				String flightNumberB = request.getParameter("flightB");
				
				session = request.getSession();
				session.setAttribute("flightA", flightNumberA);
				session.setAttribute("flightB", flightNumberB);
				
				out.print(String.format("<p>Departing Flight#: %s</p>",flightNumberA));
				if(request.getParameter("flightB") != null)
					{
						out.print(String.format("<p>Returning Flight#: %s</p>",flightNumberB));
					}
			
				String[] myArray;
				myArray = null;
				myArray = (String[])session.getAttribute("price");
				
				out.print(String.format("<p>Price of Departing Flight (Before Addons):$ %s</p>", myArray[0]));
				if(request.getParameter("flightB") != null)
				{
				out.print(String.format("<p>Price of Returning Flight (Before Addons):$ %s</p>", myArray[1]));
				}
				
			%>
			</b>
			<br>
			<p>
			<b>Meal</b>
			</p>
			<input type="radio" name="meal" value="1">Premium Meal: $15 <br>
			<input type="radio" name="meal" value="0">None<br>
			<p>
			<br>
			<b>Class</b>
			</p>
			<input type="radio" name="class" value="2">First: +$100 <br>	
			<input type="radio" name="class" value="1">Business: +$50 <br>
			<input type="radio" name="class" value="0">Economy: +$0 <br>			
			<input class="login-form-btn container-login-form-btn m-t-20" type="submit" value="Confirm" />
			</form>
			</div>
		</div>
	</div>
</body>
</html>

