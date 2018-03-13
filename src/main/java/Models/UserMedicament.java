package Models;

import java.util.ArrayList;
import java.util.List;

public class UserMedicament {
    private String medicamentName;
    public String getMedicamentName(){return this.medicamentName;}
    private void setMedicamentName(String medicamentName){this.medicamentName=medicamentName;}

    private String dateFrom;
    public String getDateFrom(){return this.dateFrom;}
    private void setDateFrom(String dateFrom){this.dateFrom=dateFrom;}

    private String deadline;
    public String getDeadline(){return this.deadline;}
    private void setDeadline(String deadline){this.deadline=deadline;}


    public UserMedicament(String medicamentName, String dateFrom, String deadline){
        List<Commentary> UserMedicaments = new ArrayList<>();
        setMedicamentName(medicamentName);
        setDateFrom(dateFrom);
        setDeadline(deadline);
    }
}
