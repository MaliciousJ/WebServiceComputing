package koreatech.cse.repository;


import koreatech.cse.domain.Book;
import koreatech.cse.domain.Translate;
import koreatech.cse.domain.Searchable;
import koreatech.cse.repository.provider.UserSqlProvider;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TranslateMapper {
    @Insert("INSERT INTO TRANSLATE (LANGUAGE, ORIGINAL, TRANSLATED, USERID, FAVORITE, DATETIME) VALUES (#{language}, #{origin}, #{trans}, #{userid}, #(favorite), #(datetime))")
    @SelectKey(statement = "SELECT LAST_INSERT_ID()", keyProperty = "id", before = false, resultType = int.class)
    void insert(Translate translate);

    @Update("UPDATE TRANSLATE SET LANGUAGE = #{language}, ORIGINAL = #{origin}, TRANSLATED = #{trans}, USERID = #{userid}, FAVORITE = #(favorite) WHERE ID = #{id}")
    void update(Translate translate);

    @Select("SELECT * FROM TRANSLATE WHERE ID = #{id}")
    Translate findOne(@Param("id") int id);

    @Select("SELECT * FROM TRANSLATE WHERE USERID = #{userid}")
    Translate findByTitle(@Param("title") String Title);

    @Delete("DELETE FROM TRANSLATE WHERE ID = #{id}")
    void delete(@Param("id") int id);

    @SelectProvider(type = UserSqlProvider.class, method = "findAllByProvider")
    List<Translate> findByProvider(Searchable searchable);

    //@formatter off
    @Select("<script>"
            + "SELECT * FROM TRANSLATE"
            + "<if test='language != null'> WHERE LANGUAGE = #{language}</if>"
            + "<if test='language != null and favorite != null'> OR FAVORITE = #{author}</if>"
            + "<if test='orderParam != null'>ORDER BY ${orderParam} DESC</if>"
            + "</script>")
    //@formatter on
    List<Translate> findByScript(Searchable searchable);
}
