<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.Klijent" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Object proveraLogin = request.getSession().getAttribute("UlogovanKorisnik");
	if(proveraLogin == null) {
		request.getSession().invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
    request.getSession().setAttribute("Title", "Administrator | Clients");
    request.getSession().setAttribute("Active", "prikazKlijenata");
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
<%
	String pretraga = request.getParameter("search");
	pretraga = pretraga == null ? "" : pretraga;
	ArrayList<Klijent> klijenti = Klijent.VratiKlijente(pretraga);
	
	boolean uspesnaPromena = request.getAttribute("uspesnaPromena") != null;
	boolean uspesnoBrisanje = request.getAttribute("uspesnoBrisanje") != null;
%>
	<%@ include file="headers and footer/adminHeader.jsp" %>

	<div class="container">
		<div class="row margin-t-50">
			<%
				if(uspesnaPromena)
				{
			%>
			<div class="col-12 alert alert-success" role="alert">
				<i class="fa-solid fa-circle-check fa-lg"></i> The selected client's details have been update!
			</div>
			<%
				}
			%>
			<%
				if(uspesnoBrisanje)
				{
			%>
			<div class="col-12 alert alert-success" role="alert">
				<i class="fa-solid fa-circle-check fa-lg"></i> The selected client has been deleted!
			</div>
			<%
				}
			%>
			<div class="col-4">
				<form action="clientSearch.jsp" method="get">
					<div class="input-group mb-3">
						<input type="text" class="form-control input-boja" name="search" placeholder="Search clients..." value="<%= pretraga %>">
						<input class="btn btn-outline-light" type="submit" value="Search">
					</div>
				</form>
			</div>
			<div class="col-8"></div>
			<%
				for(Klijent klijent : klijenti)
				{
			%>
			<div class="col-3 padding-10">
				<div class="div-artikal">
					<div class="div-artikal-naziv">
						<p class="bold"><%= klijent.getIme() + " " + klijent.getPrezime() %></p>
						<p>Number of points: <%= klijent.getBrojPoena() %></p>
						<p>Email: <%= klijent.getEmail() %></p>
						<p>Address: <%= klijent.getDrzava() + ", " + klijent.getGrad() + ", " + klijent.getAdresa() %></p>
						<p>Phone number: <%= klijent.getBrojTelefona() %></p>
						<p>Date of Birth: <%= klijent.getDatumRodjenja() %></p>
					</div>
					<div class="align-center">
						<div class="row">
							<div class="col-3"></div>
							<div class="col-3"><a href="editClient.jsp?client=<%= klijent.getId() %>" class="btn btn-light" title="Edit"><i class="fa-solid fa-user-pen fa-lg"></i></a></div>
							<div class="col-3"><a href="ServletDeleteClient?client=<%= klijent.getId() %>" class="btn btn-outline-light" title="Delete"><i class="fa-solid fa-user-minus fa-lg"></i></a></div>
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
