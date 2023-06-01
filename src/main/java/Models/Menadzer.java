package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

    public static ArrayList<Menadzer> VratiMenadzereKojimaNijeDodeljenHotel()
    {
        ArrayList<Menadzer> menadzeri = new ArrayList<>();
        String upit = "select * " +
                "from korisnik k join radnik r on k.korisnik_id = r.korisnik_id " +
                "join menadzer m on m.korisnik_id = r.korisnik_id " +
                "where m.hotel_id is null";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            ResultSet rez = stmt.executeQuery();
            while(rez.next())
            {
                String menadzerID = rez.getString("korisnik_id");
                String ime = rez.getString("ime");
                String prezime = rez.getString("prezime");
                String email = rez.getString("email");
                String drzava = rez.getString("drzava");
                String grad = rez.getString("grad");
                String adresa = rez.getString("adresa");
                String brojTelefona = rez.getString("broj_telefona");
                String datumRodjenja = rez.getString("datum_rodjenja");
                String datumZaposlenja = rez.getString("datum_zaposlenja");

                menadzeri.add(new Menadzer(menadzerID, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja, datumZaposlenja, ""));
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return menadzeri;
    }

    public String getHotelID() {
        return hotelID;
    }
}
