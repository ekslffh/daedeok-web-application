package kr.or.ddit.servlet01;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 서블릿
 * ? 웹상에서 발생하는 요청을 받고, 동적인 응답을 생성할 수 있는 자바 객체가 가져야 하는 조건에 대한 명세화 --> HttpServlet
 * 
 * 서블릿 스펙에서 주요 객체
 * 1. HttpServlet : callback 메소드
 * 2. HttpServletRequest : http 규칙에 따라 패키징된 요청에 대한 정보
 * 3. HttpServletResponse : http 규칙에 따라 패키징 될 응답에 대한 정보
 * 4. HttpSession : 하나의 클라이언트(에이전트)에 대한 정보를 가진 객체.
 * 5. ServletContext(싱글톤) : 서버와 컨텍스트에 대한 정보
 * 6. ServletConfig : 하나의 서블릿에 대한 메타 정보
 * 
 * 톰캣(WAS, Web Container, Servlet Container, JSP Container, Middle ware)의 역할
 * 		container ? 내부에서 관리되는 객체의 샘명주기 관리자.
 * 		servlet container ? 내부에서 관리되는 servlet의 샘명주기 관리자.,
 * 			서블릿 컨테이너는 확장 CGI 방식에 따라 하나의 요청을 하나의 쓰레드로 처리함.
 *  
 * 			일반적인 컨테이너의 특징
 * 			1) 싱글톤 구조로 서블릿을 관리함.
 * 			2) 생명주기를 관리하는 과정에서 여러가지 상황에 대한 콜백 구조를 가짐. 
 * 
 * 생명주기 : init, destroy
 * 요청 : service, doXXX
 */
@WebServlet("/desc") // ConventionOverConfiguration 패러다임.
public class DescriptionServlet extends HttpServlet {
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		System.out.printf("%s 서블릿 초기화\n", this.getClass().getSimpleName());
	}
	
	@Override // http request method에 따른 분기자
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("서비스 실행");
		// super.service(req, resp);
		System.out.println("서비스 종료");
	}
		
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet 실행");
		resp.getWriter().printf(Thread.currentThread().getName());
	}
	
	@Override
	public void destroy() {
		System.out.printf("%s 서블릿 소멸\n", this.getClass().getSimpleName());
	}
}
