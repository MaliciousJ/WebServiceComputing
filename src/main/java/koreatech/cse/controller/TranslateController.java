package koreatech.cse.controller;

import koreatech.cse.domain.Searchable;
import koreatech.cse.domain.Translate;
import koreatech.cse.repository.TranslateMapper;
import koreatech.cse.service.TranslateService;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
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

        String source = trans.getSource(); // 번역할 언어
        String target = trans.getTarget(); // 번역결과 언어

        trans.setFavorite(false);
        trans.setDate(new java.util.Date());
        trans.setTranslated(translate_Naver(source, target, trans.getOriginal(), "NMT"));

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
    @RequestMapping(value = "/listForTest", method = RequestMethod.GET)
    public String listForTest(Model model, @RequestParam(required=false) String source, @RequestParam(required=false) String target, @RequestParam(required=false) boolean favorite, @RequestParam(required=false) String order) {
        Searchable searchable = new Searchable();
        searchable.setSource(source);
        searchable.setTarget(target);
        searchable.setFavorite(favorite);
        searchable.setOrderParam(order);

        List<Translate> translates = translateMapper.findByScript(searchable);
        System.out.println("translates = " + translates);
        model.addAttribute("translate", translates);

        return "/translate/listForTest";

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

    public String translate_Naver(String source, String target, String original, final String KIND){
        //trans.setUserid(User.current().getId());
        String clientId = "XrGbQvmHd8WcGPKUWI7F";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "wmEiG9iXmw";//애플리케이션 클라이언트 시크릿값";
        String apiURL = null;
        if( KIND == "NMT" )
            apiURL = "https://openapi.naver.com/v1/language/translate";
        else if ( KIND == "SMT" )
            apiURL = "https://openapi.naver.com/v1/language/translate";

        try {
            String text = URLEncoder.encode(original, "UTF-8"); // 번역할 문장 입력
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);

            // post request
            String postParams = "source=" + source + "&target=" + target + "&text=" + text;
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;

            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                System.out.println("success 200");
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
                System.out.println("error 200");
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            System.out.println(response.toString());
            String responseStr = response.toString();

            int start_idx = responseStr.indexOf("translatedText") + 17;
            int end_idx = responseStr.indexOf("srcLangType") - 3;
            responseStr = responseStr.substring(start_idx, end_idx);
            return responseStr;
            // 번역결과 문장
        } catch (Exception e) {
            System.out.println(e);
            System.out.println("here");
        }
        return null;
    }

}
