<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반게시판 상세보기</title>
<style>
	.outer table{
		border-color:white;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		<h2 align="center">일반게시판 상세보기</h2>
		<br>
		<table id="detail-area" align="center" border="1">
			<tr>
				<th width="70">카테고리</th>
				<th width="70">운동</th>
				<th width="70">제목</th>
				<td width="350">제목부분입니다</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>user01</td>
				<th>작성일</th>
				<td>2023-02-20</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<p style="height:200px">글내용글내용글내용</p>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<!-- 첨부파일이 없을 경우 : 첨부파일이 없습니다. -->
					
					<!-- 첨부파일이 있을 경우 : -->
					<a download="파일원본명" href="해당파일이존재하는경로">파일원본명</a>
				</td>
			</tr>
		</table>
		
		<br>
		
		<div align="center">
			<a href="<%= contextPath %>/list.bo?currentPage=1" class="btn btn-secondary btn-sm">목록가기</a>
			
			<!-- 로그인한 사용자가 해당 게시글의 작성자인 경우 -->
			<%-- <% if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())){ %>
				<a href="<%= contextPath %>/updateForm.bo?bno=<%= b.getBoardNo() %>" class="btn btn-warning btn-sm">수정하기</a>
				<a href="<%= contextPath %>/delete.bo?bno=<%= b.getBoardNo() %>" class="btn btn-danger btn-sm">삭제하기</a>
			<% } %> --%>
		</div>
		
		<br>
		<!-- 댓글 기능 화면 구현만 해두기. 요 아래는 작업 x -->
		
		<div id="reply-area">
			<table border="1" align="center">
				<thead>
					<% if(loginUser != null) { %>
						<!-- 로그인이 되어있을 경우 -->
						<tr>
							<th>댓글작성</th>
							<td>
								<textarea id="replyContent" cols="50" rows="3" style="resize:none;"></textarea>
							</td>
							<td>
								<button onclick="insertReply();">댓글등록</button>
							</td>
						</tr>
					<% } else {%>
						<tr>
							<th>댓글작성</th>
							<td>
								<textarea id="replyContent" cols="50" rows="3" style="resize:none;" readonly>로그인 후 이용 가능한 서비스입니다.</textarea>
							</td>
							<td>
								<button disabled>댓글등록</button>
							</td>
						</tr>
					<% } %>
				</thead>
				<tbody>
					<tr>
						<td>user01</td>
						<td>테스트 댓글</td>
						<td>2023-02-20</td>
					</tr>
					<tr>
						<td>user01</td>
						<td>테스트 댓글</td>
						<td>2023-02-20</td>
					</tr>
					
					<tr>
						<td>user01</td>
						<td>테스트 댓글</td>
						<td>2023-02-20</td>
					</tr>
					
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>