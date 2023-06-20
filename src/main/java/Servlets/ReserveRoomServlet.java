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
        String dateFrom = request.getParameter("reservationFrom");
        String dateTo = request.getParameter("reservationTo");
        String roomID = request.getParameter("room");
        float fullPrice = Float.parseFloat(request.getParameter("reservationPrice"));
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

            request.setAttribute("successfulReservation", true);
            RequestDispatcher rd = request.getRequestDispatcher("clientAccount.jsp");
            rd.forward(request, response);
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }
}