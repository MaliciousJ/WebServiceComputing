package koreatech.cse.controller;

import koreatech.cse.domain.Searchable;
import koreatech.cse.domain.Translate;
import koreatech.cse.domain.User;
import koreatech.cse.repository.TranslateMapper;
import koreatech.cse.service.TranslateService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping("/translate") // /translate/list, /translate/register에서 테스트 가능
public class TranslateController {
    @Inject
    private TranslateMapper translateMapper;
    @Inject
    private TranslateService translateService;

    @RequestMapping("/register")
    public String register(Model model) {
        Translate translate = new Translate();
        model.addAttribute("Translate", translate);
        return "/translate/register";
    }

    //@PreAuthorize("hasRole('ROLE_USER')")
    @Transactional
    @RequestMapping(value="/register", method= RequestMethod.POST)
    public String register(@ModelAttribute Translate trans) {
        //trans.setUserid(User.current().getId());
        trans.setFavorite(false);
        trans.setDate(new java.util.Date());
        translateService.register(trans);
        return "redirect:/translate/list";
    }
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model, @RequestParam(required=false) String source, @RequestParam(required=false) String target, @RequestParam(required=false) boolean favorite, @RequestParam(required=false) String order) {
        Searchable searchable = new Searchable();
        searchable.setSource(source);
        searchable.setTarget(target);
        searchable.setFavorite(favorite);
        searchable.setOrderParam(order);

        List<Translate> translates = translateMapper.findByScript(searchable);
        System.out.println("translates = " + translates);
        model.addAttribute("translate", translates);

        return "/translate/list";

    }

    @Transactional
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(@RequestParam int id)
    {
       // User user = User.current();

       // if(user.getId() == translateMapper.findOne(id).getUserid())
            translateMapper.delete(id);

        return "redirect:/tranlate/register";
    }
}
