package helper;

import java.sql.*;

public class ConnectionProvider {

    private static Connection con = null;

    public static Connection getConnection() {
        try {
            if (con == null) {

                Class.forName("com.mysql.cj.jdbc.Driver");

                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/correct_college", "root", "root");
              
            }
            return con;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
