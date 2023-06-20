package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Room {
    private String roomID, hotelID, roomTypeID, roomTypeName;
    private int roomNumber;
    private float pricePerNight;
    private static final Connection conn = DBConnection.connectToDB();

    public Room() {
    }

    public Room(String roomID, String hotelID, String roomTypeID, String roomTypeName, int roomNumber, float pricePerNight) {
        this.roomID = roomID;
        this.hotelID = hotelID;
        this.roomTypeID = roomTypeID;
        this.roomTypeName = roomTypeName;
        this.roomNumber = roomNumber;
        this.pricePerNight = pricePerNight;
    }

    public static ArrayList<Room> ReturnRoomsInHotel(String hotelID, String roomTypeName)
    {
        ArrayList<Room> rooms = new ArrayList<>();
        String query = "select * " +
                "from soba s join tip_sobe ts on s.tip_sobe_id = ts.tip_sobe_id " +
                "where s.hotel_id = ? and ts.naziv like '%" + roomTypeName + "%' " +
                "order by broj_sobe";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, hotelID);
            ResultSet res = stmt.executeQuery();
            while(res.next())
            {
                String roomID = res.getString("soba_id");
                String roomTypeID = res.getString("tip_sobe_id");
                String name = res.getString("naziv");
                int roomNumber = res.getInt("broj_sobe");
                float price = res.getFloat("dnevna_cena");

                rooms.add(new Room(roomID, hotelID, roomTypeID, name, roomNumber, price));
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return rooms;
    }

    public static Room ReturnRoomDetails(String id)
    {
        Room room = new Room();
        String query = "select * from soba s join tip_sobe ts on s.tip_sobe_id = ts.tip_sobe_id where soba_id = ?";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, id);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                String hotelID = res.getString("hotel_id");
                String roomTypeID = res.getString("tip_sobe_id");
                String name = res.getString("naziv");
                int roomNumber = res.getInt("broj_sobe");
                float price = res.getFloat("dnevna_cena");

                room = new Room(id, hotelID, roomTypeID, name, roomNumber, price);
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return room;
    }

    public static boolean CheckIfRoomNumberExists(int newRoomNumber, int oldRoomNumber, String hotelID)
    {
        String query = "select broj_sobe from soba where broj_sobe = ? and hotel_id = ?";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, newRoomNumber);
            stmt.setString(2, hotelID);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                int roomNumber = res.getInt("broj_sobe");
                return roomNumber != oldRoomNumber;
            }
            else
                return false;
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return true;
    }

    public static String GenerateNewRoomID(String hotelID, int roomNumber)
    {
        return hotelID + "S" + roomNumber;
    }

    public static ArrayList<Room> ReturnAvailableRoomsInHotel(String hotelID, String roomTypeName, String dateFrom)
    {
        ArrayList<Room> allRooms = Room.ReturnRoomsInHotel(hotelID, roomTypeName);
        ArrayList<Room> availableRooms = new ArrayList<>();
        String query = "select * " +
                "from soba s join rezervacija r on r.soba_id = s.soba_id " +
                "where ? BETWEEN r.datum_pocetka and r.datum_isteka and s.soba_id = ?";
        try
        {
            for(Room room : allRooms)
            {
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, dateFrom);
                stmt.setString(2, room.getRoomID());
                ResultSet res = stmt.executeQuery();
                if(!res.next())
                {
                    availableRooms.add(room);
                }
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return availableRooms;
    }

    public static ArrayList<Room> FilterRooms(String hotelID, String roomTypeName, String dateFrom, String bedType, String numberOfBeds, String kitchen, String bathroom)
    {
        ArrayList<Room> availableRooms = Room.ReturnAvailableRoomsInHotel(hotelID, roomTypeName, dateFrom);
        ArrayList<Room> filteredRooms = new ArrayList<>();
        try
        {
            if(numberOfBeds.equals(""))
            {
                String query = "select * " +
                        "from soba s join tip_sobe ts on s.tip_sobe_id = ts.tip_sobe_id " +
                        "where s.soba_id = ? and " +
                        "ts.tip_kreveta like '%" + bedType + "%' and " +
                        "ts.kuhinja like '%" + kitchen + "%' and " +
                        "ts.kupatilo like '%" + bathroom + "%'";

                for(Room room : availableRooms)
                {
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, room.getRoomID());
                    ResultSet res = stmt.executeQuery();
                    if(res.next())
                    {
                        String roomID = res.getString("soba_id");
                        String roomTypeID = res.getString("tip_sobe_id");
                        String name = res.getString("naziv");
                        int roomNumber = res.getInt("broj_sobe");
                        float price = res.getFloat("dnevna_cena");

                        filteredRooms.add(new Room(roomID, hotelID, roomTypeID, name, roomNumber, price));
                    }
                }
            }
            else
            {
                int beds = Integer.parseInt(numberOfBeds);
                String query = "select * " +
                        "from soba s join tip_sobe ts on s.tip_sobe_id = ts.tip_sobe_id " +
                        "where s.soba_id = ? and " +
                        "ts.tip_kreveta like '%" + bedType + "%' and " +
                        "ts.broj_kreveta = ? and " +
                        "ts.kuhinja like '%" + kitchen + "%' and " +
                        "ts.kupatilo like '%" + bathroom + "%'";

                for(Room room : availableRooms)
                {
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, room.getRoomID());
                    stmt.setInt(2, beds);
                    ResultSet res = stmt.executeQuery();
                    if(res.next())
                    {
                        String roomID = res.getString("soba_id");
                        String roomTypeID = res.getString("tip_sobe_id");
                        String name = res.getString("naziv");
                        int roomNumber = res.getInt("broj_sobe");
                        float price = res.getFloat("dnevna_cena");

                        filteredRooms.add(new Room(roomID, hotelID, roomTypeID, name, roomNumber, price));
                    }
                }
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return filteredRooms;
    }

    public static Room ReturnFirstAvailableRoom(String hotelID, String roomTypeName, String dateFrom)
    {
        ArrayList<Room> availableRooms = Room.ReturnAvailableRoomsInHotel(hotelID, roomTypeName, dateFrom);

        return availableRooms.get(0);
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public String getHotelID() {
        return hotelID;
    }

    public void setHotelID(String hotelID) {
        this.hotelID = hotelID;
    }

    public String getRoomTypeID() {
        return roomTypeID;
    }

    public void setRoomTypeID(String roomTypeID) {
        this.roomTypeID = roomTypeID;
    }

    public String getRoomTypeName() {
        return roomTypeName;
    }

    public void setRoomTypeName(String roomTypeName) {
        this.roomTypeName = roomTypeName;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public float getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(float pricePerNight) {
        this.pricePerNight = pricePerNight;
    }
}
