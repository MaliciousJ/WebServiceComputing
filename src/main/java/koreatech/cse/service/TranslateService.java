package koreatech.cse.service;

import koreatech.cse.domain.Translate;
import koreatech.cse.repository.TranslateMapper;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.Date;

@Service
public class TranslateService {
    @Inject
    private TranslateMapper translateMapper;


    public Boolean register(Translate trans) {
        if(trans.getLanguage() == null || trans.getOriginal() ==  null)
            return false;

        translateMapper.insert(trans);
        System.out.println("Translate registered : " + new Date() + " | " + trans.getOriginal() + " |");
        return true;
    }
}
