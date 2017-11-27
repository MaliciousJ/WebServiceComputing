package koreatech.cse.repository;


import koreatech.cse.domain.Book;
import koreatech.cse.domain.Searchable;
import koreatech.cse.domain.User;
import koreatech.cse.repository.provider.UserSqlProvider;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookMapper {
    @Insert("INSERT INTO BOOKS (TITLE, AUTHOR, PAGE, USERID) VALUES (#{title}, #{author}, #{page}, #{userid})")
    @SelectKey(statement = "SELECT LAST_INSERT_ID()", keyProperty = "id", before = false, resultType = int.class)
    void insert(Book book);

    @Update("UPDATE BOOKS SET TITLE = #{title}, AUTHOR = #{author}, PAGE = #{page}, USERID = #{userid} WHERE ID = #{id}")
    void update(Book book);

    @Select("SELECT * FROM BOOKS WHERE ID = #{id}")
    Book findOne(@Param("id") int id);

    @Select("SELECT * FROM BOOKS WHERE TITLE = #{title}")
    Book findByTitle(@Param("title") String Title);

    @Delete("DELETE FROM BOOKS WHERE ID = #{id}")
    void delete(@Param("id") int id);

    @SelectProvider(type = UserSqlProvider.class, method = "findAllByProvider")
    List<Book> findByProvider(Searchable searchable);

    //@formatter off
    @Select("<script>"
            + "SELECT * FROM BOOKS"
            + "<if test='title != null'> WHERE TITLE = #{title}</if>"
            + "<if test='title != null and author != null'> OR AUTHOR = #{author}</if>"
            + "<if test='orderParam != null'>ORDER BY ${orderParam} DESC</if>"
            + "</script>")
    //@formatter on
    List<Book> findByScript(Searchable searchable);
}
