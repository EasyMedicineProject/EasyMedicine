package Utils;

import com.sun.org.apache.xpath.internal.SourceTree;

import java.sql.Connection;
import java.sql.DriverManager;
import static java.lang.System.out;

public class dbConnector {
    public static Connection createConnection(){
        Connection con= null ;
        System.out.println("DB Connection initialized.");
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/naturalmedicine?autoReconnect=true&useSSL=false", "root", "admivan2001");
            if(!con.isClosed()) out.println("Success");

        } catch (Exception e) {
            System.out.println(e);
        }
        return con;
    }
}
