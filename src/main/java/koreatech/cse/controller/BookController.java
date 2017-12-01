package koreatech.cse.controller;

import koreatech.cse.domain.Searchable;
import koreatech.cse.domain.Book;
import koreatech.cse.domain.User;
import koreatech.cse.repository.BookMapper;
import koreatech.cse.service.BookService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;

@Controller
@RequestMapping("/book")
public class BookController {
    @Inject
    private BookMapper bookMapper;
    @Inject
    private BookService bookService;

    @PreAuthorize("hasRole('ROLE_USER')")
    @RequestMapping("/register")
    public String register(Model model) {
        Book book = new Book();
        model.addAttribute("book", book);
        return "/book/register";
    }

    @PreAuthorize("hasRole('ROLE_USER')")
    @Transactional
    @RequestMapping(value="/register", method= RequestMethod.POST)
    public String signup(@ModelAttribute Book book) {
        book.setUserid(User.current().getId());
        bookService.register(book);
        return "redirect:/book/list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model, @RequestParam(required=false) String title, @RequestParam(required=false) String author, @RequestParam(required=false) String order) {
        Searchable searchable = new Searchable();
        searchable.setTitle(title);
        searchable.setAuthor(author);
        searchable.setOrderParam(order);
        //model.addAttribute("users", userMapper.findByProvider(searchable));
        model.addAttribute("books", bookMapper.findByScript(searchable));
        return "/book/list";
    }


    /* 구현 실패.
    * Admin 권한으로 삭제시키는 것은 성공했으나, 아예 권한 요구를 전부 삭제했음에도 권한을 요구하는 문제가 발생하여
    * 유저 권한으로 삭제 기능에 아예 접근하지 문제를 해소하는 데 실패하였다.
    *
    * 모든 코드를 전부 지우고 전처리기까지 전부 지우고 리턴만 남겼음에도 문제가 발생. */
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
    @Transactional
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(@RequestParam int id)
    {
        User user = User.current();

        if(user.getId() == bookMapper.findOne(id).getUserid())
            bookMapper.delete(id);
        else
            deleteForce(id);

        return "redirect:/book/list";
    }


    @PreAuthorize("hasRole('ROLE_ADMIN')")
    private void deleteForce(@RequestParam int id)
    {
        bookMapper.delete(id);
    }

}
