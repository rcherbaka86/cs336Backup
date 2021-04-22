<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta href="css/Login.css" charset="ISO-8859-1">
<title>CreateAuction</title>
</head>
<body>
	<%
	// User attributes
	String username = (String) request.getSession().getAttribute("username");
	
	// Vehicle attributes
	String manufacturer = request.getParameter("manufacturer");
	String model = request.getParameter("model");
	String color = request.getParameter("color");
	String milesStr = request.getParameter("miles");
	int miles = 0;
	String description = request.getParameter("description");
	String condition = request.getParameter("condition");
	String vehicleType = request.getParameter("vehicleType");
	
	// Car attributes
	String engineType = "";
	String sunroof = "";
	
	// SUV attributes
	String driveType = "";
	String extendible = "";
	
	// Motorcycle attributes
	String sidecar = "";
	String fuelConsumptionStr = "";
	int fuelConsumption = 0;
	
	// Auction attributes
	String closeDate = request.getParameter("closeDate");
	String closeTime = request.getParameter("closeTime");
	String initialPriceStr = request.getParameter("initialPrice");
	double initialPrice = 0.0;
	String minPriceStr = request.getParameter("minPrice");
	double minPrice = 0.0;
	String bidIncrementStr = request.getParameter("bidIncrement");
	double bidIncrement = 0.0;
	
	boolean error = false;
	
	// Checks if manufacturer is valid
	if (manufacturer.equals(""))
	{
		request.getSession().setAttribute("manufacturerError", "Manufacturer is empty!");
		error = true;
	}
	else if (manufacturer.length() >= 25)
	{
		request.getSession().setAttribute("manufacturerError", "Manufacturer is too long! (Max 25 characters)");
		error = true;
	}
	else
	{
		request.getSession().setAttribute("manufacturerError", "");
	}
	
	// Checks if model is valid
	if (model.equals(""))
	{
		request.getSession().setAttribute("modelError", "Model is empty!");
		error = true;
	}
	else if (model.length() >= 25)
	{
		request.getSession().setAttribute("modelError", "Model is too long! (Max 25 characters)");
		error = true;
	}
	else
	{
		request.getSession().setAttribute("modelError", "");
	}
	
	// Checks if color is valid
	if (color.equals(""))
	{
		request.getSession().setAttribute("colorError", "Color is empty!");
		error = true;
	}
	else if (color.length() >= 25)
	{
		request.getSession().setAttribute("colorError", "Color is too long! (Max 25 characters)");
		error = true;
	}
	else
	{
		request.getSession().setAttribute("colorError", "");
	}
	
	// Checks if miles is valid
	if (milesStr.equals(""))
	{
		request.getSession().setAttribute("milesError", "Miles is empty!");
		error = true;
	}
	try 
	{
		miles = Integer.parseInt(milesStr);
		if (miles < 0)
		{
			request.getSession().setAttribute("milesError", "Miles cannot be negative!");
			error = true;
		}
		else
		{
			request.getSession().setAttribute("milesError", "");
		}
	}
	catch (Exception e)
	{
		request.getSession().setAttribute("milesError", "Miles is not a valid integer!");
		error = true;
	}
	
	// Checks if description is valid
	if (description.equals(""))
	{
		request.getSession().setAttribute("descriptionError", "Description is empty!");
		error = true;
	}
	else if (description.length() >= 200)
	{
		request.getSession().setAttribute("descriptionError", "Description is too long! (Max 200 characters)");
		error = true;
	}
	else
	{
		request.getSession().setAttribute("descriptionError", "");
	}
	
	// Checks the type of vehicle and corresponding attributes
	if (vehicleType.equals("Car"))
	{
		engineType = request.getParameter("engineType");
		sunroof = request.getParameter("sunroof"); 
		
		// Checks if engine type is valid
		if (engineType.equals(""))
		{
			request.getSession().setAttribute("engineTypeError", "Engine type is empty!");
			error = true;
		}
		else if (engineType.length() >= 25)
		{
			request.getSession().setAttribute("engineTypeError", "Engine type is too long! (Max 25 characters)");
			error = true;
		}
		else
		{
			request.getSession().setAttribute("engineTypeError", "");
		}
	} 
	else if (vehicleType.equals("SUV"))
	{
		driveType = request.getParameter("driveType");
		extendible = request.getParameter("extendible"); 
	}
	else
	{
		sidecar = request.getParameter("sidecar");
		fuelConsumptionStr = request.getParameter("fuelConsumption"); 

		// Checks if engine type is valid
		if (fuelConsumptionStr.equals(""))
		{
			
			request.getSession().setAttribute("fuelConsumptionError", "Fuel consumption type is empty!");
			error = true;
		}
		try 
		{
			fuelConsumption = Integer.parseInt(fuelConsumptionStr);
			if (fuelConsumption < 0)
			{
				request.getSession().setAttribute("fuelConsumptionError", "Fuel consumption cannot be negative!");
				error = true;
			}
			else
			{
				request.getSession().setAttribute("fuelConsumptionError", "");
			}
		}
		catch (Exception e)
		{
			request.getSession().setAttribute("fuelConsumptionError", "Fuel consumption is not a valid integer!");
			error = true;
		}
	}
	
	// Checks if the given close date is valid
	if (closeDate.equals(""))
	{
		request.getSession().setAttribute("closeDateError", "Close date not specified!");
		error = true;
	}
	else
	{
		request.getSession().setAttribute("closeDateError", "");
	}
	
	// Checks if the given close time is valid
	if (closeTime.equals(""))
	{
		request.getSession().setAttribute("closeTimeError", "Close time not specified!");
		error = true;
	}
	else
	{
		request.getSession().setAttribute("closeTimeError", "");
	}
	StringBuilder sb = new StringBuilder();
	sb.append(closeTime);
	sb.append(":00");
	String time = sb.toString();
	
	// Checks if initial price is valid
	if (initialPriceStr.equals(""))
	{
		request.getSession().setAttribute("initialPriceError", "Initial price is empty!");
		error = true;
	}
	try 
	{
		initialPrice = Double.parseDouble(initialPriceStr);
		if (initialPrice < 0.0)
		{
			request.getSession().setAttribute("initialPriceError", "Initial price cannot be negative!");
			error = true;
		}
		else
		{
			request.getSession().setAttribute("initialPriceError", "");
		}
	}
	catch (Exception e)
	{
		request.getSession().setAttribute("initialPriceError", "Initial price is not a valid number!");
		error = true;
	}
	
	// Checks if initial price is valid
	if (minPriceStr.equals(""))
	{
		request.getSession().setAttribute("minPriceError", "Minimum price is empty!");
		error = true;
	}
	try 
	{
		minPrice = Double.parseDouble(minPriceStr);
		if (minPrice < 0.0)
		{
			request.getSession().setAttribute("minPriceError", "Minimum price cannot be negative!");
			error = true;
		}
		else
		{
			request.getSession().setAttribute("minPriceError", "");
		}
	}
	catch (Exception e)
	{
		request.getSession().setAttribute("minPriceError", "Minimum price is not a valid number!");
		error = true;
	}
	
	// Checks if initial price is valid
	if (bidIncrementStr.equals(""))
	{
		request.getSession().setAttribute("bidIncrementError", "Bid increment is empty!");
		error = true;
	}
	try 
	{
		bidIncrement = Double.parseDouble(bidIncrementStr);
		if (bidIncrement < 0.0)
		{
			request.getSession().setAttribute("bidIncrementError", "Bid increment cannot be negative!");
			error = true;
		}
		else
		{
			request.getSession().setAttribute("bidIncrementError", "");
		}
	}
	catch (Exception e)
	{
		request.getSession().setAttribute("bidIncrementError", "Bid increment is not a valid number!");
		error = true;
	}
	
	if (error)
	{
		request.getSession().setAttribute("manufacturer", manufacturer);
		request.getSession().setAttribute("model", model);
		request.getSession().setAttribute("color", color);
		request.getSession().setAttribute("miles", milesStr);
		request.getSession().setAttribute("description", description);
		request.getSession().setAttribute("condition", condition);
		request.getSession().setAttribute("vehicleType", vehicleType);
		request.getSession().setAttribute("engineType", engineType);
		request.getSession().setAttribute("sunroof", sunroof);
		request.getSession().setAttribute("driveType", driveType);
		request.getSession().setAttribute("extendible", extendible);
		request.getSession().setAttribute("sidecar", sidecar);
		request.getSession().setAttribute("fuelConsumption", fuelConsumptionStr);
		request.getSession().setAttribute("closeDate", closeDate);
		request.getSession().setAttribute("closeTime", closeTime);
		request.getSession().setAttribute("initialPrice", initialPriceStr);
		request.getSession().setAttribute("minPrice", minPriceStr);
		request.getSession().setAttribute("bidIncrement", bidIncrementStr);
		request.getRequestDispatcher("/CreateAuctionPage.jsp").forward(request, response);
		return;
	}
	
	// Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	// Create a SQL statement
	Statement stmt = con.createStatement();
	
	// First find the max auction_id in database
	String query = "SELECT max(auction_ID) max " +
			"FROM buymev1.`auction`";

	// Executes the query and stores the result
	ResultSet result = stmt.executeQuery(query);
	result.first();
	
	int maxAuctionID = result.getInt("max");
	int newAuctionID = maxAuctionID + 1;
	String newVehicleID = newAuctionID + "";
	
	// Make an insert statement for the vehicle table:
	String insertAuction = "INSERT INTO BuyMeV1.`auction` " + 
						 "VALUES (?,?,?,?)";
	
	// Create a Prepared SQL statement for inserting to vehicle table
	PreparedStatement ps1 = con.prepareStatement(insertAuction);

	// Add parameters of the query
	ps1.setInt(1, newAuctionID);
	ps1.setFloat(2, (float) bidIncrement);
	ps1.setFloat(3, (float) minPrice);
	ps1.setFloat(4, (float) initialPrice);
	
	ps1.executeUpdate();
	
	
	// Make an insert statement for the vehicle table:
	String insertVehicle = "INSERT INTO BuyMeV1.`vehicle` " + 
						 "VALUES (?,?,?,?,?,?,?,?,?)";
	
	// Create a Prepared SQL statement for inserting to vehicle table
	PreparedStatement ps2 = con.prepareStatement(insertVehicle);

	// Add parameters of the query
	ps2.setInt(1, newAuctionID);
	ps2.setString(2, newVehicleID);
	ps2.setString(3, manufacturer);
	ps2.setString(4, model);
	ps2.setString(5, color);
	ps2.setInt(6, miles);
	ps2.setString(7, description);
	ps2.setString(8, condition);
	ps2.setString(9, vehicleType);
	
	ps2.executeUpdate();
	
	// Make an insert statement for the creates table:
	String insertCreates = "INSERT INTO BuyMeV1.`creates` " + 
						 "VALUES (?,?,?,?)";
	
	// Create a Prepared SQL statement for inserting to vehicle table
	PreparedStatement ps3 = con.prepareStatement(insertCreates);

	// Add parameters of the query
	ps3.setString(1, username);
	ps3.setInt(2, newAuctionID);
	ps3.setString(3, time);
	ps3.setString(4, closeDate);
	
	ps3.executeUpdate();
	
	// Make an insert statement for the specifc type of vehicle table:
	String insertSpecifcVehicle;
	
	if (vehicleType.equals("Car")) // Insert into car table
	{
		insertSpecifcVehicle = "INSERT INTO BuyMeV1.`car` " + 
				 "VALUES (?,?,?,?)";
		
		// Create a Prepared SQL statement for inserting to vehicle table
		PreparedStatement ps4 = con.prepareStatement(insertSpecifcVehicle);

		// Add parameters of the query
		ps4.setInt(1, newAuctionID);
		ps4.setString(2, newVehicleID);
		ps4.setString(3, engineType);
		ps4.setString(4, sunroof);
		
		ps4.executeUpdate();
	} 
	else if (vehicleType.equals("SUV")) // Insert into suv table
	{
		insertSpecifcVehicle = "INSERT INTO BuyMeV1.`suv` " + 
				 "VALUES (?,?,?,?)";
		
		// Create a Prepared SQL statement for inserting to vehicle table
		PreparedStatement ps4 = con.prepareStatement(insertSpecifcVehicle);

		// Add parameters of the query
		ps4.setInt(1, newAuctionID);
		ps4.setString(2, newVehicleID);
		ps4.setString(3, driveType);
		ps4.setString(4, extendible);
		
		ps4.executeUpdate();
	}
	else // Insert into motorcycle table
	{
		insertSpecifcVehicle = "INSERT INTO BuyMeV1.`motorcycle` " + 
				 "VALUES (?,?,?,?)";
		
		// Create a Prepared SQL statement for inserting to vehicle table
		PreparedStatement ps4 = con.prepareStatement(insertSpecifcVehicle);

		// Add parameters of the query
		ps4.setInt(1, newAuctionID);
		ps4.setString(2, newVehicleID);
		ps4.setString(3, sidecar);
		ps4.setInt(4, fuelConsumption);
		
		ps4.executeUpdate();
	}
	
	// Redirect to home page
	request.getRequestDispatcher("/HomePage.jsp").forward(request, response);

	%>
</body>
</html>