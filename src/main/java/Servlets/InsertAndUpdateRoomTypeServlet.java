package Servlets;

import Database.DBConnection;
import Models.RoomType;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "InsertAndUpdateRoomTypeServlet", value = "/InsertAndUpdateRoomTypeServlet")
public class InsertAndUpdateRoomTypeServlet extends HttpServlet {
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
        String submit = request.getParameter("submit");
        String bedType = request.getParameter("roomTypeBedType");
        String numberOfBedsString = request.getParameter("roomTypeNumberOfBeds");
        String kitchen = request.getParameter("roomTypeKitchen");
        String bathroom = request.getParameter("roomTypeBathroom");
        String tvBool = request.getParameter("roomTypeTV");
        String desc = request.getParameter("roomTypeDesc");
        int numberOfBeds = 0;
        boolean tv = tvBool.equals("on");

        if(submit.equals("Add Room Type"))
        {
            try
            {
                numberOfBeds = Integer.parseInt(numberOfBedsString);
            }
            catch (Exception ex)
            {
                request.setAttribute("wholeNumberError", true);
                request.setAttribute("bedType", bedType);
                request.setAttribute("numberOfBeds", numberOfBedsString);
                request.setAttribute("kitchen", kitchen);
                request.setAttribute("bathroom", bathroom);
                request.setAttribute("television", tv);
                request.setAttribute("desc", desc);
                RequestDispatcher rd = request.getRequestDispatcher("addOrEditRoomType.jsp");
                rd.forward(request, response);
                response.sendRedirect("addOrEditRoomType.jsp");
            }

            String roomTypeID = RoomType.GenerateRoomTypeID(numberOfBeds, bedType, kitchen, bathroom, tv);
            String roomTypeName = RoomType.GenerateRoomTypeName(numberOfBeds, bedType, kitchen, bathroom);
            String query = "select * from tip_sobe where tip_sobe_id = ?";

            try
            {
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, roomTypeID);
                ResultSet res = stmt.executeQuery();
                if(res.next())
                {
                    request.setAttribute("roomTypeAlreadyExistsError", true);
                    request.setAttribute("bedType", bedType);
                    request.setAttribute("numberOfBeds", numberOfBedsString);
                    request.setAttribute("kitchen", kitchen);
                    request.setAttribute("bathroom", bathroom);
                    request.setAttribute("television", tv);
                    request.setAttribute("desc", desc);

                    RequestDispatcher rd = request.getRequestDispatcher("addOrEditRoomType.jsp");
                    rd.forward(request, response);
                }
                else
                {
                    query = "insert into tip_sobe value (?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement stmtInsertRoomType = conn.prepareStatement(query);
                    stmtInsertRoomType.setString(1, roomTypeID);
                    stmtInsertRoomType.setString(2, roomTypeName);
                    stmtInsertRoomType.setInt(3, numberOfBeds);
                    stmtInsertRoomType.setString(4, bedType);
                    stmtInsertRoomType.setString(5, kitchen);
                    stmtInsertRoomType.setString(6, bathroom);
                    stmtInsertRoomType.setBoolean(7, tv);
                    stmtInsertRoomType.setString(8, desc);
                    stmtInsertRoomType.execute();

                    request.setAttribute("successfulInsert", true);
                    RequestDispatcher rd = request.getRequestDispatcher("roomTypes.jsp");
                    rd.forward(request, response);
                }
            }
            catch (SQLException ex)
            {
                ex.printStackTrace();
            }
        }
        else if(submit.equals("Edit Room Type"))
        {
            String updateRoomTypeID = request.getParameter("updateRoomTypeID");

            try
            {
                numberOfBeds = Integer.parseInt(numberOfBedsString);
            }
            catch (Exception ex)
            {
                RoomType roomTypeForUpdate = RoomType.ReturnRoomTypeDetails(updateRoomTypeID);
                request.setAttribute("roomType", roomTypeForUpdate);
                request.setAttribute("checkUpdate", "1");
                request.setAttribute("wholeNumberError", true);
                request.setAttribute("bedType", bedType);
                request.setAttribute("numberOfBeds", numberOfBedsString);
                request.setAttribute("kitchen", kitchen);
                request.setAttribute("bathroom", bathroom);
                request.setAttribute("television", tv);
                request.setAttribute("desc", desc);
                RequestDispatcher rd = request.getRequestDispatcher("addOrEditRoomType.jsp");
                rd.forward(request, response);
                response.sendRedirect("addOrEditRoomType.jsp");
            }

            String roomTypeName = RoomType.GenerateRoomTypeName(numberOfBeds, bedType, kitchen, bathroom);
            String upit = "update tip_sobe set " +
                    "naziv = ?, " +
                    "broj_kreveta = ?, " +
                    "tip_kreveta = ?, " +
                    "kuhinja = ?, " +
                    "kupatilo = ?, " +
                    "televizor = ?, " +
                    "opis = ? " +
                    "where tip_sobe_id = ?";
            try
            {
                PreparedStatement stmt = conn.prepareStatement(upit);
                stmt.setString(1, roomTypeName);
                stmt.setInt(2, numberOfBeds);
                stmt.setString(3, bedType);
                stmt.setString(4, kitchen);
                stmt.setString(5, bathroom);
                stmt.setBoolean(6, tv);
                stmt.setString(7, desc);
                stmt.setString(8, updateRoomTypeID);
                stmt.execute();

                request.setAttribute("successfulUpdate", true);
                RequestDispatcher rd = request.getRequestDispatcher("roomTypes.jsp");
                rd.forward(request, response);
            }
            catch (SQLException ex)
            {
                ex.printStackTrace();
            }
        }
    }
}