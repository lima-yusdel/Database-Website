<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  	
    
    
    %>
    
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Administrative Functions</title>
	<meta charset="UTF-8">
</head>
<div Class = "topleftcorner">
	<a href="index.jsp">Log out</a>
	</div>
<body>	
	<h1> Administrative Functions </h1>
	
	<h2>Add, Edit or Delete Information for a Customer or a Customer Representative:</h2>
	<h4>Add a Customer or a Customer Representative by selecting which you want to add,<br>
	and entering the following information. Then click, 'add user'.</h4>
	<form method="post" action="processAdminFunc.jsp">
		<table>
		<tr>    
		<td><input type="radio" name="addUserButton" value="customer"/>Customer</td>
		</tr>
		<tr>    
		<td><input type="radio" name="addUserButton" value="customerRep"/>Customer Representative</td>
		</tr>
		<tr>
		</tr>
		<tr>    
		<td>UserID (less than 12 characters)</td><td><input type="text" name="addUser"></td>
		</tr>
		<tr>
		<td>password (less than 12 characters)</td><td><input type="text" name="addPassword"></td>
		</tr>
		<tr>
		<td>Full Name</td><td><input type="text" name="addName"></td>
		</tr>
		</table>
		<input type="submit" value="add user">
	</form>
	
	<h4>Enter the UserID of the person whose information you want to edit.<br>
	Then, enter the attribute and value you want to change and click 'edit user'.</h4>
	<form method="post" action="processAdminFunc.jsp">
		<table>
		<tr>    
		<td>UserID you want to edit</td><td><input type="text" name="editUser"></td>
		</tr>
		<tr>
		<td>Attribute you want to edit</td><td><input type="text" name="editAttribute"></td>
		</tr>
		<tr>
		<td>New Value</td><td><input type="text" name="editValue"></td>
		</tr>
		</table>
		<input type="submit" value="edit user">
	</form>	
	
	<h4>Enter the UserID you want to delete and click 'delete user'.</h4>
	Warning: by submitting this request all user information will be deleted and cannot be undone.
	<form method="post" action="processAdminFunc.jsp">
		<table>
		<tr>    
		<td>UserID you want to delete</td><td><input type="text" name="deleteUser"></td>
		</tr>
		</table>
		<input type="submit" value="delete user">
	</form>
	
	<h2>Obtain sales report for a particular month:</h2>
	<form method="post" action="processAdminFunc.jsp">
		<table>
		<tr>    
		<td>Enter Month (MM/YY)</td><td><input type="text" name="month"></td>
		</tr>
		</table>
		<input type="submit" value="submit">
	</form>
	
	<h2>Show flight reservations based on:</h2>
	<form method="post" action="processAdminFunc.jsp">
		<table>
		<tr>    
		<td><input type="radio" name="showFlightButton" value="flightNumber"/>Flight Number</td>
		</tr>
		<tr>
		<td><input type="radio" name="showFlightButton" value="name"/>Customer Name</td>
		</tr>
		<tr>
		<td>Enter chosen value</td><td><input type="text" name="showFlights"></td>
		</table>
		<input type="submit" value="submit">
	</form>
	
	<h2>Show summary of Revenue based on:</h2>
	<form method="post" action="processAdminFunc.jsp">
		<table>
		<tr>    
		<td><input type="radio" name="showRevenueButton" value="flightNum"/>Flight Number</td>
		</tr>
		<tr>
		<td><input type="radio" name="showRevenueButton" value="airline"/>Airline</td>
		</tr>
		<tr>
		<td><input type="radio" name="showRevenueButton" value="userID"/>Customer's userID</td>
		</tr>
		<tr>
		<td>Enter chosen value</td><td><input type="text" name="showRevenue"></td>
		</table>
		<input type="submit" value="submit">
	</form>
	
	<h2>Show revenue based on popularity:</h2>
	<form method="post" action="processAdminFunc.jsp">
		<table>
		<tr>
		<td><input type="radio" name="popularityButton" value="customer"/>Customer who generated the most total revenue</td>
		</tr>
		<tr>
		<td><input type="radio" name="popularityButton" value="flight"/>The most actively booked flight</td>
		</tr>
		</table>
		<input type="submit" value="submit">
	</form>
	
	<h2>Show all flights based on Airport:</h2>
	<form method="post" action="processAdminFunc.jsp">
		<table>
		<tr>    
		<td>Airport three-letter ID</td><td><input type="text" name="airport"></td>
		</tr>
		</table>
		<input type="submit" value="submit">
	</form>
	
</body>
</html>