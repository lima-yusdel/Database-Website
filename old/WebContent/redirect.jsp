<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import= "java.util.Date"%>
<%
	int flight = Integer.valueOf((String)request.getParameter("flight"));	
	String From = request.getParameter("From");
	String To = request.getParameter("To");
	session = request.getSession();
	session.setAttribute("fromCity", From);
	session.setAttribute("toCity", To);
	
	
	
	
	if(request.getParameter("Date") != null)
	{
		String Date = request.getParameter("Date");
		session.setAttribute("Date", Date);
	}
	
	if(flight == 2)
	{
		response.sendRedirect("selectRoundFlight.jsp");
	}
	else
		if(flight == 1)
		{
			response.sendRedirect("selectFlight.jsp");
		}
	
%>


	
	