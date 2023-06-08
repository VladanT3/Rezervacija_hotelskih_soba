package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Hotel {
    protected String id, managerID, name, country, city, description, photoName;
    protected int numberOfStars, numberOfParkingSpots;
    private static final Connection conn = DBConnection.connectToDB();

    public Hotel() {
    }

    public Hotel(String id, String managerID, String name, String country, String city, String description, String photoName, int numberOfStars, int numberOfParkingSpots) {
        this.id = id;
        this.managerID = managerID;
        this.name = name;
        this.country = country;
        this.city = city;
        this.description = description;
        this.photoName = photoName;
        this.numberOfStars = numberOfStars;
        this.numberOfParkingSpots = numberOfParkingSpots;
    }

    public static ArrayList<Hotel> ReturnHotels(String hotelName)
    {
        ArrayList<Hotel> hotels = new ArrayList<>();
        String query = "select * from hotel where naziv like '%" + hotelName + "%'";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet res = stmt.executeQuery();

            while(res.next())
            {
                String hotelID = res.getString("hotel_id");
                String managerID = res.getString("menadzer_id");
                String name = res.getString("naziv");
                String country = res.getString("drzava");
                String city = res.getString("grad");
                String desc = res.getString("opis");
                String photoName = res.getString("naziv_slike");
                int stars = res.getInt("broj_zvezdica");
                int parking = res.getInt("broj_parking_mesta");
                hotels.add(new Hotel(hotelID, managerID, name, country, city, desc, photoName, stars, parking));
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return hotels;
    }

    public static Hotel ReturnHotelDetails(String hotelID)
    {
        Hotel hotel = new Hotel();
        String query = "select * from hotel where hotel_id = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, hotelID);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                String managerID = res.getString("menadzer_id");
                String name = res.getString("naziv");
                String country = res.getString("drzava");
                String city = res.getString("grad");
                String desc = res.getString("opis");
                String photoName = res.getString("naziv_slike");
                int stars = res.getInt("broj_zvezdica");
                int parking = res.getInt("broj_parking_mesta");
                hotel = new Hotel(hotelID, managerID, name, country, city, desc, photoName, stars, parking);
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return hotel;
    }

    public static String GenerateNewHotelID()
    {
        String hotelID = "H";
        int additionToID = 0;
        String query = "select hotel_id from hotel order by datum_dodavanja desc limit 1";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                String lastHotelID = res.getString("hotel_id");
                additionToID = Integer.parseInt(lastHotelID.substring(1)) + 1;
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return hotelID + additionToID;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getManagerID() {
        return managerID;
    }

    public void setManagerID(String managerID) {
        this.managerID = managerID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getNumberOfStars() {
        return numberOfStars;
    }

    public void setNumberOfStars(int numberOfStars) {
        this.numberOfStars = numberOfStars;
    }

    public int getNumberOfParkingSpots() {
        return numberOfParkingSpots;
    }

    public void setNumberOfParkingSpots(int numberOfParkingSpots) {
        this.numberOfParkingSpots = numberOfParkingSpots;
    }

    public String getPhotoName() {
        return photoName;
    }

    public void setPhotoName(String photoName) {
        this.photoName = photoName;
    }
}
