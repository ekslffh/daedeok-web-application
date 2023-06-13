package kr.or.ddit.servlet03;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.util.Locale;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 특정 년도와 월, 로케일, 시간대 파라미터를 이용해 달력을 처리하는 컨트롤러(Model 2)
 *
 */
@WebServlet("/calendarCase2")
//@MultipartConfig
public class CalendarCase2Servlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int yearValue = Optional.ofNullable(request.getParameter("year"))
								.map(yp->Integer.parseInt(yp))
								.orElse(-1);
		int monthValue = Optional.ofNullable(request.getParameter("month"))
								.map(mp->Integer.parseInt(mp))
								.orElse(-1);
		
		Locale locale = Optional.ofNullable(request.getParameter("locale"))
				.map(lp->Locale.forLanguageTag(lp))
				.orElse(Locale.KOREA);

		ZoneId zone = Optional.ofNullable(request.getParameter("zone"))
				.map(zp->ZoneId.of(zp))
				.orElse(ZoneId.systemDefault());
			
		LocalDate TODAY = LocalDate.now(zone);
		YearMonth targetYM = YearMonth.now(zone);
		
		if (yearValue != -1 && monthValue != -1) {
			targetYM = YearMonth.of(yearValue, monthValue);
		}
		
		CalendarInfo infoVO = new CalendarInfo(targetYM, locale, zone);
		
		request.setAttribute("infoVO", infoVO);
		
		String viewName = "/WEB-INF/views/calendar/calView.jsp";
		request.getRequestDispatcher(viewName).forward(request, response);
	}
}
