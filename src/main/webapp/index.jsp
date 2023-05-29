<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.getSession().setAttribute("Title", "Login"); %>
<!DOCTYPE html>
<html>
<%@ include file="inits/headInit.jsp"%>
<body>
	<%@ include file="headers and footer/loginHeader.jsp"%>
	<%
		request.getSession().setAttribute("UlogovanKorisnik", "");
		
		String email = (String) request.getAttribute("unetEmail");
        if(email == null) email = "";
		String sifra = (String) request.getAttribute("unetaSifra");
        if(sifra == null) sifra = "";
		
		boolean greska = false;
		try
		{
			greska = (boolean) request.getAttribute("greskaLogin");
		}
        catch (Exception ignored){}
	%>
	<div class="container">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<fieldset class="margin-t-100">
					<legend>Log In</legend>
					<form method="post" action="ServletLogin" class="row">
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="email" class="form-control input-boja <%= greska ? "is-invalid" : "" %>" id="floatingEmail" name="inputEmail" placeholder="E-mail" value="<%= email %>" required>
								<label for="floatingEmail" class="text-muted">E-mail</label>
								<%
									if(greska)
									{
                                        out.print
		                                (
                                            "<div id='validacijaEmail' class='invalid-feedback'>" +
		                                        "Email or password are incorrect!" +
		                                    "</div>"
		                                );
									}
								%>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="password" class="form-control input-boja <%= greska ? "is-invalid" : "" %>" id="inputSifra" name="inputSifra" placeholder="Password" value="<%= sifra %>" required>
								<label for="inputSifra" class="text-muted">Password</label>
								<%
									if(greska)
									{
										out.print
										(
											"<div id='validacijaSifra' class='invalid-feedback'>" +
												"Email or password are incorrect!" +
											"</div>"
										);
									}
								%>
							</div>
						</div>
						<div class="col-1"></div>
						<div class="form-check form-switch col">
							<input class="form-check-input check-color" type="checkbox" id="prikazSifre">
							<label class="form-check-label" for="prikazSifre">Show password</label>
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