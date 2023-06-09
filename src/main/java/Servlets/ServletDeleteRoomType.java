package Servlets;

import Database.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "ServletDeleteRoomType", value = "/ServletDeleteRoomType")
public class ServletDeleteRoomType extends HttpServlet {
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

        String roomTypeID = request.getParameter("roomType");
        if(roomTypeID.equals(""))
        {
            String loggedInEmployee = (String) request.getSession().getAttribute("LoggedInEmployee");
            if(loggedInEmployee.equals("Manager"))
            {
                response.sendRedirect("managerAccount.jsp");
                return;
            }
            else if(loggedInEmployee.equals("Admin"))
            {
                response.sendRedirect("adminAccount.jsp");
                return;
            }
        }

        String query = "delete from tip_sobe where tip_sobe_id = ?";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, roomTypeID);
            stmt.execute();

            request.setAttribute("successfulDelete", true);
            RequestDispatcher rd = request.getRequestDispatcher("roomTypes.jsp");
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