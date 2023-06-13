<%@ page import="java.text.MessageFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4><%=MessageFormat.format("현재 실행중인 쓰레드명 : {0}", Thread.currentThread().getName()) %></h4>
<h4>JSP(Java Server Page)</h4>
<pre>
	: 서블릿의 파생 스펙으로 템플릿 엔진의 형태로 동작하는 스크립트 언어 (인터프리터 방식의 언어 : 따로 번역x)
	
	JSP container(WAS)
	: jsp 템플릿을 해석하고, 서블릿 소스를 생성하고, 컴파일을 하고,
	하나의 요청이 들어오면, 싱글톤 객체로 동작할 수 있는 인스턴스를 생성하고,
	하나의 쓰레드를 분리하고, 필요한 콜백 메소드(_jspService)를 호출 
	
	소스의 구성요소
	1. 정적 텍스트 : HTML, JS, CSS, 일반 텍스트, foreground module로 동작
	2. 스크립트 요소 : background module로 동작
		- directive(지시자), &lt;%@ 지시자명 속성명="속성값" %%gt; : 현재 JSP 페이지에 대한 설정정보
			page(required) : jsp 페이지에 대한 메타 정보(contentType, import..)
			include(optional) : 정적 내포
			taglib(optional) : 커스텀 태그를 로딩함.
			 
		- scriptlet(스크립트) : <% // java code -> _jspService 메소드의 지역 코드화 %>
		<%
			String sample = "SAMPLE";
		%>
		- expression(표현식) : <%=sample %>, <%=this.sample %>, <%=tempMtd() %>
		- declaration(선언부) : <%! %>
		<%!
			String sample = "INSTANCE SAMPLE";
			private String tempMtd(){
				return "TEST Method";
			}
		%>
		- comment(주석) : <%--  --%>
		1. foreground comment : html, js, css
		<!-- html comment -->
		2. background comment : java, jsp
		<%-- jsp comment --%>
	3. 스크립트 요소내에서 사용되는 기본 객체(8)
	4. EL(표현언어)
	5. JSTL(표준 태그 라이브러리)
</pre>
</body>
</html>