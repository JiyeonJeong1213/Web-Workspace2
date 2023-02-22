<%@ page import="java.util.ArrayList, com.kh.board.model.vo.Board" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진게시판 리스트</title>
<style>
	.outer {
		height: 800px;
	}
	.list-area{
		width: 760px;
		margin: auto;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		<h2 style="text-align:center">사진게시판</h2>
		<br>
		
		<% if(loginUser != null) { %>
			<div align="right" style="width:860px">
				<a href="<%= contextPath %>/insert.th" class="btn btn-secondary">글작성</a>
			</div>
		<% } %>
		<div class="list-area">
			<div class="thumbnail" align="center">
				<input type="hidden" value="1">
				<img src="<%= contextPath %>/resources/thumb_upfiles/animal1.gif" width="200px" height="150px">
				<p>
					NO.1 첫번째글제목<br>
					조회수 : 1
				</p>
			</div>
			<div class="thumbnail" align="center">
				<input type="hidden" value="2">
				<img src="<%= contextPath %>/resources/thumb_upfiles/animal2.gif" width="200px" height="150px">
				<p>
					NO.2 두번째글제목<br>
					조회수 : 1
				</p>
			</div>
			<div class="thumbnail" align="center">
				<input type="hidden" value="3">
				<img src="<%= contextPath %>/resources/thumb_upfiles/animal3.gif" width="200px" height="150px">
				<p>
					NO.3 세번째글제목<br>
					조회수 : 1
				</p>
			</div>
		</div>
	</div>
	
	<script>
		$(function(){
			$(".thumbnail").click(function(){
				location.href="<%= contextPath %>/detail.th?bno="+$(this).children().eq(0).val();
			});
		});
	</script>
</body>
</html>