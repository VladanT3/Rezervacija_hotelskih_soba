<%@ page import="Models.RoomType" %>
<%@ page import="Models.RoomType" %>
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
	
	request.getSession().setAttribute("Active", "roomTypes");
 
	String loggedInEmployee = (String) request.getSession().getAttribute("LoggedInEmployee");
	loggedInEmployee = loggedInEmployee == null ? "" : loggedInEmployee;
	if(loggedInEmployee.equals("Manager")){
		request.getSession().setAttribute("Title", "Manager | Room Types");
	}
	else if(loggedInEmployee.equals("Admin")){
		request.getSession().setAttribute("Title", "Administrator | Room Types");
	}
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%
		String updateCheck = (String) request.getAttribute("checkUpdate");
		int update = 0;
		RoomType roomType = new RoomType();
		if(updateCheck != null)
		{
			update = Integer.parseInt(updateCheck);
			roomType = (RoomType) request.getAttribute("roomType");
		}
		
        boolean roomTypeAlreadyExistsError = request.getAttribute("roomTypeAlreadyExistsError") != null;
		boolean wholeNumberError = request.getAttribute("wholeNumberError") != null;
        String numberOfBeds = request.getAttribute("numberOfBeds") == null ? "" : (String) request.getAttribute("numberOfBeds");
		String bedType = request.getAttribute("bedType") == null ? "" : (String) request.getAttribute("bedType");
		String kitchen = request.getAttribute("kitchen") == null ? "" : (String) request.getAttribute("kitchen");
		String bathroom = request.getAttribute("bathroom") == null ? "" : (String) request.getAttribute("bathroom");
		boolean television = request.getAttribute("television") != null;
		String desc = request.getAttribute("desc") == null ? "" : (String) request.getAttribute("desc");
		
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
			<%
				if(roomTypeAlreadyExistsError)
				{
			%>
					<div class="col-12 alert alert-danger margin-t-50" role="alert">
						<i class="fa-solid fa-circle-exclamation fa-lg"></i> Selected room type already exists!
					</div>
			<%
				}
			%>
			<div class="col-4"></div>
			<div class="col-4">
				<fieldset class="margin-t-50">
					<legend>
						<%
							if(update == 1)
								out.print("Edit Room Type");
							else
								out.print("Add New Room Type");
						%>
					</legend>
					<form action="InsertAndUpdateRoomTypeServlet" method="post" class="row">
						<div class="col-6">
							<div class="mb-3">
								<label for="roomTypeBedType" class="form-label">Bed Type</label>
								<select class="form-select input-boja" name="roomTypeBedType" id="roomTypeBedType" required>
									<option class="text-muted" value="">Select One</option>
									<option <%= bedType.equals("Single") ? "selected" : update == 1 ? roomType.getBedType().equals("Single") ? "selected" : "" : "" %> value="Single">Single</option>
									<option <%= bedType.equals("Double") ? "selected" : update == 1 ? roomType.getBedType().equals("Double") ? "selected" : "" : "" %> value="Double">Double</option>
									<option <%= bedType.equals("Single + Double") ? "selected" : update == 1 ? roomType.getBedType().equals("Single + Double") ? "selected" : "" : "" %> value="Single + Double">Single + Double</option>
									<option <%= bedType.equals("Queen") ? "selected" : update == 1 ? roomType.getBedType().equals("Queen") ? "selected" : "" : "" %> value="Queen">Queen</option>
									<option <%= bedType.equals("King") ? "selected" : update == 1 ? roomType.getBedType().equals("King") ? "selected" : "" : "" %> value="King">King</option>
								</select>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3">
								<label for="roomTypeNumberOfBeds" class="form-label">Number of Beds</label>
								<input type="text" name="roomTypeNumberOfBeds" id="roomTypeNumberOfBeds" class="form-control input-boja <%= wholeNumberError ? "is-invalid" : "" %>" value="<%= numberOfBeds != "" ? numberOfBeds : update == 1 ? roomType.getNumberOfBeds() : "" %>" required>
								<%
									if(wholeNumberError)
									{
										out.print
										(
											"<div id='validationNumberOfStars' class='invalid-feedback'>" +
												"Incorrect value, number of beds has to be a number!" +
											"</div>"
										);
									}
								%>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3">
								<label for="roomTypeKitchen" class="form-label">Kitchen Type</label>
								<select class="form-select input-boja" name="roomTypeKitchen" id="roomTypeKitchen"
								        required>
									<option class="text-muted" value="">Select One</option>
									<option <%= kitchen.equals("None") ? "selected" : update == 1 ? roomType.getKitchen().equals("None") ? "selected" : "" : "" %> value="None">None</option>
									<option <%= kitchen.equals("Semi-furnished") ? "selected" : update == 1 ? roomType.getKitchen().equals("Semi-furnished") ? "selected" : "" : "" %> value="Semi-furnished">Semi-furnished</option>
									<option <%= kitchen.equals("Fully-furnished") ? "selected" : update == 1 ? roomType.getKitchen().equals("Fully-furnished") ? "selected" : "" : "" %> value="Fully-furnished">Fully-furnished</option>
								</select>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3">
								<label for="roomTypeBathroom" class="form-label">Bathroom Type</label>
								<select class="form-select input-boja" name="roomTypeBathroom" id="roomTypeBathroom"
								        required>
									<option class="text-muted" value="">Select One</option>
									<option <%= bathroom.equals("Shower") ? "selected" : update == 1 ? roomType.getBathroom().equals("Shower") ? "selected" : "" : "" %> value="Shower">Shower</option>
									<option <%= bathroom.equals("Bath") ? "selected" : update == 1 ? roomType.getBathroom().equals("Bath") ? "selected" : "" : "" %> value="Bath">Bath</option>
								</select>
							</div>
						</div>
						<div class="col-6">
							<div class="form-check form-switch col mb-3">
								<label class="form-check-label" for="roomTypeTV">TV</label>
								<input class="form-check-input check-boja" type="checkbox" name="roomTypeTV" id="roomTypeTV" <%= television ? "checked" : update == 1 ? roomType.isTelevision() ? "checked" : "" : "" %>>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<textarea name="roomTypeDesc" id="roomTypeDesc" class="form-control input-boja" style="height: 150px" placeholder="Room Description" maxlength="500" required><%= desc != "" ? desc : update == 1 ? roomType.getDescription() : "" %></textarea>
								<label for="roomTypeDesc" class="text-muted">Room Description</label>
							</div>
						</div>
						<%
							if(update == 0)
							{
						%>
								<div class="col-12">
									<div class="d-grid gap-2">
										<input type="submit" name="submit" class="btn btn-light" value="Add Room Type">
									</div>
								</div>
						<%
							}
							else
							{
						%>
								<div class="col-12">
									<input type="hidden" name="updateRoomTypeID" value="<%= roomType.getRoomTypeID() %>">
									<div class="d-grid gap-2">
										<input type="submit" name="submit" class="btn btn-light float-end" value="Edit Room Type">
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
