<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.RoomType" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Object checkLogin = request.getSession().getAttribute("LoggedInUser");
	if(checkLogin == null)
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
	
	request.getSession().setAttribute("Active", "roomTypes");
 
	String loggedInEmployee = (String) request.getSession().getAttribute("LoggedInEmployee");
	loggedInEmployee = loggedInEmployee == null ? "" : loggedInEmployee;
	if(loggedInEmployee.equals("Manager")){
		request.getSession().setAttribute("Title", "Manager | Room Types");
	}
	else if(loggedInEmployee.equals("Admin")){
		request.getSession().setAttribute("Title", "Administrator | Room Types");
	}
%>
<html>
<%@ include file="inits/headInit.jsp" %>
	<body>
		<%
			String search = request.getParameter("search");
			search = search == null ? "" : search;
			ArrayList<RoomType> roomTypes = RoomType.ReturnRoomTypes(search);
			
			boolean successfulInsert = request.getAttribute("successfulInsert") != null;
			boolean successfulUpdate = request.getAttribute("successfulUpdate") != null;
			boolean successfulDelete = request.getAttribute("successfulDelete") != null;
			
			if(loggedInEmployee.equals("Manager")){
		%>
				<%@ include file="headers and footer/managerHeader.jsp" %>
		<%
			}
			else if(loggedInEmployee.equals("Admin")){
		%>
				<%@ include file="headers and footer/adminHeader.jsp" %>
		<%
			}
		%>
	
		<div class="container">
			<div class="row margin-t-50">
				<%
					if(successfulInsert)
					{
				%>
						<div class="col-12 alert alert-success" role="alert">
							<i class="fa-solid fa-circle-check fa-lg"></i> The new room type has been added!
						</div>
				<%
					}
				%>
				<%
					if(successfulUpdate)
					{
				%>
						<div class="col-12 alert alert-success" role="alert">
							<i class="fa-solid fa-circle-check fa-lg"></i> The selected room type details have been updated!
						</div>
				<%
					}
				%>
				<%
					if(successfulDelete)
					{
				%>
						<div class="col-12 alert alert-success" role="alert">
							<i class="fa-solid fa-circle-check fa-lg"></i> The selected room type has been deleted!
						</div>
				<%
					}
				%>
				<div class="col-1">
					<a href="addOrEditRoomType.jsp" class="btn btn-outline-light" title="Add new Room Type"><i class="fa-solid fa-plus fa-lg"></i></a>
				</div>
				<div class="col-4">
					<form action="roomTypes.jsp" method="get">
						<div class="input-group mb-3">
							<input type="text" class="form-control input-boja" name="search" placeholder="Search room types..." value="<%= search %>">
							<input class="btn btn-outline-light" type="submit" value="Search">
						</div>
					</form>
				</div>
				<div class="col-7"></div>
				<%
					for(RoomType roomType : roomTypes)
					{
				%>
				<div class="col-3 padding-10">
					<div class="div-artikal">
						<div class="div-artikal-naziv">
							<p class="bold"><%= roomType.getName() %></p>
							<p>Number of beds: <%= roomType.getNumberOfBeds() %></p>
							<p>Bed type: <%= roomType.getBedType() %></p>
							<p>Kitchen: <%= roomType.getKitchen() %></p>
							<p>Bathroom: <%= roomType.getBathroom() %></p>
							<p>TV: <%= roomType.isTelevision() ? "Yes" : "No" %></p>
						</div>
						<div class="align-center">
							<div class="row">
								<div class="col-3"></div>
								<div class="col-3"><a href="PrepareRoomTypeUpdateServlet?roomType=<%= roomType.getRoomTypeID() %>" class="btn btn-light" title="Edit"><i class="fa-solid fa-pen fa-lg"></i></a></div>
								<div class="col-3"><a href="DeleteRoomTypeServlet?roomType=<%= roomType.getRoomTypeID() %>" class="btn btn-outline-danger" title="Delete"><i class="fa-solid fa-trash fa-lg"></i></a></div>
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
