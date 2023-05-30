package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Klijent extends Korisnik{
    protected int brojPoena;

    public Klijent() {
    }

    public Klijent(String id, String ime, String prezime, String email, String drzava, String grad, String adresa, String brojTelefona, String datumRodjenja, int brojPoena) {
        super(id, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja);
        this.brojPoena = brojPoena;
    }

    public static String generisiNoviKlijentID() {
        Connection conn = DBConnection.connectToDB();
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

    public int getBrojPoena() {
        return brojPoena;
    }

    public void setBrojPoena(int brojPoena) {
        this.brojPoena = brojPoena;
    }
}
