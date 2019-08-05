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
		
			//get Users name
				String query = "SELECT name " +
						"FROM user u " +
						"Where u.userID = ? ";
			
			
			//Create a Prepared SQL statement to check if the userID to be added already exists
			PreparedStatement ps = dbConnection.prepareStatement(query);
			
			String userID = session.getAttribute("UserID").toString();
			ps.setString(1, userID);
			
			//Returns a ResultSet object to check query
			String name = "";
			ResultSet result = ps.executeQuery();
				if (result.next()){
					name = result.getString("name");
				}

		
		
			//get capacity of plane
			
				
				
	
			
				
				
			//Make an insert statement for the Ticket table:
			String insert = "INSERT INTO ticket(ticketNumber, userID, name, flightNumberA, seatNumberA, flightNumberB, seatNumberB, class, meal, purchaseDateTime, totalFare)"
			+ "VALUES (?,?,?,?,?,?,?,?,?,?,?)";


			//Create a Prepared SQL statement to check if the userID to be added already exists
			ps = dbConnection.prepareStatement(insert);	
			
			session = request.getSession();
			//UserID got from session above
			//name got from Query above
			
			int flightNumberA = Integer.valueOf((String)session.getAttribute("flightNum"));
			
			int meal = Integer.valueOf((String)request.getParameter("meal"));	
			int theClass = Integer.valueOf((String)request.getParameter("class"));
	
			
			String insertClass = "";
			if(theClass == 2){
				insertClass = "First";
			}
			else
			{
				if(theClass == 1){
					insertClass = "Business";
				}
				else
				{
					insertClass = "Economy";
				}	
			}
			
			Date date = Calendar.getInstance().getTime(); 
			java.sql.Date sqlDate = new java.sql.Date(date.getTime());
			
			Object[] thePrice = (Object[])session.getAttribute("price");
			String column = "";
			for (int i=0; i < 1; i++){
				if (thePrice[i] != null){
						column = (String) thePrice[i];
				}
				}
			int totalFare = Integer.valueOf(column);	
			if(meal == 1)
			{
				totalFare = totalFare + 15;
			}	
			if(theClass == 2)
			{
				totalFare = totalFare + 100;
			}
			else
			{
				if(theClass == 1)
				{
					totalFare = totalFare + 50;
				}
			}
			session.setAttribute("total", totalFare);
			
	    	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	    	ps.setInt(1, 0); //ticketNumber
	    	ps.setString(2, userID);
	    	ps.setString(3, name);
	    	ps.setInt(4, flightNumberA);
	    	ps.setInt(5,0); //seatNumberA
	    	ps.setInt(6,0);//flightNumberB
	    	ps.setInt(7,0);//seatNumberB
	    	ps.setString(8, insertClass);
	    	ps.setInt(9, meal);
	    	ps.setDate(10, sqlDate);
	    	ps.setInt(11, totalFare);
	    	
	    	ps.executeUpdate();
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
			<span class="login-form-title p-b-33">
				Summary
			</span>
			<% 
			int totalFare =(Integer)session.getAttribute("total");
			out.print(String.format("<p><b>Total:$ %d</p></b>", totalFare));
			%>
			<br>
			<b>
			<a href="homepage.jsp"><button>Search more flights</button></a>
			</b>
			<div class="text-align:center fs-14 p-l-35 p-b-20 p-t-5 p-r-10">
			</div>
			</div>
		</div>
	</div>
</body>
</html>



