<%@ page import="Models.Klijent" %>
<%@ page import="Models.Rezervacija" %>
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
	
	request.getSession().setAttribute("Title", "Kontinental | Your Profile");
%>
<html>
<%@ include file="inits/headInit.jsp"%>
<body>
	<%
		Klijent klijent = (Klijent) request.getSession().getAttribute("UlogovanKorisnik");
		Rezervacija rezervacija = klijent.VratiDetaljeNajblizeRezervacije();
		Hotel hotel = rezervacija.VratiDetaljeHotelaUKomJeRezervacija();
	%>
	<%@ include file="headers and footer/clientHeader.jsp"%>
	
	<div class="container">
		<div class="row">
			<div class="col-8 margin-t-50">
				<div class="row">
					<div class="col-6">
						<div class="mb-3 row">
							<label for="fullName" class="col-5 col-form-label text-muted">Full Name:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="fullName" value="<%= klijent.getIme() + " " + klijent.getPrezime() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="points" class="col-5 col-form-label text-muted">Number of Points:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="points" value="<%= klijent.getBrojPoena() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="email" class="col-5 col-form-label text-muted">E-mail:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="email" value="<%= klijent.getEmail() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="phone" class="col-5 col-form-label text-muted">Phone number:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="phone" value="<%= klijent.getBrojTelefona() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="country" class="col-5 col-form-label text-muted">Counrty:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="country" value="<%= klijent.getDrzava() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="city" class="col-5 col-form-label text-muted">City:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="city" value="<%= klijent.getGrad() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="address" class="col-5 col-form-label text-muted">Address:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="address" value="<%= klijent.getAdresa() %>">
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="mb-3 row">
							<label for="birthday" class="col-5 col-form-label text-muted">Birthday:</label>
							<div class="col">
								<input readonly class="form-control-plaintext input-boja bold" id="birthday" value="<%= klijent.getDatumRodjenja() %>">
							</div>
						</div>
					</div>
					<fieldset class="row">
						<legend>Your Upcoming Trip:</legend>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationCountry" class="col-5 col-form-label text-muted">Country:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationCountry" value="<%= hotel.getDrzava() == null ? "" : hotel.getDrzava() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationCity" class="col-5 col-form-label text-muted">City:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationCity" value="<%= hotel.getGrad() == null ? "" : hotel.getGrad() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationHotel" class="col-5 col-form-label text-muted">Hotel:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationHotel" value="<%= hotel.getNaziv() == null ? "" : hotel.getNaziv() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationRoom" class="col-5 col-form-label text-muted">Room:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationRoom" value="<%= rezervacija.VratiBrojSobeURezervaciji() == 0 ? "" : rezervacija.VratiBrojSobeURezervaciji() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationFrom" class="col-5 col-form-label text-muted">From:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationFrom" value="<%= rezervacija.getDatumPocetka() == null ? "" : rezervacija.getDatumPocetka() %>">
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3 row">
								<label for="reservationTo" class="col-5 col-form-label text-muted">To:</label>
								<div class="col">
									<input readonly class="form-control-plaintext input-boja bold" id="reservationTo" value="<%= rezervacija.getDatumIsteka() == null ? "" : rezervacija.getDatumIsteka() %>">
								</div>
							</div>
						</div>
					</fieldset>
				</div>
			</div>
			<div class="col-4">
				<div class="align-center margin-t-50 mb-3">
					<div class="col-6 mb-3 d-grid gap-2">
						<a type="button" class="btn btn-light">Browse Hotels</a>
					</div>
					<div class="col-6 mb-3"></div>
					<div class="col-6 mb-3 d-grid gap-2">
						<a type="button" class="btn btn-light">Your Reservations</a>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="headers and footer/footer.jsp" %>
	</div>
	
	<%@ include file="inits/jsInit.jsp"%>
</body>
</html>
