package Servlets;

import Database.DBConnection;
import Models.Administrator;
import Models.Klijent;
import Models.Menadzer;
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
        HttpSession session = request.getSession();

        String upit = "select * from korisnik where email = ? and sifra = password(?)";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, inputEmail);
            stmt.setString(2, inputSifra);

            ResultSet rez = stmt.executeQuery();

            if(rez.next())
            {
                String korisnikID = rez.getString("korisnik_id");

                upit = "select * from klijent where korisnik_id = ?";
                PreparedStatement stmtProveraKlijent = conn.prepareStatement(upit);
                stmtProveraKlijent.setString(1, korisnikID);

                ResultSet rezKlijent = stmtProveraKlijent.executeQuery();

                if(rezKlijent.next())
                {
                    String ime = rez.getString("ime");
                    String prezime = rez.getString("prezime");
                    String email = rez.getString("email");
                    String drzava = rez.getString("drzava");
                    String grad = rez.getString("grad");
                    String adresa = rez.getString("adresa");
                    String brojTelefona = rez.getString("broj_telefona");
                    String datumRodjenja = rez.getString("datum_rodjenja");
                    int brojPoena = rezKlijent.getInt("broj_poena");

                    Klijent klijent = new Klijent(korisnikID, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja, brojPoena);
                    session.setAttribute("UlogovanKorisnik", klijent);

                    response.sendRedirect("klijentNalog.jsp");
                }
                else
                {
                    upit = "select * from radnik where korisnik_id = ?";
                    PreparedStatement stmtProveraRadnik = conn.prepareStatement(upit);
                    stmtProveraRadnik.setString(1, korisnikID);

                    ResultSet rezRadnik = stmtProveraRadnik.executeQuery();

                    if(rezRadnik.next())
                    {
                        upit = "select * from menadzer where korisnik_id = ?";
                        PreparedStatement stmtProveraMenadzer = conn.prepareStatement(upit);
                        stmtProveraMenadzer.setString(1, korisnikID);

                        ResultSet rezMenadzer = stmtProveraMenadzer.executeQuery();

                        if(rezMenadzer.next())
                        {
                            String ime = rez.getString("ime");
                            String prezime = rez.getString("prezime");
                            String email = rez.getString("email");
                            String drzava = rez.getString("drzava");
                            String grad = rez.getString("grad");
                            String adresa = rez.getString("adresa");
                            String brojTelefona = rez.getString("broj_telefona");
                            String datumRodjenja = rez.getString("datum_rodjenja");
                            String datumZaposlenja = rezRadnik.getString("datum_zaposlenja");
                            String hotelId = rezMenadzer.getString("hotel_id");

                            Menadzer menadzer = new Menadzer(korisnikID, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja, datumZaposlenja, hotelId);
                            session.setAttribute("UlogovanKorisnik", menadzer);

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
                                String ime = rez.getString("ime");
                                String prezime = rez.getString("prezime");
                                String email = rez.getString("email");
                                String drzava = rez.getString("drzava");
                                String grad = rez.getString("grad");
                                String adresa = rez.getString("adresa");
                                String brojTelefona = rez.getString("broj_telefona");
                                String datumRodjenja = rez.getString("datum_rodjenja");
                                String datumZaposlenja = rezRadnik.getString("datum_zaposlenja");

                                Administrator admin = new Administrator(korisnikID, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja, datumZaposlenja);
                                session.setAttribute("UlogovanKorisnik", admin);

                                response.sendRedirect("adminNalog.jsp");
                            }
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