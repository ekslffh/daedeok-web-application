package kr.or.ddit.calculate;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Optional;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.or.ddit.enumpkg.OperatorType;

@WebServlet("/calculate/Case4ProcessServlet")
public class Case4ProcessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ObjectMapper mapper = new ObjectMapper();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
//		content-type: application/x-www-form-urlencoded; charset=UTF-8
//		content-type: application/json;charset=UTF-8
		String contentType = Optional.ofNullable(request.getContentType())
										.orElse("");
		
		int status = HttpServletResponse.SC_OK;
		CalculateVO target = null;
		if (contentType.contains("json")) {
			try (
				InputStream is = request.getInputStream();
			) {
				target = mapper.readValue(is, CalculateVO.class);
			}
		} else {
			try {
				String leftOp = request.getParameter("leftOp");
				String rightOp = request.getParameter("rightOp");
				String opParam = request.getParameter("opParam");
				
				double left = Double.parseDouble(leftOp);
				double right = Double.parseDouble(rightOp);
				OperatorType operator = OperatorType.valueOf(opParam);
				
				target = new CalculateVO();
				target.setLeftOp(left);
				target.setRightOp(right);
				target.setOpParam(operator);
			} catch (Exception e) {
				status = HttpServletResponse.SC_BAD_REQUEST;
				e.printStackTrace();
			}
		}
		
		response.setContentType("application/json;charset=UTF-8");
		
		try (
			PrintWriter out = response.getWriter();
		) {
//				out.println(expr);
			mapper.writeValue(out, target);
		}
	}

}
