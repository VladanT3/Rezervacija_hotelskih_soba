<%@ page import="java.util.ArrayList" %>
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
		String pretraga = request.getParameter("search");
		pretraga = pretraga == null ? "" : pretraga;
		ArrayList<TipSobe> tipoviSoba = TipSobe.VratiTipoveSoba(pretraga);
		
		boolean uspesanUnos = request.getAttribute("uspesanUnos") != null;
		boolean uspesnaPromena = request.getAttribute("uspesnaPromena") != null;
		boolean uspesnoBrisanje = request.getAttribute("uspesnoBrisanje") != null;
		
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
		<div class="row margin-t-50">
			<%
				if(uspesanUnos)
				{
			%>
			<div class="col-12 alert alert-success" role="alert">
				<i class="fa-solid fa-circle-check fa-lg"></i> The new room type has been added!
			</div>
			<%
				}
			%>
			<%
				if(uspesnaPromena)
				{
			%>
			<div class="col-12 alert alert-success" role="alert">
				<i class="fa-solid fa-circle-check fa-lg"></i> The selected room type details have been update!
			</div>
			<%
				}
			%>
			<%
				if(uspesnoBrisanje)
				{
			%>
			<div class="col-12 alert alert-success" role="alert">
				<i class="fa-solid fa-circle-check fa-lg"></i> The selected room type has been deleted!
			</div>
			<%
				}
			%>
			<div class="col-1">
				<a href="insertAndUpdateRoomType.jsp" class="btn btn-outline-light" title="Add new Room Type"><i class="fa-solid fa-plus fa-lg"></i></a>
			</div>
			<div class="col-4">
				<form action="tipoviSoba.jsp" method="get">
					<div class="input-group mb-3">
						<input type="text" class="form-control input-boja" name="search" placeholder="Search room types..." value="<%= pretraga %>">
						<input class="btn btn-outline-light" type="submit" value="Search">
					</div>
				</form>
			</div>
			<div class="col-7"></div>
			<%
				for(TipSobe tipSobe : tipoviSoba)
				{
			%>
			<div class="col-3 padding-10">
				<div class="div-artikal">
					<div class="div-artikal-naziv">
						<p class="bold"><%= tipSobe.getNaziv() %></p>
						<p>Number of beds: <%= tipSobe.getBrojKreveta() %></p>
						<p>Bed type: <%= tipSobe.getTipKreveta() %></p>
						<p>Kitchen: <%= tipSobe.getKuhinja() %></p>
						<p>Bathroom: <%= tipSobe.getKupatilo() %></p>
						<p>TV: <%= tipSobe.isTelevizor() ? "Yes" : "No" %></p>
					</div>
					<div class="align-center">
						<div class="row">
							<div class="col-3"></div>
							<div class="col-3"><a href="ServletPrepareRoomTypeUpdate?tipSobe=<%= tipSobe.getTipSobeID() %>" class="btn btn-light" title="Edit"><i class="fa-solid fa-pen fa-lg"></i></a></div>
							<div class="col-3"><a href="" class="btn btn-outline-light" title="Delete"><i class="fa-solid fa-trash fa-lg"></i></a></div>
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
