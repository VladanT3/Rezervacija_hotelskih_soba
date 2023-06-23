package Servlets;

import Database.DBConnection;
import Models.Hotel;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "InsertAndUpdateHotelServlet", value = "/InsertAndUpdateHotelServlet")
public class InsertAndUpdateHotelServlet extends HttpServlet {
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
        String managerID = request.getParameter("assignedManager") == null ? "" : request.getParameter("assignedManager");
        String name = request.getParameter("hotelName");
        String country = request.getParameter("hotelCountry");
        String city = request.getParameter("hotelCity");
        String numberOfStars = request.getParameter("hotelZvezdice");
        String numberOfParkingSpots = request.getParameter("hotelParking");
        String desc = request.getParameter("hotelDesc");
        String photoName = request.getParameter("hotelPicture");
        int stars = 0, parkingSpots = 0;

        if(submit.equals("Add Hotel"))
        {
            try
            {
                stars = Integer.parseInt(numberOfStars);
                parkingSpots = Integer.parseInt(numberOfParkingSpots);
            }
            catch (Exception ex)
            {
                request.setAttribute("wholeNumberError", true);
                request.setAttribute("manager", managerID);
                request.setAttribute("name", name);
                request.setAttribute("country", country);
                request.setAttribute("city", city);
                request.setAttribute("numberOfStars", numberOfStars);
                request.setAttribute("numberOfParkingSpots", numberOfParkingSpots);
                request.setAttribute("desc", desc);
                request.setAttribute("photoName", photoName);
                RequestDispatcher rd = request.getRequestDispatcher("addOrEditHotel.jsp");
                rd.forward(request, response);
                response.sendRedirect("addOrEditHotel.jsp");
            }

            String hotelID = Hotel.GenerateNewHotelID();
            String upit = "insert into hotel values(?, ?, ?, ?, ?, ?, ?, ?, ?, default)";
            try
            {
                PreparedStatement stmt = conn.prepareStatement(upit);
                stmt.setString(1, hotelID);
                stmt.setString(2, managerID);
                stmt.setString(3, name);
                stmt.setString(4, country);
                stmt.setString(5, city);
                stmt.setInt(6, stars);
                stmt.setInt(7, parkingSpots);
                stmt.setString(8, desc);
                stmt.setString(9, photoName);
                stmt.execute();

                upit = "update menadzer set hotel_id = ? where korisnik_id = ?";
                PreparedStatement stmtUpdateMenadzer = conn.prepareStatement(upit);
                stmtUpdateMenadzer.setString(1, hotelID);
                stmtUpdateMenadzer.setString(2, managerID);
                stmtUpdateMenadzer.execute();

                request.setAttribute("successfulInsert", true);
                RequestDispatcher rd = request.getRequestDispatcher("hotels.jsp");
                rd.forward(request, response);
            }
            catch (SQLException ex)
            {
                ex.printStackTrace();
            }
        }
        else if(submit.equals("Edit Hotel"))
        {
            String updateHotelID = request.getParameter("updateHotelID");

            try
            {
                stars = Integer.parseInt(numberOfStars);
                parkingSpots = Integer.parseInt(numberOfParkingSpots);
            }
            catch (Exception ex)
            {
                request.setAttribute("wholeNumberError", true);

                Hotel hotelZaUpdate = Hotel.ReturnHotelDetails(updateHotelID);
                request.setAttribute("hotel", hotelZaUpdate);
                request.setAttribute("checkUpdate", "1");
                request.setAttribute("manager", managerID);
                request.setAttribute("name", name);
                request.setAttribute("country", country);
                request.setAttribute("city", city);
                request.setAttribute("numberOfStars", numberOfStars);
                request.setAttribute("numberOfParkingSpots", numberOfParkingSpots);
                request.setAttribute("desc", desc);
                request.setAttribute("photoName", photoName);

                RequestDispatcher rd = request.getRequestDispatcher("addOrEditHotel.jsp");
                rd.forward(request, response);
                response.sendRedirect("addOrEditHotel.jsp");
            }

            String query;
            try
            {
                String loggedInEmployee  = (String) request.getSession().getAttribute("LoggedInEmployee");
                switch (loggedInEmployee)
                {
                    case "Manager":
                    {
                        query = "update hotel set " +
                                "naziv = ?, " +
                                "drzava = ?, " +
                                "grad = ?, " +
                                "broj_zvezdica = ?, " +
                                "broj_parking_mesta = ?, " +
                                "opis = ?, " +
                                "naziv_slike = ? " +
                                "where hotel_id = ?";
                        PreparedStatement stmtUpdateHotel = conn.prepareStatement(query);
                        stmtUpdateHotel.setString(1, name);
                        stmtUpdateHotel.setString(2, country);
                        stmtUpdateHotel.setString(3, city);
                        stmtUpdateHotel.setInt(4, stars);
                        stmtUpdateHotel.setInt(5, parkingSpots);
                        stmtUpdateHotel.setString(6, desc);
                        stmtUpdateHotel.setString(7, photoName);
                        stmtUpdateHotel.setString(8, updateHotelID);
                        stmtUpdateHotel.execute();

                        request.setAttribute("successfulUpdate", true);
                        RequestDispatcher rd = request.getRequestDispatcher("managerAccount.jsp");
                        rd.forward(request, response);
                        break;
                    }
                    case "Admin":
                    {
                        query = "update menadzer set hotel_id = null where hotel_id = ?";

                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setString(1, updateHotelID);
                        stmt.execute();

                        query = "update menadzer set hotel_id = ? where korisnik_id = ?";
                        PreparedStatement stmtUpdateManager = conn.prepareStatement(query);
                        stmtUpdateManager.setString(1, updateHotelID);
                        stmtUpdateManager.setString(2, managerID);
                        stmtUpdateManager.execute();

                        if(managerID.equals(""))
                        {
                            query = "update hotel set " +
                                    "menadzer_id = NULL, " +
                                    "naziv = ?, " +
                                    "drzava = ?, " +
                                    "grad = ?, " +
                                    "broj_zvezdica = ?, " +
                                    "broj_parking_mesta = ?, " +
                                    "opis = ?, " +
                                    "naziv_slike = ? " +
                                    "where hotel_id = ?";
                            PreparedStatement stmtUpdateHotel = conn.prepareStatement(query);
                            stmtUpdateHotel.setString(1, name);
                            stmtUpdateHotel.setString(2, country);
                            stmtUpdateHotel.setString(3, city);
                            stmtUpdateHotel.setInt(4, stars);
                            stmtUpdateHotel.setInt(5, parkingSpots);
                            stmtUpdateHotel.setString(6, desc);
                            stmtUpdateHotel.setString(7, photoName);
                            stmtUpdateHotel.setString(8, updateHotelID);
                            stmtUpdateHotel.execute();
                        }
                        else
                        {
                            query = "update hotel set " +
                                    "menadzer_id = ?, " +
                                    "naziv = ?, " +
                                    "drzava = ?, " +
                                    "grad = ?, " +
                                    "broj_zvezdica = ?, " +
                                    "broj_parking_mesta = ?, " +
                                    "opis = ?, " +
                                    "naziv_slike = ? " +
                                    "where hotel_id = ?";
                            PreparedStatement stmtUpdateHotel = conn.prepareStatement(query);
                            stmtUpdateHotel.setString(1, managerID);
                            stmtUpdateHotel.setString(2, name);
                            stmtUpdateHotel.setString(3, country);
                            stmtUpdateHotel.setString(4, city);
                            stmtUpdateHotel.setInt(5, stars);
                            stmtUpdateHotel.setInt(6, parkingSpots);
                            stmtUpdateHotel.setString(7, desc);
                            stmtUpdateHotel.setString(8, photoName);
                            stmtUpdateHotel.setString(9, updateHotelID);
                            stmtUpdateHotel.execute();
                        }

                        request.setAttribute("successfulUpdate", true);
                        RequestDispatcher rd = request.getRequestDispatcher("hotels.jsp");
                        rd.forward(request, response);
                        break;
                    }
                }
            }
            catch (SQLException ex)
            {
                ex.printStackTrace();
            }
        }
    }
}