package Utils;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class KorisnikMethods{
    static Connection conn = DBConnection.connectToDB();
    public static String generisiNoviKlijentID() {
        String ID = "K";
        int IDnumber = 1001;

        String upit = "select count(*) as brojKlijenata from klijent";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            ResultSet rez = stmt.executeQuery();

            if(rez.next())
            {
                int brojKlijenata = rez.getInt("brojKlijenata");
                IDnumber += brojKlijenata;
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return ID + IDnumber;
    }
}
