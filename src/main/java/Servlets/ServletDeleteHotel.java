package Servlets;

import Database.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "ServletDeleteHotel", value = "/ServletDeleteHotel")
public class ServletDeleteHotel extends HttpServlet {
    Connection conn = DBConnection.connectToDB();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object proveraLogin = request.getSession().getAttribute("UlogovanKorisnik");
        if(proveraLogin == null)
        {
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
            return;
        }

        String hotelID = request.getParameter("hotel");
        String upit = "delete from hotel where hotel_id = ?";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, hotelID);
            stmt.execute();

            request.setAttribute("uspesnoBrisanje", true);
            RequestDispatcher rd = request.getRequestDispatcher("adminHotels.jsp");
            rd.forward(request, response);
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}