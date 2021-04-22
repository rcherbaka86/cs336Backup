<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/Login.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>CreateAuctionPage</title>
<style>
p {
  font-weight: bold;
  font-size: 14pt;
}
</style>
</head>
<body>
	<h1>Create Auction:</h1>
	<form method="post" action="CreateAuction.jsp">
		<p>Manufacturer:</p>
		<input name="manufacturer" value=${manufacturer}>
		<div style="color: red">${manufacturerError}</div>
		
		<br>
		
		<p>Model:</p>
		<input name="model" value=${model}>
		<div style="color: red">${modelError}</div>
		
		<br>
		
		<p>Color:</p>
		<input name="color" value=${color}>
		<div style="color: red">${colorError}</div>
		
		<br>
		
		<p>Miles:</p>
		<input name="miles" value=${miles}>
		<div style="color: red">${milesError}</div>
		
		<br>
		
		<p>Description:</p>
		<textarea name="description">${description}</textarea>
		<div style="color: red">${descriptionError}</div>
		
		<br>
		
		<p>Condition:</p>
		<input type="radio" name="condition" value="Poor" ${ condition.equals("Poor") || condition == null || condition.equals("") ? 'checked="checked"' : ''}/>Poor
		<input type="radio" name="condition" value="Fair" ${ condition.equals("Fair") ? 'checked="checked"' : ''}/>Fair
		<input type="radio" name="condition" value="Good" ${ condition.equals("Good") ? 'checked="checked"' : ''}/>Good
		<input type="radio" name="condition" value="New" ${ condition.equals("New") ? 'checked="checked"' : ''}/>New
		
		<br>
		
		<p>Vehicle type: (Only need to fill out info under selected vehicle type)</p>
		<div class="big-grid">
			<div class="big-grid-item">
				<input type="radio" name="vehicleType" value="Car" 
				${ vehicleType.equals("Car") || vehicleType == null || vehicleType.equals("") ? 'checked="checked"' : ''}/>
				<label>Car</label>
			</div>
			
			<div class="big-grid-item">
				<input type="radio" name="vehicleType" value="SUV" 
				${ vehicleType.equals("SUV") ? 'checked="checked"' : ''}/>
				<label>SUV</label>
			</div>
			
			<div class="big-grid-item">
				<input type="radio" name="vehicleType" value="Motorcycle" 
				${ vehicleType.equals("Motorcycle") ? 'checked="checked"' : ''}/>
				<label>Motorcycle</label>
			</div>
			
			<div class="big-grid-item">
				<p>Engine type: (CAR ONLY)</p>
				<input name="engineType" value=${engineType}>
				<div style="color: red">${vehicleType.equals("Car") ? engineTypeError : ""}</div>
			</div>
			
			<div class="big-grid-item">
				<p>Drive type: (SUV ONLY)</p>
				<input type="radio" name="driveType" value="AWD" 
				${ driveType.equals("AWD") || driveType == null || driveType.equals("") ? 'checked="checked"' : ''}/>AWD
				<input type="radio" name="driveType" value="2WD" 
				${ driveType.equals("2WD") ? 'checked="checked"' : ''}/>2WD
			</div>
			
			<div class="big-grid-item">
				<p>Is the there a sidecar: (MOTORCYCLE ONLY)</p>
				<input type="radio" name="sidecar" value="true" 
				${ sidecar.equals("true") || sidecar == null || sidecar.equals("") ? 'checked="checked"' : ''}/>Yes
				<input type="radio" name="sidecar" value="false" 
				${ sidecar.equals("false") ? 'checked="checked"' : ''}/>No
			</div>
			
			<div class="big-grid-item">
				<p>Is there a Sunroof: (CAR ONLY)</p>
				<input type="radio" name="sunroof" value="true" 
				${ sunroof.equals("true") || sunroof == null || sunroof.equals("") ? 'checked="checked"' : ''}/>Yes
				<input type="radio" name="sunroof" value="false" 
				${ sunroof.equals("false") ? 'checked="checked"' : ''}/>No
			</div>
			
			<div class="big-grid-item">
				<p>Is the trunk extendible: (SUV ONLY)</p>
				<input type="radio" name="extendible" value="true" 
				${ extendible.equals("true") || extendible == null || extendible.equals("") ? 'checked="checked"' : ''}/>Yes
				<input type="radio" name="extendible" value="false" 
				${ extendible.equals("false") ? 'checked="checked"' : ''}/>No
			</div>
			
			<div class="big-grid-item">
				<p>Fuel consumption (Miles/Gallon): (MOTORCYCLE ONLY)</p>
				<input name="fuelConsumption" value=${fuelConsumption}>
				<div style="color: red">${vehicleType.equals("Motorcycle") ? fuelConsumptionError : ""}</div>
			</div>
		</div>
		
		<p>Initial price:</p>
		<input name="initialPrice" value=${initialPrice}>
		<div style="color: red">${initialPriceError}</div>
		
		<p>Minimum price:</p>
		<input name="minPrice" value=${minPrice}>
		<div style="color: red">${minPriceError}</div>
		
		<p>Bid increment amount:</p>
		<input name="bidIncrement" value=${bidIncrement}>
		<div style="color: red">${bidIncrementError}</div>
		
		<p>Auction close date:</p>
		<input type="date" name="closeDate" value=${closeDate}>
		<div style="color: red">${closeDateError}</div>
		
		<br>
		
		<p>Auction close time:</p>
		<input type="time" name="closeTime" value=${closeTime}>
		<div style="color: red">${closeTimeError}</div>
		
		<br>
		
		<input class="button" type="submit" value="Start Auction">
	</form>
</body>
</html>