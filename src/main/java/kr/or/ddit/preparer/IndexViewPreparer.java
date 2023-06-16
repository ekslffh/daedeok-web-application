package kr.or.ddit.preparer;

import java.util.HashMap;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

public class IndexViewPreparer implements ViewPreparer {

	@Override
	public void execute(Request req, AttributeContext arg1) {
		Map<String, Object> requestScope = req.getContext(Request.REQUEST_SCOPE);
		
		Map<String, String> welcomeMenu = new HashMap<>();
		welcomeMenu.put("menuURL", "https://www.naver.com");
		welcomeMenu.put("menuText", "네이버");
		requestScope.put("welcomeMenu", welcomeMenu);
	}

}
