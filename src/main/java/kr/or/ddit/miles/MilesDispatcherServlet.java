package kr.or.ddit.miles;

import java.io.IOException;
import java.io.InputStream;
import java.util.Optional;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MilesDispatcherServlet extends HttpServlet {
	
	private Properties mileConfig;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		System.out.printf("%s 서블릿 초기화\n", this.getClass().getName());
		
		String configLocation = Optional.ofNullable(config.getInitParameter("configLocation"))
				.orElseThrow(() -> new ServletException("configLocation 서블릿 파라미터 누락"));
		
		try (
			InputStream is = this.getClass().getResourceAsStream(configLocation);
		) {
			mileConfig = new Properties();
			mileConfig.load(is);
		} catch (IOException e) {
			// 예외 전환 (IOException -> ServletException)
			throw new ServletException(e);
		}
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		ServletConfig config =  getServletConfig();
		
		String template = Optional.ofNullable(config.getInitParameter("template"))
				.orElseThrow(() -> new ServletException("template 이라는 서블릿 파라미터 누락"));
		
		mileConfig.forEach((k, v) -> req.setAttribute(k.toString(), v));
		
		String servletPath = req.getServletPath();
		int lastIdx = servletPath.lastIndexOf(".miles");
		
		String logicalViewName = servletPath.substring(1, lastIdx);
		
		String prefix = "/WEB-INF/views/";
		String suffix = ".jsp";
		
		String contentPage = prefix + logicalViewName + suffix;
		req.setAttribute("contentPage", contentPage);
		
		req.getRequestDispatcher(template).forward(req, resp);
	}
}
