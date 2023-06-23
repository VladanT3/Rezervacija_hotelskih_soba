<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.Hotel" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Object loginCheck = request.getSession().getAttribute("LoggedInUser");
	if(loginCheck == null)
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
	
	request.getSession().setAttribute("Title", "Administrator | Hotels");
    request.getSession().setAttribute("Active", "adminHotels");
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%
		String search = request.getParameter("search");
		search = search == null ? "" : search;
		ArrayList<Hotel> hotels = Hotel.ReturnHotels(search);
		
		boolean successfulInsert = request.getAttribute("successfulInsert") != null;
        boolean successfulUpdate = request.getAttribute("successfulUpdate") != null;
        boolean successfulDelete = request.getAttribute("successfulDelete") != null;
	%>
	<%@ include file="headers and footer/adminHeader.jsp" %>

	<div class="container">
		<div class="row margin-t-50">
			<%
				if(successfulInsert)
				{
            %>
					<div class="col-12 alert alert-success" role="alert">
						<i class="fa-solid fa-circle-check fa-lg"></i> A new hotel has been added!
					</div>
			<%
				}
			%>
			<%
				if(successfulUpdate)
				{
			%>
					<div class="col-12 alert alert-success" role="alert">
						<i class="fa-solid fa-circle-check fa-lg"></i> The hotel details have been update!
					</div>
			<%
				}
			%>
			<%
				if(successfulDelete)
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
				<form action="hotels.jsp" method="get">
					<div class="input-group mb-3">
						<input type="text" class="form-control input-boja" name="search" placeholder="Search hotels..." value="<%= search %>">
						<input class="btn btn-outline-light" type="submit" value="Search">
					</div>
				</form>
			</div>
			<div class="col-7"></div>
			<%
				for(Hotel hotel : hotels)
				{
            %>
					<div class="col-3 padding-10">
						<div class="div-artikal">
							<img src="img/<%= hotel.getPhotoName() %>" class="rounded mx-auto d-block" height="200px" width="188px" alt="<%= hotel.getName() %>">
							<div class="div-artikal-naziv">
								<p><%= hotel.getName() %></p>
								<p><%= hotel.getCountry() + ", " + hotel.getCity() %></p>
								<p>Stars: <%= hotel.getNumberOfStars() %></p>
								<p>Parking spots: <%= hotel.getNumberOfParkingSpots() %></p>
							</div>
							<div class="align-center">
								<div class="row">
									<div class="col-3"></div>
									<div class="col-3"><a href="PrepareHotelUpdateServlet?hotel=<%= hotel.getId() %>" class="btn btn-light" title="Edit"><i class="fa-solid fa-pen fa-lg"></i></a></div>
									<div class="col-3"><a href="DeleteHotelServlet?hotel=<%= hotel.getId() %>" class="btn btn-outline-danger" title="Delete"><i class="fa-solid fa-trash fa-lg"></i></a></div>
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
