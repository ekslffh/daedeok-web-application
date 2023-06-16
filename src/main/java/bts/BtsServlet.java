package bts;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/bts", "/bts/B001", "/bts/B002", "/bts/B003", "/bts/B004", "/bts/B005", "/bts/B006", "/bts/B007"})
public class BtsServlet extends HttpServlet {
	private Map<String, String[]> memList;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		memList = new HashMap<>();
		memList.put("B001", new String[] {"RM", "bts/rm"});
		memList.put("B002", new String[] {"진", "bts/jin"});
		memList.put("B003", new String[] {"슈가", "bts/suga"});
		memList.put("B004", new String[] {"제이홉", "bts/jhop"});
		memList.put("B005", new String[] {"지민", "bts/jimin"});
		memList.put("B006", new String[] {"뷔", "bts/bui"});
		memList.put("B007", new String[] {"정국", "bts/jungkuk"});
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String servletPath = req.getServletPath();
		String pathInfo = servletPath.substring(servletPath.lastIndexOf('/') + 1);
		
		if (pathInfo.equals("bts")) {
			// 시작 셀렉트 화면 보여주기
			req.setAttribute("memList", memList);
			String logicalViewName = "bts/formView";
			String viewName = "/" + logicalViewName + ".tiles";
			req.getRequestDispatcher(viewName).forward(req, resp);
		} else {
			// 특정 멤버에 대해서 보여주기
			String member = pathInfo;
			int status = 200;
			String logicalViewName = null;
			
			if (member == null || member.isEmpty()) {
				status = HttpServletResponse.SC_BAD_REQUEST;
			} else if (!memList.containsKey(member)) {
				status = HttpServletResponse.SC_NOT_FOUND;
			} else {
				String[] bloodInfo = memList.get(member);
				logicalViewName = bloodInfo[1];
			}
			
			if (status != 200) {
				resp.sendError(status);
			} else {
				String viewName = "/" + logicalViewName + ".tiles";
				req.getRequestDispatcher(viewName).forward(req, resp);
			}
		}
	}
}
