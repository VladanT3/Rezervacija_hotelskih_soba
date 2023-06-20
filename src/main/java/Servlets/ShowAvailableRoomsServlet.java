package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

@WebServlet(name = "ShowAvailableRoomsServlet", value = "/ShowAvailableRoomsServlet")
public class ShowAvailableRoomsServlet extends HttpServlet {

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
        String hotel = request.getParameter("hotel");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-d");
        LocalDate reservationFrom = LocalDate.parse(dateFrom, formatter);
        LocalDate reservationTo = LocalDate.parse(dateTo, formatter);
        long difference = ChronoUnit.DAYS.between(reservationFrom, reservationTo);
        if(difference < 0)
        {
            request.setAttribute("reservationError", true);
            request.setAttribute("hotel", hotel);

            RequestDispatcher rd = request.getRequestDispatcher("browseRooms.jsp");
            rd.forward(request, response);
            response.sendRedirect("browseRooms.jsp");
        }
        else
        {
            request.setAttribute("dateFrom", dateFrom);
            request.setAttribute("dateTo", dateTo);
            request.setAttribute("hotel", hotel);

            RequestDispatcher rd = request.getRequestDispatcher("browseRooms.jsp");
            rd.forward(request, response);
            response.sendRedirect("browseRooms.jsp");
        }
    }
}