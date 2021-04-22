package com.cs336.pkg;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InputValidation 
{
	/**
	* Checks if a given string is a valid username.
	* @param str is the string being checked
	* @return an error message if not formatted correctly, null otherwise
	*/
	public static String checkUsername(String str) 
	{
		if (str.equals("")) 
		{
			return "Username is empty!";
		} 
		else if (str.indexOf(' ') != -1) 
		{
			return "Username cannot contain a space!";
		}
		else if (str.length() < 5) 
		{
			return "Username must be at least 5 characters!";
		} 
		else if (str.length() > 20) 
		{
			return "Username cannot exceed 20 characters!";
		} 
		else 
		{
			return null;
		}
	}
	
	/**
	* Checks if a given string is a valid password.
	* @param str is the string being checked
	* @return an error message if not formatted correctly, null otherwise
	*/
	public static String checkPassword(String str) 
	{
		if (str.equals("")) 
		{
			return "Password is empty!";
		} 
		else if (str.indexOf(' ') != -1) 
		{
			return "Password cannot contain a space!";
		}
		else if (str.length() < 5) 
		{
			return "Password must be at least 5 characters!";
		} 
		else if (str.length() > 20) 
		{
			return "Password cannot exceed 20 characters!";
		} 
		else 
		{
			return null;
		}
	}
	
	/**
	* Checks if a given string is a valid email address.
	* @param str is the string being checked
	* @return an error message if not formatted correctly, null otherwise
	*/
	public static String checkEmail(String str)
	{
		if (str.equals("")) 
		{
			// Email empty
			return "Email is empty!";
		} 
		else if (str.length() > 45) 
		{
			// Email too short
			return "Email too long!";
		} 
		else 
		{
			// Ensures that the given email address is valid
			boolean valid = true;
		    try 
		    {	
		        javax.mail.internet.InternetAddress emailAddress = new javax.mail.internet.InternetAddress(str);
		        emailAddress.validate();
		    } 
		    catch (javax.mail.internet.AddressException e) 
		    {
		       valid = false;
		    }
		    
		    if (!valid) 
		    {
		    	// Email invalid
		    	return  "Email is invalid!";
		    } 
		    else 
		    {
		    	// Password format is acceptable
		    	return null;
		    }
		}
	}
	
	public static void clearInputs(HttpServletRequest request) 
	{
		// Fields
		request.getSession().removeAttribute("username");
		request.getSession().removeAttribute("password");
		request.getSession().removeAttribute("email");
		
		// Errors
		request.getSession().removeAttribute("usernameError");
		request.getSession().removeAttribute("passwordError");
		request.getSession().removeAttribute("emailError");
	}
}

