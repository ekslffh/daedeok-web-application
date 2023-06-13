<%@page import="java.util.Optional"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.time.Month"%>
<%@page import="java.util.stream.Stream"%>
<%@page import="java.time.temporal.TemporalField"%>
<%@page import="java.time.format.TextStyle"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.temporal.WeekFields"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.YearMonth"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.ZoneId"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
// 	System.out.println("year: " + request.getParameter("year"));
// 	System.out.println("month: " + request.getParameter("month"));

	int yearValue = Optional.ofNullable(request.getParameter("year"))
							.map(yp->Integer.parseInt(yp))
							.orElse(-1);
	int monthValue = Optional.ofNullable(request.getParameter("month"))
							.map(mp->Integer.parseInt(mp))
							.orElse(-1);
	
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
 %>
<h4>first day of week : <%=firstDayOfWeek %></h4>
<table>
	<thead>
		<tr>
			<%
				for (int cnt = 0; cnt < 7; cnt++) {
					DayOfWeek thisTurn = firstDayOfWeek.plus(cnt);
					out.println(
						MessageFormat.format("<th class=''{1}''>{0}</th>", thisTurn.getDisplayName(TextStyle.FULL, locale), thisTurn.name().toLowerCase())
					);
				}
			%>
		</tr>
	</thead>
	<tbody>
		<%
			LocalDate firstDate = targetYM.atDay(1);
			int offset = firstDate.get(dayOfWeek) - firstDayOfWeek.get(dayOfWeek);
			LocalDate startDate = firstDate.minusDays(offset);
			int count = 0;
			for (int row = 1; row <= 6; row++) {
				out.println("<tr>");
				for (int col = 1; col <= 7; col++) {
					LocalDate thisTurn = startDate.plusDays(count++);
					YearMonth thisTurnYM = YearMonth.from(thisTurn);
					StringBuilder classes = new StringBuilder();
					classes.append(
							thisTurnYM.isBefore(targetYM) ? "before" :
								thisTurnYM.isAfter(targetYM) ? "after" :
									thisTurn.getDayOfWeek().name().toLowerCase()		
					);
					
					out.println(
						MessageFormat.format("<td class=''{1}''>{0}</td>"
											, thisTurn.getDayOfMonth()
											, classes)
					);
				}
				out.println("</tr>");
			}
		%>
	</tbody>
</table>