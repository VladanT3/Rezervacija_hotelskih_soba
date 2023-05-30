package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Klijent extends Korisnik{
    protected int brojPoena;
    private static final Connection conn = DBConnection.connectToDB();

    public Klijent() {
    }

    public Klijent(String id, String ime, String prezime, String email, String drzava, String grad, String adresa, String brojTelefona, String datumRodjenja, int brojPoena) {
        super(id, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja);
        this.brojPoena = brojPoena;
    }

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

    public Rezervacija VratiDetaljeNajblizeRezervacije()
    {
        Rezervacija rezervacija = new Rezervacija();
        String upit = "select * " +
                "from rezervacija " +
                "where klijent_id = ? and " +
                "datediff(datum_pocetka, curdate()) = " +
                "(select min(datediff(datum_pocetka, curdate())) " +
                "from rezervacija " +
                "where klijent_id = ?)";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, id);
            stmt.setString(2, id);
            ResultSet rez = stmt.executeQuery();
            if(rez.next())
            {
                rezervacija.setRezervacijaID(rez.getString("rezervacija_id"));
                rezervacija.setKlijentID(rez.getString("klijent_id"));
                rezervacija.setSobaID(rez.getString("soba_id"));
                rezervacija.setDatumPocetka(rez.getString("datum_pocetka"));
                rezervacija.setDatumIsteka(rez.getString("datum_isteka"));
                rezervacija.setCena(rez.getFloat("cena"));
            }
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }

        return rezervacija;
    }

    public int getBrojPoena() {
        return brojPoena;
    }

    public void setBrojPoena(int brojPoena) {
        this.brojPoena = brojPoena;
    }
}
