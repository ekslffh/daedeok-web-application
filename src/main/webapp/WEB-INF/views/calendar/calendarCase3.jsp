<%@page import="java.time.format.TextStyle"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="java.time.Month"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Stream"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.ZoneId"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<h4>TODAY : <span id="todayArea"></span></h4>
<h4>server's CURRENT : <span id="currentArea">한국 표준시 : 현재 시간</span></h4>
<hr />

<form id="calendarForm" onchange="this.requestSubmit()" method="post"
	enctype="application/x-www-form-urlencoded"
>
	<input type="number" name="year" data-year="<%=LocalDate.now().getYear() %>" />
	<select name="month" data-month="<%=LocalDate.now().getMonthValue() %>">
		<%=
			Stream.of(Month.values())
				.map(m->{
					return MessageFormat.format("<option value=''{0}''>{1}</option>"
									, m.getValue()
									, m.getDisplayName(TextStyle.FULL, Locale.getDefault()));
				}).collect(Collectors.joining("\n"))
		%>
	</select>
	<select name="locale" data-locale="<%=Locale.getDefault().toLanguageTag() %>">
		<%=
			Stream.of(Locale.getAvailableLocales())
				.filter(l -> !l.getDisplayName(l).isEmpty())
				.map(l -> {
					// locale code(locale tag) ex) ko_KR
					return MessageFormat.format("<option value=''{0}''>{1}</option>", l.toLanguageTag(), l.getDisplayLanguage(Locale.getDefault()));
				}).collect(Collectors.joining("\n"))
		%>
	</select>
	<select name="zone" data-zone="<%=ZoneId.systemDefault().getId() %>">
		<%=
			ZoneId.getAvailableZoneIds().stream()
				.map(z -> MessageFormat.format("<option value=''{0}''>{1}</option>", z, ZoneId.of(z).getDisplayName(TextStyle.FULL, Locale.getDefault())))
				.collect(Collectors.joining("\n"))
		%>
	</select>
</form>

<div id="calendarArea"></div>

<script type="text/javascript">
// 	JS scheduling function : setTimeout, setInterval
	setInterval(() => {
		let queryString = new URLSearchParams(new FormData(calendarForm)).toString();
		fetch(`<%=request.getContextPath() %>/05/serverTime?\${queryString}`, {
			method: "get",
			headers: {
				"Accept" : "application/json" // ajax dataType과 동일
			}
		})
		.then(resp => resp.json())
			.then(respObj => {
				currentArea.innerHTML = `\${respObj.zone}:\${respObj.CURRENT}`;
				todayArea.innerHTML = respObj.TODAY;
			});
	}, 1000);
	
	calendarForm.addEventListener("submit", function(event) {
		event.preventDefault();
		// form 동기요청을 비동기 요청으로 전환.
		let url = calendarForm.action;
		let method = calendarForm.method;
		let formData = new FormData(calendarForm);
		let requestContentType = calendarForm.enctype;
		let settings = {
			method: method,
			headers: {
				"Content-Type": requestContentType
			},
// 			body: formData // multipart 형태 전송
			body: new URLSearchParams(formData).toString()
		};
//	 	resp.json() // json content
// 		resp.text() // html/plain content
		fetch(url, settings)
			.then(resp => resp.text())
			.then(html => {
				document.querySelector('#calendarArea').innerHTML = html;
			})
	});
	
	calendarForm.querySelectorAll("[name]").forEach((ipt)=>{
		let name = ipt.name;
		let data = ipt.dataset[name];
		if (data)
			ipt.value = data;
		calendarForm.requestSubmit();
	});
	
	// event bubbling 전파 : 자식 엘리먼트에 대해 발생한 이벤트는 부모 엘리먼트에게 전파됨.
	calendarArea.addEventListener("click", (event) => {
		if (event.target.classList.contains("changer")) {
			calendarForm.year.value = event.target.dataset.year;
			calendarForm.month.value = event.target.dataset.month;
			calendarForm.requestSubmit();
		}
	});
	
	console.log($);
</script>