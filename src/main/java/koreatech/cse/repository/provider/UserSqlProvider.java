package koreatech.cse.repository.provider;

import koreatech.cse.domain.Searchable;
import org.apache.ibatis.jdbc.SQL;

public class UserSqlProvider {

    public String findAllByProvider(final Searchable searchable) {
        return new SQL() {
            {
                SELECT("*");
                FROM("USERS");
                if(searchable.getName() != null) {
                    WHERE("NAME = #{name}");
                    if(searchable.getEmail() != null) {
                        OR();
                        WHERE("EMAIL = #{email}");
                    }
                }
                if(searchable.getOrderParam() != null) {

                    ORDER_BY(searchable.getOrderParam() + " DESC");
                }
            }
        }.toString();
    }
}
