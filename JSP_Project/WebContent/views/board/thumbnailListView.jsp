<%@ page import="java.util.ArrayList, com.kh.board.model.vo.Board" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	ArrayList<Board> bList = (ArrayList<Board>)request.getAttribute("bList");
	int listNo = 1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진게시판 리스트</title>
<style>
	.outer {
		min-height: 800px;
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
			
			<% if(bList.isEmpty()) {%>
				조회된 리스트가 없습니다.
			<%} else { %>
				<% for(Board b : bList) { %>
					<div class="thumbnail" align="center">
						<input type="hidden" value="<%= b.getBoardNo() %>">
						<img src="<%= contextPath %><%= b.getAt().getFilePath()+b.getAt().getChangeName() %> <%--<%= b.getTitleImg() %>--%>" width="200px" height="150px">
						<p>
							NO.<%= listNo++ %> <%= b.getBoardTitle() %><br>
							조회수 : <%= b.getCount() %>
						</p>
					</div>
				<% } %>
			<% } %>
				<%-- <input type="hidden" value="1">
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
					조회수 : 1.
				</p> --%>
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