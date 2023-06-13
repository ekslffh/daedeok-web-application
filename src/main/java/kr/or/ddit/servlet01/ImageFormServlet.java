package kr.or.ddit.servlet01;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.MessageFormat;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/imageForm1.do")
public class ImageFormServlet extends HttpServlet {
	
	private ServletContext application;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		application = getServletContext();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String folderPath = application.getInitParameter("mediaFolder");
		File folder = new File(folderPath);
		
		String[] imageFiles = folder.list((d, n) -> {
			String mime = application.getMimeType(n);
			return mime != null && mime.startsWith("image/");
		});
		
		StringBuilder html = new StringBuilder();
		
		html.append("<html>                                         ");
		html.append("	<body>                                      ");
		html.append(MessageFormat.format("<form action=''{0}/image.do''>", req.getContextPath()));
		html.append("			<select name='image' onchange='this.form.submit()'>               ");
		for (String tmp : imageFiles) {
			html.append(MessageFormat.format("<option>{0}</option>", tmp));
		}
		html.append("			</select>                           ");
//		html.append("			<button type='submit'>전송</button> ");
		html.append("		</form>                                 ");
		html.append("	</body>                                     ");
		html.append("</html>										");
		
		
		
		resp.setContentType("text/html; charset=utf-8");
		// try~With~resource(since java 1.7) : auto close 특성을 가진 문법
		try( 
			// Closeable 객체 선언 구문
			PrintWriter out = resp.getWriter();
		) {
			out.println(html);
		}
		
//		PrintWriter out = null;
//		try {
//			out = resp.getWriter();
//			out.println(html);
//		} finally {
//			out.close();
//		}
	}
}
