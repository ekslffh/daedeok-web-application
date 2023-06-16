<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Map<String, String[]> memList = (Map) request.getAttribute("memList");
%>
<form action="" method="post">
	<select class="form-select" name="member">
		<%=
			memList.entrySet().stream()
				.map(e -> MessageFormat.format("<option value=''{0}''>{1}</option>"
									, e.getKey(), e.getValue()[0]))
				.collect(Collectors.joining("\n"))
		%>
	</select>
</form>
<script>
$('[name=member]').on('change', function(event) {
	event.preventDefault();
	let value = $(this).val();
	this.form.action += "/" + value;
	this.form.requestSubmit();
})
</script>