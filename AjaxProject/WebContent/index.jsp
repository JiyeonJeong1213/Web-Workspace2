<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<h1>Ajax 개요</h1>
	
	<p>
		Asynchronous JavaScript And Xml의 약자 <br><br>
		서버로부터 데이터를 가져와 전체 페이지를 새로고침하지 않고 일부만 로드할 수 있게 하는 기법<br>
		우리가 기존에 a태그로 요청하거나 form태그를 통해 요청했던 방식은 동기식 요청방식 <br>
		=> 응답페이지가 돌아와야 볼 수 있으며 응답페이지가 호출되기 전까지 아무 요청하지 못함 <br>
		비동기식 요청을 보내기 위해서는 AJAX라는 기술이 필요함
		<br><br>
		
		* 동기식/비기식 <br>
		- 동기식 : 요청 처리 후 그에 해당하는 응답페이지가 돌아와야만 그 다음 작업 가능함<br>
		만약 서버에서 호출된 결과까지의 시간이 지연되면 계속 기다려야 함(흰화면으로 보이게 됨) <br>
		전체 페이지가 리로드 됨(새로고침 즉, 페이지가 기본적으로 한번 깜빡거림)<br><br>
		
		- 비동기식 : 현재 페이지를 그대로 유지하면서 중간중간 추가적인 요청을 보내줄 수 있음 <br>
		요청을 한다고 해서 다른 페이지로 넘어가지 않음(현재 페이지 유지) <br>
		요청을 보내놓고 그에 해당하는 응답이 돌아올 때 까지 현재 페이지에서 다른 작업을 할 수 있음 <br>
		ex) 아이디 중복체크기능, 검색어 자동 완성 기능 <br><br>
		
		* 비동기식의 단점 <br>
		- 현재 페이지에 지속적으로 리소스가 쌓임 => 페이지가 느려질 수 있음 <br>
		- 페이지 내 복잡도가 크게 증가함 -> 에러발생시 대처가 어려워질 수 있음 <br>
		- 요청 후 돌아온 응답데이터를 가지고 현재 페이지에 새로운 요소를 만들어서 뿌려줘야 되는데,
		  DOM요소를 새로이 만들어내는 구문을 잘 숙지해야 함 <br><br>
	</p>
	
	<h1>javascript방식을 이용한 Ajax테스트</h1>
	
	<h3>자바스크립트를 이용한 ajax통신</h3>
	
	<h3>1. 버튼 클릭시 get방식으로 서버에 데이터 전송 및 응답</h3>
	<button onclick="ajaxTest1();">JavaScript ajax 테스트1(GET방식)</button>
	
	<h3>2. 버튼 클릭시 post방식으로 서버에 데이터 전송 및 응답</h3>
	<button onclick="ajaxTest2();">JavaScript ajax 테스트2(POST방식)</button>
	
	<div id="target"></div>
	
	<script>
		function ajaxTest1(){
			// ajax로 서버와 통신하기
			
			// 1. XMLHttpRequest 객체 생성하기
			const xhr = new XMLHttpRequest();
			
			// 2. XMLHttpRequest객체를 설정하기
			// open()함수를 이용해서 통신값을 설정
			// 매개변수1 : get/post, 매개변수2 : 요청을 보내는 주소, [매개변수3 : 동기식/비동기식]
			// *클라이언트가 보내는 값을 파라미터로 전송
			xhr.open("get", "<%= contextPath %>/ajaxTest.do?id=admin");
			
			// 3. 요청에 대한 서버 응답을 처리할 함수를 지정
			// xhr객체의 onreadystatechange속성에 이벤트핸들러를 추가
			// xhr객체의 상태를 관리하는 속성
			// 1) readystate : 전송상태를 관리
			// 2) status : 응답결과를 관리
			
			xhr.onreadystatechange = function(){
				
				if(xhr.readyState == 4){ // 응답완료
					if(xhr.status == 200) { // 정상적으로 수신완료
						// 서버가 응답한 내용은 xhr객체의 responseText라는 속성에 자동으로 들어감
						console.log(xhr.responseText);
						document.getElementById("target").innerHTML += "<h3>"+xhr.responseText+"</h3>";
					}else if(xhr.status == 404) { // 찾는 페이지(url)가 존재하지 않는다
						alert("찾는 페이지가 존재하지 않습니다.");
					}else { // 그 외 에러
						alert("에러가 발생했습니다.");
					}
				}
			}
			
			// 4. 설정 완료 후 요청을 보냄(send)
			xhr.send();
		}
		
		function ajaxTest2(){
			const xhr = new XMLHttpRequest();
			
			xhr.open("post", "<%= contextPath %>/ajaxTest.do");
			
			xhr.onreadystatechange = function(){
				
				if(xhr.readyState == 4) {
					if(xhr.status == 200) {
						document.getElementById("target").innerHTML += "<h4>"+xhr.responseText+"</h4>";
					}
				}
			}
			
			// post방식으로 데이터 전송시 파라미터 설정 방법
			// url에 데이터 내용을 작성하지 않고, send함수의 매개변수로 작성해야 함
			// 전송방식도 수정해줘야 함
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.send("id=user01");
		}
	</script>
	
	<pre>
		* jQuery방식에서의 AJAX통신
		
		$.ajax({
			속성명:속성값,
			속성명:속성값,
			속성명:속성값,
			...
		});
		
		* 주요속성
		- url : 요청할 url(필수)
		- type|method : 요청전송방식(get/post, 생략시 기본값은 get)
		- data : 요청시 전달할 값
		- success : ajax통신 성공시 실행할 함수를 정의
		- error : ajax통신 실패시 실행할 함수를 정의
		- complete : ajax통신 실패했든 성공했든 무조건 실행할 함수 정의
		
		* 부수적인 속성
		- async : 서버와의 비동기 처리방식 설정 여부(기본값 true)
		- contentType : request의 데이터 인코딩 방식 정의(보내는 측의 데이터 인코딩)
		- dataType : response로 오는 데이터의 자료형 설정(값을 추가 안 하면 스마트하게 판단함)
					 text : String데이터
					 xml : 트리형태의 구조
					 json : 맵 형태의 구조(일반적인 데이터 구조)
					 script : javascript 및 일반 String 형태의 데이터
					 html : html태그 자체를 return하는 방식
		- accept : 파라미터의 타입 설정 (사용자 특화된 파라미터 타입 설정 가능)
		- beforeSend : ajax요청을 하기 전에 실행되는 이벤트핸들러(데이터 가공 및 header관련 설정)
		- cache : 요청 및 결과값을 scope에서 갖고 있지 않도록 하는 것 (기본값 true)
		- contents : jQuery에서 response의 데이터를 파싱하는 방식 정의
		- crossDomain : 타 도메인 호출 가능 여부(기본값 false)
		- dataFilter : response데이터를 받았을 때 정상적인 값을 return할 수 있도록 데이터와 데이터 타입 설정
		- global : 기본 이벤트 사용여부 => 버퍼링값이 시작과 끝을 나타낼 때, 선처리 작업시 사용함
		- password : 서버에 접속권한이 필요한 경우 설정
		- processDta : 서버로 보내는 값에 대한 형태 설정 여부 (기본데이터 원하는 경우 false)
		- timeout : 서버 요청시 응답 대기시간 설정(ms단위)
	</pre>
	
	<h1>jQuery방식을 이용한 AJAX테스트</h1>
	
	<h3>1. 버튼 클릭시 get방식으로 서버에 데이터 전송 및 응답</h3>
	
	입력 : <input type="text" id="input1">
	<button id="btn1">전송</button>
	<br>
	응답 : <label id="output1">응답 대기 중...</label>
	
	<script>
		$(function(){
			$("#btn1").click(function(){
				// 기존의 동기식 방식
				// location.href = "/ajax/url.do?input="+input.value;
				
				// 비동기식 통신 : 페이지 전환이 되지 않음
				$.ajax({
					url : '<%= contextPath %>/jqAjax1.do',
					type : 'get',
					data : {input : $("#input1").val()},
					success : function(result){ // 매개변수에는 서블릿으로부터 전달받은 응답데이터가 담겨있다.
						console.log(result);
						$("#output1").text(result);
					},
					error : function(){
						console.log("ajax통신 실패");
					},
					complete : function(){
						console.log("ajax통신 여부와 상관 없이 항상 실행됨");
					}
				});
			});
		});
	</script>
	
	<hr><br>
	
	<h3>2. 버튼 클릭시 post방식으로 서버에 데이터 전송 및 응답</h3>
	이름 : <input type="text" id="input2_1"> <br>
	나이 : <input type="number" id="input2_2"> <br>
	<button onclick="test2();">전송</button>
	<br>
	응답 : <label id="output2">응답대기중...</label>
	
	<script>
		// 버전1) 문자열데이터 응답 받기
		function test2(){
			<%-- $.ajax({
				url : "<%= contextPath %>/jqAjax2.do",
				data : {
					name : $("#input2_1").val(),
					age : $("#input2_2").val()
				},
				type : "post",
				success : function(result) {
					$("#output2").text(result);
					
					// 입력값을 초기화
					$("#input2_1").val("");
					$("#input2_2").val("");
				},
				error : function(){
					console.log("ajax통신 실패");
				}
			}); --%>
			
			// 버전2) JSON데이터 응답 받기
			$.ajax({
				url : "<%= contextPath %>/jqAjax2.do",
				data : {
					name : $("#input2_1").val(),
					age : $("#input2_2").val()
				},
				type : "post",
				success : function(result){
					console.log(result);
					
					// JSONArray로 응답 받는 경우
					//$("#output2").text("이름 : "+result[0]+", 나이 : "+result[1]);
					
					// JSONObject로 응답 받는 경우
					$("#output2").text("이름 : "+result.name+", 나이 : "+result.age);
				},
				error : function(){
					console.log("통신실패");
				}
			});
		}
	</script>
</body>
</html>