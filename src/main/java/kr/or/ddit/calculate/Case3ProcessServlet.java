package kr.or.ddit.calculate;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.enumpkg.OperatorType;

@WebServlet("/calculate/Case3ProcessServlet")
public class Case3ProcessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String leftOp = request.getParameter("leftOp");
		String rightOp = request.getParameter("rightOp");
		String opParam = request.getParameter("opParam");
		
		try {
			double left = Double.parseDouble(leftOp);
			double right = Double.parseDouble(rightOp);
			OperatorType operator = OperatorType.valueOf(opParam);
			double result = operator.biOperate(left, right);
			
			String expr = operator.expression(left, right);
			
			// native
			Map<String, Object> target = new HashMap<String, Object>();
			target.put("expr", expr);
			target.put("result", result);
			target.put("left", right);
			target.put("right", right);
			target.put("operator", operator);
			
			String accept = request.getHeader("accept");
			String contentType = null;
			Object content = null;
			if (accept.contains("json")) {
				contentType = "application/json;charset=UTF-8";
				ObjectMapper mapper = new ObjectMapper();
				content = mapper.writeValueAsString(target);
			} else if (accept.contains("xml")) {
				response.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE);
				return;
			} else {
				contentType = "text/html;charset=UTF-8";
				content = target.get("expr");
			}
			
			response.setContentType(contentType);
			try (
				PrintWriter out = response.getWriter();
			) {
				out.println(Objects.toString(content, ""));
			}
		} catch (Exception e) {
			response.sendError(400);
		}
	}

}
