package kr.or.ddit.servlet04;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/model2/sample")
public class Model2SampleControllerServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String contentPage = "/WEB-INF/views/02/gugudan.jsp";
		req.setAttribute("contentPage", contentPage);
		
		String viewName = "/WEB-INF/views/template.jsp";
		req.getRequestDispatcher(viewName).forward(req, resp);
	}
}
