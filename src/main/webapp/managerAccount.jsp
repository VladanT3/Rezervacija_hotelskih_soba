<%@ page import="Models.Manager" %>
<%@ page import="Models.Hotel" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
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
	
	request.getSession().setAttribute("Title", "Kontinental | Manager");
%>
<html>
<%@ include file="inits/headInit.jsp"%>
<body>
	<%
		Manager manager = (Manager) request.getSession().getAttribute("LoggedInUser");
        Hotel assignedHotel = manager.ReturnAssignedHotel();
		boolean successfulUpdate = request.getAttribute("successfulUpdate") != null;
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-d");
		LocalDate managerDateOfHire = LocalDate.parse(manager.getDateOfHiring(), formatter);
		LocalDate managerBirthday = LocalDate.parse(manager.getBirthday(), formatter);
		formatter = DateTimeFormatter.ofPattern("eeee d. MMMM, y");
		String dateOfHire = managerDateOfHire.format(formatter);
		String birthday = managerBirthday.format(formatter);
	%>
	<%@ include file="headers and footer/managerHeader.jsp"%>

	<div class="container">
		<div class="row">
			<%
				if(successfulUpdate)
				{
			%>
					<div class="col-12 alert alert-success margin-t-50" role="alert">
						<i class="fa-solid fa-circle-check fa-lg"></i> The hotel details have been update!
					</div>
			<%
				}
			%>
			<div class="col-8 margin-t-50">
				<div class="row">
					<div class="col-6">
						<div class="mb-3 row">
							<label for="fullName" class="col-5 col-form-label text-muted">Full Name:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="fullName" value="<%= manager.getFirstName() + " " + manager.getLastName() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="email" class="col-5 col-form-label text-muted">E-mail:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="email" value="<%= manager.getEmail() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="phone" class="col-5 col-form-label text-muted">Phone number:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="phone" value="<%= manager.getPhoneNumber() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="hired" class="col-5 col-form-label text-muted">Hired:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="hired" value="<%= dateOfHire %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="country" class="col-5 col-form-label text-muted">Counrty:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="country" value="<%= manager.getCountry() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="city" class="col-5 col-form-label text-muted">City:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="city" value="<%= manager.getCity() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="address" class="col-5 col-form-label text-muted">Address:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="address" value="<%= manager.getAddress() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="birthday" class="col-5 col-form-label text-muted">Birthday:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="birthday" value="<%= birthday %>">
							</div>
						</div>
					</div>
					<fieldset class="row">
						<legend>Assigned Hotel:</legend>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelName" class="col-5 col-form-label text-muted">Hotel Name:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelName" value="<%= assignedHotel.getName() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelCountry" class="col-5 col-form-label text-muted">Hotel Country:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelCountry" value="<%= assignedHotel.getCountry() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelCity" class="col-5 col-form-label text-muted">Hotel City:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelCity" value="<%= assignedHotel.getCity() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelStars" class="col-5 col-form-label text-muted">Number of Stars:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelStars" value="<%= assignedHotel.getNumberOfStars() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelParking" class="col-5 col-form-label text-muted">Number of Parking Spots:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelParking" value="<%= assignedHotel.getNumberOfParkingSpots() %>">
								</div>
							</div>
						</div>
					</fieldset>
				</div>
			</div>
			<div class="col-4">
				<div class="align-center margin-t-50 mb-3">
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="PrepareHotelUpdateServlet?hotel=<%= assignedHotel.getId() %>" type="button" class="btn btn-light">Edit Hotel</a>
					</div>
					<div class="col-6 mb-3"></div>
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="searchRooms.jsp" type="button" class="btn btn-light">Show All Hotel Rooms</a>
					</div>
					<div class="col-6"></div>
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="roomTypes.jsp" type="button" class="btn btn-light">Show All Room Types</a>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="headers and footer/footer.jsp" %>
	</div>

	<%@ include file="inits/jsInit.jsp"%>
</body>
</html>
