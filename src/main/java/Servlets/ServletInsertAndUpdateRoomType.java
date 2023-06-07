package Servlets;

import Database.DBConnection;
import Models.TipSobe;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
                request.setAttribute("brojKreveta", brojKrevetaString);
                request.setAttribute("kuhinja", kuhinja);
                request.setAttribute("kupatilo", kupatilo);
                request.setAttribute("televizor", tv);
                request.setAttribute("opis", opis);
                RequestDispatcher rd = request.getRequestDispatcher("insertAndUpdateRoomType.jsp");
                rd.forward(request, response);
                response.sendRedirect("insertAndUpdateRoomType.jsp");
            }

            String tipSobeId = TipSobe.GenerisiTipSobeID(brojKreveta, tipKreveta, kuhinja, kupatilo, tv);
            String nazivTipaSobe = TipSobe.GenerisiNazivTipaSobe(brojKreveta, tipKreveta, kuhinja, kupatilo);
            String upit = "select * from tip_sobe where tip_sobe_id = ?";

            try
            {
                PreparedStatement stmt = conn.prepareStatement(upit);
                stmt.setString(1, tipSobeId);
                ResultSet rez = stmt.executeQuery();
                if(rez.next())
                {
                    request.setAttribute("postojiTipSobeGreska", true);
                    request.setAttribute("tipKreveta", tipKreveta);
                    request.setAttribute("brojKreveta", brojKrevetaString);
                    request.setAttribute("kuhinja", kuhinja);
                    request.setAttribute("kupatilo", kupatilo);
                    request.setAttribute("televizor", tv);
                    request.setAttribute("opis", opis);

                    RequestDispatcher rd = request.getRequestDispatcher("insertAndUpdateRoomType.jsp");
                    rd.forward(request, response);
                }
                else
                {
                    upit = "insert into tip_sobe value (?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement stmtUnosTipaSobe = conn.prepareStatement(upit);
                    stmtUnosTipaSobe.setString(1, tipSobeId);
                    stmtUnosTipaSobe.setString(2, nazivTipaSobe);
                    stmtUnosTipaSobe.setInt(3, brojKreveta);
                    stmtUnosTipaSobe.setString(4, tipKreveta);
                    stmtUnosTipaSobe.setString(5, kuhinja);
                    stmtUnosTipaSobe.setString(6, kupatilo);
                    stmtUnosTipaSobe.setBoolean(7, tv);
                    stmtUnosTipaSobe.setString(8, opis);
                    stmtUnosTipaSobe.execute();

                    request.setAttribute("uspesanUnos", true);
                    RequestDispatcher rd = request.getRequestDispatcher("tipoviSoba.jsp");
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
                brojKreveta = Integer.parseInt(brojKrevetaString);
            }
            catch (Exception ex)
            {
                TipSobe tipZaUpdate = TipSobe.VratiDetaljeTipaSobe(updateRoomTypeID);
                request.setAttribute("tipSobe", tipZaUpdate);
                request.setAttribute("updateProvera", "1");
                request.setAttribute("ceoBrojGreska", true);
                request.setAttribute("tipKreveta", tipKreveta);
                request.setAttribute("brojKreveta", brojKrevetaString);
                request.setAttribute("kuhinja", kuhinja);
                request.setAttribute("kupatilo", kupatilo);
                request.setAttribute("televizor", tv);
                request.setAttribute("opis", opis);
                RequestDispatcher rd = request.getRequestDispatcher("insertAndUpdateRoomType.jsp");
                rd.forward(request, response);
                response.sendRedirect("insertAndUpdateRoomType.jsp");
            }

            String nazivTipaSobe = TipSobe.GenerisiNazivTipaSobe(brojKreveta, tipKreveta, kuhinja, kupatilo);
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
                stmt.setString(1, nazivTipaSobe);
                stmt.setInt(2, brojKreveta);
                stmt.setString(3, tipKreveta);
                stmt.setString(4, kuhinja);
                stmt.setString(5, kupatilo);
                stmt.setBoolean(6, tv);
                stmt.setString(7, opis);
                stmt.setString(8, updateRoomTypeID);
                stmt.execute();

                request.setAttribute("uspesnaPromena", true);
                RequestDispatcher rd = request.getRequestDispatcher("tipoviSoba.jsp");
                rd.forward(request, response);
            }
            catch (SQLException ex)
            {
                ex.printStackTrace();
            }
        }
    }
}