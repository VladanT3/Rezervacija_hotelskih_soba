package Servlets;

import Database.DBConnection;
import Models.Room;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "ServletInsertAndUpdateRoom", value = "/ServletInsertAndUpdateRoom")
public class ServletInsertAndUpdateRoom extends HttpServlet {
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

        String loggedInEmployee = (String) request.getSession().getAttribute("LoggedInEmployee");
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
        String hotelID = request.getParameter("hotelID");
        String roomTypeID = request.getParameter("roomTypeID");
        String roomNumberString = request.getParameter("roomNumber");
        String pricePerNight = request.getParameter("pricePerNight");
        int roomNumber = 0;
        float price = 0;

        try
        {
            if(submit.equals("Add Room to Hotel"))
            {
                try
                {
                    roomNumber = Integer.parseInt(roomNumberString);
                    price = Float.parseFloat(pricePerNight);
                }
                catch (Exception ex)
                {
                    request.setAttribute("numberError", true);
                    request.setAttribute("pickedHotelID", hotelID);
                    request.setAttribute("pickedRoomType", roomTypeID);
                    request.setAttribute("pickedRoomNumber", roomNumberString);
                    request.setAttribute("pickedPricePerNight", pricePerNight);

                    RequestDispatcher rd = request.getRequestDispatcher("addOrEditRoom.jsp");
                    rd.forward(request, response);
                    response.sendRedirect("addOrEditRoom.jsp");
                }

                if(Room.CheckIfRoomNumberExists(roomNumber, 0, hotelID))
                {
                    request.setAttribute("roomNumberAlreadyExistsError", true);
                    request.setAttribute("pickedHotelID", hotelID);
                    request.setAttribute("pickedRoomType", roomTypeID);
                    request.setAttribute("pickedRoomNumber", roomNumberString);
                    request.setAttribute("pickedPricePerNight", pricePerNight);

                    RequestDispatcher rd = request.getRequestDispatcher("addOrEditRoom.jsp");
                    rd.forward(request, response);
                    response.sendRedirect("addOrEditRoom.jsp");
                }

                String roomID = Room.GenerateNewRoomID(hotelID, roomNumber);
                String query = "insert into soba values(?, ?, ?, null, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, roomID);
                stmt.setString(2, hotelID);
                stmt.setString(3, roomTypeID);
                stmt.setInt(4, roomNumber);
                stmt.setFloat(5, price);
                stmt.execute();

                request.setAttribute("successfulInsert", true);
                RequestDispatcher rd = request.getRequestDispatcher("searchRooms.jsp");
                rd.forward(request, response);
                response.sendRedirect("http://localhost:8080/Rezervacija_hotelskih_soba_war_exploded/searchRooms.jsp?hotel=" + hotelID);
            }
            else if(submit.equals("Edit Room"))
            {
                String updateRoomID = request.getParameter("updateRoomID");
                try
                {
                    roomNumber = Integer.parseInt(roomNumberString);
                    price = Float.parseFloat(pricePerNight);
                }
                catch (Exception ex)
                {
                    Room roomForUpdate = Room.ReturnRoomDetails(updateRoomID);
                    request.setAttribute("room", roomForUpdate);
                    request.setAttribute("checkUpdate", "1");
                    request.setAttribute("numberError", true);
                    request.setAttribute("pickedRoomType", roomTypeID);
                    request.setAttribute("pickedRoomNumber", roomNumberString);
                    request.setAttribute("pickedPricePerNight", pricePerNight);

                    RequestDispatcher rd = request.getRequestDispatcher("addOrEditRoom.jsp");
                    rd.forward(request, response);
                    response.sendRedirect("addOrEditRoom.jsp");
                }
                Room oldRoom = Room.ReturnRoomDetails(updateRoomID);
                if(Room.CheckIfRoomNumberExists(roomNumber, oldRoom.getRoomNumber(), hotelID))
                {
                    Room roomForUpdate = Room.ReturnRoomDetails(updateRoomID);
                    request.setAttribute("room", roomForUpdate);
                    request.setAttribute("checkUpdate", "1");
                    request.setAttribute("roomNumberAlreadyExistsError", true);
                    request.setAttribute("pickedHotelID", hotelID);
                    request.setAttribute("pickedRoomType", roomTypeID);
                    request.setAttribute("pickedRoomNumber", roomNumberString);
                    request.setAttribute("pickedPricePerNight", pricePerNight);

                    RequestDispatcher rd = request.getRequestDispatcher("addOrEditRoom.jsp");
                    rd.forward(request, response);
                    response.sendRedirect("addOrEditRoom.jsp");
                }

                String query = "update soba set " +
                        "tip_sobe_id = ?, " +
                        "broj_sobe = ?, " +
                        "dnevna_cena = ? " +
                        "where soba_id = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, roomTypeID);
                stmt.setInt(2, roomNumber);
                stmt.setFloat(3, price);
                stmt.setString(4, updateRoomID);
                stmt.execute();

                request.setAttribute("successfulUpdate", true);
                RequestDispatcher rd = request.getRequestDispatcher("searchRooms.jsp");
                rd.forward(request, response);
                response.sendRedirect("http://localhost:8080/Rezervacija_hotelskih_soba_war_exploded/searchRooms.jsp?hotel=" + hotelID);
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }
}