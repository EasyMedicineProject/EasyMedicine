package Models;

import Utils.dbConnector;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class LoginModel {

    public String authenticateLogin(String email, String password) throws UnsupportedEncodingException {
        Connection conn;
        ResultSet resultSet = null;
        String DBemail = "";
        String DBpassword = "";
        String DBusername = "";
        String SHA256Password;
        String users="users";

        try {
            conn = dbConnector.createConnection();
            SHA256Password=convertToSHA256(password);
            String query = "SELECT * FROM users";

            PreparedStatement preparedStmt = conn.prepareStatement(query);
          resultSet= preparedStmt.executeQuery(query);
            while (resultSet.next()) {
                /*byte ptext[] = resultSet.getString("email").getBytes("ISO-8859-1");
                DBemail = new String(ptext, "UTF-8");
                ptext = resultSet.getString("password").getBytes("ISO-8859-1");
                DBpassword = new String(ptext, "UTF-8");
                ptext = resultSet.getString("username").getBytes("ISO-8859-1");
                DBusername = new String(ptext, "UTF-8");*/

                DBemail = resultSet.getString("email");
                DBpassword = resultSet.getString("password");
                DBusername = resultSet.getString("username");

                System.out.println("Email = " + email);
                System.out.println("Password = " + password);
                System.out.println("DBEmail = " + DBemail);
                System.out.println("DBUsername = " + DBusername);
                System.out.println("DBPassword = " + DBpassword);

                //TO DO Register check for duplicate users
                if((email.equals(DBemail) && SHA256Password.equals(DBpassword)) ||
                        (email.equals(DBusername) && SHA256Password.equals(DBpassword))) {
                    resultSet.close();
                    preparedStmt.close();
                    conn.close();
                    return DBusername;

                }

            }
            resultSet.close();
            preparedStmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return "FAIL";

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

    public String getEmail(String username) throws SQLException {
        Connection conn=null;
        ResultSet resultSet=null;
        PreparedStatement preparedStmt=null;
        try {
            conn = dbConnector.createConnection();
            String emailQuery = "SELECT email FROM users WHERE username=?";

            preparedStmt = conn.prepareStatement(emailQuery);
            preparedStmt.setString(1, username);
            resultSet= preparedStmt.executeQuery();

            resultSet.next();
            return resultSet.getString("email");

    }
    catch (SQLException e) {
            e.printStackTrace();
        }
        resultSet.close();
        preparedStmt.close();
        conn.close();
        return null;
    }

    public String getGender(String username) throws SQLException {
        Connection conn=null;
        ResultSet resultSet=null;
        PreparedStatement preparedStmt=null;
        try {
            conn = dbConnector.createConnection();
            String emailQuery = "SELECT gender FROM users WHERE username=?";

            preparedStmt = conn.prepareStatement(emailQuery);
            preparedStmt.setString(1, username);
            resultSet= preparedStmt.executeQuery();

            resultSet.next();
            return resultSet.getString("gender");

        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        resultSet.close();
        preparedStmt.close();
        conn.close();
        return null;
    }
}