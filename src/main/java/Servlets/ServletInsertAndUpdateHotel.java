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

@WebServlet(name = "ServletInsertAndUpdateHotel", value = "/ServletInsertAndUpdateHotel")
public class ServletInsertAndUpdateHotel extends HttpServlet {
    Connection conn = DBConnection.connectToDB();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String submit = request.getParameter("submit");
        String menadzerID = request.getParameter("assignedManager") == null ? "" : request.getParameter("assignedManager");
        String naziv = request.getParameter("hotelName");
        String drzava = request.getParameter("hotelCountry");
        String grad = request.getParameter("hotelCity");
        String brojZvezdica = request.getParameter("hotelZvezdice");
        String brojParkingMesta = request.getParameter("hotelParking");
        String opis = request.getParameter("hotelDesc");
        String nazivSlike = request.getParameter("hotelPicture");
        int zvezdice = 0, parkingMesta = 0;

        try
        {
            zvezdice = Integer.parseInt(brojZvezdica);
            parkingMesta = Integer.parseInt(brojParkingMesta);
        }
        catch (Exception ex)
        {
            request.setAttribute("ceoBrojGreska", true);
            request.setAttribute("menadzer", menadzerID);
            request.setAttribute("naziv", naziv);
            request.setAttribute("drzava", drzava);
            request.setAttribute("grad", grad);
            request.setAttribute("brojZvezdica", brojZvezdica);
            request.setAttribute("brojParkingMesta", brojParkingMesta);
            request.setAttribute("opis", opis);
            request.setAttribute("nazivSlike", nazivSlike);
            RequestDispatcher rd = request.getRequestDispatcher("insertAndUpdateHotel.jsp");
            rd.forward(request, response);
            response.sendRedirect("insertAndUpdateHotel.jsp");
        }

        if(submit.equals("Add Hotel"))
        {
            String hotelID = Hotel.GenerisiNoviHotelID();
            String upit = "insert into hotel values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try
            {
                PreparedStatement stmt = conn.prepareStatement(upit);
                stmt.setString(1, hotelID);
                stmt.setString(2, menadzerID);
                stmt.setString(3, naziv);
                stmt.setString(4, drzava);
                stmt.setString(5, grad);
                stmt.setInt(6, zvezdice);
                stmt.setInt(7, parkingMesta);
                stmt.setString(8, opis);
                stmt.setString(9, nazivSlike);
                stmt.execute();

                upit = "update menadzer set hotel_id = ? where korisnik_id = ?";
                PreparedStatement stmtUpdateMenadzer = conn.prepareStatement(upit);
                stmtUpdateMenadzer.setString(1, hotelID);
                stmtUpdateMenadzer.setString(2, menadzerID);
                stmtUpdateMenadzer.execute();

                request.setAttribute("uspesanUnos", true);
                RequestDispatcher rd = request.getRequestDispatcher("adminHoteli.jsp");
                rd.forward(request, response);
            }
            catch (SQLException ex)
            {
                ex.printStackTrace();
            }
        }
        else if(submit.equals("Edit Hotel"))
        {
            String upit;
            String updateHotelID = request.getParameter("updateHotelID");
            try
            {
                String ulogovanRadnik  = (String) request.getSession().getAttribute("UlogovanRadnik");
                switch (ulogovanRadnik)
                {
                    case "Menadzer":
                    {
                        upit = "update hotel set " +
                                "naziv = ?, " +
                                "drzava = ?, " +
                                "grad = ?, " +
                                "broj_zvezdica = ?, " +
                                "broj_parking_mesta = ?, " +
                                "opis = ?, " +
                                "naziv_slike = ? " +
                                "where hotel_id = ?";
                        PreparedStatement stmtPromenaHotela = conn.prepareStatement(upit);
                        stmtPromenaHotela.setString(1, naziv);
                        stmtPromenaHotela.setString(2, drzava);
                        stmtPromenaHotela.setString(3, grad);
                        stmtPromenaHotela.setInt(4, zvezdice);
                        stmtPromenaHotela.setInt(5, parkingMesta);
                        stmtPromenaHotela.setString(6, opis);
                        stmtPromenaHotela.setString(7, nazivSlike);
                        stmtPromenaHotela.setString(8, updateHotelID);
                        stmtPromenaHotela.execute();

                        request.setAttribute("uspesnaPromena", true);
                        RequestDispatcher rd = request.getRequestDispatcher("menadzerNalog.jsp");
                        rd.forward(request, response);
                        break;
                    }
                    case "Admin":
                    {
                        upit = "update menadzer set hotel_id = null where hotel_id = ?";

                        PreparedStatement stmt = conn.prepareStatement(upit);
                        stmt.setString(1, updateHotelID);
                        stmt.execute();

                        upit = "update menadzer set hotel_id = ? where korisnik_id = ?";
                        PreparedStatement stmtPromenaMenadzera = conn.prepareStatement(upit);
                        stmtPromenaMenadzera.setString(1, updateHotelID);
                        stmtPromenaMenadzera.setString(2, menadzerID);
                        stmtPromenaMenadzera.execute();

                        if(menadzerID.equals(""))
                        {
                            upit = "update hotel set " +
                                    "menadzer_id = NULL, " +
                                    "naziv = ?, " +
                                    "drzava = ?, " +
                                    "grad = ?, " +
                                    "broj_zvezdica = ?, " +
                                    "broj_parking_mesta = ?, " +
                                    "opis = ?, " +
                                    "naziv_slike = ? " +
                                    "where hotel_id = ?";
                            PreparedStatement stmtPromenaHotela = conn.prepareStatement(upit);
                            stmtPromenaHotela.setString(1, naziv);
                            stmtPromenaHotela.setString(2, drzava);
                            stmtPromenaHotela.setString(3, grad);
                            stmtPromenaHotela.setInt(4, zvezdice);
                            stmtPromenaHotela.setInt(5, parkingMesta);
                            stmtPromenaHotela.setString(6, opis);
                            stmtPromenaHotela.setString(7, nazivSlike);
                            stmtPromenaHotela.setString(8, updateHotelID);
                            stmtPromenaHotela.execute();
                        }
                        else
                        {
                            upit = "update hotel set " +
                                    "menadzer_id = ?, " +
                                    "naziv = ?, " +
                                    "drzava = ?, " +
                                    "grad = ?, " +
                                    "broj_zvezdica = ?, " +
                                    "broj_parking_mesta = ?, " +
                                    "opis = ?, " +
                                    "naziv_slike = ? " +
                                    "where hotel_id = ?";
                            PreparedStatement stmtPromenaHotela = conn.prepareStatement(upit);
                            stmtPromenaHotela.setString(1, menadzerID);
                            stmtPromenaHotela.setString(2, naziv);
                            stmtPromenaHotela.setString(3, drzava);
                            stmtPromenaHotela.setString(4, grad);
                            stmtPromenaHotela.setInt(5, zvezdice);
                            stmtPromenaHotela.setInt(6, parkingMesta);
                            stmtPromenaHotela.setString(7, opis);
                            stmtPromenaHotela.setString(8, nazivSlike);
                            stmtPromenaHotela.setString(9, updateHotelID);
                            stmtPromenaHotela.execute();
                        }

                        request.setAttribute("uspesnaPromena", true);
                        RequestDispatcher rd = request.getRequestDispatcher("adminHoteli.jsp");
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