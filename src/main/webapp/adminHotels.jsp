<%@ page import="java.util.ArrayList" %>
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
	
	request.getSession().setAttribute("Title", "Administrator | Hotels");
    request.getSession().setAttribute("Active", "adminHoteli");
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%
		boolean uspesanUnos = request.getAttribute("uspesanUnos") != null;
        boolean uspesnaPromena = request.getAttribute("uspesnaPromena") != null;
        boolean uspesnoBrisanje = request.getAttribute("uspesnoBrisanje") != null;
	%>
	<%@ include file="headers and footer/adminHeader.jsp" %>

	<div class="container">
		<%
			String pretraga = request.getParameter("search");
            pretraga = pretraga == null ? "" : pretraga;
			ArrayList<Hotel> hoteli = Hotel.VratiHotele(pretraga);
		%>
		<div class="row margin-t-50">
			<%
				if(uspesanUnos)
				{
            %>
					<div class="col-12 alert alert-success" role="alert">
						<i class="fa-solid fa-circle-check fa-lg"></i> A new hotel has been added!
					</div>
			<%
				}
			%>
			<%
				if(uspesnaPromena)
				{
			%>
					<div class="col-12 alert alert-success" role="alert">
						<i class="fa-solid fa-circle-check fa-lg"></i> The hotel details have been update!
					</div>
			<%
				}
			%>
			<%
				if(uspesnoBrisanje)
				{
			%>
					<div class="col-12 alert alert-success" role="alert">
						<i class="fa-solid fa-circle-check fa-lg"></i> The hotel has been deleted!
					</div>
			<%
				}
			%>
			<div class="col-1">
				<a href="addOrEditHotel.jsp" class="btn btn-outline-light" title="Add new Hotel"><i class="fa-solid fa-plus fa-lg"></i></a>
			</div>
			<div class="col-4">
				<form action="adminHotels.jsp" method="get">
					<div class="input-group mb-3">
						<input type="text" class="form-control input-boja" name="search" placeholder="Search hotels..." value="<%= pretraga %>">
						<input class="btn btn-outline-light" type="submit" value="Search">
					</div>
				</form>
			</div>
			<div class="col-7"></div>
			<%
				for(Hotel hotel : hoteli)
				{
            %>
					<div class="col-3 padding-10">
						<div class="div-artikal">
							<img src="img/<%= hotel.getNazivSlike() %>" class="rounded mx-auto d-block" height="200px" width="188px" alt="<%= hotel.getNaziv() %>">
							<div class="div-artikal-naziv">
								<p><%= hotel.getNaziv() %></p>
								<p><%= hotel.getDrzava() + ", " + hotel.getGrad() %></p>
								<p>Stars: <%= hotel.getBrojZvezdica() %></p>
								<p>Parking spots: <%= hotel.getBrojParkingMesta() %></p>
							</div>
							<div class="align-center">
								<div class="row">
									<div class="col-3"></div>
									<div class="col-3"><a href="ServletPrepareHotelUpdate?hotel=<%= hotel.getId() %>" class="btn btn-light" title="Edit"><i class="fa-solid fa-pen fa-lg"></i></a></div>
									<div class="col-3"><a href="ServletDeleteHotel?hotel=<%= hotel.getId() %>" class="btn btn-outline-light" title="Delete"><i class="fa-solid fa-trash fa-lg"></i></a></div>
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
