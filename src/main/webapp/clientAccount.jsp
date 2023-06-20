<%@ page import="Models.Client" %>
<%@ page import="Models.Reservation" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="Models.*" %>
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
%>
<html>
<%@ include file="inits/headInit.jsp"%>
<body>
	<%
		Client client = (Client) request.getSession().getAttribute("LoggedInUser");
		Reservation reservation = client.ReturnDetailsOfClosestReservation();
		Hotel hotel = reservation.ReturnHotelDetailsInReservation();
		
		boolean successfulUpdate = request.getAttribute("successfulUpdate") != null;
		boolean successfulReservation = request.getAttribute("successfulReservation") != null;
		
        String dateFrom = "", dateTo = "";
        if(reservation.getDateFrom() != null)
        {
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-d");
	        LocalDate reservationFrom = LocalDate.parse(reservation.getDateFrom(), formatter);
	        LocalDate reservationTo = LocalDate.parse(reservation.getDateTo(), formatter);
	        formatter = DateTimeFormatter.ofPattern("eeee d. MMMM, y");
	        dateFrom = reservationFrom.format(formatter);
	        dateTo = reservationTo.format(formatter);
        }
	%>
	<%@ include file="headers and footer/clientHeader.jsp"%>
	
	<div class="container">
		<div class="row margin-t-50">
			<%
				if(successfulUpdate)
				{
			%>
					<div class="col-12 alert alert-success" role="alert">
						<i class="fa-solid fa-circle-check fa-lg"></i> Your account details have been updated!
					</div>
			<%
				}
			%>
			<%
				if(successfulReservation)
				{
			%>
					<div class="col-12 alert alert-success" role="alert">
						<i class="fa-solid fa-circle-check fa-lg"></i> Your reservation has been completed, you can view the details in "Your Reservations" tab!
					</div>
			<%
				}
			%>
			<div class="col-8">
				<div class="row">
					<div class="col-6">
						<div class="mb-3 row">
							<label for="fullName" class="col-5 col-form-label text-muted">Full Name:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="fullName" value="<%= client.getFirstName() + " " + client.getLastName() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="points" class="col-5 col-form-label text-muted">Number of Points:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="points" value="<%= client.getNumberOfPoints() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="email" class="col-5 col-form-label text-muted">E-mail:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="email" value="<%= client.getEmail() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="phone" class="col-5 col-form-label text-muted">Phone number:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="phone" value="<%= client.getPhoneNumber() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="country" class="col-5 col-form-label text-muted">Counrty:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="country" value="<%= client.getCountry() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="city" class="col-5 col-form-label text-muted">City:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="city" value="<%= client.getCity() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="address" class="col-5 col-form-label text-muted">Address:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="address" value="<%= client.getAddress() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="birthday" class="col-5 col-form-label text-muted">Birthday:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="birthday" value="<%= client.getBirthday() %>">
							</div>
						</div>
					</div>
					<fieldset class="row">
						<legend>Your Upcoming Trip:</legend>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationCountry" class="col-5 col-form-label text-muted">Country:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationCountry" value="<%= hotel.getCountry() == null ? "" : hotel.getCountry() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationCity" class="col-5 col-form-label text-muted">City:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationCity" value="<%= hotel.getCity() == null ? "" : hotel.getCity() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationHotel" class="col-5 col-form-label text-muted">Hotel:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationHotel" value="<%= hotel.getName() == null ? "" : hotel.getName() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationRoom" class="col-5 col-form-label text-muted">Room:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationRoom" value="<%= reservation.ReturnRoomNumberInReservation() == 0 ? "" : reservation.ReturnRoomNumberInReservation() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationFrom" class="col-5 col-form-label text-muted">From:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationFrom" value="<%= dateFrom %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationTo" class="col-5 col-form-label text-muted">To:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationTo" value="<%= dateTo %>">
								</div>
							</div>
						</div>
					</fieldset>
				</div>
			</div>
			<div class="col-4">
				<div class="align-center mb-3">
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="editClient.jsp?client=<%= client.getId() %>" type="button" class="btn btn-light">Edit Account Details</a>
					</div>
					<div class="col-6 mb-3"></div>
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="browseHotels.jsp" type="button" class="btn btn-light">Browse Hotels</a>
					</div>
					<div class="col-6 mb-3"></div>
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="showReservations.jsp" type="button" class="btn btn-light">Your Reservations</a>
					</div>
					<div class="col-6 mb-3"></div>
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="DeleteClientServlet?client=<%= client.getId() %>" type="button" class="btn btn-outline-danger">Delete Account</a>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="headers and footer/footer.jsp" %>
	</div>
	
	<%@ include file="inits/jsInit.jsp"%>
</body>
</html>
