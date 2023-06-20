package Servlets;

import Models.Hotel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "PrepareHotelUpdateServlet", value = "/PrepareHotelUpdateServlet")
public class PrepareHotelUpdateServlet extends HttpServlet {
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

        String hotelID = request.getParameter("hotel");
        if(hotelID.equals(""))
        {
            String loggedInEmployee = request.getSession().getAttribute("LoggedInEmployee") == null ? "" : (String) request.getSession().getAttribute("LoggedInEmployee");
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

        Hotel hotelForUpdate = Hotel.ReturnHotelDetails(hotelID);
        request.setAttribute("hotel", hotelForUpdate);
        request.setAttribute("checkUpdate", "1");
        RequestDispatcher rd = request.getRequestDispatcher("addOrEditHotel.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}