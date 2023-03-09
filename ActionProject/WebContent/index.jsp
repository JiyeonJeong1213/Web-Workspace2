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
	
	<!--  
		* JSP를 이루는 구성인자
		
		1. JSP 스크립트원소 : JSP페이지 안에서 자바코드를 직접기술할 수 있게 하는 기술
		   ex) 선언문, 스크립트릿, 표현식, 지시어...
		   
		2. 지시어 : JSP페이지 정보에 대한 내용을 표현한다거나 또다른 페이지를 포함할 때 사용
		   ex) 지시어 (page지시어, include지시어, taglib지시어(라이브러리 추가시 사용))
		
		3. JSP 액션태그 : XML기술을 이용해서 기존 jsp문법을 확장하는 기술을 제공하는 태그
			- 표준액션태그(Standard Action Tag) : JSP페이지에서 바로 사용가능(별도의 라이브러리 필요 없음)
											   표준액션태그는 모든 태그명 앞에 jsp: 이라는 접두어가 붙음
			- 커스텀액션태그(Custom Action Tag) : JSP페이지에서 바로 사용 불가능(별도의 라이브러리 연동 해줘야함)
											  커스텀액션태그는 모든 태그명 안에 별도의 접두어가 붙음(c:, fn:, fmt:)
											  제공되고 있는 대표적인 유용한 라이브러리가 (JSTL)
		4. EL 표현언어
	-->
	
	<h1>* JSP Action Tag</h1>
	<p>
		XML기술을 이용해서 기존 JSP문법을 확장시키는 기술을 제공하는 태그들
	</p>
	
	<h3>1. 표준 액션 태그</h3>
	<p>
		JSP페이지에서 별도의 라이브러리 연동 없이 바로 사용 가능 <br>
		태그 앞에 jsp: 접두어가 붙음
	</p>
	<a href="views/2_StandardAction/01_include.jsp">include.jsp</a>
	<br>
	<a href="views/2_StandardAction/02_forward.jsp">forward.jsp</a>
	<br>
	
	<h3>2. 커스텀 액션 태그</h3>
	<a href="views/3_CustomAction/jstl.jsp">JSTL</a>
</body>
</html>