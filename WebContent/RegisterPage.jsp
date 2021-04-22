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
<title>RegisterPage</title>
</head>
<body>

	<div class="centered wrapper">
		<div class="box">
			
			<div class="title">Create Account</div>
			
			<form method="post" action="RegisterUser.jsp">
				<div class="grid">
					<label class="grid-item label body-font">Username:</label>
					<input class="grid-item input-box body-font" name="username" value=${username}>
					
					<div class="grid-item bottom-padding"></div>
					<div class="grid-item bottom-padding" style="color: red; text-align: left;">${usernameError}</div>
				
					<label class="grid-item label body-font">Password:</label>
					<input class="grid-item input-box body-font" name="password" value=${password}>
					
					<div class="grid-item bottom-padding"></div>
					<div class="grid-item bottom-padding" style="color: red; text-align: left;">${passwordError}</div>
					
					<label class="grid-item label body-font">E-mail:</label>
					<input class="grid-item input-box body-font" name="email" value=${email}>
					
					<div class="grid-item bottom-padding"></div>
					<div class="grid-item bottom-padding" style="color: red; text-align: left;">${emailError}</div>
				</div>
				
				<br/>
				
				<input class="button" type="submit" value="Register">
			</form>
		</div>
	</div>
	
</body>
</html>