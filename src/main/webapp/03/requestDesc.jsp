<%@page import="java.text.MessageFormat"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03/requestDesc.jsp</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-3.7.0.min.js"></script>
</head>
<body>
<form id="sampleForm" action="<%=request.getContextPath() %>/03/dataProcess.do" method="post">
<pre>
	<input type="text" name="param1" />
	<input type="number" name="param2" />
	<select name="selParamSingle">
		<option value>선택</option>
		<option value="opt1Value">opt1</option>
		<option>opt2</option>
	</select>
<!-- 	HTMLElement, property, boolean -->
<!-- 	attr("multiple", "multiple"), prop("multiple", true) -->
	<select name="selParamMulti" multiple size="5">
		<option value>선택</option>
		<option value="opt1Value">opt1</option>
		<option>opt2</option>
	</select>
	<label><input type="radio" name="rdoParam" value="radio1" />RADIO1</label>
	<label><input type="radio" name="rdoParam" value="radio2" />RADIO2</label>
	<label><input type="checkbox" name="chkParam" value="Check1" />CHECK1</label>
	<label><input type="checkbox" name="chkParam" value="Check2" />CHECK2</label>
	<input type="date" name="dateParam" />
	<input type="datetime-local" name="datetimeParam" />
	<input type="submit" value="전송" />
</pre>
</form>
<h4>Http Request Packaging(HttpServletRequest)</h4>
<pre>
	1. Request Line : protocol/version(HTTP/1.1) URL, Request Method
		<%=request.getProtocol() %>
		<%=request.getRequestURI() %>
		<%=request.getMethod() %>
	
		* Request Method : 현재 요청의 의도(목적)과 패키징 구조를 표현
		1) GET(default), R : Read
		2) POST, C : Write
		3) PUT(전체수정)/PATCH(선택수정), U : Update
		4) DELETE, D
		5) OPTIONS : preFlight 요청에 사용됨.
		6) HEAD : response Body가 없는 응답을 요청함.
		7) TRACE : server debugging 요청.
		
	2. Request Header : meta data(현재 클라이언트와 요청에 대한 부가 정보)
		<%=request.getHeader("accept") %>
		Accept-* : 응답에 대한 조건을 설정.
		ex) Accept : application/json, Accept-Language : ko_KR
		Content-* : request body에 대한 부가정보
		ex) Content-Type : multipart/form-data, application/json
		User-Agent : 클라이언트가 사용하는 시스템과 브라우저에 대한 정보
		
	3. Request Body(Content Body, Message Body, only Post) : send data(content) 그 자체.
		1) 요청 파라미터 (application/x-www-form-urlencoded)
			: GET 메소드에서도 Query String의 형태로 제한적인 파라미터를 전송할 수 있음.
			- String getParameter(String parameterName) 
			  Map&lt;String, String[]&gt; getParameterMap()
			  String[] getParameterValues(String parameterName)
			  Enumeration&lt;String&gt; getParameterNames()
		2) multipart (multipart/form-data) : Part(servlet 3.x), FileItem(servlet 2.x)
			- Part getPart(String partName)
			  Collection&lt;Part&gt; getParts()
		3) payload (json|xml, application/json|application/xml)
			- InputStream getInputStream()
			  (역직렬화-DeSerialization, 언마샬링-UnMarshalling)
			  
</pre>
<table border>
	<thead>
		<tr>
			<th>헤더이름</th>
			<th>헤더값</th>
		</tr>
	</thead>
	<tbody>
		<%	
			StringBuilder html = new StringBuilder();
			String pattern = "<tr><td>{0}</td><td>{1}</td></tr>\n";
			Enumeration<String> names = request.getHeaderNames();
			while (names.hasMoreElements()) {
				String headerName = names.nextElement();
				String headerValue = request.getHeader(headerName);
				html.append(
					MessageFormat.format(pattern, headerName, headerValue)
				);
			}
			out.println(html);
		%>
	</tbody>
</table>
<script type="text/javascript">
// 	sampleForm.onsubmit=
	$(sampleForm).on("submit", function(event) {
		event.preventDefault();
// 		this==event.target // HTMLElement
// 		$(this) // jquery Object
// 		this.action
// 		$(this).attr("action")
		console.log(`HtmlElement : \${this}`);
		console.log(`jquery Object : \${$(this)}`);
		let url = this.action;
		let method = this.method;
		let data = $(this).serialize(); // form 입력값들을 파라미터 형태로 전송가능한 문자열로 만들어줌.
		let settings = {
			url : url,
			method : method,
			data : data,
			
			// --------------------------
			
			dataType :"json", // request Accept:application/json, response Content-type:application/json
			
			success : function(resp) {
				alert(resp.message);
			},
			
			error : function(jqXHR, status, error) {
				console.log(jqXHR);
				console.log(status);
				console.log(error);
			}
		}; // request line, header, body -> response processing
		
		console.log(settings);
		$.ajax(settings);
		
		return false;
	}); // callback function
</script>
</body>
</html>