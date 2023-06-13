<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String[] imageFiles = (String[]) request.getAttribute("imageFiles");
	%>

	<form action='<%=request.getContextPath()%>/image.do'>

		<select name='image' onchange='this.form.submit()'>
			<%
			for (String tmp : imageFiles) {
			%>
			<option><%=tmp%></option>
			<%
			}
			%>
		</select>
		<button type='submit'>전송</button>
	</form>
</body>
</html>