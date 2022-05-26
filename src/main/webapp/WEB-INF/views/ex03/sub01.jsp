<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.min.js" integrity="sha512-OvBgP9A2JBgiRad/mM36mkzXSXaJE9BEIENnVEmeZdITvwT09xnxLtT4twkCa8m/loMbPHsvPl0T8lRGVBwjlQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>

<script>
	$(document).ready(function() {
		$("#button1").click(function() {
			$.ajax({url : "/spr2/ex03/sub03"});
		});
		$("#button2").click(function() {
			$.ajax({url : "/spr2/ex03/sub04"});
		});
		$("#button3").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub05", 
				type : "get"
			});
		});
		$("#button4").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub06", 
				method : "post"	// type : "post"와 같은 역할
			});
		});
		$("#button5").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub07", 
				type : "delete"
			});
		});
		$("#button6").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub08", 
				type : "put"
			});
		});
		$("#button7").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub09", 
				type : "get",	// type의 기본값은 get이므로 생략 가능
				data : {
					title : "Epl",
					writer : "Son"
				}
			});
		});
		$("#button8").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub10", 
				type : "post",
				data : {
					name : "Son",
					address : "Korea"
				}
			});
		});
		$("#button9").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub11", 
				type : "post",
				data : {
					title : "득점왕",
					writer : "Son"
				}
			});
		});
		$("#button10").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub10",
				type : "post",
				data : "name=Son&address=Korea"
			});
		});
		$("#button11").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub11",
				type : "post",
				data : "title=득점왕&writer=Son"
			});
		});
		$("#button12").click(function(e) {
			e.preventDefault();
			const dataString = $("#form1").serialize();
			$.ajax({
				url : "/spr2/ex03/sub10",
				type : "post",
				data : dataString
			});
		});
		$("#button13").click(function(e) {
			e.preventDefault();
			const dataString = $("#form2").serialize();
			$.ajax({
				url : "/spr2/ex03/sub11",
				type : "post",
				data : dataString
			});
		});
		
		$("#button14").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub12",
				type : "post",
				success : function(data) {
					console.log("요청 성공");
					console.log("받은 데이터", data);
				}
			});
		});
		
		$("#button15").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub13",
				type : "get",
				success : function(lotto) {
					// console.log(data);
					$("#result1").text(lotto);
				}
			});
		});
		$("#button16").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub14",
				type : "get",
				success : function(book) {
					/* console.log(book);
					console.log(book.title);
					console.log(book.writer); */
					$("#result2").text(book.title);
					$("#result3").text(book.writer);
				}
			});
		});
		$("#button17").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub15",
				success : function(data) {
					console.log(data);
				}
			});
		});
		$("#button18").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub16",
				type : "get",
				success : function(data) {
					console.log(data);
				},
				error : function() {
					console.log("ajax error!");
				}				
			
			});
		});
		$("#button19").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub16",
				type : "get",
				success : function(data) {
				},
				error : function() {
					$("#message19").show();
					$("#message19").text("ajax error!").fadeOut(3000);
				}				
			
			});
		});
		$("#button20").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub17",
				success : function(data) {
					console.log("받은 데이터 : ", data);
				},
				error : function() {
					console.log("ajax error!");
				}				
			
			});
		});
		$("#button21").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub18",
				success : function(data) {
					$("#message20").show();
					$("#message20").removeClass("error").text(data).fadeOut(3000);
				},
				error : function() {
					$("#message20").show();
					$("#message20").addClass("error").text("failed").fadeOut(3000);
				}				
			
			});
		});
		$("#button22").click(function() {
			$.ajax({
				url : "/spr2/ex03/sub18",
				success : function(data) {
					$("#message20").show();
					$("#message20").removeClass("error").text(data).fadeOut(3000);
				},
				error : function() {
					$("#message20").show();
					$("#message20").addClass("error").text("failed").fadeOut(3000);
				},				
				complete : function() {
					console.log("process complete");
				}
			});
		});
	});
</script>
<style>
	.error {
		background-color: red;
		color : yellow;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<!-- /spr2/ex03/sub03 -->
	<button id="button1">ajax 요청</button>
	
	<!-- 버튼 클릭시 /spr2/ex03/sub04 로 ajax 요청 보내기 -->
	<!-- controller에도 해당 경로 요청에 일하는 메소드 추가 -->
	<button id="button2">ajax 연습</button>
	
	<!-- /spr2/ex03/sub05 -->
	<button id="button3">get방식 요청</button>
	
	<!-- /spr2/ex03/sub06 -->
	<button id="button4">post방식 요청</button>
	
	<!-- /spr2/ex03/sub07 -->
	<button id="button5">delete방식 요청</button>
	
	<!-- /spr2/ex03/sub08 -->
	<button id="button6">put방식 요청</button>
	
	<hr />
	
	<p>서버로 데이터 보내기</p>
	<!-- /spr2/ex03/sub09 -->
	<button id="button7">get방식 데이터 보내기</button>
	
	<!-- /spr2/ex03/sub10 -->
	<button id="button8">post방식 데이터 보내기</button>
	
	<!-- /spr2/ex03/sub11 -->
	<button id="button9">post방식 데이터 보내기</button>
	
	<!-- /spr2/ex03/sub10 -->
	<button id="button10">post방식 데이터 보내기 (encoded string)</button>
	
	<!-- /spr2/ex03/sub11 -->
	<button id="button11">post방식 데이터 보내기2 (encoded string)</button>
	
	<hr />
	
	<p>폼 데이터 보내기</p>
	<form action="/spr2/ex03/sub10" id="form1" method="post">
		name : <input type="text" name="name"/><br />
		address : <input type="text" name="address" /><br />
		<input id="button12" type="submit"  value="전송" />
	</form>
	
	<form id="form2">
		title : <input type="text" name="title" /><br />
		writer : <input type="text" name="writer" /><br />
		<input type="submit" value="전송" id="button13"/>
	</form>
	
	<hr />
	
	<p>응답 처리</p>	
	<!-- url : /spr2/ex03/sub12 -->
	<button id="button14">응답 처리 1</button>
	
	<br />
	
	<button id="button15">로또 번호</button>
	<p>받은 번호 : <span id="result1"></span></p>
	
	<hr />
	
	<button id="button16">json 데이터 받기</button>
	<p>책 제목 : <span id="result2"></span></p>
	<p>책 저자 : <span id="result3"></span></p>
	
	<button id="button17">map</button>
	
	<hr />
	
	<p>요청 실패</p>
	<button id="button18">요청 실패</button>
	<br />
	<button id="button19">요청 실패2</button>
	<p class="error" id="message19"></p>
	
	<hr />
	
	<p>서버에서 응답</p>
	<button id="button20">서버 응답</button>
	
	<br />
	
	<button id="button21">50% 확률</button>
	<p class="error" id="message20"></p>
	
	<button id="button22">50% 확률 2</button>
</body>
</html>