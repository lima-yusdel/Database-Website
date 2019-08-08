<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Search Flights</title>
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
			<span class="login-form-title p-b-33">
				Find the best flights 
			</span>
			<div class="text-align:center fs-14 p-l-35 p-b-20 p-t-5 p-r-10">
			<form action="redirect.jsp" method="POST">
			<div class="wrap-input">
				<input class="input" type="text" name="From" placeholder="From: (city)">
				<span class="focus-input-1"></span>
				<span class="focus-input-2"></span>
			</div>
			<div class="wrap-input rs1">
				<input class="input" type="text" name="To" placeholder="To where: (city)"/>
				<span class="focus-input-1"></span>
				<span class="focus-input-2"></span>
			</div>	
			<div class="wrap-input rs1">
				<input class="input" type="text" name="Date" placeholder="(Optional) Date: Year-Month-Day"/>
				<span class="focus-input-1"></span>
				<span class="focus-input-2"></span>
			</div>	
			<input type="radio" name="flight" value="2"> Round Trip<br>
			<input type="radio" name="flight" value="1"> One Way<br>
			<input class="login-form-btn container-login-form-btn m-t-20" type="submit" value="Find flights" />
			</form>
			</div>
		</div>
	</div>
</div>	
</body>
</html>