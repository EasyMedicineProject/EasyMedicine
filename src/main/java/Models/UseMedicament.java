package Models;

import Utils.dbConnector;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class UseMedicament {
    private String username;
    private void setUsername(String username){ this.username = username; }

    private int medicamentId;
    private void setMedicamentId(int medicamentId){ this.medicamentId = medicamentId; }

    private String deadline;
    public String getDeadline(){ return deadline; }
    private void setDeadline(String deadline){ this.deadline = deadline; }

    public UseMedicament(String username, int medicamentId, String deadline){
        setUsername(username);
        setMedicamentId(medicamentId);
        setDeadline(deadline);
    }

    public UseMedicament(){
    }

    public void useCustomMedicament(String username, Date deadline, String medicamentName) throws SQLException, UnsupportedEncodingException {
        
        Connection conn;
        ResultSet usedMedicamentsResultSet;
        ResultSet checkRepeatResultSet;

        
        String insertQuery = "INSERT INTO users_medicaments_use(username, medicament_name, date_from,deadline) VALUES(?,?,?,?);";
        String getUsedMedicament = "SELECT medicaments_use FROM users WHERE username=? or email=?";
        String usedMedicamentsUpdate="UPDATE users SET medicaments_use=? WHERE username=? OR email=?";
        String checkRepeatQuery = "SELECT * FROM users_medicaments_use WHERE date_from=? AND deadline=? AND medicament_name=?;";
        String deleteQuery = "DELETE FROM users_medicaments_use WHERE date_from=? AND deadline=?  AND medicament_name=?;";
        medicamentName= URLDecoder.decode( medicamentName, "UTF-8" );
        


        try{
            System.out.println("UseMedicamentModel: In useMedicament method (try).");
            conn = dbConnector.createConnection();

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            String dateAsString = dateFormat.format(date);
            date = dateFormat.parse(dateAsString);
            System.out.println("Current date = " + dateFormat.format(date));
            Timestamp currentTimestamp = new java.sql.Timestamp(date.getTime());
            Timestamp deadlineTimestamp = new java.sql.Timestamp(deadline.getTime());
            System.out.println("After " + deadline + " days date = " + dateFormat.format(date));

           
           PreparedStatement preparedStmt = conn.prepareStatement(getUsedMedicament);
            preparedStmt.setString(1, username);
            preparedStmt.setString(2, username);
            usedMedicamentsResultSet= preparedStmt.executeQuery();

            preparedStmt = conn.prepareStatement(checkRepeatQuery);
            preparedStmt.setTimestamp(1, currentTimestamp);
            preparedStmt.setTimestamp(2, currentTimestamp);
            preparedStmt.setString(3, medicamentName);
            checkRepeatResultSet= preparedStmt.executeQuery();

            if(currentTimestamp.before(deadlineTimestamp)) {
                if (usedMedicamentsResultSet!=null) usedMedicamentsResultSet.next();
                System.out.println("in UPDATE if");
                preparedStmt = conn.prepareStatement(usedMedicamentsUpdate);
                preparedStmt.setString(1, usedMedicamentsResultSet.getString(1) + "," + medicamentName);
                preparedStmt.setString(2, username);
                preparedStmt.setString(3, username);
                preparedStmt.executeUpdate();
            }
            else {
                usedMedicamentsResultSet.close();
                preparedStmt.close();
                conn.close();
            }

            if(username!=null){
               
                if(currentTimestamp.before(deadlineTimestamp)){
                    System.out.println("im in if for inser");
                    preparedStmt = conn.prepareStatement(insertQuery);
                    preparedStmt.setString(1,username);
                    preparedStmt.setString(2,medicamentName);
                    preparedStmt.setTimestamp(3,currentTimestamp);
                    preparedStmt.setTimestamp(4,deadlineTimestamp);
                    preparedStmt.executeUpdate();
                }
                else{
                    usedMedicamentsResultSet.close();

                    preparedStmt.close();
                    conn.close();
                    
                }
                if(checkRepeatResultSet.next()) {
                    preparedStmt = conn.prepareStatement(deleteQuery);
                    preparedStmt.setTimestamp(1, currentTimestamp);
                    preparedStmt.setTimestamp(2, currentTimestamp);
                    preparedStmt.setString(3, medicamentName);
                    preparedStmt.executeUpdate();
                }
            }


            preparedStmt.close();
            conn.close();

        } catch (SQLException e) {
            System.out.println("im in catch 1");
            e.printStackTrace();
        } catch (ParseException e) {
            System.out.println("im in catch 2");
            e.printStackTrace();
        }
        
    }






    public boolean useMedicament(String username, Date deadline, String medicamentName) throws UnsupportedEncodingException {
        Connection conn;
       // ResultSet resultSet;
        ResultSet usedMedicamentsResultSet;
        ResultSet checkRepeatResultSet;

       // String selectQuery = "SELECT id FROM medicaments WHERE `name`=?;";
        String insertQuery = "INSERT INTO users_medicaments_use(username, medicament_name, date_from,deadline) VALUES(?,?,?,?);";
        String getUsedMedicament = "SELECT medicaments_use FROM users WHERE username=? or email=?";
        String usedMedicamentsUpdate="UPDATE users SET medicaments_use=? WHERE username=? OR email=?";
        String checkRepeatQuery = "SELECT * FROM users_medicaments_use WHERE date_from=? AND deadline=? AND medicament_name=?;";
        String deleteQuery = "DELETE FROM users_medicaments_use WHERE date_from=? AND deadline=?  AND medicament_name=?;";
        medicamentName= URLDecoder.decode( medicamentName, "UTF-8" );
        //int medicamentId=0;


        try{
            System.out.println("UseMedicamentModel: In useMedicament method (try).");
            conn = dbConnector.createConnection();

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            String dateAsString = dateFormat.format(date);
            date = dateFormat.parse(dateAsString);
            System.out.println("Current date = " + dateFormat.format(date));
            Timestamp currentTimestamp = new java.sql.Timestamp(date.getTime());
            Timestamp deadlineTimestamp = new java.sql.Timestamp(deadline.getTime());
            System.out.println("After " + deadline + " days date = " + dateFormat.format(date));

           /*PreparedStatement preparedStmt = conn.prepareStatement(selectQuery);
            preparedStmt.setString(1, medicamentName);
            resultSet= preparedStmt.executeQuery();
            System.out.println(resultSet.next());
            medicamentId=resultSet.getInt("id");*/

            PreparedStatement preparedStmt = conn.prepareStatement(getUsedMedicament);
            preparedStmt.setString(1, username);
            preparedStmt.setString(2, username);
            usedMedicamentsResultSet= preparedStmt.executeQuery();

            preparedStmt = conn.prepareStatement(checkRepeatQuery);
            preparedStmt.setTimestamp(1, currentTimestamp);
            preparedStmt.setTimestamp(2, currentTimestamp);
            preparedStmt.setString(3, medicamentName);
            checkRepeatResultSet= preparedStmt.executeQuery();

            if(currentTimestamp.before(deadlineTimestamp)) {
                if (usedMedicamentsResultSet!=null) usedMedicamentsResultSet.next();
                System.out.println("in UPDATE if");
                preparedStmt = conn.prepareStatement(usedMedicamentsUpdate);
                preparedStmt.setString(1, usedMedicamentsResultSet.getString(1) + "," + medicamentName);
                preparedStmt.setString(2, username);
                preparedStmt.setString(3, username);
                preparedStmt.executeUpdate();
            }
            else {
                usedMedicamentsResultSet.close();
               // resultSet.close();
                preparedStmt.close();
                conn.close();
                return false;
            }

            if(username!=null){
                System.out.println("UseMedicament Model: username = " + username);
                System.out.println("UseMedicament Model: medicamentName = " + medicamentName);
                System.out.println("UseMedicament Model: deadline = " + deadline);

                System.out.println("UseMedicament Model: username = " + username + " (insertQuery)");
                System.out.println("UseMedicament Model: medicamentName = " + medicamentName + " (insertQuery)");
                System.out.println("UseMedicament Model: currentTimestamp = " + currentTimestamp + " (insertQuery)");
                System.out.println("UseMedicament Model: deadlineTimestamp = " + deadlineTimestamp + " (insertQuery)");

                if(currentTimestamp.before(deadlineTimestamp)){
                    System.out.println("im in if for inser");
                    preparedStmt = conn.prepareStatement(insertQuery);
                    preparedStmt.setString(1,username);
                    preparedStmt.setString(2,medicamentName);
                    preparedStmt.setTimestamp(3,currentTimestamp);
                    preparedStmt.setTimestamp(4,deadlineTimestamp);
                    preparedStmt.executeUpdate();
                }
                else{
                    usedMedicamentsResultSet.close();
                    //resultSet.close();
                    preparedStmt.close();
                    conn.close();
                    return false;
                }
                if(checkRepeatResultSet.next()) {
                    preparedStmt = conn.prepareStatement(deleteQuery);
                    preparedStmt.setTimestamp(1, currentTimestamp);
                    preparedStmt.setTimestamp(2, currentTimestamp);
                    preparedStmt.setString(3, medicamentName);
                    preparedStmt.executeUpdate();
                }
            }

           // resultSet.close();
            preparedStmt.close();
            conn.close();

        } catch (SQLException e) {
            System.out.println("im in catch 1");
            e.printStackTrace();
        } catch (ParseException e) {
            System.out.println("im in catch 2");
            e.printStackTrace();
        }
        return true;
    }

    public void stopUsingMedicament(String username, String medicamentName) throws UnsupportedEncodingException {
        Connection conn;
        String updateUsersMedicamentsUseQuery = "UPDATE users_medicaments_use SET deadline = ? WHERE username = ? AND medicament_name = ? LIMIT 1;";
        String updateUsersQuery = "UPDATE users SET medicaments_use = REPLACE ((SELECT medicaments_use WHERE username = ?), ?, '') WHERE username = ?;";
        String checkRepeatQuery = "SELECT * FROM users_medicaments_use WHERE date_from=? AND deadline=? AND medicament_name=?;";
        String deleteQuery = "DELETE FROM users_medicaments_use WHERE date_from=? AND deadline=?  AND medicament_name=?;";
        medicamentName = URLDecoder.decode( medicamentName, "UTF-8" );
        ResultSet checkRepeatResultSet;

        try{
            conn = dbConnector.createConnection();

            if(username!=null){
                PreparedStatement preparedStmt;

                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date date = new Date();
                String dateAsString = dateFormat.format(date);
                System.out.println("DateAsString = " + dateAsString);
                date = dateFormat.parse(dateAsString);
                System.out.println("Stop using medicament: date = " + date);
                Timestamp newDeadline = new java.sql.Timestamp(date.getTime());

                System.out.println("UseMedicament Model: username = " + username);
                System.out.println("UseMedicament Model: medicamentName = " + medicamentName);
                System.out.println("UseMedicament Model: deadline = " + newDeadline);


                System.out.println("Before query");
                System.out.println("CurrentTimestamp = " + newDeadline);
                System.out.println("Medicament Name = " + medicamentName);

                preparedStmt = conn.prepareStatement(checkRepeatQuery);
                preparedStmt.setTimestamp(1, newDeadline);
                preparedStmt.setTimestamp(2, newDeadline);
                preparedStmt.setString(3, medicamentName);
                checkRepeatResultSet= preparedStmt.executeQuery();
                System.out.println("After query");

                if(checkRepeatResultSet.next()) {
                    System.out.println("in DELETE if");
                    preparedStmt = conn.prepareStatement(deleteQuery);
                    preparedStmt.setTimestamp(1, newDeadline);
                    preparedStmt.setTimestamp(2, newDeadline);
                    preparedStmt.setString(3, medicamentName);
                    preparedStmt.executeUpdate();
                }
                System.out.println("(Before query)DateAsString = " + dateAsString);
                preparedStmt = conn.prepareStatement(updateUsersMedicamentsUseQuery);
                preparedStmt.setString(1,dateAsString);
                preparedStmt.setString(2,username);
                preparedStmt.setString(3, medicamentName);
                preparedStmt.executeUpdate();

                preparedStmt = conn.prepareStatement(updateUsersQuery);
                preparedStmt.setString(1,username);
                preparedStmt.setString(2, "," + medicamentName);
                preparedStmt.setString(3, username);
                preparedStmt.executeUpdate();

                preparedStmt.close();
            }
            conn.close();

        }
        catch (SQLException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}