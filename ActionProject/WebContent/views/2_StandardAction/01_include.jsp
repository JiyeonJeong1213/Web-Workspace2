<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>include</h3>
	<p>또 다른 페이지를 포함하고자 할 때 쓰는 방식</p>
	
	<h4>1. 기존의 include지시어를 이용한 방식(정적 include방식 == 컴파일 시 포함되는 형태)</h4>
	<%-- <%@ include file="footer.jsp" %> --%>
	<br><br>
	
	특징 : include하고 있는 페이지상에 선언되어 있는 변수를 현재 페이지에서도 사용 가능함 <br>
	<%-- include한 페이지 year의 변수값 : <%= year %> --%> <br>
	단, 현재 페이지에 동일한 이름의 변수를 선언할 수 없다.
	
	<hr>
	
	<h4>2. JSP 표준 액션 태그를 이용한 방식(동적 include방식 == 런타임 시 포함되는 형태)</h4>
	<!--  
		반드시 시작태그와 종료태그를 같이 써야 함
		단, 시작태그와 종료태그 사이에 값이 존재할 필요가 없는 경우 종료태그 없이 시작태그에 /로 닫아줘야 함
	-->
	<jsp:include page="footer.jsp"/>
	<br><br>
	
	특징 1 : include하고 있는 페이지에 선언된 변수를 공유하지 않음(즉, 동일한 이름의 변수 선언 가능) <br>
	<% String year = "2023"; %>
	특징 2 : 포함 시 include하는 페이지로 내가 원하는 값을 전달할 수도 있음 <br>
	<jsp:include page="footer.jsp">
		<jsp:param value="${empty requestScope.test?'hoho':requestScope.test }" name="test"/>
	</jsp:include>
</body>
</html>