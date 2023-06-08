package Servlets;

import Models.Hotel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletPrepareHotelUpdate", value = "/ServletPrepareHotelUpdate")
public class ServletPrepareHotelUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object checkLogin = request.getSession().getAttribute("LoggedInUser");
        if(checkLogin == null)
        {
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
            return;
        }

        Hotel hotelForUpdate = Hotel.ReturnHotelDetails(request.getParameter("hotel"));
        request.setAttribute("hotel", hotelForUpdate);
        request.setAttribute("checkUpdate", "1");
        RequestDispatcher rd = request.getRequestDispatcher("addOrEditHotel.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}