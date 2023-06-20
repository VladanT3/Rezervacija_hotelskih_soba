<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.Reservation" %>
<%@ page import="Models.Client" %>
<%@ page import="Models.Hotel" %>
<%@ page import="Models.Room" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
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
	
	request.getSession().setAttribute("Title", "Kontinental | Your Profile");
	request.getSession().setAttribute("Active", "showReservations");
%>
<html>
<%@ include file="inits/headInit.jsp"%>
<body>
	<%
		Client client = (Client) request.getSession().getAttribute("LoggedInUser");
		ArrayList<Reservation> reservations = Reservation.ReturnAllClientsReservations(client.getId());
  
		boolean successfulDelete = request.getAttribute("successfulDelete") != null;
	%>
	<%@ include file="headers and footer/clientHeader.jsp"%>

	<div class="container">
		<div class="row margin-t-50">
			<%
				if(successfulDelete)
				{
			%>
					<div class="col-12 alert alert-success" role="alert">
						<i class="fa-solid fa-circle-check fa-lg"></i> Your reservation has been successfully deleted!
					</div>
			<%
				}
			%>
			<%
				for(Reservation reservation : reservations)
				{
					Hotel hotel = reservation.ReturnHotelDetailsInReservation();
                    Room room = Room.ReturnRoomDetails(reservation.getRoomID());
                    
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-d");
					LocalDate reservationFrom = LocalDate.parse(reservation.getDateFrom(), formatter);
					LocalDate reservationTo = LocalDate.parse(reservation.getDateTo(), formatter);
					formatter = DateTimeFormatter.ofPattern("eeee d. MMMM, y");
                    String dateFrom = reservationFrom.format(formatter);
                    String dateTo = reservationTo.format(formatter);
			%>
					<div class="col-3 padding-10">
						<div class="div-artikal">
							<div class="div-artikal-naziv">
								<p class="bold"><%= hotel.getCountry() + ", " + hotel.getCity() %></p>
								<p>Hotel: <%= hotel.getName() %></p>
								<p>Room: <%= reservation.ReturnRoomNumberInReservation() %></p>
								<p class="bold"><%= room.getRoomTypeName() %></p>
								<p>From: <%= dateFrom %></p>
								<p>To: <%= dateTo %></p>
								<p class="bold">Price: €<%= reservation.getPrice() %></p>
							</div>
							<div class="align-center">
								<div class="row">
									<div class="col-12">
										<div class="d-grid gap-2">
											<a href="DeleteReservationServlet?reservation=<%= reservation.getReservationID() %>" type="button" class="btn btn-outline-danger" title="Delete Reservation"><i class="fa-solid fa-trash fa-lg"></i></a>
										</div>
									</div>
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
