<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.getSession().setAttribute("Title", "Kontinental | Login"); %>
<!DOCTYPE html>
<html>
<%@ include file="inits/headInit.jsp"%>
<body>
	<%@ include file="headers and footer/loginHeader.jsp"%>
	<%
		request.getSession().setAttribute("LoggedInUser", null);
        request.getSession().setAttribute("LoggedInEmployee", null);
        request.getSession().setAttribute("LoggedInClient", null);
		
		String email = (String) request.getAttribute("inputEmail");
        if(email == null) email = "";
        
		String password = (String) request.getAttribute("inputPassword");
        if(password == null) password = "";
        
		boolean loginError = request.getAttribute("loginError") != null;
	%>
	<div class="container">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<fieldset class="margin-t-100">
					<legend>Log In</legend>
					<form method="post" action="LoginServlet" class="row">
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="email" class="form-control input-boja <%= loginError ? "is-invalid" : "" %>" id="floatingEmail" name="inputEmail" placeholder="E-mail" value="<%= email %>" required>
								<label for="floatingEmail" class="text-muted">E-mail</label>
								<%
									if(loginError)
									{
                                        out.print
		                                (
                                            "<div id='validationEmail' class='invalid-feedback'>" +
		                                        "Email or password are incorrect!" +
		                                    "</div>"
		                                );
									}
								%>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="password" class="form-control input-boja <%= loginError ? "is-invalid" : "" %>" id="userPassword" name="inputPassword" placeholder="Password" value="<%= password %>" required>
								<label for="userPassword" class="text-muted">Password</label>
								<%
									if(loginError)
									{
										out.print
										(
											"<div id='validationPassword' class='invalid-feedback'>" +
												"Email or password are incorrect!" +
											"</div>"
										);
									}
								%>
							</div>
						</div>
						<div class="col-1"></div>
						<div class="form-check form-switch col">
							<input class="form-check-input check-boja" type="checkbox" id="showPassword">
							<label class="form-check-label" for="showPassword">Show password</label>
						</div>
						<div class="col-12 align-center margin-t-10">
							<div class="d-grid gap-2">
								<input type="submit" class="btn btn-light" value="Log In">
							</div>
						</div>
						<div class="col margin-t-20">
							Don't have an account? <a class="link-light" href="signup.jsp">Sign Up</a>
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