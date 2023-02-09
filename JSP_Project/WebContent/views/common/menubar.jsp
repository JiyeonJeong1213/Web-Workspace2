<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome C Class</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	#Login-form, #user-info {float: right;}
	#user-info a {
		text-decoration: none;
		color: black;
		font-size: 12px;
	}
	.nav-area {background: black;}
	.menu {
		display: table-cell; /* 인라인 요소처럼 배치 가능 */
		height: 50px;
		width: 150px;
	}
	.menu a{
		text-decoraion: none;
		color: white;
		font-size: 20px;
		font-weight: bold;
		display: block;
		width: 100%;
		height: 100%;
		
		line-height: 50px; /* 위 아래에서 가운데로 조정 */
	}
	.menu a:hover {
		background: darkgray;
	}
</style>
</head>
<body>
	<h1 align="center">Welcome C Class</h1>
	
	<div class="Login-area">
		<form id="Login-form" action="<%= request.getContextPath() %>/login.me" method="">
			<table>
				<tr>
					<th>아이디 : </th>
					<td><input type="text" name="userId" required></td>
				</tr>
				<tr>
					<th>비밀번호 : </th>
					<td><input type="password" name="userPwd" required></td>
				</tr>
				<tr>
					<th colspan="2">
						<button>로그인</button>
						<button type="button" onclick="enrollPage();">회원가입</button>
					</th>
				</tr>
			</table>
		</form>
	</div>
	
	<br clear="both"> <!-- float 속성 해제  -->
	<br>
	
	<div class="nav-area" align="center">
		<div class="menu"><a href="<%= contextPath%>">HOME</a></div>
		<div class="menu"><a href="<%= contextPath%>/list.no">공지사항</a></div>
		<div class="menu"><a href="<%= contextPath%>/list.bo?currentPage=1">일반게시판</a></div>
		<div class="menu"><a href="<%= contextPath%>/list.th">사진게시판</a></div>
	</div>
</body>
</html>