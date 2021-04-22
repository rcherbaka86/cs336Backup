<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<style>
input[type="submit"]:hover {
	cursor: pointer;
}
</style>
<link href="css/Login.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>HomePage</title>
</head>
<body>
	<h1>Hi ${username}!</h1>
	<form method="get" action="LoginPage.jsp">
		<input class="button" type="submit" value="Logout">
	</form>
	
	<form method="get" action="CreateAuctionPage.jsp">
		<input class="button" type="submit" value="Create Auction">
	</form>
</body>
</html>