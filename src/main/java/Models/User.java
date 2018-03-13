package Models;

import Utils.dbConnector;
import sun.misc.BASE64Encoder;

import javax.jms.Session;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;


public class User {
    public void CreateRegistration(String email, String password, String username, String gender) throws SQLException, NoSuchAlgorithmException {

        Connection conn;

        String SHA256Password;

            conn = dbConnector.createConnection();

            SHA256Password = convertToSHA256(password);
            String query = " insert into users (email,password,username,gender)"
                    + " values (?, ?, ?, ?)";

            PreparedStatement preparedStmt = conn.prepareStatement(query);
            preparedStmt.setString(1, email);
            preparedStmt.setString(2, SHA256Password);
            preparedStmt.setString(3,username);
            preparedStmt.setString(4,gender);
            preparedStmt.executeUpdate();
        System.out.println("User.createRegistration Email = " + email);
        System.out.println("User.createRegistration Password = " + SHA256Password);
        System.out.println("User.createRegistration Username = " + username);
        System.out.println("User.createRegistration Gender = " + gender);
            preparedStmt.close();
            conn.close();

    }
    public static String convertToSHA256(String inputString) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(inputString.getBytes());
        byte byteData[] = md.digest();
        //convert the byte to hex format method 1
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < byteData.length; i++) {
            sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }
        return sb.toString();
    }


}

