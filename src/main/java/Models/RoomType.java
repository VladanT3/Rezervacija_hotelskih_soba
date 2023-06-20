package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class RoomType {
    private String roomTypeID, name, bedType, kitchen, bathroom, description;
    private int numberOfBeds;
    private boolean television;
    private static final Connection conn = DBConnection.connectToDB();

    public RoomType() {
    }

    public RoomType(String roomTypeID, String name, String bedType, String kitchen, String bathroom, String description, int numberOfBeds, boolean television) {
        this.roomTypeID = roomTypeID;
        this.name = name;
        this.bedType = bedType;
        this.kitchen = kitchen;
        this.bathroom = bathroom;
        this.description = description;
        this.numberOfBeds = numberOfBeds;
        this.television = television;
    }

    public static ArrayList<RoomType> ReturnRoomTypes(String name)
    {
        ArrayList<RoomType> roomTypes = new ArrayList<>();
        String query = "select * from tip_sobe where naziv like '%" + name + "%'";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet res = stmt.executeQuery();
            while(res.next())
            {
                String id = res.getString("tip_sobe_id");
                String roomTypeName = res.getString("naziv");
                int numberOfBeds = res.getInt("broj_kreveta");
                String bedType = res.getString("tip_kreveta");
                String kitchen = res.getString("kuhinja");
                String bathroom = res.getString("kupatilo");
                boolean television = res.getBoolean("televizor");
                String desc = res.getString("opis");

                roomTypes.add(new RoomType(id, roomTypeName, bedType, kitchen, bathroom, desc, numberOfBeds, television));
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return roomTypes;
    }

    public static RoomType ReturnRoomTypeDetails(String typeID)
    {
        RoomType roomType = new RoomType();
        String query = "select * from tip_sobe where tip_sobe_id = ?";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, typeID);
            ResultSet res = stmt.executeQuery();
            if(res.next())
            {
                String id = res.getString("tip_sobe_id");
                String roomTypeName = res.getString("naziv");
                int numberOfBeds = res.getInt("broj_kreveta");
                String bedType = res.getString("tip_kreveta");
                String kitchen = res.getString("kuhinja");
                String bathroom = res.getString("kupatilo");
                boolean television = res.getBoolean("televizor");
                String desc = res.getString("opis");

                roomType = new RoomType(id, roomTypeName, bedType, kitchen, bathroom, desc, numberOfBeds, television);
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return roomType;
    }

    public static String GenerateRoomTypeID(int numberOfBeds, String bedType, String kitchen, String bathroom, boolean tv)
    {
        String id = "TS";
        int numberOfBedsAdditionToID;

        switch (bedType)
        {
            case "Single":
            {
                id += numberOfBeds + "S";
                break;
            }
            case "Double":
            {
                numberOfBedsAdditionToID = numberOfBeds / 2;
                id += numberOfBedsAdditionToID + "D";
                break;
            }
            case "Single + Double":
            {
                numberOfBedsAdditionToID = numberOfBeds / 3;
                id += numberOfBedsAdditionToID + "SD";
                break;
            }
            case "Queen":
            {
                numberOfBedsAdditionToID = numberOfBeds / 2;
                id += numberOfBedsAdditionToID + "Q";
                break;
            }
            case "King":
            {
                numberOfBedsAdditionToID = numberOfBeds / 2;
                id += numberOfBedsAdditionToID + "K";
                break;
            }
        }

        switch (kitchen)
        {
            case "None":
            {
                id += "0K";
                break;
            }
            case "Semi-furnished":
            {
                id += "1K";
                break;
            }
            case "Fully-furnished":
            {
                id += "2K";
                break;
            }
        }

        switch (bathroom)
        {
            case "Shower":
            {
                id += "Shw";
                break;
            }
            case "Bath":
            {
                id += "Bth";
                break;
            }
        }

        if(tv)
            id += "1TV";
        else
            id += "0TV";

        return id;
    }

    public static String GenerateRoomTypeName(int numberOfBeds, String bedType, String kitchen, String bathroom)
    {
        String name = "";
        int numberOfBedsAddition;

        switch (bedType)
        {
            case "Single":
            {
                name += numberOfBeds + "x Single ";
                if(numberOfBeds > 1)
                    name += "Beds | ";
                else
                    name += "Bed | ";
                break;
            }
            case "Double":
            {
                numberOfBedsAddition = numberOfBeds / 2;
                name += numberOfBedsAddition + "x Double ";
                if(numberOfBedsAddition > 1)
                    name += "Beds | ";
                else
                    name += "Bed | ";
                break;
            }
            case "Single + Double":
            {
                numberOfBedsAddition = numberOfBeds / 3;
                name += numberOfBedsAddition + "x Single/Double ";
                if(numberOfBedsAddition > 1)
                    name += "Combos | ";
                else
                    name += "Combo | ";
                break;
            }
            case "Queen":
            {
                numberOfBedsAddition = numberOfBeds / 2;
                name += numberOfBedsAddition + "x Queen Size ";
                if(numberOfBedsAddition > 1)
                    name += "Beds | ";
                else
                    name += "Bed | ";
                break;
            }
            case "King":
            {
                numberOfBedsAddition = numberOfBeds / 2;
                name += numberOfBedsAddition + "x King Size ";
                if(numberOfBedsAddition > 1)
                    name += "Beds | ";
                else
                    name += "Bed | ";
                break;
            }
        }

        switch (kitchen)
        {
            case "None":
            {
                name += "No Kitchen | ";
                break;
            }
            case "Semi-furnished":
            {
                name += "Semi-furnished Kitchen | ";
                break;
            }
            case "Fully-furnished":
            {
                name += "Fully-furnished Kitchen | ";
                break;
            }
        }

        switch (bathroom)
        {
            case "Shower":
            {
                name += "Shower";
                break;
            }
            case "Bath":
            {
                name += "Bath";
                break;
            }
        }

        return name;
    }

    public String getRoomTypeID() {
        return roomTypeID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBedType() {
        return bedType;
    }

    public String getKitchen() {
        return kitchen;
    }

    public void setKitchen(String kitchen) {
        this.kitchen = kitchen;
    }

    public String getBathroom() {
        return bathroom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getNumberOfBeds() {
        return numberOfBeds;
    }

    public boolean isTelevision() {
        return television;
    }

    public void setTelevision(boolean television) {
        this.television = television;
    }
}
