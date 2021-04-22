<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {
  background-image: linear-gradient(to bottom right, #020024, #00d4ff);
}
input[type="submit"]:hover {
	cursor: pointer;
}
</style>
<link href="css/Login.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>LoginPage</title>
</head>
<body>
	<div class="centered wrapper">
		<div class="box">
			<div class="title">Log in</div>
			
			<form method="post" action="LoginUser.jsp">
				
				<div class="grid">
					<label class="grid-item label body-font">Username:</label>
					<input class="grid-item input-box body-font" name="username" value=${username}>
					
					<div class="grid-item bottom-padding"></div>
					<div class="grid-item bottom-padding" style="color: red; text-align: left;">${usernameError}</div>
				
					<label class="grid-item label body-font">Password:</label>
					<input class="grid-item input-box body-font" name="password" value=${password}>
					
					<div class="grid-item bottom-padding"></div>
					<div class="grid-item bottom-padding" style="color: red; text-align: left;">${passwordError}</div>
				</div>
				
				<div class="body-font">
					<label>Not registered yet? </label>
					<a class="link" 
					onclick="<% InputValidation.clearInputs(request); %>" 
					href="http://localhost:8080/cs336project/RegisterPage.jsp">
						Create an account
					</a>
				</div>
				
				<br/>
				
				<input class="button" type="submit" value="Login">
			</form>
			
		</div>
	</div>
	
</body>
</html>