package kr.or.ddit.view;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

/**
 * Json Content 를 생성하기 위한 view layer
 *
 */
@WebServlet("/jsonView.view")
public class JsonViewServlet extends HttpServlet {
	
	private ObjectMapper mapper = new ObjectMapper()
								.registerModule(new JavaTimeModule())
								.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json;charset=UTF-8");
		
		Map<String, Object> target = new HashMap<>();
		Enumeration<String> attrNames = req.getAttributeNames();
		while (attrNames.hasMoreElements()) {
			String name = (String) attrNames.nextElement();
			Object value = req.getAttribute(name);
			target.put(name, value);
		}
		
		try (
			PrintWriter out = resp.getWriter();
		) {
			mapper.writeValue(out, target);
		}
	}
}
