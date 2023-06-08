package Servlets;

import Models.RoomType;
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
        Object checkLogin = request.getSession().getAttribute("LoggedInUser");
        if(checkLogin == null)
        {
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
            return;
        }

        RoomType roomTypeForUpdate = RoomType.ReturnRoomTypeDetails(request.getParameter("roomType"));
        request.setAttribute("roomType", roomTypeForUpdate);
        request.setAttribute("checkUpdate", "1");
        RequestDispatcher rd = request.getRequestDispatcher("addOrEditRoomType.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}