<%@ page import="Models.Hotel" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Object loginCheck = request.getSession().getAttribute("LoggedInUser");
	if(loginCheck == null)
	{
		request.getSession().invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
	
	String loggedInEmployee = request.getSession().getAttribute("LoggedInEmployee") == null ? "" : (String) request.getSession().getAttribute("LoggedInEmployee");
	if(loggedInEmployee.equals("Manager"))
	{
		response.sendRedirect("managerAccount.jsp");
		return;
	}
	else if(loggedInEmployee.equals("Admin"))
	{
		response.sendRedirect("adminAccount.jsp");
		return;
	}
	
	request.getSession().setAttribute("Title", "Kontinental | Pick a Hotel");
	request.getSession().setAttribute("Active", "browseHotels");
%>
<html>
<%@ include file="inits/headInit.jsp" %>
<body>
	<%
		String search = request.getParameter("search");
		search = search == null ? "" : search;
		ArrayList<Hotel> hotels = Hotel.ReturnHotels(search);
	%>
	<%@ include file="headers and footer/clientHeader.jsp" %>

	<div class="container">
		<div class="row margin-t-50">
			<div class="col-4">
				<form action="hotels.jsp" method="get">
					<div class="input-group mb-3">
						<input type="text" class="form-control input-boja" name="search" placeholder="Search hotels..." value="<%= search %>">
						<input class="btn btn-outline-light" type="submit" value="Search">
					</div>
				</form>
			</div>
			<div class="col-8"></div>
			<h1>Choose a Hotel</h1>
			<%
				for(Hotel hotel : hotels)
				{
			%>
			<div class="col-4 padding-10">
				<div class="div-artikal" onclick="location.assign('browseRooms.jsp?hotel=<%= hotel.getId() %>')">
					<img src="img/<%= hotel.getPhotoName() %>" class="rounded mx-auto d-block" height="300px" width="282px" alt="<%= hotel.getName() %>">
					<div class="div-artikal-naziv">
						<p class="bold"><%= hotel.getName() %></p>
						<p><%= hotel.getCountry() + ", " + hotel.getCity() %></p>
						<p>
							<%
								for(int i = 0; i < hotel.getNumberOfStars(); i++)
								{
							%>
									<i class="fa-solid fa-star fa-lg" style="color: #ffd24f;"></i>
							<%
								}
							%>
						</p>
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
