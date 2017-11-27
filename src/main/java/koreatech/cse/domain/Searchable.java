package koreatech.cse.domain;


public class Searchable {
    private String name;
    private String email;
    private String orderParam;
    private String author;
    private String title;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOrderParam() {
        return orderParam;
    }

    public void setOrderParam(String orderParam) {
        this.orderParam = orderParam;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
