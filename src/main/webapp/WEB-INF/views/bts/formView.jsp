<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Map<String, String[]> memList = (Map) request.getAttribute("memList");
%>
<form method="post">
	<select class="form-select" name="member" onchange="this.form.requestSubmit();">
		<%=
			memList.entrySet().stream()
				.map(e -> MessageFormat.format("<option value=''{0}''>{1}</option>"
									, e.getKey(), e.getValue()[0]))
				.collect(Collectors.joining("\n"))
		%>
	</select>
</form>