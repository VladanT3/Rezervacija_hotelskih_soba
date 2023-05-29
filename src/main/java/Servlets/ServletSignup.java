package Servlets;

import Database.DBConnection;
import Utils.KorisnikMethods;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.*;
import java.util.Date;

@WebServlet(name = "ServletSignup", value = "/ServletSignup")
public class ServletSignup extends HttpServlet {
    Connection conn = DBConnection.connectToDB();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String upit;
        boolean greskaEmail = false;

        String inputIme = request.getParameter("inputIme");
        String inputPrezime = request.getParameter("inputPrezime");
        String inputEmail = request.getParameter("inputEmail");
        String inputSifra = request.getParameter("inputSifra");
        String inputDrzava = request.getParameter("inputDrzava");
        String inputGrad = request.getParameter("inputGrad");
        String inputAdresa = request.getParameter("inputAdresa");
        String inputBrojTelefona = request.getParameter("inputPhone");
        String inputDatumRodjenja = request.getParameter("inputDatumRodjenja");

        upit = "select email from korisnik where email = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, inputEmail);

            ResultSet rez = stmt.executeQuery();

            if(rez.next())
            {
                greskaEmail = true;
                request.setAttribute("greskaEmail", greskaEmail);
                RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                rd.forward(request, response);
            }
            else
            {
                String korisnikID = KorisnikMethods.generisiNoviKorisnikID();

                upit = "insert into korisnik values(?, ?, ?, ?, password(?), ?, ?, ?, ?, ?)";

                PreparedStatement stmtUnosKorisnika = conn.prepareStatement(upit);
                stmtUnosKorisnika.setString(1, korisnikID);
                stmtUnosKorisnika.setString(2, inputIme);
                stmtUnosKorisnika.setString(3, inputPrezime);
                stmtUnosKorisnika.setString(4, inputEmail);
                stmtUnosKorisnika.setString(5, inputSifra);
                stmtUnosKorisnika.setString(6, inputDrzava);
                stmtUnosKorisnika.setString(7, inputGrad);
                stmtUnosKorisnika.setString(8, inputAdresa);
                stmtUnosKorisnika.setString(9, inputBrojTelefona);
                stmtUnosKorisnika.setString(10, inputDatumRodjenja);
                stmtUnosKorisnika.execute();

                upit = "insert into kupac values()";

                request.getSession().setAttribute("UlogovanKorisnik", korisnikID);
                response.sendRedirect("kupacNalog.jsp");
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }
}