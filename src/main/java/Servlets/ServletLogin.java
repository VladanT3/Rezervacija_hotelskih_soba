package Servlets;

import Database.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "ServletLogin", value = "/ServletLogin")
public class ServletLogin extends HttpServlet {
    Connection conn = DBConnection.connectToDB();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputEmail = request.getParameter("inputEmail");
        String inputSifra = request.getParameter("inputSifra");
        boolean greskaLogin = false;

        String upit = "select korisnik_id from korisnik where email = ? and sifra = password(?)";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, inputEmail);
            stmt.setString(2, inputSifra);

            ResultSet rez = stmt.executeQuery();

            if(rez.next())
            {
                String korisnikID = rez.getString("korisnik_id");
                request.getSession().setAttribute("UlogovanKorisnik", korisnikID);

                upit = "select * from kupac where korisnik_id = ?";
                PreparedStatement stmtProveraKupac = conn.prepareStatement(upit);
                stmtProveraKupac.setString(1, korisnikID);

                ResultSet rezKupac = stmtProveraKupac.executeQuery();

                if(rezKupac.next())
                {
                    response.sendRedirect("klijentNalog.jsp");
                }
                else
                {
                    upit = "select * from menadzer where korisnik_id = ?";
                    PreparedStatement stmtProveraMenadzer = conn.prepareStatement(upit);
                    stmtProveraMenadzer.setString(1, korisnikID);

                    ResultSet rezMenadzer = stmtProveraMenadzer.executeQuery();

                    if(rezMenadzer.next())
                    {
                        response.sendRedirect("menadzerNalog.jsp");
                    }
                    else
                    {
                        upit = "select * from administrator where korisnik_id = ?";
                        PreparedStatement stmtProveraAdmin = conn.prepareStatement(upit);
                        stmtProveraAdmin.setString(1, korisnikID);

                        ResultSet rezAdmin = stmtProveraAdmin.executeQuery();

                        if(rezAdmin.next())
                        {
                            response.sendRedirect("adminNalog.jsp");
                        }
                    }
                }
            }
            else
            {
                greskaLogin = true;
                request.setAttribute("greskaLogin", greskaLogin);
                request.setAttribute("unetEmail", inputEmail);
                request.setAttribute("unetaSifra", inputSifra);
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
    }
}