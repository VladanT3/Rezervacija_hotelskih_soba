package Servlets;

import Models.TipSobe;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletPrepareRoomTypeUpdate", value = "/ServletPrepareRoomTypeUpdate")
public class ServletPrepareRoomTypeUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object proveraLogin = request.getSession().getAttribute("UlogovanKorisnik");
        if(proveraLogin == null)
        {
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
            return;
        }

        TipSobe tipZaUpdate = TipSobe.VratiDetaljeTipaSobe(request.getParameter("tipSobe"));
        request.setAttribute("tipSobe", tipZaUpdate);
        request.setAttribute("updateProvera", "1");
        RequestDispatcher rd = request.getRequestDispatcher("insertAndUpdateRoomType.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}