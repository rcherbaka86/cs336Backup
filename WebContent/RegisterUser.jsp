<%@page import="javax.mail.internet.InternetAddress"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="javax.mail.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
	
		boolean error = false;
	
		// Checks the format of the username
		String errorMsg1 = InputValidation.checkUsername(username);
		
		if (errorMsg1 == null)
		{
			// Username format acceptable
			request.getSession().removeAttribute("usernameError");
		}
		else
		{
			// Error in username format
			request.getSession().setAttribute("usernameError", errorMsg1);
			error = true;	
		}
		
		// Checks the format of the password
		String errorMsg2 = InputValidation.checkPassword(password);
		
		if (errorMsg2 == null)
		{
			// Password format acceptable
			request.getSession().removeAttribute("passwordError");
		}
		else
		{
			// Error in password format
			request.getSession().setAttribute("passwordError", errorMsg2);
			error = true;
		}
		
		// Checks the format of the email
		String errorMsg3 = InputValidation.checkEmail(email);
		
		if (errorMsg3 == null)
		{
			// Password format acceptable
			request.getSession().removeAttribute("emailError");
		}
		else
		{
			// Error in password format
			request.getSession().setAttribute("emailError", errorMsg3);
			error = true;
		}
	
		// Return to login page if there's any error
		if (error) 
		{
			request.getSession().setAttribute("username", username);
			request.getSession().setAttribute("password", password);
			request.getSession().setAttribute("email", email);
			request.getRequestDispatcher("/RegisterPage.jsp").forward(request, response);
			return;
		} 
	
		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
	
		// Create a SQL statement
		Statement stmt = con.createStatement();

		// Make an insert statement for the user table:
		String insertUser = "INSERT INTO BuyMeV1.`user` " + 
							 "VALUES (?,?)";
		
		// Create a Prepared SQL statement for inserting to user table
		PreparedStatement ps1 = con.prepareStatement(insertUser);

		// Add parameters of the query
		ps1.setString(1, username);
		ps1.setString(2, password);
		
		try 
		{
			ps1.executeUpdate();
		} 
		catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) 
		{
			// The username already exists in the database (Case-Insensitive)
			request.getSession().setAttribute("username", username);
			request.getSession().setAttribute("password", password);
			request.getSession().setAttribute("usernameError", "Username already taken!");
			request.getRequestDispatcher("/RegisterPage.jsp").forward(request, response);
			
			// Close the connection
			con.close();
			return;
		}
		
		// Make an insert statement for the end-user table:
		String insertEndUser = "INSERT INTO BuyMeV1.`end-user` " + 
							 "VALUES (?,?,?)";
		
		// Create a Prepared SQL statement for inserting to end-user table
		PreparedStatement ps2 = con.prepareStatement(insertEndUser);

		// Add parameters of the query
		ps2.setString(1, username);
		ps2.setString(2, password);
		ps2.setString(3, email);
		ps2.executeUpdate();
	
		// Close the connection
		con.close();
		
		// Save the username
		request.getSession().setAttribute("username", username);
		request.getSession().removeAttribute("password");
		
		// Redirect to home page
		request.getRequestDispatcher("/HomePage.jsp").forward(request, response);
	%>
</body>
</html>