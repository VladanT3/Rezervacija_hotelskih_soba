package Servlets;

import Database.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "ServletInsertAndUpdateRoomType", value = "/ServletInsertAndUpdateRoomType")
public class ServletInsertAndUpdateRoomType extends HttpServlet {
    Connection conn = DBConnection.connectToDB();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().invalidate();
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String submit = request.getParameter("submit");
        String tipKreveta = request.getParameter("roomTypeTipKreveta");
        String brojKrevetaString = request.getParameter("roomTypeBrojKreveta");
        String kuhinja = request.getParameter("roomTypeKuhinja");
        String kupatilo = request.getParameter("roomTypeKupatilo");
        String tvBool = request.getParameter("roomTypeTV");
        String opis = request.getParameter("roomTypeDesc");
        int brojKreveta = 0;
        boolean tv = tvBool.equals("on");

        if(submit.equals("Add Room Type"))
        {
            try
            {
                brojKreveta = Integer.parseInt(brojKrevetaString);
            }
            catch (Exception ex)
            {
                request.setAttribute("ceoBrojGreska", true);
                request.setAttribute("tipKreveta", tipKreveta);
                request.setAttribute("brojKreveta", brojKreveta);
                request.setAttribute("kuhinja", kuhinja);
                request.setAttribute("kupatilo", kupatilo);
                request.setAttribute("televizor", tv);
                request.setAttribute("opis", opis);
                RequestDispatcher rd = request.getRequestDispatcher("insertAndUpdateRoomType.jsp");
                rd.forward(request, response);
                response.sendRedirect("insertAndUpdateRoomType.jsp");
            }


        }
        else if(submit.equals("Edit Room Type"))
        {

        }
    }
}