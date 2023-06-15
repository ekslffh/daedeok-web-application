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

@WebServlet("/bts")
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
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("memList", memList);
		String logicalViewName = "bts/formView";
		String viewName = "/" + logicalViewName + ".miles";
		req.getRequestDispatcher(viewName).forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String member = req.getParameter("member");
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
			String viewName = "/" + logicalViewName + ".miles";
			req.getRequestDispatcher(viewName).forward(req, resp);
		}
	}
}
