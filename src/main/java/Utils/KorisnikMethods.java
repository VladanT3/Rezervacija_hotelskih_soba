package Utils;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class KorisnikMethods{
    static Connection conn = DBConnection.connectToDB();
    public static String generisiNoviKorisnikID() {
        String ID = "K";
        int IDnumber = 1001;

        String upit = "select count(*) as brojKupaca from kupac";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            ResultSet rez = stmt.executeQuery();

            if(rez.next())
            {
                int brojKupaca = rez.getInt("brojKupaca");
                IDnumber += brojKupaca;
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return ID + IDnumber;
    }
}
