<%@ page import="Models.Client" %>
<%@ page import="Models.Room" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="Models.RoomType" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.text.DecimalFormat" %>
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
    
    String roomTypeID = request.getParameter("roomType") == null ? request.getAttribute("roomType") == null ? "" : (String) request.getAttribute("roomType") : request.getParameter("roomType");
    String hotelID = request.getParameter("hotel") == null ? request.getAttribute("hotel") == null ? "" : (String) request.getAttribute("hotel") : request.getParameter("hotel");
	
	if(roomTypeID.equals(""))
	{
		response.sendRedirect("browseHotels.jsp");
		return;
	}
	
	request.getSession().setAttribute("Title", "Kontinental | Finalize your Reservation");
	request.getSession().setAttribute("Active", "browseHotels");
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%
		String dateFrom = request.getParameter("dateFrom") == null ? request.getAttribute("dateFrom") == null ? "" : (String) request.getAttribute("dateFrom") : request.getParameter("dateFrom");
		String dateTo = request.getParameter("dateTo") == null ? request.getAttribute("dateTo") == null ? "" : (String) request.getAttribute("dateTo") : request.getParameter("dateTo");
		Client client = (Client) request.getSession().getAttribute("LoggedInUser");
		RoomType roomType = RoomType.ReturnRoomTypeDetails(roomTypeID);
		Room roomToBeReserved = Room.ReturnFirstAvailableRoom(hotelID, roomType.getName(), dateFrom);
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-d");
		LocalDate reservationFrom = LocalDate.parse(dateFrom, formatter);
		LocalDate reservationTo = LocalDate.parse(dateTo, formatter);
  
		long difference = ChronoUnit.DAYS.between(reservationFrom, reservationTo);
        float reservationPrice = difference * roomToBeReserved.getPricePerNight();
        
		DecimalFormat numberFormat = new DecimalFormat("#.00");
        String price = numberFormat.format(reservationPrice);
	%>
	<%@ include file="headers and footer/clientHeader.jsp" %>
	
	<div class="container">
		<div class="row margin-t-50">
			<div class="col-4"></div>
			<div class="col-4">
				<fieldset>
					<legend>Finalize Reservation</legend>
					<form action="ReserveRoomServlet" method="post" class="row">
						<input type="hidden" name="roomType" value="<%= roomTypeID %>">
						<input type="hidden" name="hotel" value="<%= hotelID %>">
						<input type="hidden" name="room" value="<%= roomToBeReserved.getRoomID() %>">
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" class="form-control input-boja" name="clientFirstName" id="clientFirstName" placeholder="First Name" value="<%= client.getFirstName() %>" required readonly>
								<label for="clientFirstName" class="text-muted">First Name</label>
							</div>
						</div>
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" class="form-control input-boja" name="clientLastName" id="clientLastName" placeholder="Last Name" value="<%= client.getLastName() %>" required readonly>
								<label for="clientLastName" class="text-muted">First Name</label>
							</div>
						</div>
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" class="form-control input-boja" name="clientEmail" id="clientEmail" placeholder="E-mail" value="<%= client.getEmail() %>" required readonly>
								<label for="clientEmail" class="text-muted">E-mail</label>
							</div>
						</div>
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" class="form-control input-boja" name="clientPhone" id="clientPhone" placeholder="Phone Number" value="<%= client.getPhoneNumber() %>" required readonly>
								<label for="clientPhone" class="text-muted">Phone Number</label>
							</div>
						</div>
						<div class="col-6"><label for="reservationFrom" class="form-label">Reserve From:</label></div>
						<div class="col-6"><label for="reservationTo" class="form-label">Reserve Until:</label></div>
						<div class="col-6">
							<div class="mb-3">
								<input type="date" class="form-control input-boja color-scheme-dark" name="reservationFrom" id="reservationFrom" value="<%= dateFrom %>" readonly>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3">
								<input type="date" class="form-control input-boja color-scheme-dark" name="reservationTo" id="reservationTo" value="<%= dateTo %>" readonly>
							</div>
						</div>
						<div class="col-6"><label for="reservationPrice" class="form-label">Total Price:</label></div>
						<div class="col-6"><label class="form-check-label" for="applyPoints">Use your points? You have:</label></div>
						<div class="col-6">
							<div class="mb-3">
								<input type="text" class="form-control input-boja" name="reservationPrice" id="reservationPrice" placeholder="Total Price" value="<%= price %>" readonly>
							</div>
						</div>
						<div class="col-6">
							<div class="form-check form-switch">
								<input class="form-check-input check-boja" type="checkbox" name="applyPoints" id="applyPoints" <%= client.getNumberOfPoints() == 0 ? "disabled" : "" %> value="<%= client.getNumberOfPoints() %>">
								<label class="form-check-label" for="applyPoints"><%= client.getNumberOfPoints() %></label>
							</div>
						</div>
						<div class="col-12 align-center">
							<div class="d-grid gap-2">
								<input type="submit" class="btn btn-light" value="Reserve">
							</div>
						</div>
					</form>
				</fieldset>
			</div>
			<div class="col-4"></div>
		</div>
		
		<%@ include file="headers and footer/footer.jsp" %>
	</div>
	
	<script src="js/adjustReservationPrice.js"></script>
	<%@ include file="inits/jsInit.jsp"%>
</body>
</html>
