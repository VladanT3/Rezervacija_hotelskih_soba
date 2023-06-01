<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.Menadzer" %>
<%@ page import="Models.Hotel" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	String ulogovanRadnik = (String) request.getSession().getAttribute("UlogovanRadnik");
	ulogovanRadnik = ulogovanRadnik == null ? "" : ulogovanRadnik;
    if(ulogovanRadnik.equals("Menadzer")){
	    request.getSession().setAttribute("Title", "Manager | Edit Hotel");
	    request.getSession().setAttribute("Active", "editHotel");
    }
    else if(ulogovanRadnik.equals("Admin")){
	    request.getSession().setAttribute("Title", "Administrator | Hotels");
	    request.getSession().setAttribute("Active", "adminHoteli");
    }
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%
		String izmenaProvera = (String) request.getAttribute("updateProvera");
        int izmena = 0;
		Hotel hotel = new Hotel();
        if(izmenaProvera != null)
        {
	        izmena = Integer.parseInt(izmenaProvera);
            hotel = (Hotel) request.getAttribute("hotel");
        }
        
		ArrayList<Menadzer> menadzeri = Menadzer.VratiMenadzereKojimaNijeDodeljenHotel();
	%>
	<%@ include file="headers and footer/adminHeader.jsp" %>
	
	<div class="container">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<fieldset class="margin-t-50">
					<legend>
						<%
							if(izmena == 1)
                                out.print("Edit Hotel");
                            else
                                out.print("Add New Hotel");
						%>
					</legend>
					<form action="ServletInsertAndUpdateHotel" method="post" class="row">
						<%
							if(ulogovanRadnik.equals("Admin"))
							{
                        %>
							<div class="col-12">
								<div class="mb-3">
									<label for="assignedManager" class="form-label">Hotel Manager:</label>
									<select class="form-select input-boja" id="assignedManager" name="assignedManager" required>
										<option value="">Select One</option>
										<%
											for(Menadzer menadzer : menadzeri)
											{
                                                boolean selected = menadzer.getId().equals(hotel.getMenadzerId());
										%>
												<option value="<%= menadzer.getId() %>" <%= selected ? "selected" : "" %>><%= menadzer.getId() + " - " + menadzer.getIme() + " " + menadzer.getPrezime() %></option>
										<%
											}
										%>
									</select>
								</div>
							</div>
						<%
							}
						%>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="text" name="hotelName" id="hotelName" class="form-control input-boja" placeholder="Hotel Name" value="<%= izmena == 1 ? hotel.getNaziv() : "" %>" required>
								<label for="hotelName" class="text-muted">Hotel Name</label>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="text" name="hotelCountry" id="hotelCountry" class="form-control input-boja" placeholder="Country" value="<%= izmena == 1 ? hotel.getDrzava() : "" %>" required>
								<label for="hotelCountry" class="text-muted">Country:</label>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="text" name="hotelCity" id="hotelCity" class="form-control input-boja" placeholder="City" value="<%= izmena == 1 ? hotel.getGrad() : "" %>" required>
								<label for="hotelCity" class="text-muted">City</label>
							</div>
						</div>
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" name="hotelZvezdice" id="hotelZvezdice" class="form-control input-boja" placeholder="Number of stars" value="<%= izmena == 1 ? hotel.getBrojZvezdica() : "" %>" required>
								<label for="hotelZvezdice" class="text-muted">Number of stars</label>
							</div>
						</div>
						<div class="col-6">
							<div class="form-floating mb-3">
								<input type="text" name="hotelParking" id="hotelParking" class="form-control input-boja" placeholder="Parking spots" value="<%= izmena == 1 ? hotel.getBrojParkingMesta() : "" %>" required>
								<label for="hotelParking" class="text-muted">Parking spots</label>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="text" name="hotelPicture" id="hotelPicture" class="form-control input-boja" placeholder="Hotel Picture" value="<%= izmena == 1 ? hotel.getNazivSlike() : "" %>">
								<label for="hotelPicture" class="text-muted">Hotel Picture</label>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<textarea name="hotelDesc" id="hotelDesc" class="form-control input-boja" style="height: 150px;" placeholder="Hotel Description" maxlength="500" required><%= izmena == 1 ? hotel.getOpis() : "" %></textarea>
								<label for="hotelDesc" class="text-muted">Hotel Description</label>
							</div>
						</div>
						<div class="col-6">
							<input type="submit" name="submit" class="btn btn-info" value="Unesi" <%= izmena == 1 ? "disabled" : "" %>>
						</div>
						<div class="col-6">
							<input type="submit" name="submit" class="btn btn-info float-end" value="Izmeni" <%= izmena == 1 ? "" : "disabled" %>>
						</div>
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
