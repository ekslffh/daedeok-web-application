package kr.or.ddit.servlet04;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bloodType")
public class BloodTypeServlet extends HttpServlet {
	private Map<String, String[]> bloodType;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		bloodType = new HashMap<>();
		bloodType.put("BT01", new String[] {"A형", "blood/a"});
		bloodType.put("BT02", new String[] {"B형", "blood/b"});
		bloodType.put("BT03", new String[] {"AB형", "blood/ab"});
		bloodType.put("BT04", new String[] {"O형", "blood/o"});
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("bloodType", bloodType);
		
		String logicalViewName = "blood/formView";
		String viewName = "/" + logicalViewName + ".miles";
		req.getRequestDispatcher(viewName).forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String code = req.getParameter("blood");
		int status = 200;
		String logicalViewName = null;
		
		if (code == null || code.isEmpty()) {
			status = HttpServletResponse.SC_BAD_REQUEST;
		} else if (!bloodType.containsKey(code)) {
			status = HttpServletResponse.SC_NOT_FOUND;
		} else {
			String[] bloodInfo = bloodType.get(code);
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
