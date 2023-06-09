<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.Manager" %>
<%@ page import="Models.Hotel" %>
<%@ page import="Models.Manager" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Object checkLogin = request.getSession().getAttribute("LoggedInUser");
	if(checkLogin == null)
	{
		request.getSession().invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
	
	boolean isClientLoggedIn = request.getSession().getAttribute("LoggedInClient") != null;
	if(isClientLoggedIn)
	{
		response.sendRedirect("clientAccount.jsp");
		return;
	}
	
	String loggedInEmployee = (String) request.getSession().getAttribute("LoggedInEmployee");
	loggedInEmployee = loggedInEmployee == null ? "" : loggedInEmployee;
    if(loggedInEmployee.equals("Manager")){
	    request.getSession().setAttribute("Title", "Manager | Edit Hotel");
	    request.getSession().setAttribute("Active", "editHotel");
    }
    else if(loggedInEmployee.equals("Admin")){
	    request.getSession().setAttribute("Title", "Administrator | Hotels");
	    request.getSession().setAttribute("Active", "adminHoteli");
    }
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%
		String checkUpdate = (String) request.getAttribute("checkUpdate");
        int update = 0;
		Hotel hotel = new Hotel();
        Manager hotelManager = new Manager();
        if(checkUpdate != null)
        {
	        update = Integer.parseInt(checkUpdate);
            hotel = (Hotel) request.getAttribute("hotel");
            hotelManager = Manager.ReturnManager(hotel.getManagerID());
        }
        
		ArrayList<Manager> unassignedManagers = Manager.ReturnManagersWhoArentAssignedAHotel();
        
        boolean wholeNumberError = request.getAttribute("wholeNumberError") != null;
        String inputManager = request.getAttribute("manager") == null ? "" : (String) request.getAttribute("manager");
        String inputName = request.getAttribute("name") == null ? "" : (String) request.getAttribute("name");
        String inputCountry = request.getAttribute("country") == null ? "" : (String) request.getAttribute("country");
        String inputCity = request.getAttribute("city") == null ? "" : (String) request.getAttribute("city");
        String inputStars = request.getAttribute("numberOfStars") == null ? "" : (String) request.getAttribute("numberOfStars");
        String inputParking = request.getAttribute("numberOfParkingSpots") == null ? "" : (String) request.getAttribute("numberOfParkingSpots");
        String desc = request.getAttribute("desc") == null ? "" : (String) request.getAttribute("desc");
        String photoName = request.getAttribute("photoName") == null ? "" : (String) request.getAttribute("photoName");
		
        if(loggedInEmployee.equals("Manager")){
	%>
			<%@ include file="headers and footer/managerHeader.jsp" %>
	<%
		}
		else if(loggedInEmployee.equals("Admin")){
	%>
			<%@ include file="headers and footer/adminHeader.jsp" %>
	<%
		}
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<fieldset class="margin-t-50">
					<legend>
						<%
							if(update == 1)
                                out.print("Edit Hotel");
                            else
                                out.print("Add New Hotel");
						%>
					</legend>
					<form action="ServletInsertAndUpdateHotel" method="post" class="row">
						<%
							if(loggedInEmployee.equals("Admin"))
							{
                        %>
							<div class="col-12">
								<div class="mb-3">
									<label for="assignedManager" class="form-label">Hotel Manager:</label>
									<select class="form-select input-boja" id="assignedManager" name="assignedManager">
										<option value="">Select One</option>
										<%
											if(update == 1 && hotelManager.getId() != null){
                                        %>
												<option selected value="<%= hotelManager.getId() %>"><%= hotelManager.getId() + " - " + hotelManager.getFirstName() + " " + hotelManager.getLastName() %></option>
										<%
											}
										%>
										<%
											for(Manager manager : unassignedManagers)
											{
                                                boolean selected = manager.getId().equals(inputManager);
										%>
												<option value="<%= manager.getId() %>" <%= selected ? "selected" : "" %>><%= manager.getId() + " - " + manager.getFirstName() + " " + manager.getLastName() %></option>
										<%
											}
										%>
									</select>
								</div>
							</div>
						<%
							}
						%>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="text" name="hotelName" id="hotelName" class="form-control input-boja" placeholder="Hotel Name" value="<%= inputName != "" ? inputName : update == 1 ? hotel.getName() : "" %>" required>
								<label for="hotelName" class="text-muted">Hotel Name</label>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="text" name="hotelCountry" id="hotelCountry" class="form-control input-boja" placeholder="Country" value="<%= inputCountry != "" ? inputCountry : update == 1 ? hotel.getCountry() : "" %>" required>
								<label for="hotelCountry" class="text-muted">Country:</label>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="text" name="hotelCity" id="hotelCity" class="form-control input-boja" placeholder="City" value="<%= inputCity != "" ? inputCity : update == 1 ? hotel.getCity() : "" %>" required>
								<label for="hotelCity" class="text-muted">City</label>
							</div>
						</div>
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" name="hotelZvezdice" id="hotelZvezdice" class="form-control input-boja <%= wholeNumberError ? "is-invalid" : "" %>" placeholder="Number of stars" value="<%= inputStars != "" ? inputStars : update == 1 ? hotel.getNumberOfStars() : "" %>" required>
								<label for="hotelZvezdice" class="text-muted">Number of stars</label>
								<%
									if(wholeNumberError)
									{
										out.print
										(
											"<div id='validationNumberOfStars' class='invalid-feedback'>" +
												"Incorrect value, number of stars has to be a number!" +
											"</div>"
										);
									}
								%>
							</div>
						</div>
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" name="hotelParking" id="hotelParking" class="form-control input-boja <%= wholeNumberError ? "is-invalid" : "" %>" placeholder="Parking spots" value="<%= inputParking != "" ? inputParking : update == 1 ? hotel.getNumberOfParkingSpots() : "" %>" required>
								<label for="hotelParking" class="text-muted">Parking spots</label>
								<%
									if(wholeNumberError)
									{
										out.print
										(
											"<div id='validationParkingSpots' class='invalid-feedback'>" +
												"Incorrect value, number of parking spots has to be a number!" +
											"</div>"
										);
									}
								%>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="text" name="hotelPicture" id="hotelPicture" class="form-control input-boja" placeholder="Hotel Picture" value="<%= photoName != "" ? photoName : update == 1 ? hotel.getPhotoName() : "" %>">
								<label for="hotelPicture" class="text-muted">Hotel Picture</label>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<textarea name="hotelDesc" id="hotelDesc" class="form-control input-boja" style="height: 150px" placeholder="Hotel Description" maxlength="500" required><%= desc != "" ? desc : update == 1 ? hotel.getDescription() : "" %></textarea>
								<label for="hotelDesc" class="text-muted">Hotel Description</label>
							</div>
						</div>
						<%
							if(update == 0)
							{
                        %>
								<div class="col-12">
									<div class="d-grid gap-2">
										<input type="submit" name="submit" class="btn btn-light" value="Add Hotel">
									</div>
								</div>
						<%
							}
                            else
							{
                        %>
								<div class="col-12">
									<input type="hidden" name="updateHotelID" value="<%= hotel.getId() %>">
									<div class="d-grid gap-2">
										<input type="submit" name="submit" class="btn btn-light float-end" value="Edit Hotel">
									</div>
								</div>
						<%
							}
						%>
					</form>
				</fieldset>
			</div>
			<div class="col-4"></div>
		</div>
		
		<%@ include file="headers and footer/footer.jsp" %>
	</div>
	
	<%@ include file="inits/jsInit.jsp"%>
</body>
</html>
