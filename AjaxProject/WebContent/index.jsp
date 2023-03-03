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
			xhr.send("id=user01&name=지연"); // 여러개 보내려면 어떻게?
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
	
	<h3>3. 서버로 데이터 전송 후 조회된 객체를 응답데이터로 받기</h3>
	회원번호 입력 : <input type="number" id="input3">
	<button onclick="test3();">조회</button>
	<div id="output3"></div>
	
	<script>
		function test3(){
			$.ajax({
				url : "jqAjax3.do",
				data : {no : $("#input3").val()},
				success : (result) => {
					console.log(result);
					
					let resultStr = "회원번호 : "+result.userNo+"<br>"
									+"이름 : "+result.userName+"<br>"
									+"아이디 : "+result["userId"]+"<br>"
									+"주소 : "+result["address"]
					$("#output3").html(resultStr);
				},
				error : function(req, status, error){
					console.log(req, status, error);
				}
			});
		}
	</script>
	
	<h3>4. 응답데이터로 여러개의 객체들이 담겨있는 ArrayList받기</h3>
	<button onclick="test4();">회원정보조회</button>
	<table id="output4" border="1" style="text-align:center">
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>아이디</th>
				<th>주소</th>
			</tr>
		</thead>
		<tbody>
		
		</tbody>
	</table>
	
	<script>
		function test4(){
			$.ajax({
				url : "<%= contextPath %>/jqAjax4.do",
				success : function(result){
					let str = "";
					
					for(let i = 0; i < result.length; i++) {
						str += "<tr>"
							    + "<td>"+result[i].userNo+"</td>"
							    + "<td>"+result[i].userName+"</td>"
							    + "<td>"+result[i]['userId']+"</td>"
							    + "<td>"+result[i]['address']+"</td>"
						str + "</tr>";
					}
					
					$("#output4 tbody").html(str);
				}
			});
		}
	</script>
	
	<h2>5. ajax를 활용한 자동완성기능 구현하기</h2>
	<select id="searchType">
		<option value="1">글제목</option>
		<option value="2">카테고리</option>
		<option value="3">글내용</option>
		<option value="4">작성자</option>
	</select>
	<input id='keyword' type="text" placeholder="찾을 게시글을 작성하세요">
	<select id="list">
	</select>
	
	<script>
	$(function(){
		$("#keyword").keyup(function(e){
			$.ajax({
				url : "<%= contextPath %>/jqAutoSearch.do",
				data : {
					keyword : $("#keyword").val(),
					searchType : $("#searchType").val()
					    },
				success : function(data){
					$("#list").html(""); // 리스트 비워주기
					console.log(data);
					
					let str = "";
					for(let i = 0; i<data.length; i++){
						str += "<option>"
							+ data[i].boardTitle
							+"</option>"
					}
					$("#list").html(str);
				}
			});
		});
	});
	</script>
	
	<h2>6. Ajax로 html파일 받아오기</h2>
	<button id="htmlAjax">html문서 받기</button>
	<div id="htmloutput"></div>
	
	<script>
		$(function(){
			$("#htmlAjax").click(function(){
				$.ajax({
					url : "<%= contextPath %>/jqHtmlTest.do",
					type : "post",
					dataType : "html",
					success : function(data){
						console.log(data);
						$("#htmloutput").html(data);
					}
				});
			});
		});
	</script>
	
	<h2>7. xml데이터 가져오기</h2>
	<button id="xmlTest">xml데이터 가져오기</button>
	<div id="fiction">
		<h2>소설</h2>
		<table id = "fiction-info">
		</table>
	</div>
	<div id="it">
		<h2>프로그래밍</h2>
		<table id = "it-info">
		</table>
	</div>
	
	<script>
		$(function(){
			$("#xmlTest").click(()=>{
				$.ajax({
					url : "books.xml",
					success : function(data){
						let ficheader = "<tr><th>제목</th><th>저자</th></tr>";
						let itheader = ficheader;
						console.log(data);
						
						//let entity = $(data).find("books");
						let entity = $(data).find(":root"); // 해당 xml파일의 시작태그를 가져올 수 있는 선택자
						console.log(entity);
						
						let books = $(entity).find("book");
						console.log(books);
						
						books.each(function(index, item){
							let info = "<tr>"
										+ "<td>"+$(item).find("title").text()+"</td>"
										+ "<td>"+$(item).find("author").text()+"</td>"
									 + "</tr>"
							let subject = $(item).find("subject").text();
							if(subject == "소설"){
								ficheader += info;
							}else if(subject == "프로그래밍"){
								itheader += info;
							}
						});
						
						$("#fiction-info").html(ficheader);
						$("#it-info").html(itheader);
					}
				});
			});
		});
	</script>
	
	<h2>8. Ajax를 이용한 파일 업로드 처리하기</h2>
	<input type="file" id="upfile" multiple>
	<button onclick="sendFile();">파일전송</button>
	
	<script>
		function sendFile(){
			// 비동기 방식으로 파일 전송시에는 FormData라는 객체를 생성해서 파일을 추가시켜줘야 함
			let form = new FormData();
			//console.log($("#upfile")[0], $("#upfile")[0].files[0]);
			//form.append("upfile", $("#upfile")[0].files[0]); 
			$.each($("#upfile")[0].files, function(index, item){
				console.log(index, item);
				form.append("upfile"+index, item);
			});
			
			$.ajax({
				url : "<%= contextPath %>/fileUpload.do",
				data : form,
				type : "post",
				processData : false,
				contentType : false, // 순수한 file형태로 보내기 위해 false로 해줘야 인코딩이 안됨
				success : function(data){
					alert("업로드성공");
					$("#upfile").val("");
				}
			}); 
		}
	</script>
</body>
</html>