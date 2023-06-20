<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4>타이머 : <span id="timerArea"></span></h4>
<div id="messageArea" hidden>
	<p>세션 연장 여부 확인</p>
	<input type="button" value="예" class="controlBtn" id="yesBtn" />
	<input type="button" value="아니오" class="controlBtn" id="noBtn" />
</div>
<h4>HttpSession</h4>
<pre>
	HttpSession : http 프로토콜로 형성된 connection 의 한 세션에 대한 정보를 가진 객체.
	세션 ? 
		시간(ConnectLess) : 어플리케이션을 사용하기 시작하는 순간부터 사용 종료까지의 기간.
		통로(ConnectFull) : C/S 사이의 유일한 연결 통로(Connection)
	
	세션의 생명주기
		생성 : 어플리케이션을 대상으로 최초의 요청이 발생한 경우.
			: 트래킹 모드로 저장되어 전송되는 세션 아이디가 없는 요청인 경우, 최초로 판단.
			--> session id 가 부여됨. <%=session.getId() %>
		유지(session tracking mode) : C/S 가 세션 아이디를 공유하는 방법.
			Cookie : ex) JSESSIONID 라는 이름의 쿠키를 통해 세션 아이디 공유.
			URL : <a href="sessionDesc.jsp;jsessionid=<%=session.getId() %>">세션 유지</a>
			SSL(Secure Socket Layer)
		종료(소멸)
			1. timeout(만료시간, ex)30분) : 요청과 다음번 요청 사이의 시간의 간격이 timeout 이상으로 벌어지면 세션 소멸. 
			2. cookie 삭제 : JSESSIONID 쿠키 제거 -> dummy session 잔존
			3. 브라우저 종료시 -> dummy session 잔존
			4. 명시적인 로그아웃 : invalidate 활용
			<%--
				session.invalidate();
			--%>
		세션 생성 시점 : <%=new Date(session.getCreationTime()) %>
		세션 아이디 : <%=session.getId() %>
		timeout : <%=session.getMaxInactiveInterval() %>s
		마지막 요청 시점 : <%=new Date(session.getLastAccessedTime()) %>
</pre>
<script type="text/javascript">
	const timeout = <%=session.getMaxInactiveInterval() %>;
	const speed = 1000;
	let timer = timeout;
	let timeFormat = function(time) {
		// formatting : 1:59
		if ((time || time == 0) && time >= 0) {
			let minute = Math.trunc( time / 60 );
			let second = time % 60;
			return `\${new String(minute).padStart(2, '0')}:\${new String(second).padStart(2, '0')}`;
		} else {
			throw new Error("시간 데이터는 0이상의 값이 필요함.");
		}
	}
	let messageArea = document.getElementById('messageArea');
	// scheduling : timeout, interval
	let timerJob = setInterval(() => {
		if (timer == 60) {
			messageArea.hidden = false;
		}
		if (timer <= 0) {
			messageArea.hidden = true;
			clearInterval(timerJob);	
		} else {
			timerArea.innerHTML = timeFormat(--timer);
		}
	}, 1*speed);
	
	let controlBtns = document.querySelectorAll('.controlBtn');
	controlBtns.forEach(btn => btn.addEventListener('click', function() {
		if (this.id == 'yesBtn') {
			let url = '<%=request.getRequestURI() %>';
			fetch(url, { method: "head" })
			.then(resp => timer = timeout);
		}
		messageArea.hidden = true;
	}));
	
	<%--
		의사코드
		1. 시간이 1분이 남았을 때 메시지가 보인다.
		2-1. 예를 누르면 시간이 다시 2분으로 늘어난다. (연장)
			: 세션을 먼저 연장하고 timer시간 다시 늘리기
		2-2. 아니오를 누르면 시간은 그대로이다.
		3. 메시지가 사라진다.
	--%>
	
</script>
</body>
</html>