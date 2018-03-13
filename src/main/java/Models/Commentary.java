package Models;

import java.util.ArrayList;
import java.util.List;

public class Commentary {
    private String content;
    public String getContent(){return this.content;}
    private void setContent(String content){this.content=content;}

    private String username;
    public String getUsername(){return this.username;}
    private void setUsername(String username){this.username=username;}

    public Commentary(String content,String username){
        List<Commentary> comments = new ArrayList<>();
        setContent(content);
        setUsername(username);
    }
}
