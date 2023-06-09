package Servlets;

import Database.DBConnection;
import Models.Client;
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
        String query;
        HttpSession session = request.getSession();

        String firstName = request.getParameter("clientFirstName");
        String lastName = request.getParameter("clientLastName");
        String email = request.getParameter("clientEmail");
        String password = request.getParameter("userPassword");
        String country = request.getParameter("clientCountry");
        String city = request.getParameter("clientCity");
        String address = request.getParameter("clientAddress");
        String phoneNumber = request.getParameter("clientPhone");
        String birthday = request.getParameter("clientBirthday");

        query = "select * from korisnik where email = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);

            ResultSet res = stmt.executeQuery();

            if(res.next())
            {
                request.setAttribute("emailError", true);
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName", lastName);
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                request.setAttribute("city", city);
                request.setAttribute("address", address);
                request.setAttribute("phoneNumber", phoneNumber);
                request.setAttribute("birthday", birthday);

                RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                rd.forward(request, response);
                response.sendRedirect("signup.jsp");
            }
            else
            {
                String userID = Client.GenerateNewClientID();

                query = "insert into korisnik values(?, ?, ?, ?, password(?), ?, ?, ?, ?, ?, default)";

                PreparedStatement stmtInsertUser = conn.prepareStatement(query);
                stmtInsertUser.setString(1, userID);
                stmtInsertUser.setString(2, firstName);
                stmtInsertUser.setString(3, lastName);
                stmtInsertUser.setString(4, email);
                stmtInsertUser.setString(5, password);
                stmtInsertUser.setString(6, country);
                stmtInsertUser.setString(7, city);
                stmtInsertUser.setString(8, address);
                stmtInsertUser.setString(9, phoneNumber);
                stmtInsertUser.setString(10, birthday);
                stmtInsertUser.execute();

                query = "insert into klijent values(?, 0)";
                PreparedStatement stmtInsertClient = conn.prepareStatement(query);
                stmtInsertClient.setString(1, userID);
                stmtInsertClient.execute();

                query = "select * from korisnik kor join klijent kl on kor.korisnik_id = kl.korisnik_id where email = ?";
                PreparedStatement stmtReturnClient = conn.prepareStatement(query);
                stmtReturnClient.setString(1, email);
                ResultSet resClient = stmtReturnClient.executeQuery();

                if(resClient.next())
                {
                    String clientFirstName = resClient.getString("ime");
                    String clientLastName = resClient.getString("prezime");
                    String clientEmail = resClient.getString("email");
                    String clientCountry = resClient.getString("drzava");
                    String clientCity = resClient.getString("grad");
                    String clientAddress = resClient.getString("adresa");
                    String clientPhone = resClient.getString("broj_telefona");
                    String clientBirthday = resClient.getString("datum_rodjenja");
                    int numberOfPoints = resClient.getInt("broj_poena");

                    Client client = new Client(userID, clientFirstName, clientLastName, clientEmail, clientCountry, clientCity, clientAddress, clientPhone, clientBirthday, numberOfPoints);
                    session.setAttribute("LoggedInUser", client);
                    session.setAttribute("LoggedInClient", true);

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