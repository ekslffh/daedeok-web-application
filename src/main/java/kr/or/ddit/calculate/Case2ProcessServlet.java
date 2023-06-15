package kr.or.ddit.calculate;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.enumpkg.OperatorType;

@WebServlet("/calculate/Case2ProcessServlet")
public class Case2ProcessServlet extends HttpServlet {
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
			
			Map<String, Object> target = new HashMap<String, Object>();
			target.put("expr", expr);
			target.put("result", result);
			target.put("left", right);
			target.put("right", right);
			target.put("operator", operator);
			
			response.setContentType("application/json;charset=UTF-8");
			
			try (
				PrintWriter out = response.getWriter();
			) {
//				out.println(expr);
				new ObjectMapper().writeValue(out, target);
			}
		} catch (Exception e) {
			response.sendError(400);
		}
	}

}
