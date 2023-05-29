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
					<legend>Ulogovanje</legend>
					<form method="post" action="ServletLogin" class="row">
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="email" class="form-control input-boja <%= greska ? "is-invalid" : "" %>" id="floatingEmail" name="inputEmail" placeholder="E-mail" value="<%= email %>">
								<label for="floatingEmail" class="text-muted">E-mail</label>
								<%
									if(greska)
									{
                                        out.print
		                                (
                                            "<div id='validacijaEmail' class='invalid-feedback'>" +
		                                        "Email ili šifra nisu prepoznati!" +
		                                    "</div>"
		                                );
									}
								%>
							</div>
						</div>
						<div class="col-12">
							<div class="form-floating mb-3">
								<input type="password" class="form-control input-boja <%= greska ? "is-invalid" : "" %>" id="inputSifra" name="inputSifra" placeholder="Šifra" value="<%= sifra %>">
								<label for="inputSifra" class="text-muted">Šifra</label>
								<%
									if(greska)
									{
										out.print
										(
											"<div id='validacijaSifra' class='invalid-feedback'>" +
												"Email ili šifra nisu prepoznati!" +
											"</div>"
										);
									}
								%>
							</div>
						</div>
						<div class="col-1"></div>
						<div class="form-check form-switch col">
							<input class="form-check-input check-boja" type="checkbox" id="prikazSifre">
							<label class="form-check-label" for="prikazSifre">Prikaži šifru</label>
						</div>
						<div class="col-12 align-center margin-t-10">
							<input type="submit" class="btn btn-light" value="Uloguj se">
						</div>
						<div class="col margin-t-20">
							Nemate nalog? <a class="link-light">Napravi nalog</a>
						</div>
					</form>
				</fieldset>
			</div>
			<div class="col-4"></div>
		</div>
		
		<%@ include file="headers and footer/footer.jsp" %>
	</div>
	
	<script src="js/prikazSifre.js"></script>
	<%@ include file="inits/jsInit.jsp"%>
</body>
</html>