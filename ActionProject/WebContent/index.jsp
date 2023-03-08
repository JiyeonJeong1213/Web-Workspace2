<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>* EL(Expression language)표현언어</h1>
	<p>
		기존에 사용했던 표현식(출력식) &lt;%= name %&gt;과 같이 <br>
		JSP상에서 표현하고자 하는 값을 \${name}의 형식으로 표현해서 작성하는 것 <!-- 특수기호 쓰고 싶으면 \쓰면 됨 -->
		<br>
		javascript의 \${자바스크립트변수}를 쓰고 싶다면 페이지 지시어 중 isElIgnored속성을 true로 변경해주면 됨
	</p>
	
	<h3>1. EL 기본 구문</h3>
	<a href="/action/el.do">01_EL</a>
	
	<h3>2. EL의 연산자에 대해 배우기</h3>
	<a href="/action/operation.do">02_EL의 연산자</a>
</body>
</html>