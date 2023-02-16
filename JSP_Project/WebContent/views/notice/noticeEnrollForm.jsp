<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성 페이지</title>
<style>
	#enroll-form input, #enroll-form textarea {
		width:100%;
		box-sizing : border-box;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		<h2 align = "center">공지사항 작성하기</h2>
		<br>
		
		<form id="enroll-form" action="<%= contextPath%>/insert.no" method="post">
		
			<input type="hidden" name="userNo" value="<%= loginUser.getUserNo() %>">
			<!-- 현재 로그인 한 유저의 정보를 알아내는 방법 중 2번째 방법 
				- hidden타입의 input태그로 현재 세션에 있는 loginUser정보를 담아주는 방법
			-->
			<table align="center">
				<tr>
					<th width="50">제목</th>
					<td width="350"><input type="text" name="title" required></td>
				</tr>
				<tr>
					<th>내용</th>
					<td></td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea name="content" rows="10" style="resize:none" required></textarea>
					</td>
				</tr>
			</table>
			<br><br>
			<div align="center">
				<button type="submit">등록</button>
				<button type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
	</div>
</body>
</html>