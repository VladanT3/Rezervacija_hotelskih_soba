<%@ page import="Models.Manager" %>
<%@ page import="Models.Hotel" %>

<%
	String active = (String) request.getSession().getAttribute("Active");
	active = active == null ? "" : active;
	Manager m = (Manager) request.getSession().getAttribute("LoggedInUser");
	Hotel ah = m.ReturnAssignedHotel();
%>

<header>
	<nav class="navbar fixed-top navbar-expand-lg bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="managerAccount.jsp">
				<img src="img/logo.png" alt="Logo" width="50" height="50">
				Kontinental
			</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item">
						<a href="PrepareHotelUpdateServlet?hotel=<%= ah.getId() %>" class="nav-link <%= active.equals("editHotel") ? "active" : "" %>">
							<i class="fa-solid fa-hotel fa-lg bi d-block mx-auto mb-1"></i>
							Edit Hotel
						</a>
					</li>
					<li class="nav-item">
						<a href="rooms.jsp" class="nav-link <%= active.equals("searchRooms") ? "active" : "" %>">
							<i class="fa-solid fa-door-closed fa-lg bi d-block mx-auto mb-1"></i>
							Rooms
						</a>
					</li>
					<li class="nav-item">
						<a href="roomTypes.jsp" class="nav-link <%= active.equals("roomTypes") ? "active" : "" %>">
							<i class="fa-solid fa-bed fa-lg bi d-block mx-auto mb-1"></i>
							Room Types
						</a>
					</li>
				</ul>
			</div>
			<div class="text-end">
				<div class="btn-group">
					<a type="button" class="btn btn-outline-dark" href="managerAccount.jsp">
						<i class="fa-solid fa-user fa-lg"></i>
					</a>
					<a href="LogoutServlet" type="button" class="btn btn-dark me-2">Log Out</a>
				</div>
			</div>
		</div>
	</nav>
	<nav class="navbar navbar-expand-lg bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">
				<img src="" alt="Logo" width="50" height="50">
				Kontinental
			</a>
		</div>
	</nav>
</header>