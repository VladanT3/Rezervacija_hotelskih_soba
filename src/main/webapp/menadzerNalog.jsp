<%@ page import="Models.Menadzer" %>
<%@ page import="Models.Hotel" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Object proveraLogin = request.getSession().getAttribute("UlogovanKorisnik");
	if(proveraLogin == null)
	{
		request.getSession().invalidate();
		response.sendRedirect("index.jsp");
        return;
	}
	
	request.getSession().setAttribute("Title", "Kontinental | Manager");
%>
<html>
<%@ include file="inits/headInit.jsp"%>
<body>
	<%
		Menadzer menadzer = (Menadzer) request.getSession().getAttribute("UlogovanKorisnik");
        Hotel dodeljenHotel = menadzer.VratiDodeljenHotel();
		boolean uspesnaPromena = request.getAttribute("uspesnaPromena") != null;
	%>
	<%@ include file="headers and footer/managerHeader.jsp"%>

	<div class="container">
		<div class="row">
			<%
				if(uspesnaPromena)
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
								<input readonly class="form-control-plaintext input-boja bold" id="fullName" value="<%= menadzer.getIme() + " " + menadzer.getPrezime() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="email" class="col-5 col-form-label text-muted">E-mail:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="email" value="<%= menadzer.getEmail() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="phone" class="col-5 col-form-label text-muted">Phone number:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="phone" value="<%= menadzer.getBrojTelefona() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="hired" class="col-5 col-form-label text-muted">Hired:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="hired" value="<%= menadzer.getDatumZaposlenja() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="country" class="col-5 col-form-label text-muted">Counrty:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="country" value="<%= menadzer.getDrzava() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="city" class="col-5 col-form-label text-muted">City:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="city" value="<%= menadzer.getGrad() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="address" class="col-5 col-form-label text-muted">Address:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="address" value="<%= menadzer.getAdresa() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="birthday" class="col-5 col-form-label text-muted">Birthday:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="birthday" value="<%= menadzer.getDatumRodjenja() %>">
							</div>
						</div>
					</div>
					<fieldset class="row">
						<legend>Assigned Hotel:</legend>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelName" class="col-5 col-form-label text-muted">Hotel Name:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelName" value="<%= dodeljenHotel.getNaziv() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelCountry" class="col-5 col-form-label text-muted">Hotel Country:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelCountry" value="<%= dodeljenHotel.getDrzava() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelCity" class="col-5 col-form-label text-muted">Hotel City:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelCity" value="<%= dodeljenHotel.getGrad() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelStars" class="col-5 col-form-label text-muted">Number of Stars:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelStars" value="<%= dodeljenHotel.getBrojZvezdica() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="hotelParking" class="col-5 col-form-label text-muted">Number of Parking Spots:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="hotelParking" value="<%= dodeljenHotel.getBrojParkingMesta() %>">
								</div>
							</div>
						</div>
					</fieldset>
				</div>
			</div>
			<div class="col-4">
				<div class="align-center margin-t-50 mb-3">
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="ServletPrepareHotelUpdate?hotel=<%= dodeljenHotel.getId() %>" type="button" class="btn btn-light">Edit Hotel</a>
					</div>
					<div class="col-6 mb-3"></div>
					<div class="col-6 mb-3 d-grid gap-2">
						<a type="button" class="btn btn-light">Show All Hotel Rooms</a>
					</div>
					<div class="col-6"></div>
					<div class="col-6 mb-3 d-grid gap-2">
						<a href="tipoviSoba.jsp" type="button" class="btn btn-light">Show All Room Types</a>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="headers and footer/footer.jsp" %>
	</div>

	<%@ include file="inits/jsInit.jsp"%>
</body>
</html>
