<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Map<String, String[]> bloodType = (Map) request.getAttribute("bloodType");
%>
<h4>혈액형별 성격 유형 검사</h4>
<form method="post">
	<select class="form-select" name="blood" onchange="this.form.requestSubmit();">
		<option value>혈액형</option>
		<%=
			bloodType.entrySet().stream()
				.map(e -> MessageFormat.format("<option value=''{0}''>{1}</option>"
									, e.getKey(), e.getValue()[0]))
				.collect(Collectors.joining("\n"))
		%>
	</select>
</form>
<script>
	console.log($.ajax);
</script>