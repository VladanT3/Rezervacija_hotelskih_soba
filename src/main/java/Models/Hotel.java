package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Hotel {
    protected String id, menadzerId, naziv, drzava, grad, opis, nazivSlike;
    protected int brojZvezdica, brojParkingMesta;
    private static final Connection conn = DBConnection.connectToDB();

    public Hotel() {
    }

    public Hotel(String id, String menadzerId, String naziv, String drzava, String grad, String opis, String nazivSlike, int brojZvezdica, int brojParkingMesta) {
        this.id = id;
        this.menadzerId = menadzerId;
        this.naziv = naziv;
        this.drzava = drzava;
        this.grad = grad;
        this.opis = opis;
        this.nazivSlike = nazivSlike;
        this.brojZvezdica = brojZvezdica;
        this.brojParkingMesta = brojParkingMesta;
    }

    public static ArrayList<Hotel> VratiHotele(String nazivHotela)
    {
        ArrayList<Hotel> hoteli = new ArrayList<>();
        String upit = "select * from hotel where naziv like '%" + nazivHotela + "%'";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            ResultSet rez = stmt.executeQuery();

            while(rez.next())
            {
                String hotelID = rez.getString("hotel_id");
                String menadzerID = rez.getString("menadzer_id");
                String naziv = rez.getString("naziv");
                String drzava = rez.getString("drzava");
                String grad = rez.getString("grad");
                String opis = rez.getString("opis");
                String nazivSlike = rez.getString("naziv_slike");
                int zvezdice = rez.getInt("broj_zvezdica");
                int parking = rez.getInt("broj_parking_mesta");
                hoteli.add(new Hotel(hotelID, menadzerID, naziv, drzava, grad, opis, nazivSlike, zvezdice, parking));
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return hoteli;
    }

    public static Hotel VratiDetaljeHotela(String hotelID)
    {
        Hotel hotel = new Hotel();
        String upit = "select * from hotel where hotel_id = ?";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, hotelID);
            ResultSet rez = stmt.executeQuery();
            if(rez.next())
            {
                String menadzerID = rez.getString("menadzer_id");
                String naziv = rez.getString("naziv");
                String drzava = rez.getString("drzava");
                String grad = rez.getString("grad");
                String opis = rez.getString("opis");
                String nazivSlike = rez.getString("naziv_slike");
                int zvezdice = rez.getInt("broj_zvezdica");
                int parking = rez.getInt("broj_parking_mesta");
                hotel = new Hotel(hotelID, menadzerID, naziv, drzava, grad, opis, nazivSlike, zvezdice, parking);
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return hotel;
    }

    public static String GenerisiNoviHotelID()
    {
        String hotelID = "H";
        int dodatakID = 11;
        String upit = "select count(*) as brojHotela from hotel";

        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            ResultSet rez = stmt.executeQuery();
            if(rez.next())
            {
                dodatakID += rez.getInt("brojHotela");
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return hotelID + dodatakID;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMenadzerId() {
        return menadzerId;
    }

    public void setMenadzerId(String menadzerId) {
        this.menadzerId = menadzerId;
    }

    public String getNaziv() {
        return naziv;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    public String getDrzava() {
        return drzava;
    }

    public void setDrzava(String drzava) {
        this.drzava = drzava;
    }

    public String getGrad() {
        return grad;
    }

    public void setGrad(String grad) {
        this.grad = grad;
    }

    public String getOpis() {
        return opis;
    }

    public void setOpis(String opis) {
        this.opis = opis;
    }

    public int getBrojZvezdica() {
        return brojZvezdica;
    }

    public void setBrojZvezdica(int brojZvezdica) {
        this.brojZvezdica = brojZvezdica;
    }

    public int getBrojParkingMesta() {
        return brojParkingMesta;
    }

    public void setBrojParkingMesta(int brojParkingMesta) {
        this.brojParkingMesta = brojParkingMesta;
    }

    public String getNazivSlike() {
        return nazivSlike;
    }

    public void setNazivSlike(String nazivSlike) {
        this.nazivSlike = nazivSlike;
    }
}
