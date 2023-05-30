package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Rezervacija {
    protected String rezervacijaID, klijentID, sobaID, datumPocetka, datumIsteka;
    protected float cena;
    private static final Connection conn = DBConnection.connectToDB();

    public Rezervacija() {
    }

    public Rezervacija(String rezervacijaID, String klijentID, String sobaID, String datumPocetka, String datumIsteka, float cena) {
        this.rezervacijaID = rezervacijaID;
        this.klijentID = klijentID;
        this.sobaID = sobaID;
        this.datumPocetka = datumPocetka;
        this.datumIsteka = datumIsteka;
        this.cena = cena;
    }

    public Hotel VratiDetaljeHotelaUKomJeRezervacija()
    {
        Hotel hotel = new Hotel();
        String upit = "select * from hotel h join soba s on h.hotel_id = s.hotel_id where soba_id = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, sobaID);
            ResultSet rez = stmt.executeQuery();
            if(rez.next())
            {
                hotel.setId(rez.getString("hotel_id"));
                hotel.setMenadzerId(rez.getString("menadzer_id"));
                hotel.setNaziv(rez.getString("naziv"));
                hotel.setDrzava(rez.getString("drzava"));
                hotel.setGrad(rez.getString("grad"));
                hotel.setBrojZvezdica(rez.getInt("broj_zvezdica"));
                hotel.setBrojParkingMesta(rez.getInt("broj_parking_mesta"));
                hotel.setOpis(rez.getString("opis"));
            }
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }

        return hotel;
    }

    public int VratiBrojSobeURezervaciji()
    {
        int brojSobe = 0;
        String upit = "select broj_sobe from soba where soba_id = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, sobaID);
            ResultSet rez = stmt.executeQuery();
            if(rez.next())
            {
                brojSobe = rez.getInt("broj_sobe");
            }
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }

        return brojSobe;
    }

    public void setRezervacijaID(String rezervacijaID) {
        this.rezervacijaID = rezervacijaID;
    }

    public void setKlijentID(String klijentID) {
        this.klijentID = klijentID;
    }

    public void setSobaID(String sobaID) {
        this.sobaID = sobaID;
    }

    public String getRezervacijaID() {
        return rezervacijaID;
    }

    public String getKlijentID() {
        return klijentID;
    }

    public String getSobaID() {
        return sobaID;
    }

    public String getDatumPocetka() {
        return datumPocetka;
    }

    public void setDatumPocetka(String datumPocetka) {
        this.datumPocetka = datumPocetka;
    }

    public String getDatumIsteka() {
        return datumIsteka;
    }

    public void setDatumIsteka(String datumIsteka) {
        this.datumIsteka = datumIsteka;
    }

    public float getCena() {
        return cena;
    }

    public void setCena(float cena) {
        this.cena = cena;
    }
}
