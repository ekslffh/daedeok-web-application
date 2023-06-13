<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	response.setContentLength(10);
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>04/responseDesc.jsp</title>
</head>
<body>
<h4>HttpServletResponse</h4>
<pre>
	: 서버가 클라이언트로 전송하는 응답에 대한 모든 정보를 가진 객체.
	
	HTTP response packaging
	1. Response Line : 서버의 요청 처리 결과를 표현하는 상태 코드(response status code)
		* response status code
		HTTP : connectLESS, stateLESS
		100~ : ing..., connectFULL(의도적인 연결 수립/종료가 가능.), Websocket protocol 에서 활용됨.
		200~ : OK(SUCCESS)
		300~ : 최종적으로 요청 처리가 완료되려면, 클라이언트로 추가 액션이 필요함.
			304(Not Modified) : 정적 자원의 cache 와 연관된 상태 코드
			302/307(Moved) : Location 헤더를 통해 자원의 새로운 위치를 알려줌.
							==> Location 방향을 새로운 요청을 전송함. (redirect 이동 구조)
		400~ : client side error
			401/403 : 보안(인증-authentication/ 인가-authorization) 처리에 활용
				401(UnAuthorized) : 미인증 사용자에 대해 사용(UnAuthenticated).
				403(Forbidden) : 특정 자원에 대한 접근 허용 여부에 사용. 권한이 없는 사용자의 접근을 막을 때 사용함.
			404 : Not Found
			405 : Method Not Allowed
			400 : Bad Request(요청 검증시 사용)
			406/415 : 전송 컨텐츠 타입과 연관된 상태코드
				406(Not Acceptable) : request Accept 헤더와 연관됨.
									: 서버가 클라이언트의 요청 컨텐츠 타입을 처리할 수 없음.
				415(UnSupported Media Type) : request Content-Type헤더와 연관됨.
											: 서버가 읽을 수 없는 형태의 컨텐츠가 전송됐을때.
			<%--
				HttpServletResponse.SC_not
			--%>
		500~ : server side error
			500 : Internal Server Error
		
	2. Response Header : response body 의 메타데이터, name/value
		* Content-* (Content-Type, Content-Length)
		* Cache-*
		* auto request (Refresh - 갱신 주기, 초단위)
			: 동기 요청구조상에서 document에 대한 제어권이 필요함.
			cf) JS 비동기 요청 구조에서 auto request : JS 스케줄링 함수 활용 가능.
		* redirect Location
		
	3. Response Body(Content Body, Message Body)
		1) JSP 의 정적 테스트
		2) JSPWriter out 객체 이용
		3) PrintWriter response.getWriter() 객체 이용
		4) ServletOutputStream response.getOutputStream() 객체 이용
		
		===> response body 데이터를 직렬화
	<%--
		out.println("text");
		response.getWriter().println("text");
		response.getOutputStream().write(4);
	--%>
</pre>
</body>
</html>