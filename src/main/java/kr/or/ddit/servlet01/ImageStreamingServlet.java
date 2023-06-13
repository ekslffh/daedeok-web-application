package kr.or.ddit.servlet01;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ImageStreamingServlet extends HttpServlet {
	
	private String folderPath;
	private ServletContext application;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		application = getServletContext();
		
		folderPath = application.getInitParameter("mediaFolder");
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fileName = req.getParameter("image");
		
		if (fileName == null || fileName.isEmpty()) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		File imageFile = new File(folderPath, fileName);
		
		if (!imageFile.exists()) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND);
//			imageFile = new File(folderPath, "noImage.png");
			return;
		}
		
//		MIME(Multipuposed Internet Mail Extension)
//		mime => main타입/sub타입
		String mime = getServletContext().getMimeType(fileName);
		
		if (mime == null || !mime.startsWith("image/")) {
			resp.sendError(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE);
			return;
		}
		
		resp.setContentType(mime);
		resp.setContentLengthLong(imageFile.length());

		FileInputStream fis = null;
		OutputStream os = null;
		try {
			fis = new FileInputStream(imageFile);
			os = resp.getOutputStream();
//     		stream(byte/char) copy
			byte[] buffer = new byte[1024];
			int cnt = -1; // EOF, EOS 문자 (-1, null)
			while ((cnt = fis.read(buffer)) != -1) {
				os.write(buffer, 0, cnt);
			}
		} finally {
			if (fis != null) 
				fis.close();
			if (os != null) 
				os.close();
		}

//      1. request 입력
//		2. 처리
//		3. response 출력
	}
}
