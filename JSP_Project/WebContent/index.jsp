<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  
	* 회원서비스       |	C(Insert)	|	R(Select)	|	U(Update)	|	D(Delete)
	=================================================================================
	  로그인			|				|		o		|				|
	  회원가입			|		o		|				|				|
	[아이디 중복확인]   |				|		o		|				|
	  마이페이지		|				|		o		|				|
	  정보변경			|				|				|		o		|
	  회원탈퇴			|				|				|		o		|		o
	
	* 공지사항서비스	- 공지사항리스트조회(R) / 공지사항상세조회(R) / 공지사항작성(C) / 수정(U) / 삭제(U/D)
	* 일반게시판서비스   - 게시판리스트조회(R) / 게시판상세조회(R) / 게시판 작성(C) - (첨부파일 1개 업로드) / 수정(U) / 삭제(U/D)
					  [댓글리스트 조회(R)/작성(C)]
	* 사진게시판서비스   - 리스트조회(R) / 상세조회(R) / 작성(C) - (다중 첨부파일 업로드)
-->

	<%@ include file="views/common/menubar.jsp" %>
</body>
</html>