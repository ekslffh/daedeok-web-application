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
	int yearValue = Optional.ofNullable(request.getParameter("year"))
							.map(yp->Integer.parseInt(yp))
							.orElse(-1);
	int monthValue = Optional.ofNullable(request.getParameter("month"))
							.map(mp->Integer.parseInt(mp))
							.orElse(-1);
	
	Locale locale = Optional.ofNullable(request.getParameter("locale"))
			.map(lp->Locale.forLanguageTag(lp))
			.orElse(Locale.getDefault());

	ZoneId zone = Optional.ofNullable(request.getParameter("zone"))
			.map(zp->ZoneId.of(zp))
			.orElse(ZoneId.systemDefault());
		
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.before, .after {
		color: silver;
	}
	.<%=DayOfWeek.SUNDAY.name().toLowerCase() %> {
		color: red;
	}
	.<%=DayOfWeek.SATURDAY.name().toLowerCase() %> {
		color: blue;
	}
	td, th {
		border: 1px solid black;
		text-align: center;
	}
	table {
		border-collapse: collapse;
		width: 100%;
		height: 500px;
	}
</style>
</head>
<body>
<h4>TODAY : <span id="todayArea"></span></h4>
<h4>server's CURRENT : <span id="currentArea"></span></h4>
<hr />

<form id="calendarForm" onchange="this.requestSubmit()" method="post">
	<input type="number" name="year" data-year="<%=targetYM.getYear() %>" />
	<select name="month" data-month="<%=targetYM.getMonthValue() %>">
		<%=
			Stream.of(Month.values())
				.map(m->{
					return MessageFormat.format("<option value=''{0}''>{1}</option>"
									, m.getValue()
									, m.getDisplayName(TextStyle.FULL, locale));
				}).collect(Collectors.joining("\n"))
		%>
	</select>
	<select name="locale" data-locale="<%=locale.toLanguageTag() %>">
		<%=
			Stream.of(Locale.getAvailableLocales())
				.filter(l -> !l.getDisplayName(l).isEmpty())
				.map(l -> {
					// locale code(locale tag) ex) ko_KR
					return MessageFormat.format("<option value=''{0}''>{1}</option>", l.toLanguageTag(), l.getDisplayLanguage(locale));
				}).collect(Collectors.joining("\n"))
		%>
	</select>
	<select name="zone" data-zone="<%=zone.getId() %>">
		<%=
			ZoneId.getAvailableZoneIds().stream()
				.map(z -> MessageFormat.format("<option value=''{0}''>{1}</option>", z, ZoneId.of(z).getDisplayName(TextStyle.FULL, locale)))
				.collect(Collectors.joining("\n"))
		%>
	</select>
</form>

<h4>
<a href="javascript:;" class="changer" data-year="<%=beforeYM.getYear() %>" data-month="<%=beforeYM.getMonthValue() %>">전달</a>
<%=targetYM.format(DateTimeFormatter.ofPattern("uuuu, MMMM", locale)) %>
<a href="javascript:;" class="changer" data-year="<%=beforeYM.getYear() %>" data-year="<%=nextYM.getYear() %>" data-month="<%=nextYM.getMonthValue() %>">다음달</a>
</h4>

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

<script type="text/javascript">
// 	JS scheduling function : setTimeout, setInterval
	setInterval(() => {
		fetch("<%=request.getContextPath() %>/05/serverTime", {
			method: "get",
			headers: {
				"Accept" : "application/json" // ajax dataType과 동일
			}
		})
		.then(resp => resp.json())
			.then(respObj => {
				todayArea.innerHTML = respObj.TODAY;
				currentArea.innerHTML = respObj.CURRENT;
			});
	}, 1000);
	
	calendarForm.querySelectorAll("[name]").forEach((ipt)=>{
		let name = ipt.name;
		let data = ipt.dataset[name];
		if (data)
			ipt.value = data;
	});
	
	document.querySelectorAll(".changer").forEach(atag => {
		atag.addEventListener("click", (event) => {
			
			calendarForm.year.value = event.target.dataset.year
			calendarForm.month.value = event.target.dataset.month
			
			calendarForm.requestSubmit();
		});
	});
</script>
</body>
</html>