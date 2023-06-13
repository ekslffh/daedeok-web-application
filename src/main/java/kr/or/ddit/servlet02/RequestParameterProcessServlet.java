package kr.or.ddit.servlet02;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/03/dataProcess.do")
public class RequestParameterProcessServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 1. getParameterNames() / getParameterValues()를 이용한 방법
//		Enumeration<String> parameterNames = req.getParameterNames();
//		while (parameterNames.hasMoreElements()) {
//			String parameterName = parameterNames.nextElement();
//			String[] parameterValues = req.getParameterValues(parameterName);
//				System.out.printf("%s : %s\n", parameterName, Arrays.toString(parameterValues));
//		}
		
		req.setCharacterEncoding("UTF-8");
		// 2. getParameterMap() / entrySet()을 이용한 방법
		Map<String, String[]> parameterMap = req.getParameterMap();
		for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
			String parameterName = entry.getKey();
			String[] values = entry.getValue();
			System.out.printf("%s : %s\n", parameterName, Arrays.toString(values));
		}
		
		String accept = req.getHeader("accept");
		String contentType = null;
		Object responseContent = null;
		if (accept.contains("json")) {
			// Native Object
			Map<String, Object> target = new HashMap<>();
			target.put("message", "요청 처리 완료. 결과 메시지 전송.");
			
			// Marcahlling
			contentType = "application/json;charset=UTF-8";
			ObjectMapper mapper = new ObjectMapper();
			responseContent = mapper.writeValueAsString(target);
		} else {
			contentType = "text/plain;charset=UTF-8";
			responseContent = "요청 처리 완료. 결과 메시지 전송.";
		}
		
//		Accept : text/html
		// Serialization
		resp.setContentType(contentType);
		try(
			PrintWriter out = resp.getWriter();
		) {
			out.println(Objects.toString(responseContent, ""));
		}
	}
}
