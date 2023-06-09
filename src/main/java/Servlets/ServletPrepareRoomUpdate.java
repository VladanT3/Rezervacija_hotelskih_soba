package Servlets;

import Models.Room;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletPrepareRoomUpdate", value = "/ServletPrepareRoomUpdate")
public class ServletPrepareRoomUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object checkLogin = request.getSession().getAttribute("LoggedInUser");
        if(checkLogin == null)
        {
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
            return;
        }

        Room roomForUpdate = Room.ReturnRoomDetails(request.getParameter("room"));
        request.setAttribute("room", roomForUpdate);
        request.setAttribute("checkUpdate", "1");
        RequestDispatcher rd = request.getRequestDispatcher("addOrEditRoom.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}