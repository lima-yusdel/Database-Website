<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Representative Functions</title>
</head>
<div Class = "topleftcorner">
	<a href="index.jsp">Log out</a>
	</div>
<body>

<h1>Customer Representative Functions</h1>

<h2>Make a flight reservation on behalf of user:</h2>
<form method="post" action="processCustRepFunc.jsp">
		<table>
		<tr>    
		<td>UserID to make a flight reservation for:</td><td><input type="text" name="bookUser"></td>
		</tr>
		</table>
		<input type="submit" value="submit">
	</form>

<h2>Edit a flight reservation for a customer:</h2>
<form method="post" action="processCustRepFunc.jsp">
		<table>
		<tr>    
		<td>UserID to edit a flight reservation for:</td><td><input type="text" name="editUser"></td>
		</tr>
		<tr>    
		<td>Ticket number to edit:</td><td><input type="text" name="editTicket"></td>
		</tr>
		<tr>    
		<td><input type="radio" name="mealButton" value="premium"/>Premium Meal: +$15.00</td>
		</tr>
		<tr>    
		<td><input type="radio" name="mealButton" value="none"/>No Meal: +$0.00</td>
		</tr>
		<tr>
		</tr>
		<tr>    
		<td><input type="radio" name="classButton" value="first"/>First Class: +$100.00</td>
		</tr>
		<tr>    
		<td><input type="radio" name="classButton" value="business"/>Business Class: +$50.00</td>
		</tr>
		<tr>    
		<td><input type="radio" name="classButton" value="economy"/>Economy Class: +$0.00</td>
		</tr>
		</table>
		<input type="submit" value="submit">
	</form>

<h2>Add, Edit, or Delete information for Aircrafts, Airports or Flights </h2>
<form method="post" action="processCustRepFunc.jsp">
		<table>
		<tr>
		<td>Choose which type of information you want to work with:</td>
		</tr>
		<tr>    
		<td><input type="radio" name="informationButton" value="aircraft"/>Aircrafts</td>
		</tr>
		<tr>
		<td><input type="radio" name="informationButton" value="airport"/>Airports</td>
		</tr>
		<tr>
		<td><input type="radio" name="informationButton" value="flight"/>Flights</td>
		</tr>
		<tr>
		<td>What do you want to do with this value?</td>
		</tr>
		<tr>    
		<td><input type="radio" name="actionButton" value="aircraft"/>Add</td>
		</tr>
		<tr>
		<td><input type="radio" name="actionButton" value="airport"/>Edit</td>
		</tr>
		<tr>
		<td><input type="radio" name="actionButton" value="flight"/>Delete</td>
		</tr>
		
		</table>
		<input type="submit" value="submit">
	</form>
	
<h2>Retrieve a list of all passengers on the waiting list of a particular flight:</h2>
<form method="post" action="processCustRepFunc.jsp">
		<table>
		<tr>    
		<td>Flight Number:</td><td><input type="text" name="flightNumber"></td>
		</tr>
		</table>
		<input type="submit" value="submit">
	</form>

</body>
</html>