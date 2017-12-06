package koreatech.cse.domain;

import java.io.Serializable;
import java.util.Date;

public class Translate implements Serializable {
    private int id;

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    private String source;
    private String target;
    private String original; // Original
    private String translated; // Translated
    private int userid;
    private int favorite;
    private String date;


    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getOriginal() {
        return original;
    }

    public void setOriginal(String original) {
        this.original = original;
    }

    public String getTranslated() {
        return translated;
    }

    public void setTranslated(String translated) {
        this.translated = translated;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }


    public int getFavorite() {
        return favorite;
    }

    public void setFavorite(int favorite) {
        this.favorite = favorite;
    }


    public void setDate(Date date) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.date = sdf.format(date);
    }

    @Override
    public String toString() {
        return "Translate{" +
                "id=" + id +
                ", source='" + source + '\'' +
                ", target='" + target + '\'' +
                ", original='" + original + '\'' +
                ", translated='" + translated + '\'' +
                ", userid=" + userid +
                ", favorite=" + favorite +
                ", date='" + date + '\'' +
                '}';
    }
}
