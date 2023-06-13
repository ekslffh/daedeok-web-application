package kr.or.ddit.calculate;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Objects;
import java.util.Optional;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.or.ddit.enumpkg.OperatorType;

/**
 * 1. request parameter / html response
 * 2. request parameter / json response
 * 
 * 3. request json payload / html response
 * 4. request json payload / json response
 *
 */
@WebServlet("/calculate/Case5ProcessServlet")
public class Case5ProcessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
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
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String requestContentType = Optional.ofNullable(request.getContentType()).orElse("");
		
		try {
			
			CalculateVO target = null;
			if (requestContentType.contains("json")) {
				target = dataFromJsonPayload(request);
			} else if (requestContentType.contains("xml")) {
				// 서버가 사용할 수 없는 데이터 형식으로 왔어
				response.sendError(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE);
				return;
			} else {
				target = dataFromParameter(request);
			}
			
			String accept = request.getHeader("accept");
			String responseContentType = null;
			Object content = null;
			if (accept.contains("json")) {
				responseContentType = "application/json;charset=UTF-8";
				System.out.println("target: " + target);
				content = mapper.writeValueAsString(target);
				System.out.println("content: " + content);
			} else if (accept.contains("xml")) {
				// 서버가 보낼수 없는 데이터타입으로 요청이 옴.
				response.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE);
				return;
			} else {
				responseContentType = "text/html;charset=UTF-8";
				content = target.getExpr();
			}
			
			response.setContentType(responseContentType);
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
