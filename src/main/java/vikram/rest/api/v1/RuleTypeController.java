package vikram.rest.api.v1;

import java.util.Arrays;
import java.util.List;
import javax.annotation.security.RolesAllowed;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import vikram.rest.v1.model.RuleType;

@RestController
@RequestMapping("/rest/api/v1")
@RolesAllowed("ROLE_ADMIN")
public class RuleTypeController {

  @RequestMapping(value = "/ruletype", method= RequestMethod.GET)

  public List<RuleType> getRuleTypes() {
    return Arrays.asList(
        new RuleType("rule1", "abcdef"),
        new RuleType("rule2", "fedcba")
    );

  }
}
