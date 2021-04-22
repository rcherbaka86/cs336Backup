<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LoginUser</title>
</head>
<body>


	<%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
	
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
	
		// Return to login page if there's any error
		if (error) 
		{
			request.getSession().setAttribute("username", username);
			request.getSession().setAttribute("password", password);
			request.getRequestDispatcher("/LoginPage.jsp").forward(request, response);
			return;
		} 
	
		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
	
		// Create a SQL statement
		Statement stmt = con.createStatement();
	
		// Determines if a user with the given credentials exists
		String query = "SELECT EXISTS(" + 
					   		"SELECT * " + 
					   		"FROM buymev1.`user` e " +
					   		"WHERE BINARY e.username = '" + username + "' AND BINARY e.password = '" + password + "' " + 
				   	   ") AS 'exists'";
	
		// Executes the query and stores the result
		ResultSet result = stmt.executeQuery(query);
		result.first();
		
		int exists = result.getInt("exists");
	
		if (exists == 0) 
		{
			// User doesn't exist
			request.getSession().setAttribute("username", username);
			request.getSession().setAttribute("password", password);
			request.getSession().setAttribute("passwordError", "Username or password incorrect!");
			request.getRequestDispatcher("/LoginPage.jsp").forward(request, response);
			
			// Close the connection
			con.close();
			return;
		}
	
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