package Servlets;

import Database.DBConnection;
import Models.Client;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "ServletEditClient", value = "/ServletEditClient")
public class ServletEditClient extends HttpServlet {
    Connection conn = DBConnection.connectToDB();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().invalidate();
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("clientID");
        String firstName = request.getParameter("clientFirstName");
        String lastName = request.getParameter("clientLastName");
        String email = request.getParameter("clientEmail");
        String password = request.getParameter("clientPassword");
        String country = request.getParameter("clientCountry");
        String city = request.getParameter("clientCity");
        String address = request.getParameter("clientAddress");
        String phoneNumber = request.getParameter("clientPhone");
        String birthday = request.getParameter("clientBirthday");

        try
        {
            if(password.equals(""))
            {
                if(country.equals(""))
                {
                    String query = "update korisnik set " +
                            "ime = ?, " +
                            "prezime = ?, " +
                            "email = ?, " +
                            "grad = ?, " +
                            "adresa = ?, " +
                            "broj_telefona = ?, " +
                            "datum_rodjenja = ? " +
                            "where korisnik_id = ?";

                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, firstName);
                    stmt.setString(2, lastName);
                    stmt.setString(3, email);
                    stmt.setString(4, city);
                    stmt.setString(5, address);
                    stmt.setString(6, phoneNumber);
                    stmt.setString(7, birthday);
                    stmt.setString(8, id);
                    stmt.execute();

                    Client oldClient = (Client) request.getSession().getAttribute("LoggedInUser");
                    int points = oldClient.getNumberOfPoints();
                    String oldCountry = oldClient.getCountry();

                    Client updatedClient = new Client(id, firstName, lastName, email, oldCountry, city, address, phoneNumber, birthday, points);
                    request.getSession().setAttribute("LoggedInUser", updatedClient);

                    request.setAttribute("successfulUpdate", true);
                    RequestDispatcher rd = request.getRequestDispatcher("clientAccount.jsp");
                    rd.forward(request, response);
                    response.sendRedirect("clientAccount.jsp");
                }
                else
                {
                    String query = "update korisnik set " +
                            "ime = ?, " +
                            "prezime = ?, " +
                            "email = ?, " +
                            "drzava = ?, " +
                            "grad = ?, " +
                            "adresa = ?, " +
                            "broj_telefona = ?, " +
                            "datum_rodjenja = ? " +
                            "where korisnik_id = ?";

                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, firstName);
                    stmt.setString(2, lastName);
                    stmt.setString(3, email);
                    stmt.setString(4, country);
                    stmt.setString(5, city);
                    stmt.setString(6, address);
                    stmt.setString(7, phoneNumber);
                    stmt.setString(8, birthday);
                    stmt.setString(9, id);
                    stmt.execute();

                    Client oldClient = (Client) request.getSession().getAttribute("LoggedInUser");
                    int points = oldClient.getNumberOfPoints();

                    Client updatedClient = new Client(id, firstName, lastName, email, country, city, address, phoneNumber, birthday, points);
                    request.getSession().setAttribute("LoggedInUser", updatedClient);

                    request.setAttribute("successfulUpdate", true);
                    RequestDispatcher rd = request.getRequestDispatcher("clientAccount.jsp");
                    rd.forward(request, response);
                    response.sendRedirect("clientAccount.jsp");
                }
            }
            else
            {
                if(country.equals(""))
                {
                    String query = "update korisnik set " +
                            "ime = ?, " +
                            "prezime = ?, " +
                            "email = ?, " +
                            "sifra = password(?), " +
                            "grad = ?, " +
                            "adresa = ?, " +
                            "broj_telefona = ?, " +
                            "datum_rodjenja = ? " +
                            "where korisnik_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, firstName);
                    stmt.setString(2, lastName);
                    stmt.setString(3, email);
                    stmt.setString(4, password);
                    stmt.setString(5, city);
                    stmt.setString(6, address);
                    stmt.setString(7, phoneNumber);
                    stmt.setString(8, birthday);
                    stmt.setString(9, id);
                    stmt.execute();

                    Client oldClient = (Client) request.getSession().getAttribute("LoggedInUser");
                    int points = oldClient.getNumberOfPoints();
                    String oldCountry = oldClient.getCountry();

                    Client updatedClient = new Client(id, firstName, lastName, email, oldCountry, city, address, phoneNumber, birthday, points);
                    request.getSession().setAttribute("LoggedInUser", updatedClient);

                    request.setAttribute("successfulUpdate", true);
                    RequestDispatcher rd = request.getRequestDispatcher("clientAccount.jsp");
                    rd.forward(request, response);
                    response.sendRedirect("clientAccount.jsp");
                }
                else
                {
                    String query = "update korisnik set " +
                            "ime = ?, " +
                            "prezime = ?, " +
                            "email = ?, " +
                            "sifra = password(?), " +
                            "drzava = ?, " +
                            "grad = ?, " +
                            "adresa = ?, " +
                            "broj_telefona = ?, " +
                            "datum_rodjenja = ? " +
                            "where korisnik_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, firstName);
                    stmt.setString(2, lastName);
                    stmt.setString(3, email);
                    stmt.setString(4, password);
                    stmt.setString(5, country);
                    stmt.setString(6, city);
                    stmt.setString(7, address);
                    stmt.setString(8, phoneNumber);
                    stmt.setString(9, birthday);
                    stmt.setString(10, id);
                    stmt.execute();

                    Client oldClient = (Client) request.getSession().getAttribute("LoggedInUser");
                    int points = oldClient.getNumberOfPoints();

                    Client updatedClient = new Client(id, firstName, lastName, email, country, city, address, phoneNumber, birthday, points);
                    request.getSession().setAttribute("LoggedInUser", updatedClient);

                    request.setAttribute("successfulUpdate", true);
                    RequestDispatcher rd = request.getRequestDispatcher("clientAccount.jsp");
                    rd.forward(request, response);
                    response.sendRedirect("clientAccount.jsp");
                }
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }
}