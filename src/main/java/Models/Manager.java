package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Manager extends Employee {
    protected String hotelID;
    private static final Connection conn = DBConnection.connectToDB();

    public Manager() {
    }

    public Manager(String id, String firstName, String lastName, String email, String country, String city, String address, String phoneNumber, String birthday, String dateOfHiring, String hotelID) {
        super(id, firstName, lastName, email, country, city, address, phoneNumber, birthday, dateOfHiring);
        this.hotelID = hotelID;
    }

    public Hotel ReturnAssignedHotel()
    {
        Hotel hotel = new Hotel();
        String query = "select * from hotel where menadzer_id = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, id);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                String hotelId = res.getString("hotel_id");
                String managerID = res.getString("menadzer_id");
                String name = res.getString("naziv");
                String country = res.getString("drzava");
                String city = res.getString("grad");
                String desc = res.getString("opis");
                String photoName = res.getString("naziv_slike");
                int stars = res.getInt("broj_zvezdica");
                int parking = res.getInt("broj_parking_mesta");
                hotel = new Hotel(hotelId, managerID, name, country, city, desc, photoName, stars, parking);
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return hotel;
    }

    public static ArrayList<Manager> ReturnManagersWhoArentAssignedAHotel()
    {
        ArrayList<Manager> managers = new ArrayList<>();
        String query = "select * " +
                "from korisnik k join radnik r on k.korisnik_id = r.korisnik_id " +
                "join menadzer m on m.korisnik_id = r.korisnik_id " +
                "where m.hotel_id is null";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet res = stmt.executeQuery();
            while(res.next())
            {
                String menadzerID = res.getString("korisnik_id");
                String firstName = res.getString("ime");
                String lastName = res.getString("prezime");
                String email = res.getString("email");
                String country = res.getString("drzava");
                String city = res.getString("grad");
                String address = res.getString("adresa");
                String phoneNumber = res.getString("broj_telefona");
                String birthday = res.getString("datum_rodjenja");
                String dateOfHiring = res.getString("datum_zaposlenja");

                managers.add(new Manager(menadzerID, firstName, lastName, email, country, city, address, phoneNumber, birthday, dateOfHiring, ""));
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return managers;
    }

    public static Manager ReturnManager(String id)
    {
        Manager manager = new Manager();
        String query = "select * " +
                "from korisnik k join radnik r on k.korisnik_id = r.korisnik_id " +
                "join menadzer m on m.korisnik_id = r.korisnik_id " +
                "where k.korisnik_id = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, id);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                String menadzerID = res.getString("korisnik_id");
                String firstName = res.getString("ime");
                String lastName = res.getString("prezime");
                String email = res.getString("email");
                String country = res.getString("drzava");
                String city = res.getString("grad");
                String address = res.getString("adresa");
                String phoneNumber = res.getString("broj_telefona");
                String birthday = res.getString("datum_rodjenja");
                String dateOfHiring = res.getString("datum_zaposlenja");
                String hotelId = res.getString("hotel_id");

                manager = new Manager(menadzerID, firstName, lastName, email, country, city, address, phoneNumber, birthday, dateOfHiring, hotelId);
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return manager;
    }

    public String getHotelID() {
        return hotelID;
    }
}
