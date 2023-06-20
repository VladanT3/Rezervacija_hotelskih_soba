package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Reservation {
    protected String reservationID, clientID, roomID, dateFrom, dateTo;
    protected float price;
    private static final Connection conn = DBConnection.connectToDB();

    public Reservation() {
    }

    public Reservation(String reservationID, String clientID, String roomID, String dateFrom, String dateTo, float price) {
        this.reservationID = reservationID;
        this.clientID = clientID;
        this.roomID = roomID;
        this.dateFrom = dateFrom;
        this.dateTo = dateTo;
        this.price = price;
    }

    public Hotel ReturnHotelDetailsInReservation()
    {
        Hotel hotel = new Hotel();
        String query = "select * from hotel h join soba s on h.hotel_id = s.hotel_id where soba_id = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, roomID);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                hotel.setId(res.getString("hotel_id"));
                hotel.setManagerID(res.getString("menadzer_id"));
                hotel.setName(res.getString("naziv"));
                hotel.setCountry(res.getString("drzava"));
                hotel.setCity(res.getString("grad"));
                hotel.setNumberOfStars(res.getInt("broj_zvezdica"));
                hotel.setNumberOfParkingSpots(res.getInt("broj_parking_mesta"));
                hotel.setDescription(res.getString("opis"));
            }
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }

        return hotel;
    }

    public int ReturnRoomNumberInReservation()
    {
        int roomNumber = 0;
        String query = "select broj_sobe from soba where soba_id = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, roomID);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                roomNumber = res.getInt("broj_sobe");
            }
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }

        return roomNumber;
    }

    public static String GenerateNewReservationID(String roomID, String clientID)
    {
        String reservationID = clientID + "-" + roomID + "-R";
        int IDnumber;
        String query = "select count(*) as numberOfReservations from rezervacija where klijent_id = ? and soba_id = ?";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, clientID);
            stmt.setString(2, roomID);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                IDnumber = res.getInt("numberOfReservations") + 11;
                reservationID += IDnumber;
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return reservationID;
    }

    public static ArrayList<Reservation> ReturnAllClientsReservations(String clientID)
    {
        ArrayList<Reservation> reservations = new ArrayList<>();
        String query = "select * " +
                "from rezervacija " +
                "where klijent_id = ?";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, clientID);
            ResultSet res = stmt.executeQuery();
            while(res.next())
            {
                String reservationID = res.getString("rezervacija_id");
                String roomID = res.getString("soba_id");
                String dateFrom = res.getString("datum_pocetka");
                String dateTo = res.getString("datum_isteka");
                float price = res.getFloat("cena");

                reservations.add(new Reservation(reservationID, clientID, roomID, dateFrom, dateTo, price));
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return reservations;
    }

    public void setReservationID(String reservationID) {
        this.reservationID = reservationID;
    }

    public void setClientID(String clientID) {
        this.clientID = clientID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public String getReservationID() {
        return reservationID;
    }

    public String getClientID() {
        return clientID;
    }

    public String getRoomID() {
        return roomID;
    }

    public String getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(String dateFrom) {
        this.dateFrom = dateFrom;
    }

    public String getDateTo() {
        return dateTo;
    }

    public void setDateTo(String dateTo) {
        this.dateTo = dateTo;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
}
