package koreatech.cse.domain;

import java.io.Serializable;
import java.util.Date;

public class Translate implements Serializable {
    private int id;
    private String language;
    private String original; // Original
    private String translated; // Translated
    private int userid;

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

    private boolean favorite;
    private String date;

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


    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }



    public boolean isFavorite() {
        return favorite;
    }

    public void setFavorite(boolean favorite) {
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
                ", language='" + language + '\'' +
                ", origin='" + original + '\'' +
                ", trans='" + translated + '\'' +
                ", userid=" + userid + '\'' +
                ", favorite='" + favorite + '\'' +
                ", datetime='" + date +
                '}';
    }
}
