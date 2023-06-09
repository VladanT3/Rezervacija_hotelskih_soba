package Servlets;

import Database.DBConnection;
import Models.Administrator;
import Models.Client;
import Models.Manager;
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

        String loggedInEmployee = (String) request.getSession().getAttribute("LoggedInEmployee");
        if(loggedInEmployee.equals("Manager"))
        {
            response.sendRedirect("managerAccount.jsp");
        }
        else if(loggedInEmployee.equals("Admin"))
        {
            response.sendRedirect("adminAccount.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputEmail = request.getParameter("inputEmail");
        String inputSifra = request.getParameter("inputPassword");
        HttpSession session = request.getSession();

        String query = "select * from korisnik where email = ? and sifra = password(?)";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, inputEmail);
            stmt.setString(2, inputSifra);

            ResultSet res = stmt.executeQuery();

            if(res.next())
            {
                String userID = res.getString("korisnik_id");

                query = "select * from klijent where korisnik_id = ?";
                PreparedStatement stmtCheckClient = conn.prepareStatement(query);
                stmtCheckClient.setString(1, userID);

                ResultSet resClient = stmtCheckClient.executeQuery();

                if(resClient.next())
                {
                    String firstName = res.getString("ime");
                    String lastName = res.getString("prezime");
                    String email = res.getString("email");
                    String country = res.getString("drzava");
                    String city = res.getString("grad");
                    String address = res.getString("adresa");
                    String phoneNumber = res.getString("broj_telefona");
                    String birthday = res.getString("datum_rodjenja");
                    int numberOfPoints = resClient.getInt("broj_poena");

                    Client client = new Client(userID, firstName, lastName, email, country, city, address, phoneNumber, birthday, numberOfPoints);
                    session.setAttribute("LoggedInUser", client);
                    session.setAttribute("LoggedInClient", true);

                    response.sendRedirect("clientAccount.jsp");
                }
                else
                {
                    query = "select * from radnik where korisnik_id = ?";
                    PreparedStatement stmtCheckEmployee = conn.prepareStatement(query);
                    stmtCheckEmployee.setString(1, userID);

                    ResultSet resEmployee = stmtCheckEmployee.executeQuery();

                    if(resEmployee.next())
                    {
                        query = "select * from menadzer where korisnik_id = ?";
                        PreparedStatement stmtCheckManager = conn.prepareStatement(query);
                        stmtCheckManager.setString(1, userID);

                        ResultSet rezMenadzer = stmtCheckManager.executeQuery();

                        if(rezMenadzer.next())
                        {
                            String firstName = res.getString("ime");
                            String lastName = res.getString("prezime");
                            String email = res.getString("email");
                            String country = res.getString("drzava");
                            String city = res.getString("grad");
                            String address = res.getString("adresa");
                            String phoneNumber = res.getString("broj_telefona");
                            String birthday = res.getString("datum_rodjenja");
                            String dateOfHiring = resEmployee.getString("datum_zaposlenja");
                            String hotelID = rezMenadzer.getString("hotel_id");

                            Manager manager = new Manager(userID, firstName, lastName, email, country, city, address, phoneNumber, birthday, dateOfHiring, hotelID);
                            session.setAttribute("LoggedInUser", manager);
                            session.setAttribute("LoggedInEmployee", "Manager");

                            response.sendRedirect("managerAccount.jsp");
                        }
                        else
                        {
                            query = "select * from administrator where korisnik_id = ?";
                            PreparedStatement stmtCheckAdmin = conn.prepareStatement(query);
                            stmtCheckAdmin.setString(1, userID);

                            ResultSet resAdmin = stmtCheckAdmin.executeQuery();

                            if(resAdmin.next())
                            {
                                String firstName = res.getString("ime");
                                String lastName = res.getString("prezime");
                                String email = res.getString("email");
                                String country = res.getString("drzava");
                                String city = res.getString("grad");
                                String address = res.getString("adresa");
                                String phoneNumber = res.getString("broj_telefona");
                                String birthday = res.getString("datum_rodjenja");
                                String dateOfHiring = resEmployee.getString("datum_zaposlenja");

                                Administrator admin = new Administrator(userID, firstName, lastName, email, country, city, address, phoneNumber, birthday, dateOfHiring);
                                session.setAttribute("LoggedInUser", admin);
                                session.setAttribute("LoggedInEmployee", "Admin");

                                response.sendRedirect("adminAccount.jsp");
                            }
                        }
                    }
                }
            }
            else
            {
                request.setAttribute("loginError", true);
                request.setAttribute("inputEmail", inputEmail);
                request.setAttribute("inputPassword", inputSifra);
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