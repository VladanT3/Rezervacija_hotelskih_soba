package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection conn;

    public static Connection connectToDB(){
        try
        {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteli_projekat", "root", "");
        }
        catch (SQLException ex)
        {
            return null;
        }
        return conn;
    }
}
