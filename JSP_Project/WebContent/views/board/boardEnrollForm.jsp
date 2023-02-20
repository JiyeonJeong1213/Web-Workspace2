<%@ page import="java.util.ArrayList, com.kh.board.model.vo.Category" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	ArrayList<Category> list = (ArrayList<Category>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판 작성</title>
<style>
	#enroll-form>table{border:1px solid white;}
	#enroll-form input, #enroll-form textarea {
		width:100%;
		box-sizing:border-box;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		<h2 align="center">일반게시판 작성하기</h2>
		<br>
		
		<form action="<%= contextPath %>/insert.bo" id="enroll-form" method="post" enctype="multipart/form-data"> <!-- 파일 업로드 하려면 필요한 인코딩 타입 -->
			<!-- 카테고리, 제목, 내용, 첨부파일을 입력받고, 작성자 정보 -->
			<table align="center">
				<tr>
					<!--  
						DB로부터 카테고리 정보를 조회해서 보여주게끔 하는 게 좋음
						카테고리가 새롭게 추가되거나 삭제되는 경우 해당 카테고리를 참조하고 있는
						모든 JSP에 들어가서 일일이 수정해줘야 하기 때문				
					-->
					<th width="100">카테고리</th>
					<td width="500">
						<select name="category">
							<% for(Category c : list) { %>
								<option value="<%= c.getCategoryNo() %>"><%= c.getCategoryName() %></option>
							<% } %>
							<!-- <option value="10">공통</option>
							<option value="20">운동</option>
							<option value="30">등산</option>
							<option value="40">게임</option>
							<option value="50">낚시</option>
							<option value="60">요리</option>
							<option value="70">기타</option> -->
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" required></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" rows="10" required></textarea></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td><input type="file" name="upfile"></td>
				</tr>
			</table>
			<br>
			<div align="center">
				<button type="submit">작성하기</button>
				<button type="reset">취소하기</button>
			</div>
		</form>
	</div>
</body>
</html>