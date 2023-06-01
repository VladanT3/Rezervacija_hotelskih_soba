package Servlets;

import Models.Hotel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletPrepareUpdate", value = "/ServletPrepareUpdate")
public class ServletPrepareUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Hotel hotelZaUpdate = Hotel.VratiDetaljeHotela(request.getParameter("hotel"));
        request.setAttribute("hotel", hotelZaUpdate);
        request.setAttribute("updateProvera", "1");
        RequestDispatcher rd = request.getRequestDispatcher("insertAndUpdateHotel.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}