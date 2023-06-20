package Servlets;

import Database.DBConnection;
import Models.Client;
import Models.Reservation;
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

@WebServlet(name = "ReserveRoomServlet", value = "/ReserveRoomServlet")
public class ReserveRoomServlet extends HttpServlet {
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

        String loggedInEmployee = request.getSession().getAttribute("LoggedInEmployee") == null ? "" : (String) request.getSession().getAttribute("LoggedInEmployee");
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
        String dateFrom = request.getParameter("reservationFrom");
        String dateTo = request.getParameter("reservationTo");
        String roomID = request.getParameter("room");
        float fullPrice = Float.parseFloat(request.getParameter("reservationPrice"));
        String applyPoints = request.getParameter("applyPoints");
        Client client = (Client) request.getSession().getAttribute("LoggedInUser");

        String reservationID = Reservation.GenerateNewReservationID(roomID, client.getId());
        String query = "insert into rezervacija values(?, ?, ?, ?, ?, ?)";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, reservationID);
            stmt.setString(2, client.getId());
            stmt.setString(3, roomID);
            stmt.setString(4, dateFrom);
            stmt.setString(5, dateTo);
            stmt.setFloat(6, fullPrice);
            stmt.execute();

            if(applyPoints != null)
            {
                query = "update klijent set broj_poena = 0 where korisnik_id = ?";
                PreparedStatement stmtUpdatePoints = conn.prepareStatement(query);
                stmtUpdatePoints.setString(1, client.getId());
                stmtUpdatePoints.execute();

                client.setNumberOfPoints(0);
                request.getSession().setAttribute("LoggedInUser", client);

                request.setAttribute("successfulReservation", true);
                RequestDispatcher rd = request.getRequestDispatcher("clientAccount.jsp");
                rd.forward(request, response);
            }
            else
            {
                int newPoints = client.getNumberOfPoints() + 2;

                query = "update klijent set broj_poena = ? where korisnik_id = ?";
                PreparedStatement stmtUpdatePoints = conn.prepareStatement(query);
                stmtUpdatePoints.setInt(1, newPoints);
                stmtUpdatePoints.setString(2, client.getId());
                stmtUpdatePoints.execute();

                client.setNumberOfPoints(newPoints);
                request.getSession().setAttribute("LoggedInUser", client);

                request.setAttribute("successfulReservation", true);
                RequestDispatcher rd = request.getRequestDispatcher("clientAccount.jsp");
                rd.forward(request, response);
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }
}