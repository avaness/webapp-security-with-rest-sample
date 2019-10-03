package vikram;

import javax.servlet.annotation.WebServlet;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@org.springframework.stereotype.Controller
@WebServlet
public class Controller {
  @RequestMapping(value = "/", method = RequestMethod.GET)
  public ModelAndView main(){
    return new ModelAndView("index");
    // GET request "/" returns index.jsp through dispatcher-servlet
  }
}
