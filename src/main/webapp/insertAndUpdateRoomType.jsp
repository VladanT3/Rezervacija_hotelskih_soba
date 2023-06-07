<%@ page import="Models.TipSobe" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Object proveraLogin = request.getSession().getAttribute("UlogovanKorisnik");
	if(proveraLogin == null)
	{
		request.getSession().invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
	
	request.getSession().setAttribute("Active", "roomTypes");
 
	String ulogovanRadnik = (String) request.getSession().getAttribute("UlogovanRadnik");
	ulogovanRadnik = ulogovanRadnik == null ? "" : ulogovanRadnik;
	if(ulogovanRadnik.equals("Menadzer")){
		request.getSession().setAttribute("Title", "Manager | Room Types");
	}
	else if(ulogovanRadnik.equals("Admin")){
		request.getSession().setAttribute("Title", "Administrator | Room Types");
	}
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%
		String izmenaProvera = (String) request.getAttribute("updateProvera");
		int izmena = 0;
		TipSobe tipSobe = new TipSobe();
		if(izmenaProvera != null)
		{
			izmena = Integer.parseInt(izmenaProvera);
			tipSobe = (TipSobe) request.getAttribute("tipSobe");
		}
		
        boolean postojiTipSobeGreska = request.getAttribute("postojiTipSobeGreska") != null;
		boolean ceoBrojGreska = request.getAttribute("ceoBrojGreska") != null;
        String brojKreveta = request.getAttribute("brojKreveta") == null ? "" : (String) request.getAttribute("brojKreveta");
		String tipKreveta = request.getAttribute("tipKreveta") == null ? "" : (String) request.getAttribute("tipKreveta");
		String kuhinja = request.getAttribute("kuhinja") == null ? "" : (String) request.getAttribute("kuhinja");
		String kupatilo = request.getAttribute("kupatilo") == null ? "" : (String) request.getAttribute("kupatilo");
		boolean televizor = request.getAttribute("televizor") != null;
		String opis = request.getAttribute("opis") == null ? "" : (String) request.getAttribute("opis");
		
		if(ulogovanRadnik.equals("Menadzer")){
	%>
			<%@ include file="headers and footer/managerHeader.jsp" %>
	<%
		}
		else if(ulogovanRadnik.equals("Admin")){
	%>
			<%@ include file="headers and footer/adminHeader.jsp" %>
	<%
		}
	%>
	
	<div class="container">
		<div class="row">
			<%
				if(postojiTipSobeGreska)
				{
			%>
					<div class="col-12 alert alert-danger margin-t-50" role="alert">
						<i class="fa-solid fa-circle-exclamation fa-lg"></i> Selected room type already exists!
					</div>
			<%
				}
			%>
			<div class="col-4"></div>
			<div class="col-4">
				<fieldset class="margin-t-50">
					<legend>
						<%
							if(izmena == 1)
								out.print("Edit Room Type");
							else
								out.print("Add New Room Type");
						%>
					</legend>
					<form action="ServletInsertAndUpdateRoomType" method="post" class="row">
						<div class="col-6">
							<div class="mb-3">
								<label for="roomTypeTipKreveta" class="form-label">Bed Type</label>
								<select class="form-select input-boja" name="roomTypeTipKreveta" id="roomTypeTipKreveta" required>
									<option class="text-muted" value="">Select One</option>
									<option <%= tipKreveta.equals("Single") ? "selected" : izmena == 1 ? tipSobe.getTipKreveta().equals("Single") ? "selected" : "" : "" %> value="Single">Single</option>
									<option <%= tipKreveta.equals("Double") ? "selected" : izmena == 1 ? tipSobe.getTipKreveta().equals("Double") ? "selected" : "" : "" %> value="Double">Double</option>
									<option <%= tipKreveta.equals("Single + Double") ? "selected" : izmena == 1 ? tipSobe.getTipKreveta().equals("Single + Double") ? "selected" : "" : "" %> value="Single + Double">Single + Double</option>
									<option <%= tipKreveta.equals("Queen") ? "selected" : izmena == 1 ? tipSobe.getTipKreveta().equals("Queen") ? "selected" : "" : "" %> value="Queen">Queen</option>
									<option <%= tipKreveta.equals("King") ? "selected" : izmena == 1 ? tipSobe.getTipKreveta().equals("King") ? "selected" : "" : "" %> value="King">King</option>
								</select>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3">
								<label for="roomTypeBrojKreveta" class="form-label">Number of Beds</label>
								<input type="text" name="roomTypeBrojKreveta" id="roomTypeBrojKreveta" class="form-control input-boja <%= ceoBrojGreska ? "is-invalid" : "" %>" value="<%= brojKreveta != "" ? brojKreveta : izmena == 1 ? tipSobe.getBrojKreveta() : "" %>" required>
								<%
									if(ceoBrojGreska)
									{
										out.print
										(
											"<div id='validacijaBrojZvezdica' class='invalid-feedback'>" +
												"Incorrect value, number of beds has to be a number!" +
											"</div>"
										);
									}
								%>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3">
								<label for="roomTypeKuhinja" class="form-label">Kitchen Type</label>
								<select class="form-select input-boja" name="roomTypeKuhinja" id="roomTypeKuhinja" required>
									<option class="text-muted" value="">Select One</option>
									<option <%= kuhinja.equals("None") ? "selected" : izmena == 1 ? tipSobe.getKuhinja().equals("None") ? "selected" : "" : "" %> value="None">None</option>
									<option <%= kuhinja.equals("Semi-furnished") ? "selected" : izmena == 1 ? tipSobe.getKuhinja().equals("Semi-furnished") ? "selected" : "" : "" %> value="Semi-furnished">Semi-furnished</option>
									<option <%= kuhinja.equals("Fully-furnished") ? "selected" : izmena == 1 ? tipSobe.getKuhinja().equals("Fully-furnished") ? "selected" : "" : "" %> value="Fully-furnished">Fully-furnished</option>
								</select>
							</div>
						</div>
						<div class="col-6">
							<div class="mb-3">
								<label for="roomTypeKupatilo" class="form-label">Bathroom Type</label>
								<select class="form-select input-boja" name="roomTypeKupatilo" id="roomTypeKupatilo" required>
									<option class="text-muted" value="">Select One</option>
									<option <%= kupatilo.equals("Shower") ? "selected" : izmena == 1 ? tipSobe.getKupatilo().equals("Shower") ? "selected" : "" : "" %> value="Shower">Shower</option>
									<option <%= kupatilo.equals("Bath") ? "selected" : izmena == 1 ? tipSobe.getKupatilo().equals("Bath") ? "selected" : "" : "" %> value="Bath">Bath</option>
								</select>
							</div>
						</div>
						<div class="col-6">
							<div class="form-check form-switch col mb-3">
								<label class="form-check-label" for="roomTypeTV">TV</label>
								<input class="form-check-input check-boja" type="checkbox" name="roomTypeTV" id="roomTypeTV" <%= televizor ? "checked" : izmena == 1 ? tipSobe.isTelevizor() ? "checked" : "" : "" %>>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<textarea name="roomTypeDesc" id="roomTypeDesc" class="form-control input-boja" style="height: 150px" placeholder="Room Description" maxlength="500" required><%= opis != "" ? opis : izmena == 1 ? tipSobe.getOpis() : "" %></textarea>
								<label for="roomTypeDesc" class="text-muted">Room Description</label>
							</div>
						</div>
						<%
							if(izmena == 0)
							{
						%>
								<div class="col-12">
									<div class="d-grid gap-2">
										<input type="submit" name="submit" class="btn btn-light" value="Add Room Type">
									</div>
								</div>
						<%
							}
							else
							{
						%>
								<div class="col-12">
									<input type="hidden" name="updateRoomTypeID" value="<%= tipSobe.getTipSobeID() %>">
									<div class="d-grid gap-2">
										<input type="submit" name="submit" class="btn btn-light float-end" value="Edit Room Type">
									</div>
								</div>
						<%
							}
						%>
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