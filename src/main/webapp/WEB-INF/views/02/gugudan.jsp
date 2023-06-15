<%@page import="java.text.MessageFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int minDan = (Integer) request.getAttribute("minDan");
	int maxDan = (Integer) request.getAttribute("maxDan");
%>
<form id="gugudanForm">
	<input type="text" placeholder="최소단" name="minDan" value="<%=minDan %>" />
	<select name="maxDan">
		<option value>최대단</option>
		<%
		StringBuilder options = new StringBuilder();
		String optPtrn = "<option value=''{0}'' {1}>{0}단</option>";
		for (int i = 2; i <= 9; i++) {
			String selected = (i == maxDan) ? "selected" : "";
			options.append(MessageFormat.format(optPtrn, i, selected));
		}
		out.println(options);
		%>
	</select>
	<button type="submit">전송</button>
</form>

<h4><%=MessageFormat.format("{0}단부터 {1}단까지의 구구단", minDan, maxDan) %></h4>
<%=makeGugudanTable(minDan, maxDan) %>

<h4>2단부터 9단까지의 구구단</h4>
<%
	StringBuilder html = new StringBuilder();
	html.append("<table>");
	for (int i = 2; i <= 9; i++) {
		html.append("<tr>");
		for (int j = 1; j <= 9; j++) {
		html.append(MessageFormat.format("<td>{0}*{1}={2}</td>", i, j, i * j));
		}
		html.append("</tr>");
	}
	html.append("</table>");
%>
<%=html %>

<table>
	<%
		for (int i = 2; i <= 9; i++) {
			%>
			<tr>
			<% 
			for (int j = 1; j <= 9; j++) {
			%>
			<td><%=MessageFormat.format("{0}*{1}={2}", i, j, (i * j)) %></td>
			<% 
			}
			%>
			</tr>
			<% 
		}
	%>
</table>

<%!
private String makeGugudanTable(int min, int max) {
	StringBuilder html = new StringBuilder();
	html.append("<table border>");
	for (int i = min; i <= max; i++) {
		html.append("<tr>");
		for (int j = 1; j <= 9; j++) {
		html.append(MessageFormat.format("<td>{0}*{1}={2}</td>", i, j, i * j));
		}
		html.append("</tr>");
	}
	html.append("</table>");
	return html.toString();
}
%>
