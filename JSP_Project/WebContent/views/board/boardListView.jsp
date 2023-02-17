<%@ page import="com.kh.common.model.vo.PageInfo, java.util.ArrayList, com.kh.board.model.vo.Board" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	ArrayList<Board> list = (ArrayList<Board>) request.getAttribute("list");
	
	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	int maxPage = pi.getMaxPage();
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<style>
	.list-area{
		border: 1px solid white;
		text-align: center;
	}
	.list-area>tbody>tr:hover{
		background: gray;
		cursor: pointer;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		<h2 align="center">일반게시판</h2>
		<br>
		
		<!-- 글 등록 버튼(로그인 한 회원만 보이도록) -->
		<% if(loginUser != null) { %>
			<div align="right" style="width:850px">
				<a href="<%= contextPath %>/enrollForm.bo" class="btn btn-secondary">글작성</a>
			</div>
		<% } %>
		
		<table class="list-area" align="center">
			<thead>
				<tr>
					<th width="70">글번호</th>
					<th width="70">카테고리</th>
					<th width="300">제목</th>
					<th width="100">작성자</th>
					<th width="50">조회수</th>
					<th width="100">작성일</th>
				</tr>
			</thead>
			<tbody>
				<% if(list.isEmpty()) { %>
					<tr>
						<td colspan="6">조회된 리스트가 없습니다</td>
					</tr>
				<% } else { %>
					<% for(Board b : list) { %>
						<tr>
							<td><%= b.getBoardNo() %></td>
							<td><%= b.getCategory() %></td>
							<td><%= b.getBoardTitle() %></td>
							<td><%= b.getBoardWriter() %></td>
							<td><%= b.getCount() %></td>
							<td><%= b.getCreateDate() %></td>
						</tr>
					<% } %>
				<% } %>
				<!-- <tr>
					<td>10</td>
					<td>운동</td>
					<td>제목</td>
					<td>user01</td>
					<td>100</td>
					<td>2023-02-17</td>
				</tr>
				<tr>
					<td>11</td>
					<td>운동</td>
					<td>제목</td>
					<td>user01</td>
					<td>100</td>
					<td>2023-02-17</td>
				</tr>
				<tr>
					<td>12</td>
					<td>운동</td>
					<td>제목</td>
					<td>user01</td>
					<td>100</td>
					<td>2023-02-17</td>
				</tr>
				<tr>
					<td>13</td>
					<td>운동</td>
					<td>제목</td>
					<td>user01</td>
					<td>100</td>
					<td>2023-02-17</td>
				</tr> -->
			</tbody>
		</table>
		<br><br>
		
		<!-- 페이징바 영역 -->
		<div align="center" class="paging-area">
		
			<% if(currentPage != 1) { %>
				<button onclick="location.href='<%= contextPath %>/list.bo?currentPage=<%= currentPage-1 %>'">&lt;</button>
			<% } %>
			
			<% for(int i = startPage; i <= endPage; i++) { %>
				<% if(i != currentPage) { %>
					<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=i%>';"><%= i %></button>
				<% }else { %>
					<button disabled><%= i %></button>
				<% } %>
			<% } %>
			
			<!-- <button>1</button>
			<button>2</button>
			<button>3</button>
			<button>4</button>
			<button>5</button>
			<button>6</button>
			<button>7</button>
			<button>8</button>
			<button>9</button>
			<button>10</button> -->
			
			<% if(currentPage != maxPage) { %>
				<button onclick="location.href='<%= contextPath %>/list.bo?currentPage=<%= currentPage+1 %>'">&gt;</button>
			<% } %>
			
		</div>
	</div>
</body>
</html>