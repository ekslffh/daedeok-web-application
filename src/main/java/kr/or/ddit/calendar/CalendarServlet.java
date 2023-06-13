package kr.or.ddit.calendar;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.temporal.TemporalField;
import java.time.temporal.WeekFields;
import java.util.Locale;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/calendar")
public class CalendarServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/05/calendarCase1.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("year: " + req.getParameter("year"));
	 	System.out.println("month: " + req.getParameter("month"));
	 	
		int yearValue = Optional.ofNullable(req.getParameter("year")).map(yp -> Integer.parseInt(yp)).orElse(-1);
		int monthValue = Optional.ofNullable(req.getParameter("month")).map(mp -> Integer.parseInt(mp)).orElse(-1);
		
		Locale locale = Locale.KOREA;
		ZoneId zone = ZoneId.systemDefault();
		LocalDate TODAY = LocalDate.now(zone);

		YearMonth targetYM = YearMonth.now(zone);

		if (yearValue != -1 && monthValue != -1) {
			targetYM = YearMonth.of(yearValue, monthValue);
		}

		WeekFields weekFields = WeekFields.of(locale);
		DayOfWeek firstDayOfWeek = weekFields.getFirstDayOfWeek();
		TemporalField dayOfWeek = weekFields.dayOfWeek();

		YearMonth beforeYM = targetYM.minusMonths(1);
		YearMonth nextYM = targetYM.plusMonths(1);
		
		req.getRequestDispatcher("/05/calendar.jsp").forward(req, resp);
	}

}
