<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.Room" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%! static String hotelID; %>
<%
	Object checkLogin = request.getSession().getAttribute("LoggedInUser");
	if(checkLogin == null)
	{
		request.getSession().invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
	
	request.getSession().setAttribute("Active", "searchRooms");
    
    String loggedInEmployee = (String) request.getSession().getAttribute("LoggedInEmployee");
    loggedInEmployee = loggedInEmployee == null ? "" : loggedInEmployee;
	
    if(loggedInEmployee.equals("Manager")){
		request.getSession().setAttribute("Title", "Manager | Rooms");
        Manager loggedInManager = (Manager) request.getSession().getAttribute("LoggedInUser");
        hotelID = loggedInManager.ReturnAssignedHotel().getId();
	}
	else if(loggedInEmployee.equals("Admin")){
		request.getSession().setAttribute("Title", "Administrator | Rooms");
		hotelID = request.getParameter("hotel") == null ? hotelID : request.getParameter("hotel");
	}
%>
<html>
	<%@ include file="inits/headInit.jsp" %>
	<body>
		<%
			String search = request.getParameter("search");
			search = search == null ? "" : search;
            Hotel pickedHotel = Hotel.ReturnHotelDetails(hotelID);
			ArrayList<Room> rooms = Room.ReturnRoomsInHotel(hotelID, search);
            ArrayList<Hotel> hotels = Hotel.ReturnHotels("");
			
			boolean successfulInsert = request.getAttribute("successfulInsert") != null;
			boolean successfulUpdate = request.getAttribute("successfulUpdate") != null;
			boolean successfulDelete = request.getAttribute("successfulDelete") != null;
			
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
			<div class="row margin-t-50">
				<%
					if(successfulInsert)
					{
				%>
						<div class="col-12 alert alert-success" role="alert">
							<i class="fa-solid fa-circle-check fa-lg"></i> The new room has been added!
						</div>
				<%
					}
				%>
				<%
					if(successfulUpdate)
					{
				%>
						<div class="col-12 alert alert-success" role="alert">
							<i class="fa-solid fa-circle-check fa-lg"></i> The selected room's details have been update!
						</div>
				<%
					}
				%>
				<%
					if(successfulDelete)
					{
				%>
						<div class="col-12 alert alert-success" role="alert">
							<i class="fa-solid fa-circle-check fa-lg"></i> The selected room has been deleted!
						</div>
				<%
					}
				%>
				<div class="col-1">
					<a href="" class="btn btn-outline-light" title="Add new Room"><i class="fa-solid fa-plus fa-lg"></i></a>
				</div>
				<div class="col-4">
					<form action="searchRooms.jsp" method="get">
						<div class="input-group mb-3">
							<input type="text" class="form-control input-boja" name="search" placeholder="Search room types..." value="<%= search %>">
							<input class="btn btn-outline-light" type="submit" value="Search">
						</div>
					</form>
				</div>
				<div class="col-4">
					<%
						if(loggedInEmployee.equals("Admin"))
						{
					%>
							<div class="btn-group">
								<button class="btn btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="true" aria-expanded="false">
									Choose a Hotel
								</button>
								<ul class="dropdown-menu dropdown-menu-dark">
									<%
										for(Hotel hotel : hotels)
										{
									%>
									<li><a class="dropdown-item" href="searchRooms.jsp?hotel=<%= hotel.getId() %>"><%= hotel.getName() %></a></li>
									<%
										}
									%>
								</ul>
							</div>
					<%
						}
					%>
				</div>
				<div class="col-3"></div>
				<div class="col-12"><h2><%= pickedHotel.getName() == null ? "" : pickedHotel.getName() %></h2></div>
				<%
					for(Room room : rooms)
					{
				%>
				<div class="col-3 padding-10">
					<div class="div-artikal">
						<div class="div-artikal-naziv">
							<p class="bold"><%= room.getRoomNumber() %></p>
							<p><%= room.getRoomTypeName() %></p>
							<p>Price per Night: €<%= String.format("%.02f", room.getPricePerNight()) %></p>
							<p>Reserved: <%= room.getReservationID() != null ? "Yes" : "No" %></p>
						</div>
						<div class="align-center">
							<div class="row">
								<div class="col-3"></div>
								<div class="col-3"><a href="ServletPrepareRoomUpdate?room=<%= room.getRoomID() %>" class="btn btn-light" title="Edit"><i class="fa-solid fa-pen fa-lg"></i></a></div>
								<div class="col-3"><a href="ServletDeleteRoom?room=<%= room.getRoomID() %>" class="btn btn-outline-light" title="Delete"><i class="fa-solid fa-trash fa-lg"></i></a></div>
								<div class="col-3"></div>
							</div>
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