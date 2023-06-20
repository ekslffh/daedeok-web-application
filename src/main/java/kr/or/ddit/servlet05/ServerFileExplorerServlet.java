package kr.or.ddit.servlet05;

import java.io.File;
import java.io.IOException;
import java.text.MessageFormat;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/server")
public class ServerFileExplorerServlet extends HttpServlet {
	private ServletContext application;
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		application = getServletContext();
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String rootUrl = Optional.ofNullable(req.getParameter("target"))
								.filter((t)-> !t.isEmpty())
								.orElse("/");
		String realPath = application.getRealPath(rootUrl);
		File targetFolder = new File(realPath);
		
		int status = 200;
		String message = null;
		if (!targetFolder.exists()) {
			status = 404;
			message = MessageFormat.format("{0} 해당 자원은 존재하지 않습니다.", rootUrl);
		} else if (targetFolder.isFile()) {
			status = 400;
			message = MessageFormat.format("{0} 해당 자원은 디렉토리가 아닙니다.", rootUrl);
		}
		
		if (status != 200) {
			resp.sendError(status, message);
			return;
		}
		
		File[] listFiles = targetFolder.listFiles((d, n) -> true);
		
		List<FileAdapter> children = Stream.of(listFiles)
											.map((f) -> {
												try {
													return new FileAdapter(f, application);
												} catch (IOException e) {
													// 예외 전환 (checked -> unchecked), wrapper pattern
													throw new RuntimeException(e);
												}
											}).collect(Collectors.toList());
		
		req.setAttribute("listFiles", children);
		
		String logicalViewName = "server/explorer";
		String viewName = "/" + logicalViewName + ".tiles";
		req.getRequestDispatcher(viewName).forward(req, resp);
	}
}
