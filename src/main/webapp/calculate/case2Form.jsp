<%@page import="java.util.List"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="kr.or.ddit.enumpkg.OperatorType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-3.7.0.min.js"></script>
</head>
<body>
<form id="calForm" action="<%=request.getContextPath() %>/calculate/Case2ProcessServlet" method="post">
	<input type="number" name="leftOp" />
	<select name="opParam">
		<option value>연산자</option>
		<%
			OperatorType[] opTypes = OperatorType.values();
			String options = Arrays.stream(opTypes)
					.map(op -> MessageFormat.format("<option value=''{0}''>{1}</option>", op.name(), op.getSign()))
					.collect(Collectors.joining("\n"));
			out.println(options);
		%>
	</select>
	<input type="number" name="rightOp" />
	<button type="submit">=</button>
</form>
<div id="resultArea"></div>
<script type="text/javascript">
	$(calForm).on("submit", (event) => {
		event.preventDefault();
// 		this is window
		let calForm = event.target;
		let url = calForm.action;
		let method = calForm.method;
		let data = $(calForm).serialize();
		
		let settings = {
			url : url,
			method : method,
			data : data,
			dataType : "json", // json(application/json), xml(application/xml), html(text/html), text(text/plain)
								// Accept(request header), Content-Type(response header)
			success : function(resp) {
// 				resultArea.innerHTML = `<p>\${resp}</p>`;
				$(resultArea).html($("<p>").html(resp['expr']));
			},
			error : function(jqXHR, status, error) {
				console.log(jqXHR);
				console.log(status);
				console.log(error);
			}
		}; // request line, header, body -> response processing

		$.ajax(settings);
	});
</script>
</body>
</html>