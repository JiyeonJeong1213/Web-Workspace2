<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<style>
	#enroll-form table {margin: auto;}
	#enroll-form input {margin: 5px;}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<!-- ../ : 현재 위치로부터 한번 빠져나감(상위 디렉토리로 이동) -->
	<div class="outer">
		<br>
		<h2 align="center">회원가입</h2>
		<form id="enroll-form" action="${contextPath }/insert.me" method="post">
		  <!-- 아이디, 비밀번호, 이름, 전화번호, 이메일, 주소, 취미 -->
            <table>
                <!-- (tr>td*3)*8 -->
                <tr>
                    <td>* 아이디</td>
                    <td><input type="text" name="userId" maxlength="12" required></td>
                    <td><button type="button" onclick="idCheck();">중복확인</button></td> 
                </tr>
                <tr>
                    <td>* 비밀번호</td>
                    <td><input type="password" name="userPwd" maxlength="15" required></td>
                    <td></td>
                </tr>
                <tr>
                    <td>* 비밀번호 확인</td>
                    <td><input type="password" maxlength="15" required></td> <!-- 단순 비교 확인 용도라 key 값을 부여 안해도 됨 -->
                    <td></td>
                </tr>
                <tr>
                    <td>* 이름</td>
                    <td><input type="text" name="userName" maxlength="6" required></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;전화번호</td>
                    <td><input type="text" name="phone" placeholder="- 포함해서 입력"><td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;이메일</td>
                    <td><input type="email" name="email"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;주소</td>
                    <td><input type="text" name="address"></td>
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
            <br><br>
            <div align="center">
            	<button type="submit" disabled>회원가입</button>
            	<button type="reset">초기화</button>
            </div>
		</form>
	</div>
	
	<script>
		function idCheck(){
			// 아이디를 입력하는 input요소 얻어오기
			console.log($("#enroll-form input[name='userId']").val());
			const $userId = $("#enroll-form input[name='userId']");
			// 비동기 요청 보내기
			$.ajax({
				url : "${contextPath }/idCheck.me",
				data : {id : $userId.val()},
				success : function(result) {
					if(result == "NNNNN"){
						// 이미 존재하는 아이디인 경우
						alert("이미 존재하거나 회원 탈퇴한 아이디 입니다.");
						$userId.val("");
						$userId.focus();
					}else{
						// 사용 가능한 경우
						if(confirm("사용가능한 아이디 입니다. 사용 하시겠습니까?")){
							// 아이디값 수정할 수 없게 막기
							$userId.attr("readonly", true);
							// 회원가입버튼 활성화
							$("button[type='submit']").removeAttr("disabled");
						}else{
							$userId.val("");
							$userId.focus();
						}
					}				
				},
				error : function(){
					console.log("아이디 중복체크 실패");
				}
			});
		}
	</script>
	
</body>
</html>