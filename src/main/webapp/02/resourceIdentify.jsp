<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4> 자원의 종류와 식별 방법 </h4>
<pre>
	1. file system resource
	2. classpath resource
	3. web resource
		: 자원을 식별하는 방법
		URI(Uniform Resource Identifier)
		
		URL(Unifrom Resource Locator)
		URN(Uniform Resource Naming)
		URC(Uniform Resource Content)
		
		URL 구성 요소
		http://www.naver.com/depth/....
		protocol://IP[domain]:port/depth.....
		
		SOP(Same Origin Policy), CORS(Cross Origin Resource Sharing)
		
		절대경로 "/" 로 시작
			1) http://localhost:80/WebStudy01/resources/images/cat1.jpg
			2) //localhost:80/WebStudy01/resources/images/cat1.jpg (location.protocol)
			3) /WebStudy01/resources/images/cat1.jpg (location.host, location.port)
		상대경로 : 현재 위치(location.href)를 기준으로 절대 경로를 파악하는 방법
				../resources/images/cat1.jpg
		
</pre>
<img src="../resources/images/cat1.jpg" />
<img src="<%=request.getContextPath() %>/resources/images/cat1.jpg" />
<img src="/WebStudy01/resources/images/cat1.jpg" />
<img src="//localhost:80/WebStudy01/resources/images/cat1.jpg" />
<img src="http://localhost:80/WebStudy01/resources/images/cat1.jpg" />
</body>
</html>