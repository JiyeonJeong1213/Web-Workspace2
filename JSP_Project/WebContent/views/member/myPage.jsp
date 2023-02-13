<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
	#mypage-form table{margin:auto;}
	#mypage-form input{margin:5px;}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<% 
		String userId = loginUser.getUserId();
		String userName = loginUser.getUserName();
		String phone = loginUser.getPhone();
		String email = loginUser.getEmail();
		String address = loginUser.getAddress();
		String interest = loginUser.getInterest();
	%>
	
	<div class="outer">
		<br>
		<h2 align="center">마이페이지</h2>
		
		<form id="mypage-form" action="<%= contextPath %>/update.me" method="post">
			<table>
                <!-- (tr>td*3)*8 -->
                <tr>
                    <td>* 아이디</td>
                    <td><input type="text" name="userId" maxlength="12" required readonly value="<%= userId %>"></td>
                    <td></td> 
                </tr>
                <tr>
                    <td>* 이름</td>
                    <td><input type="text" name="userName" maxlength="6" required value="<%= userName %>"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;전화번호</td>
                    <td><input type="text" name="phone" placeholder="- 포함해서 입력" value="<%= phone == null ? "" : phone %>"><td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;이메일</td>
                    <td><input type="email" name="email" value="<%= email == null ? "" : email %>"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;주소</td>
                    <td><input type="text" name="address" value="<%= address==null?"":address %>"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;관심분야</td>
                    <td colspan="2">
                        <!-- (input[type=checkbox name=interest id= value=]+label)*6 -->

                        <input type="checkbox" name="interest" id="sports" value="운동">
                        <label for="sports">운동</label>

                        <input type="checkbox" name="interest" id="hiking" value="등산">
                        <label for="hiking">등산</label>

                        <input type="checkbox" name="interest" id="fishing" value="낚시">
                        <label for="fishing">낚시</label>

                        <br>

                        <input type="checkbox" name="interest" id="cooking" value="요리">
                        <label for="cooking">요리</label>

                        <input type="checkbox" name="interest" id="game" value="게임">
                        <label for="game">게임</label>

                        <input type="checkbox" name="interest" id="movie" value="영화">
                        <label for="movie">영화</label>
                    </td>
                </tr>
            </table>
            
            <script>
            	$(function(){
            		let interest = "<%= interest == null ? "" : interest %>"
            		// "" or "운동, 등산, 게임"
            		
            		$("input[name='interest']").each(function(){
            			// 순차적으로 접근한 input요소의 value값을 가져와서 interest변수 안에 value값이 포함되어있는지 확인
            			// 포함되어 있다면 현재 접근한 input요소에 checked속성 부여
            			if(interest.search($(this).val())>=0) { // interest문자열로부터 현재 체크박스의 value가 포함되어있는지 확인
            													// 문자열.search(찾고자하는 문자열) -> 찾고자 하는 문자열의 인덱스를 반환해줌
            				$(this).attr("checked",true);
            			}
            		});
            	});
            </script>
           
            <br><br>
           
           <div align="center">
           		<button type="submit" class="btn btn-secondary btn-sm">정보변경</button>
           		<button type="button" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#updatePwdForm">비밀번호 변경</button>
           		<button type="button" class="btn btn-danger btn-sm" data-toggle="modal" date-target="#deleteForm">회원탈퇴</button>
           </div> 
		</form>
	</div>
</body>
</html>