package kr.or.ddit.calculate.model2;

import java.io.IOException;
import java.io.InputStream;
import java.util.Optional;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.or.ddit.calculate.CalculateVO;
import kr.or.ddit.enumpkg.OperatorType;

@WebServlet("/calculate/Case6ProcessServlet")
public class Case6ProcessServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String viewName = "/WEB-INF/views/calculate/case6Form.jsp";
		req.getRequestDispatcher(viewName).forward(req, resp);
	}
	
	private ObjectMapper mapper = new ObjectMapper();
	
	private CalculateVO dataFromParameter(HttpServletRequest request) throws Exception {
		String leftOp = request.getParameter("leftOp");
		String rightOp = request.getParameter("rightOp");
		String opParam = request.getParameter("opParam");
		
		double left = Double.parseDouble(leftOp);
		double right = Double.parseDouble(rightOp);
		OperatorType operator = OperatorType.valueOf(opParam);
		
		CalculateVO target = new CalculateVO();
		target.setLeftOp(left);
		target.setRightOp(right);
		target.setOpParam(operator);
		
		return target;
	}
	
	private CalculateVO dataFromJsonPayload(HttpServletRequest request) throws IOException {
		try (
			InputStream is = request.getInputStream();
		) {
			return mapper.readValue(is, CalculateVO.class);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String requestContentType = Optional.ofNullable(request.getContentType()).orElse("");
		
		try {
			
			CalculateVO target = null; // Model
			if (requestContentType.contains("json")) {
				target = dataFromJsonPayload(request);
			} else if (requestContentType.contains("xml")) {
				response.sendError(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE);
				return;
			} else {
				target = dataFromParameter(request);
			}
			
			request.setAttribute("calculate", target);
			
			String accept = request.getHeader("accept");
			String viewName = null;
			if (accept.contains("json")) {
				viewName = "/jsonView.view";
			} else if (accept.contains("xml")) {
				response.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE);
				return;
			} else {
				viewName = "/WEB-INF/views/calculate/calculateResult.jsp";
			}
			request.getRequestDispatcher(viewName).forward(request, response);
			
		} catch (Exception e) {
			response.sendError(400);
		}
	}
}
