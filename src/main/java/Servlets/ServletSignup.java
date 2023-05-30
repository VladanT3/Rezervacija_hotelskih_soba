package Servlets;

import Database.DBConnection;
import Models.Klijent;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.*;

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
        HttpSession session = request.getSession();

        String inputIme = request.getParameter("inputIme");
        String inputPrezime = request.getParameter("inputPrezime");
        String inputEmail = request.getParameter("inputEmail");
        String inputSifra = request.getParameter("inputSifra");
        String inputDrzava = request.getParameter("inputDrzava");
        String inputGrad = request.getParameter("inputGrad");
        String inputAdresa = request.getParameter("inputAdresa");
        String inputBrojTelefona = request.getParameter("inputPhone");
        String inputDatumRodjenja = request.getParameter("inputDatumRodjenja");

        upit = "select * from korisnik ko join klijent kl on ko.korisnik_id = kl.korisnik_id where email = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, inputEmail);

            ResultSet rez = stmt.executeQuery();

            if(rez.next())
            {
                boolean obrisan = rez.getBoolean("obrisan");
                if(!obrisan)
                {
                    greskaEmail = true;
                    request.setAttribute("greskaEmail", greskaEmail);
                    request.setAttribute("ime", inputIme);
                    request.setAttribute("prezime", inputPrezime);
                    request.setAttribute("email", inputEmail);
                    request.setAttribute("sifra", inputSifra);
                    request.setAttribute("grad", inputGrad);
                    request.setAttribute("adresa", inputAdresa);
                    request.setAttribute("brojTelefona", inputBrojTelefona);
                    request.setAttribute("datumRodjenja", inputDatumRodjenja);
                    RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                    rd.forward(request, response);
                }
                else
                {
                    String korisnikId = rez.getString("korisnik_id");
                    upit = "update klijent set obrisan = 0 where korisnik_id = ?";
                    PreparedStatement stmtVracanjeNaloga = conn.prepareStatement(upit);
                    stmtVracanjeNaloga.setString(1, korisnikId);
                    stmtVracanjeNaloga.execute();

                    String ime = rez.getString("ime");
                    String prezime = rez.getString("prezime");
                    String email = rez.getString("email");
                    String drzava = rez.getString("drzava");
                    String grad = rez.getString("grad");
                    String adresa = rez.getString("adresa");
                    String brojTelefona = rez.getString("broj_telefona");
                    String datumRodjenja = rez.getString("datum_rodjenja");
                    int brojPoena = rez.getInt("broj_poena");

                    Klijent klijent = new Klijent(korisnikId, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja, brojPoena);
                    session.setAttribute("UlogovanKorisnik", klijent);

                    response.sendRedirect("klijentNalog.jsp");
                }
            }
            else
            {
                String korisnikID = Klijent.generisiNoviKlijentID();

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

                upit = "insert into klijent values(?, 0)";
                PreparedStatement stmtUnosKlijenta = conn.prepareStatement(upit);
                stmtUnosKlijenta.setString(1, korisnikID);
                stmtUnosKlijenta.execute();

                upit = "select * from korisnik kor join klijent kl on kor.korisnik_id = kl.korisnik_id where email = ?";
                PreparedStatement stmtVadjenjeKorisnika = conn.prepareStatement(upit);
                stmtVadjenjeKorisnika.setString(1, inputEmail);
                ResultSet rezKorisnik = stmtVadjenjeKorisnika.executeQuery();

                if(rezKorisnik.next())
                {
                    String ime = rezKorisnik.getString("ime");
                    String prezime = rezKorisnik.getString("prezime");
                    String email = rezKorisnik.getString("email");
                    String drzava = rezKorisnik.getString("drzava");
                    String grad = rezKorisnik.getString("grad");
                    String adresa = rezKorisnik.getString("adresa");
                    String brojTelefona = rezKorisnik.getString("broj_telefona");
                    String datumRodjenja = rezKorisnik.getString("datum_rodjenja");
                    int brojPoena = rezKorisnik.getInt("broj_poena");

                    Klijent klijent = new Klijent(korisnikID, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja, brojPoena);
                    session.setAttribute("UlogovanKorisnik", klijent);

                    response.sendRedirect("klijentNalog.jsp");
                }
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }
}