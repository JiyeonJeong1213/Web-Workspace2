<%@ page import="com.kh.notice.model.vo.Notice" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    Notice n = (Notice) request.getAttribute("n");
    // 글번호(noticeNo), 글제목(noticeTitle), 글내용, 아이디, 작성일
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file = "../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		<h2 align="center">공지사항 상세보기</h2>
		<br>
		
		<table id="detail-area" align="center" border="1">
			<tr>
				<th width="70">제목</th>
				<td width="350" colspan="3"><%= n.getNoticeTitle() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%= n.getNoticeWriter() %></td>
				<th>작성일</th>
				<td><%= n.getCreateDate() %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<p style="height:150px;"><%= n.getNoticeContent() %></p>
				</td>
			</tr>
		</table>
		<br><br>
		
		<div align="center">
			<a href="<%=contextPath %>/list.no" class="btn btn-secondary btn-sm">목록</a>
			
			<% if(loginUser != null && loginUser.getUserId().equals(n.getNoticeWriter())) { %>
				<!-- 현재 로그인을 한 사용자가 해당 글을 작성한 작성자일 경우에만 보여지도록 컨트롤 -->
				<a href="<%= contextPath %>/updateForm.no?nno=<%= n.getNoticeNO() %>" class="btn btn-warning btn-sm">수정</a>
				<a href="<%= contextPath %>/deleteForm.no?nno=<%= n.getNoticeNO() %>" class="btn btn-danger btn-sm">삭제</a>
			<% } %>
		</div>
	</div>
</body>
</html>