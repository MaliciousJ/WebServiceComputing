package koreatech.cse.domain;

import java.util.Date;

public class Translate {
    private int id;
    private String language;
    private String origin; // Original
    private String trans; // Translated
    private int userid;
    private boolean favorite;
    private String datetime;

    public int getId(int id) {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getTrans() {
        return trans;
    }

    public void setTrans(String trans) {
        this.trans = trans;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getuserid(int userid) {
        return userid;
    }

    public boolean isFavorite() {
        return favorite;
    }

    public void setFavorite(boolean favorite) {
        this.favorite = favorite;
    }

    public String getDatetime() {
        return datetime;
    }
    public void setDatetime(Date date) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.datetime = sdf.format(date);
    }

    @Override
    public String toString() {
        return "Translate{" +
                "id=" + id +
                ", language='" + language + '\'' +
                ", origin='" + origin + '\'' +
                ", trans='" + trans + '\'' +
                ", user_id=" + userid + '\'' +
                ", favorite='" + favorite + '\'' +
                ", datetime='" + datetime +
                '}';
    }
}
