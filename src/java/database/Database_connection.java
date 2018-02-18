package database;

import java.sql.*;

public class Database_connection {

    public Class c;
    public Connection cnn;

    public Database_connection() throws ClassNotFoundException, SQLException {
        c.forName("com.mysql.jdbc.Driver");
        cnn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_db", "root", "vicky");
        //   cnn = DriverManager.getConnection("jdbc:mysql://mariadb15859-saikiran.cloudhosting.rsaweb.co.za/online_db", "root", "BDGkro86104");      
    }
}
