package kr.or.ddit.servlet02;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/02/gugudan.do")
public class GugudanServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int minDan = 2;
		int maxDan = 9;
		
		String minParam = req.getParameter("minDan");
		String maxParam = req.getParameter("maxDan");
		
		if (minParam != null && maxParam != null) {
			try {
				minDan = Integer.parseInt(minParam);
				maxDan = Integer.parseInt(maxParam);
			} catch (NumberFormatException e) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 요청입니다.");
				return;
			}
		}
		
		req.setAttribute("minDan", minDan);
		req.setAttribute("maxDan", maxDan);
		
		String logicalViewName = "02/gugudan";
		
		String viewName = "/" + logicalViewName + ".miles";
		req.getRequestDispatcher(viewName).forward(req, resp);
	}
}
