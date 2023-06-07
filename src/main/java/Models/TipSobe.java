package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TipSobe {
    private String tipSobeID, naziv, tipKreveta, kuhinja, kupatilo, opis;
    private int brojKreveta;
    private boolean televizor;
    private static final Connection conn = DBConnection.connectToDB();

    public TipSobe() {
    }

    public TipSobe(String tipSobeID, String naziv, String tipKreveta, String kuhinja, String kupatilo, String opis, int brojKreveta, boolean televizor) {
        this.tipSobeID = tipSobeID;
        this.naziv = naziv;
        this.tipKreveta = tipKreveta;
        this.kuhinja = kuhinja;
        this.kupatilo = kupatilo;
        this.opis = opis;
        this.brojKreveta = brojKreveta;
        this.televizor = televizor;
    }

    public static ArrayList<TipSobe> VratiTipoveSoba(String naziv)
    {
        ArrayList<TipSobe> tipoviSoba = new ArrayList<>();
        String upit = "select * from tip_sobe where naziv like '%" + naziv + "%'";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            ResultSet rez = stmt.executeQuery();
            while(rez.next())
            {
                String id = rez.getString("tip_sobe_id");
                String nazivTipa = rez.getString("naziv");
                int brojKreveta = rez.getInt("broj_kreveta");
                String tipKreveta = rez.getString("tip_kreveta");
                String kuhinja = rez.getString("kuhinja");
                String kupatilo = rez.getString("kupatilo");
                boolean televizor = rez.getBoolean("televizor");
                String opis = rez.getString("opis");

                tipoviSoba.add(new TipSobe(id, nazivTipa, tipKreveta, kuhinja, kupatilo, opis, brojKreveta, televizor));
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return tipoviSoba;
    }

    public static TipSobe VratiDetaljeTipaSobe(String tipID)
    {
        TipSobe tipSobe = new TipSobe();
        String upit = "select * from tip_sobe where tip_sobe_id = ?";
        try
        {
            PreparedStatement stmt = conn.prepareStatement(upit);
            stmt.setString(1, tipID);
            ResultSet rez = stmt.executeQuery();
            if(rez.next())
            {
                String id = rez.getString("tip_sobe_id");
                String nazivTipa = rez.getString("naziv");
                int brojKreveta = rez.getInt("broj_kreveta");
                String tipKreveta = rez.getString("tip_kreveta");
                String kuhinja = rez.getString("kuhinja");
                String kupatilo = rez.getString("kupatilo");
                boolean televizor = rez.getBoolean("televizor");
                String opis = rez.getString("opis");

                tipSobe = new TipSobe(id, nazivTipa, tipKreveta, kuhinja, kupatilo, opis, brojKreveta, televizor);
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return tipSobe;
    }

    public static String GenerisiTipSobeID(int brojKreveta, String tipKreveta, String kuhinja, String kupatilo, boolean tv)
    {
        String id = "TS";
        int dodatakIDBrojKreveta = 0;

        switch (tipKreveta)
        {
            case "Single":
            {
                id += brojKreveta + "S";
                break;
            }
            case "Double":
            {
                dodatakIDBrojKreveta = brojKreveta / 2;
                id += dodatakIDBrojKreveta + "D";
                break;
            }
            case "Single + Double":
            {
                dodatakIDBrojKreveta = brojKreveta / 3;
                id += dodatakIDBrojKreveta + "SD";
                break;
            }
            case "Queen":
            {
                dodatakIDBrojKreveta = brojKreveta / 2;
                id += dodatakIDBrojKreveta + "Q";
                break;
            }
            case "King":
            {
                dodatakIDBrojKreveta = brojKreveta / 2;
                id += dodatakIDBrojKreveta + "K";
                break;
            }
        }

        switch (kuhinja)
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

        switch (kupatilo)
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

    public static String GenerisiNazivTipaSobe(int brojKreveta, String tipKreveta, String kuhinja, String kupatilo)
    {
        String naziv = "";
        int dodatakNazivBrojKreveta = 0;

        switch (tipKreveta)
        {
            case "Single":
            {
                naziv += brojKreveta + "x Single ";
                if(brojKreveta > 1)
                    naziv += "Beds | ";
                else
                    naziv += "Bed | ";
                break;
            }
            case "Double":
            {
                dodatakNazivBrojKreveta = brojKreveta / 2;
                naziv += dodatakNazivBrojKreveta + "x Double ";
                if(dodatakNazivBrojKreveta > 1)
                    naziv += "Beds | ";
                else
                    naziv += "Bed | ";
                break;
            }
            case "Single + Double":
            {
                dodatakNazivBrojKreveta = brojKreveta / 3;
                naziv += dodatakNazivBrojKreveta + "x Single/Double ";
                if(dodatakNazivBrojKreveta > 1)
                    naziv += "Combos | ";
                else
                    naziv += "Combo | ";
                break;
            }
            case "Queen":
            {
                dodatakNazivBrojKreveta = brojKreveta / 2;
                naziv += dodatakNazivBrojKreveta + "x Queen Size ";
                if(dodatakNazivBrojKreveta > 1)
                    naziv += "Beds | ";
                else
                    naziv += "Bed | ";
                break;
            }
            case "King":
            {
                dodatakNazivBrojKreveta = brojKreveta / 2;
                naziv += dodatakNazivBrojKreveta + "x King Size ";
                if(dodatakNazivBrojKreveta > 1)
                    naziv += "Beds | ";
                else
                    naziv += "Bed | ";
                break;
            }
        }

        switch (kuhinja)
        {
            case "None":
            {
                naziv += "No Kitchen | ";
                break;
            }
            case "Semi-furnished":
            {
                naziv += "Semi-furnished Kitchen | ";
                break;
            }
            case "Fully-furnished":
            {
                naziv += "Fully-furnished Kitchen | ";
                break;
            }
        }

        switch (kupatilo)
        {
            case "Shower":
            {
                naziv += "Shower";
                break;
            }
            case "Bath":
            {
                naziv += "Bath";
                break;
            }
        }

        return naziv;
    }

    public String getTipSobeID() {
        return tipSobeID;
    }

    public void setTipSobeID(String tipSobeID) {
        this.tipSobeID = tipSobeID;
    }

    public String getNaziv() {
        return naziv;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    public String getTipKreveta() {
        return tipKreveta;
    }

    public void setTipKreveta(String tipKreveta) {
        this.tipKreveta = tipKreveta;
    }

    public String getKuhinja() {
        return kuhinja;
    }

    public void setKuhinja(String kuhinja) {
        this.kuhinja = kuhinja;
    }

    public String getKupatilo() {
        return kupatilo;
    }

    public void setKupatilo(String kupatilo) {
        this.kupatilo = kupatilo;
    }

    public String getOpis() {
        return opis;
    }

    public void setOpis(String opis) {
        this.opis = opis;
    }

    public int getBrojKreveta() {
        return brojKreveta;
    }

    public void setBrojKreveta(int brojKreveta) {
        this.brojKreveta = brojKreveta;
    }

    public boolean isTelevizor() {
        return televizor;
    }

    public void setTelevizor(boolean televizor) {
        this.televizor = televizor;
    }
}
