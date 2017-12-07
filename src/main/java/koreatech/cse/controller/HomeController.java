package koreatech.cse.controller;

import koreatech.cse.domain.Searchable;
import koreatech.cse.domain.Translate;
import koreatech.cse.repository.TranslateMapper;
import koreatech.cse.service.TranslateService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
public class HomeController {
    @Inject
    private TranslateMapper translateMapper;

    @Value("${env.text}")
    private String env;

    @ModelAttribute("name")
    private String getName() {
        return "IamHomeControllerModelAttribute";
    }

    @RequestMapping
    public String home(Model model) {
        model.addAttribute("textFromController", "World");
        return "hello";
    }

    @RequestMapping(value = "/translate", method = RequestMethod.POST)
    public String requestMapping() {
        return "/translate";
    }

    @RequestMapping(value = "/memo", method = RequestMethod.GET)
    public String memo(Model model, @RequestParam(required=false) String source, @RequestParam(required=false) String target, @RequestParam(required=false) String order)
    {
        Searchable searchable = new Searchable();
        searchable.setSource(source);
        searchable.setTarget(target);
        searchable.setFavorite(1);
        searchable.setOrderParam("favorite");

        List<Translate> translates = translateMapper.findByScript(searchable);
        System.out.println("translates = " + translates);
        model.addAttribute("translate", translates);

        return "/memo";
    }

}
