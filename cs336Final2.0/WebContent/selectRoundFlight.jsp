<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import= "java.util.Date"%>
<%
	try {

		Connection dbConnection = null;

		String url = "jdbc:mysql://Mydatabase.cputfd1eymsx.us-east-1.rds.amazonaws.com:3306/MirandaDatabase";
		Properties info  = new Properties();
		info.put("user", "MirandaDatabase"); //stores the username and password
		info.put("password", "miranda19");
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //The mysql connector

		dbConnection = DriverManager.getConnection(url, info); //Get the connection

		session = request.getSession();
		
		String fromCity = String.valueOf(session.getAttribute("fromCity"));
		String toCity = String.valueOf(session.getAttribute("toCity"));
		
		String query = "SELECT * " +
					"FROM flight f " +
					"Where f.departCity = ? " + 
					"and f.arriveCity = ?" +
					"union " +
					 "SELECT * " +
					 "FROM flight f " +
					 "Where f.departCity = ? " + 
					"and f.arriveCity = ?";
		
		
		//Create a Prepared SQL statement to check if the userID to be added already exists
		PreparedStatement ps = dbConnection.prepareStatement(query);
		
		ps.setString(1, fromCity);
		ps.setString(2, toCity);
		ps.setString(3, toCity);
		ps.setString(4, fromCity);
		
		//Returns a ResultSet object to check query
		ResultSet result = ps.executeQuery();
		
		session = request.getSession();
		Object[][] flights = new Object[10][12];
		int i = 0;
		while (result.next()) {
            // Read values using column name
            int flightNum = result.getInt("flightNumber");
            String departsTime = result.getString("departsDateTime");
            String departID = result.getString("threeLetterID_Departs");
            String arrivesTime = result.getString("arrivesDateTime");
           	String arriveID = result.getString("threeLetterID_Arrives");
           	String price = result.getString("price");

            flights[i][0] = flightNum;
            flights[i][1] = departsTime;
            flights[i][2] = departID;
            flights[i][4] = arrivesTime;
            flights[i][5] = arriveID;
            flights[i][6] = price;
            i++;
        }
		
		session.setAttribute("flights", flights);
		
	    	dbConnection.close();
 		}

	catch (Exception ex) {
		out.print(ex);
	}

%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Round flights</title>
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
			<span class="login-form-title p-b-33">
				Flights 
			</span>
			<div class="text-align:center fs-14 p-l-35 p-b-20 p-t-5 p-r-10">
			</div>
			<button onclick="goBack()">Go Back</button>
			<script>
				function goBack() {
				  window.history.back();
				}
				</script>
			<br>
			<form action="confirmFlight.jsp" method="POST">
			<div class="wrap-input">
				<table style="text-align:center;" border="1">
			    <thead>
			    <tr>
			        <td>Flight Number</td>
			        <td>Depart Time</td>
			        <td>Departs From</td>
			        <td>Arrive Time</td>
			        <td>Arrives At</td>
			        <td>Price</td>
			    </tr>
			    </thead>
			    <tbody>
					<% 
					Object[][] tuples = (Object[][])session.getAttribute("flights");
					
					for (int i=0; i < 10; i++){
						for (int j = 0; j < 12; j++){
							if (tuples[i][j] != null){
								if (tuples[i][j] instanceof Integer)
								{
									int number = (Integer) tuples[i][j];
									String column = Integer.toString(number);
									out.print(String.format("<tr>" +
	                                        "<td>%s</td>"  
	                                   		 , column));
								} else { //assert not int
									String column = (String)tuples[i][j];
									out.print(String.format("<td>%s</td>",column));
								}
							}
						}
					}
					out.print("</tr>");
					%>
					
		  </tbody>
		</table>
		<br>
			</div>
			<div class="wrap-input">
			 <input class="input" type="text" name="flightA" placeholder="Departing Flight Number">
				<span class="focus-input-1"></span>
				<span class="focus-input-2"></span>
				</div>
			<div class="wrap-input rs1">
			 <input class="input" type="text" name="flightB" placeholder="Returning Flight Number">
				<span class="focus-input-1"></span>
				<span class="focus-input-2"></span>
			</div>
			<input class="login-form-btn container-login-form-btn m-t-20" type="submit" value="Select" />
			</form>
				
			</div>
		</div>
	</div>
</body>
</html>