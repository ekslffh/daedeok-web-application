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
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/customLibs.js"></script>
</head>
<body>
<div style="border: 1px solid black;">
	<h4>reqeust content-type header : server side unmarshalling 여부</h4>
	<input type="radio" name="contentType" value="Parameter" checked />Parameter
	<input type="radio" name="contentType" value="json" />JSON
</div>
<div style="border: 1px solid black">
	<h4>reqeust accept-header == response content-type: server side marshalling 여부</h4>
	<input type="radio" name="acceptType" value="json" />JSON
	<input type="radio" name="acceptType" value="xml" />XML
	<input type="radio" name="acceptType" value="html" />HTML
</div>
<form id="calForm" action="<%=request.getContextPath() %>/calculate/Case5ProcessServlet" method="post">
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
	let $resultArea = $('#resultArea');
	let functions = {
		json: function(resp) {
			let $newTag = $('<p>').html(resp.expr);
			$resultArea.html($newTag);
		},
		html: function(resp) {
			let $newTag = $('<p>').html(resp);
			$resultArea.html($newTag);
		}
	};
	$(calForm).on("submit", (event) => {
		event.preventDefault();
// 		this is window
		let calForm = event.target;
		let url = calForm.action;
		let method = calForm.method;
		
		let data = null;
		let headers = {};
		let dataType = $('[name=acceptType]:checked').val() ?? "html";
// 		dataType ? dataType : "html" => dataType ?? "html"
		let contentType = $("[name=contentType]:checked").val() ?? "parameter";
		if (contentType.toLowerCase() == "json") {
			let nativeData = $(calForm).serializeObject();
			data = JSON.stringify(nativeData);
			headers['Content-Type'] = "application/json;charset=UTF-8"; 
		} else {
			data = $(calForm).serialize();
		}
		
		let success = functions[dataType];
		let settings = {
			url : url,
			method : method,
			data : data,
			headers: headers,
			dataType : dataType, // json(application/json), xml(application/xml), html(text/html), text(text/plain)
								// Accept(request header), Content-Type(response header)
			success : success,
			error : function(jqXHR, status, error) {
				console.log(jqXHR);
				console.log(status);
				console.log(error);
			}
		}; // request line, header, body -> response processing

		console.log("settings: ", settings);
		$.ajax(settings);
	});
</script>
</body>
</html>