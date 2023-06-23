<%@ page import="Models.Hotel" %>
<%@ page import="Models.Room" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Object loginCheck = request.getSession().getAttribute("LoggedInUser");
	if(loginCheck == null)
	{
		request.getSession().invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
	
	String loggedInEmployee = request.getSession().getAttribute("LoggedInEmployee") == null ? "" : (String) request.getSession().getAttribute("LoggedInEmployee");
	if(loggedInEmployee.equals("Manager"))
	{
		response.sendRedirect("managerAccount.jsp");
		return;
	}
	else if(loggedInEmployee.equals("Admin"))
	{
		response.sendRedirect("adminAccount.jsp");
		return;
	}
	
	String hotelID = request.getParameter("hotel") == null ? request.getAttribute("hotel") == null ? "" : (String) request.getAttribute("hotel") : request.getParameter("hotel");
    
    if(hotelID.equals(""))
    {
        response.sendRedirect("hotels.jsp");
        return;
    }
	
	request.getSession().setAttribute("Title", "Kontinental | Pick a Room");
	request.getSession().setAttribute("Active", "browseHotels");
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%! static String dateFrom, dateTo; %>
	<%
		boolean dateError = request.getAttribute("reservationError") != null;
        boolean currentDateError = request.getAttribute("currentDateError") != null;
		dateFrom = request.getParameter("dateFrom") == null ? request.getAttribute("dateFrom") == null ? "" : (String) request.getAttribute("dateFrom") : request.getParameter("dateFrom");
		dateTo = request.getParameter("dateTo") == null ? request.getAttribute("dateTo") == null ? "" : (String) request.getAttribute("dateTo") : request.getParameter("dateTo");
		
		String search = request.getParameter("search");
		search = search == null ? "" : search;
		Hotel pickedHotel = Hotel.ReturnHotelDetails(hotelID);
        ArrayList<Room> rooms = new ArrayList<>();
        if(!dateFrom.equals(""))
        {
	        rooms = Room.ReturnAvailableRoomsInHotel(hotelID, search, dateFrom);
        }
        
        boolean filters = request.getParameter("filters") != null;
        if(filters)
        {
            String bedType = request.getParameter("bedType") == null ? "" : request.getParameter("bedType");
            String numberOfBeds = request.getParameter("numberOfBeds") == null ? "" : request.getParameter("numberOfBeds");
            String kitchen = request.getParameter("kitchen") == null ? "" : request.getParameter("kitchen");
            String bathroom = request.getParameter("bathroom") == null ? "" : request.getParameter("bathroom");
            
            rooms = Room.FilterRooms(hotelID, search, dateFrom, bedType, numberOfBeds, kitchen, bathroom);
        }
	%>
	<%@ include file="headers and footer/clientHeader.jsp" %>

	<div class="container">
		<div class="row margin-t-50">
			<div class="col-4">
				<form action="ShowAvailableRoomsServlet" method="post" class="row">
					<input type="hidden" name="hotel" value="<%= pickedHotel.getId() %>">
					<div class="col-6">
						<label for="reservationFrom" class="form-label">Reserve From:</label>
					</div>
					<div class="col-6">
						<label for="reservationTo" class="form-label">Reserve Until:</label>
					</div>
					<div class="col-6">
						<div class="mb-3">
							<input type="date" class="form-control input-boja color-scheme-dark <%= dateError || currentDateError ? "is-invalid" : "" %>" name="reservationFrom" id="reservationFrom" value="<%= dateFrom %>" required>
							<%
								if(dateError)
								{
							%>
							<div id='validationDateFrom' class='invalid-feedback'>
								"Reserve From" date has to be before "Reserve Until"!
							</div>
							<%
								}
							%>
							<%
								if(currentDateError)
								{
							%>
							<div id='validationDateFrom' class='invalid-feedback'>
								"Reserve From" date can't be before the current date!
							</div>
							<%
								}
							%>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3">
							<input type="date" class="form-control input-boja color-scheme-dark <%= dateError ? "is-invalid" : "" %>" name="reservationTo" id="reservationTo" value="<%= dateTo %>" required>
							<%
								if(dateError)
								{
							%>
							<div id='validationDateTo' class='invalid-feedback'>
								"Reserve Until" date has to be after "Reserve From"!
							</div>
							<%
								}
							%>
						</div>
					</div>
					<div class="col-12">
						<div class="d-grid gap-2">
							<input type="submit" class="btn btn-light" value="Show Available Rooms">
						</div>
					</div>
				</form>
			</div>
			<%
				if(rooms.size() > 0)
				{
			%>
					<div class="col-4"></div>
					<div class="col-4">
						<form action="browseRooms.jsp" method="get">
							<input type="hidden" name="hotel" value="<%= pickedHotel.getId() %>">
							<input type="hidden" name="dateFrom" value="<%= dateFrom %>">
							<input type="hidden" name="dateTo" value="<%= dateTo %>">
							<label for="search" class="form-label">Search:</label>
							<div class="input-group mb-3">
								<input type="text" class="form-control input-boja" name="search" id="search" placeholder="Search rooms..." value="<%= search %>">
								<button class="btn btn-outline-light"><i class="fa-solid fa-magnifying-glass fa-lg"></i></button>
							</div>
						</form>
					</div>
					<hr>
					<div class="row">
						<div class="col-3">
							<form action="browseRooms.jsp?hotel=<%= pickedHotel.getId() %>" method="get" class="row">
								<input type="hidden" name="hotel" value="<%= pickedHotel.getId() %>">
								<input type="hidden" name="filters" value="1">
								<input type="hidden" name="dateFrom" value="<%= dateFrom %>">
								<input type="hidden" name="dateTo" value="<%= dateTo %>">
								<h1 class="mb-3">Filters:</h1>
								<h3 class="mb-3">Bed type</h3>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="bedType" id="bedTypeSingle" class="form-check-input check-boja" value="Single">
									<label for="bedTypeSingle" class="form-check-label">Single</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="bedType" id="bedTypeDouble" class="form-check-input check-boja" value="Double">
									<label for="bedTypeDouble" class="form-check-label">Double</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="bedType" id="bedTypeSingleDouble" class="form-check-input check-boja" value="Single + Double">
									<label for="bedTypeSingleDouble" class="form-check-label">Single + Double</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="bedType" id="bedTypeQueen" class="form-check-input check-boja" value="Queen">
									<label for="bedTypeQueen" class="form-check-label">Queen</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="bedType" id="bedTypeKing" class="form-check-input check-boja" value="King">
									<label for="bedTypeKing" class="form-check-label">King</label>
								</div>
								<hr>
								<h3 class="mb-3">Number of Beds</h3>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="numberOfBeds" id="number1" class="form-check-input check-boja" value="1">
									<label for="number1" class="form-check-label">1</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="numberOfBeds" id="number2" class="form-check-input check-boja" value="2">
									<label for="number2" class="form-check-label">2</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="numberOfBeds" id="number3" class="form-check-input check-boja" value="3">
									<label for="number3" class="form-check-label">3</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="numberOfBeds" id="number4" class="form-check-input check-boja" value="4">
									<label for="number4" class="form-check-label">4</label>
								</div>
								<hr>
								<h3 class="mb-3">Kitchen</h3>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="kitchen" id="kitcheNone" class="form-check-input check-boja" value="None">
									<label for="kitcheNone" class="form-check-label">None</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="kitchen" id="kitcheSemi" class="form-check-input check-boja" value="Semi-furnished">
									<label for="kitcheSemi" class="form-check-label">Semi-furnished</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="kitchen" id="kitcheFull" class="form-check-input check-boja" value="Fully-furnished">
									<label for="kitcheFull" class="form-check-label">Fully-furnished</label>
								</div>
								<hr>
								<h3 class="mb-3">Bathroom</h3>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="bathroom" id="bathroomShw" class="form-check-input check-boja" value="Shower">
									<label for="bathroomShw" class="form-check-label">Shower</label>
								</div>
								<div class="col-12 mb-3 form-check">
									<input type="radio" name="bathroom" id="bathroomBth" class="form-check-input check-boja" value="Bath">
									<label for="bathroomBth" class="form-check-label">Bath</label>
								</div>
								<hr>
								<div class="col-12 align-center margin-t-10">
									<div class="d-grid gap-2">
										<input type="submit" class="btn btn-light" value="Apply Filters">
										<input type="reset" class="btn btn-outline-light" value="Reset Filters">
									</div>
								</div>
							</form>
						</div>
						<div class="col-9">
							<div class="row">
								<%
									String roomName = rooms.get(0).getRoomTypeName();
                                    boolean firstRoom = true;
									for(Room room : rooms)
									{
                                        if(firstRoom)
                                        {
                                            firstRoom = false;
								%>
											<div class="col-4 padding-10">
												<div class="div-artikal" onclick="location.assign('reservationForm.jsp?hotel=<%= pickedHotel.getId() %>&roomType=<%= room.getRoomTypeID() %>&dateFrom=<%= dateFrom %>&dateTo=<%= dateTo %>')">
													<div class="div-artikal-naziv">
														<p class="bold"><%= room.getRoomTypeName() %></p>
														<p>Price per Night: €<%= String.format("%.02f", room.getPricePerNight()) %></p>
													</div>
												</div>
											</div>
								<%
                                        }
                                        if(!room.getRoomTypeName().equals(roomName))
                                        {
                                            roomName = room.getRoomTypeName();
								%>
											<div class="col-4 padding-10">
												<div class="div-artikal" onclick="location.assign('reservationForm.jsp?hotel=<%= pickedHotel.getId() %>&roomType=<%= room.getRoomTypeID() %>&dateFrom=<%= dateFrom %>&dateTo=<%= dateTo %>')">
													<div class="div-artikal-naziv">
														<p class="bold"><%= room.getRoomTypeName() %></p>
														<p>Price per Night: €<%= String.format("%.02f", room.getPricePerNight()) %></p>
													</div>
												</div>
											</div>
								<%
										}
								%>
								<%
									}
								%>
							</div>
						</div>
					</div>
			<%
				}
			%>
		</div>
		
		<%@ include file="headers and footer/footer.jsp" %>
	</div>
	
	<%@ include file="inits/jsInit.jsp"%>
</body>
</html>
