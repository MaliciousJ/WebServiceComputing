package koreatech.cse.repository;


import koreatech.cse.domain.Searchable;
import koreatech.cse.domain.Translate;
import koreatech.cse.repository.provider.UserSqlProvider;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TranslateMapper {
    @Insert("INSERT INTO TRANSLATE (SOURCE, TARGET, ORIGINAL, TRANSLATED, USERID, FAVORITE, DATE) VALUES (#{source}, #{target}, #{original}, #{translated}, #{userid}, #{favorite}, #{date})")
    @SelectKey(statement = "SELECT LAST_INSERT_ID()", keyProperty = "id", before = false, resultType = int.class)
    void insert(Translate translate);

    @Update("UPDATE TRANSLATE SET SOURCE = #{source}, TARGET = #{target}, ORIGINAL = #{original}, TRANSLATED = #{translated}, USERID = #{userid}, FAVORITE = #{favorite} WHERE ID = #{id}")
    void update(Translate translate);

    @Select("SELECT * FROM TRANSLATE WHERE ID = #{id}")
    Translate findOne(@Param("id") int id);

    @Select("SELECT * FROM TRANSLATE WHERE SOURCE = #{source}")
    Translate findBySource(@Param("source") String source);

    @Select("SELECT * FROM TRANSLATE WHERE TARGET = #{target}")
    Translate findByTarget(@Param("target") String target);

    @Select("SELECT * FROM TRANSLATE WHERE SOURCE = #{source} AND TARGET = #{target}")
    Translate findByLanguage(@Param("source") String target, @Param("source") String source);

    @Select("SELECT * FROM TRANSLATE WHERE FAVORITE = #{favorite}")
    Translate findByFavorite(@Param("favorite") String favorite);

    @Delete("DELETE FROM TRANSLATE WHERE ID = #{id}")
    void delete(@Param("id") int id);

    @Select("SELECT * FROM TRANSLATE WHERE ORIGINAL = #{original} AND TRANSLATED = #{translated}")
    Translate searchByOrigTrans(Translate translate);

    @Update("UPDATE TRANSLATE SET FAVORITE = #{favorite} WHERE ID = #{id}")
    void updateCount(Translate translate);

    @SelectProvider(type = UserSqlProvider.class, method = "findAllByProvider")
    List<Translate> findByProvider(Searchable searchable);

    //@formatter off
    @Select("<script>"
            + "SELECT * FROM TRANSLATE"
            + "<if test='source != null'> WHERE SOURCE = #{source}</if>"
            + "<if test='source != null and target != null'> OR TARGET = #{target}</if>"
            + "<if test='orderParam != null'>ORDER BY ${orderParam} DESC</if>"
            + "</script>")
    //@formatter on
    List<Translate> findByScript(Searchable searchable);


}
