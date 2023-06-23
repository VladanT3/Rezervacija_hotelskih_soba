<%@ page import="Models.Room" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.RoomType" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%! Hotel roomsHotel; %>
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
	
	request.getSession().setAttribute("Active", "searchRooms");
	
	String loggedInEmployee = (String) request.getSession().getAttribute("LoggedInEmployee");
	loggedInEmployee = loggedInEmployee == null ? "" : loggedInEmployee;
	if(loggedInEmployee.equals("Manager")){
		request.getSession().setAttribute("Title", "Manager | Add or Edit Rooms");
        Manager manager = (Manager) request.getSession().getAttribute("LoggedInUser");
        roomsHotel = manager.ReturnAssignedHotel();
	}
	else if(loggedInEmployee.equals("Admin")){
		request.getSession().setAttribute("Title", "Administrator | Add or Edit Rooms");
        roomsHotel = new Hotel();
	}
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%
		String updateCheck = (String) request.getAttribute("checkUpdate");
		int update = 0;
		Room room = new Room();
		if(updateCheck != null)
		{
			update = Integer.parseInt(updateCheck);
			room = (Room) request.getAttribute("room");
            roomsHotel = Hotel.ReturnHotelDetails(room.getHotelID());
		}
		
		ArrayList<Hotel> hotels = Hotel.ReturnHotels("");
        ArrayList<RoomType> roomTypes = RoomType.ReturnRoomTypes("");
		
        boolean numberError = request.getAttribute("numberError") != null;
		boolean roomNumberAlreadyExistsError = request.getAttribute("roomNumberAlreadyExistsError") != null;
        String pickedHotelID = request.getAttribute("pickedHotelID") == null ? "" : (String) request.getAttribute("pickedHotelID");
        String pickedRoomType = request.getAttribute("pickedRoomType") == null ? "" : (String) request.getAttribute("pickedRoomType");
        String pickedRoomNumber = request.getAttribute("pickedRoomNumber") == null ? "" : (String) request.getAttribute("pickedRoomNumber");
        String pickedPricePerNight = request.getAttribute("pickedPricePerNight") == null ? "" : (String) request.getAttribute("pickedPricePerNight");
		
		if(loggedInEmployee.equals("Manager"))
        {
	%>
		<%@ include file="headers and footer/managerHeader.jsp" %>
	<%
		}
	else if(loggedInEmployee.equals("Admin"))
        {
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
							{
						%>
								Edit Room
						<%
							}
							else
							{
						%>
								Add New Room
						<%
							}
						%>
					</legend>
					<form action="InsertAndUpdateRoomServlet" method="post" class="row">
						<div class="col-12">
							<div class="mb-3">
								<label for="hotelID" class="form-label">Hotel</label>
								<select class="form-select input-boja" name="hotelID" id="hotelID" required>
									<%
										if(update == 1 || loggedInEmployee.equals("Manager"))
										{
									%>
											<option selected value="<%= roomsHotel.getId() %>"><%= roomsHotel.getName() %></option>
									<%
										}
                                        else if(loggedInEmployee.equals("Admin"))
										{
									%>
											<option value="">Select One</option>
									<%
											room.setHotelID(room.getHotelID() == null ? "" : room.getHotelID());
											for(Hotel hotel : hotels)
											{
									%>
												<option <%= pickedHotelID.equals(hotel.getId()) ? "selected" : room.getHotelID().equals(hotel.getId()) ? "selected" : "" %> value="<%= hotel.getId() %>"><%= hotel.getName() %></option>
									<%
											}
										}
									%>
								</select>
							</div>
						</div>
						<div class="col-12">
							<div class="mb-3">
								<label for="roomTypeID" class="form-label">Room Type</label>
								<select class="form-select input-boja" name="roomTypeID" id="roomTypeID" required>
									<option value="">Select One</option>
									<%
										for(RoomType roomType : roomTypes)
										{
									%>
											<option <%= pickedRoomType.equals(roomType.getRoomTypeID()) ? "selected" : update == 1 ? roomType.getRoomTypeID().equals(room.getRoomTypeID()) ? "selected" : "" : "" %> value="<%= roomType.getRoomTypeID() %>"><%= roomType.getName() %></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" class="form-control input-boja <%= numberError || roomNumberAlreadyExistsError ? "is-invalid" : "" %>" placeholder="Room Number" name="roomNumber" id="roomNumber" minlength="3" maxlength="3" value="<%= !pickedRoomNumber.equals("") ? pickedRoomNumber : update == 1 ? room.getRoomNumber() : "" %>" required>
								<label for="roomNumber" class="text-muted">Room Number</label>
								<%
									if(numberError)
									{
								%>
										<div id='validationRoomNumber' class='invalid-feedback'>
											Incorrect value, room number has to be a whole number!
										</div>
								<%
									}
                                    if(roomNumberAlreadyExistsError)
                                    {
								%>
										<div id='validationRoomExists' class='invalid-feedback'>
											Selected room number already exists in this hotel!
										</div>
								<%
                                    }
								%>
							</div>
						</div>
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" class="form-control input-boja <%= numberError ? "is-invalid" : "" %>" placeholder="Price per Night" name="pricePerNight" id="pricePerNight" value="<%= !pickedPricePerNight.equals("") ? pickedPricePerNight : update == 1 ? room.getPricePerNight() : "" %>" required>
								<label for="pricePerNight" class="text-muted">Price per Night</label>
								<%
									if(numberError)
									{
								%>
										<div id='validationPricePerNight' class='invalid-feedback'>
											Incorrect value, price per night has to be a real number!
										</div>
								<%
									}
								%>
							</div>
						</div>
						<div class="col-12">
							<div class="d-grid gap-2">
							<%
								if(update == 0)
								{
							%>
									<input type="submit" name="submit" class="btn btn-light" value="Add Room to Hotel">
							<%
								}
								else
								{
							%>
									<input type="hidden" name="updateRoomID" value="<%= room.getRoomID() %>">
									<input type="submit" name="submit" class="btn btn-light float-end" value="Edit Room">
							<%
								}
							%>
							</div>
						</div>
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
