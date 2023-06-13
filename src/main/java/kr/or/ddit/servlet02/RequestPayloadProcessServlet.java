package kr.or.ddit.servlet02;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.or.ddit.vo.SampleFormVO;

@WebServlet("/03/payloadDataProcess.do")
public class RequestPayloadProcessServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ObjectMapper mapper = new ObjectMapper();

		req.setCharacterEncoding("UTF-8");

		try (
			InputStream is = req.getInputStream();
		) {
//			JSON -> Native - Unmarshalling(+deserialization)
			SampleFormVO target = mapper.readValue(is, SampleFormVO.class);
			System.out.println(target);
		}
		
		String accept = req.getHeader("accept");
		String contentType = null;
		Object responseContent = null;
		if (accept.contains("json")) {
			// Native Object
			Map<String, Object> target = new HashMap<>();
			target.put("message", "요청 처리 완료. 결과 메시지 전송.");
			
			// Marshalling
			contentType = "application/json;charset=UTF-8";
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
