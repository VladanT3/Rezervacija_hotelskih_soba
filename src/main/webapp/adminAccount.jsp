<%@ page import="Models.Administrator" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Object checkLogin = request.getSession().getAttribute("LoggedInUser");
	if(checkLogin == null)
	{
		request.getSession().invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
 
	request.getSession().setAttribute("Title", "Kontinental | Administrator");
%>
<html>
<%@ include file="inits/headInit.jsp"%>
<body>
	<%
		Administrator admin = (Administrator) request.getSession().getAttribute("LoggedInUser");
	%>
	<%@ include file="headers and footer/adminHeader.jsp"%>
	
	<div class="container">
		<div class="row">
			<div class="col-8 margin-t-50">
				<div class="row">
					<div class="col-6">
						<div class="mb-3 row">
							<label for="fullName" class="col-5 col-form-label text-muted">Full Name:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="fullName" value="<%= admin.getFirstName() + " " + admin.getLastName() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="email" class="col-5 col-form-label text-muted">E-mail:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="email" value="<%= admin.getEmail() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="phone" class="col-5 col-form-label text-muted">Phone number:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="phone" value="<%= admin.getPhoneNumber() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="hired" class="col-5 col-form-label text-muted">Hired:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="hired" value="<%= admin.getDateOfHiring() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="country" class="col-5 col-form-label text-muted">Counrty:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="country" value="<%= admin.getCountry() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="city" class="col-5 col-form-label text-muted">City:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="city" value="<%= admin.getCity() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="address" class="col-5 col-form-label text-muted">Address:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="address" value="<%= admin.getAddress() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="birthday" class="col-5 col-form-label text-muted">Birthday:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="birthday" value="<%= admin.getBirthday() %>">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-4">
				<div class="align-center margin-t-50 mb-3">
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="adminHotels.jsp" type="button" class="btn btn-light">Show All Hotels</a>
					</div>
					<div class="col-6 mb-3"></div>
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="searchRooms.jsp" type="button" class="btn btn-light">Show All Rooms</a>
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
