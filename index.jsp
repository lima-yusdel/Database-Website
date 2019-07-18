<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Login</title>
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
						Account Login
					</span>
				<form action="processLogin.jsp" method="GET">
				<div class="wrap-input">
					<input class="input" type="text" name="username" placeholder="Username">
					<span class="focus-input-1"></span>
					<span class="focus-input-2"></span>
				</div>
			
				<div class="wrap-input rs1">
					 <input class="input" type="text" name="pass" placeholder="Password"/>
					 <span class="focus-input-1"></span>
					 <span class="focus-input-2"></span>
				</div>
				
					<input class="login-form-btn container-login-form-btn m-t-20" type="submit" value="Log in" />
				</form>
					<div class="text-center p-t-20">
					<span class="txt1">
						Create an account?
					</span>
					<a href="createAccount.jsp" class="txt2 hov1">
						Sign up
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>