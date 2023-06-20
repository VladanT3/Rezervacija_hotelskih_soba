package Models;

import Database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Client extends User {
    protected int numberOfPoints;
    private static final Connection conn = DBConnection.connectToDB();

    public Client(String id, String firstName, String lastName, String email, String country, String city, String address, String phoneNumber, String birthday, int numberOfPoints) {
        super(id, firstName, lastName, email, country, city, address, phoneNumber, birthday);
        this.numberOfPoints = numberOfPoints;
    }

    public static String GenerateNewClientID() {
        String ID = "K";
        int IDnumber = 0;

        String query = "select ko.korisnik_id " +
                "from korisnik ko join klijent kl on ko.korisnik_id = kl.korisnik_id " +
                "order by datum_dodavanja desc " +
                "limit 1";
        try
        {
            if(conn != null)
            {
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet res = stmt.executeQuery();

                if(res.next())
                {
                    String lastClientID = res.getString("korisnik_id");
                    IDnumber = Integer.parseInt(lastClientID.substring(1)) + 1;
                }
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }

        return ID + IDnumber;
    }

    public Reservation ReturnDetailsOfClosestReservation()
    {
        Reservation reservation = new Reservation();
        String query = "select * " +
                "from rezervacija " +
                "where klijent_id = ? and " +
                "datediff(datum_pocetka, curdate()) = " +
                "(select min(datediff(datum_pocetka, curdate())) " +
                "from rezervacija " +
                "where klijent_id = ?)";
        try
        {
            if(conn != null)
            {
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, id);
                stmt.setString(2, id);
                ResultSet res = stmt.executeQuery();
                if(res.next())
                {
                    String reservationID = res.getString("rezervacija_id");
                    String clientID = res.getString("klijent_id");
                    String roomID = res.getString("soba_id");
                    String dateFrom = res.getString("datum_pocetka");
                    String dateTo = res.getString("datum_isteka");
                    float price = res.getFloat("cena");

                    reservation = new Reservation(reservationID, clientID, roomID, dateFrom, dateTo, price);
                }
            }
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }

        return reservation;
    }

    public int getNumberOfPoints() {
        return numberOfPoints;
    }

    public void setNumberOfPoints(int numberOfPoints) {
        this.numberOfPoints = numberOfPoints;
    }
}
