package Models;

import Utils.dbConnector;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class PasswordChange {
    public void changePassword(String username, String currentPassword, String newPassword) {
        Connection conn;
        ResultSet resultSet = null;
        String DBemail = "";
        String DBpassword = "";
        String DBusername = "";

        try {
            conn = dbConnector.createConnection();
            currentPassword=convertToSHA256(currentPassword);
            String selectQuery = "SELECT *FROM users";
            PreparedStatement preparedStmt = conn.prepareStatement(selectQuery);
            resultSet= preparedStmt.executeQuery(selectQuery);
            while (resultSet.next()) {
                DBemail = resultSet.getString("email");
                DBpassword = resultSet.getString("password");
                DBusername = resultSet.getString("username");
                //TO DO Register check for duplicate users
                if((username.equals(DBemail) && currentPassword.equals(DBpassword)) ||
                        (username.equals(DBusername) && currentPassword.equals(DBpassword))) {
                    String query = " UPDATE users SET password=? WHERE username=? OR email=?";

                    preparedStmt = conn.prepareStatement(query);
                    preparedStmt.setString(1, convertToSHA256(newPassword));
                    preparedStmt.setString(2, username);
                    preparedStmt.setString(3,username);
                    preparedStmt.executeUpdate();
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
