package koreatech.cse.service;

import koreatech.cse.domain.Authority;
import koreatech.cse.domain.Book;
import koreatech.cse.domain.User;
import koreatech.cse.repository.AuthorityMapper;
import koreatech.cse.repository.BookMapper;
import koreatech.cse.repository.UserMapper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.Date;
import java.util.List;

@Service
public class BookService{
    @Inject
    private BookMapper bookMapper;


    public Boolean register(Book book) {
        if(book.getAuthor() == null || book.getTitle() ==  null)
            return false;

        bookMapper.insert(book);
        System.out.println("book registered :" + new Date());
        return true;
    }
}
