package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Menadzer extends Radnik{
    protected String hotelID;
    private static final Connection conn = DBConnection.connectToDB();

    public Menadzer() {
    }

    public Menadzer(String id, String ime, String prezime, String email, String drzava, String grad, String adresa, String brojTelefona, String datumRodjenja, String datumZaposlenja, String hotelID) {
        super(id, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja, datumZaposlenja);
        this.hotelID = hotelID;
    }

    public String VratiNazivDodeljenogHotela()
    {
        String upit = "select naziv from hotel where menadzer_id = ?";
        String nazivHotela = "";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, id);
            ResultSet rez = stmt.executeQuery();
            if(rez.next())
                nazivHotela = rez.getString("naziv");
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
        return nazivHotela;
    }

    public String getHotelID() {
        return hotelID;
    }
}
