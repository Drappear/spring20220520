<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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
<title>Insert title here</title>
<script>
	$(document).ready(function() {
		
		let passwordCheck = true;
		let emailCheck = true;
		let nickNameCheck = true;
		
		// 이메일 변경시 버튼 활성화
		const oldEmail = $("#emailInput1").val();
		
		$("#emailInput1").keyup(function() {
			const newEmail = $("#emailInput1").val();
			
			if(oldEmail === newEmail) {
				$("#checkEmailButton1").attr("disabled", "");
				$("#emailMessage1").text("");
			} else {
				$("#checkEmailButton1").removeAttr("disabled");				
			}
		});
		
		// ajax 이메일 중복 확인
		$("#checkEmailButton1").click(function(e) {
			e.preventDefault();
			
			const data = {email : $("#emailInput1").val()};
			
			emailCheck = false;
			
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch(data) {
						case "available" :
							$("#emailMessage1").text("사용 가능한 이메일 입니다.");	
							emailCheck = true;
							break;
						case "unavailable" :
							$("#emailMessage1").text("사용중인 이메일 입니다.");
							break;
					}
				},
				error : function() {
					$("#emailMessage1").text("중복 확인 중 문제 발생, 다시 시도해 주세요.");
				},
				complete : function() {
					$("#checkEmailButton1").removeAttr("disabled");
					enableEdit();
				}
			});
		});
		
		// 닉네임 변경시 버튼 활성화
		const oldNickName = $("#nickNameInput1").val();
		
		$("#nickNameInput1").keyup(function() {
			const newNickName = $("#nickNameInput1").val();
			
			if(oldNickName === newNickName) {
				$("#checkNickNameButton1").attr("disabled", "");
				$("#nickNameMessage1").text("");
			} else {
				$("#checkNickNameButton1").removeAttr("disabled");				
			}
		});
		
		// ajax 닉네임 중복 확인
		$("#checkNickNameButton1").click(function(e) {
			e.preventDefault();
			
			const data = {nickName : $("#nickNameInput1").val()};
			
			nickNameCheck = false;
			
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch(data) {
						case "available" :
							$("#nickNameMessage1").text("사용 가능한 닉네임 입니다.");
							nickNameCheck = true;
							break;
						case "unavailable" :
							$("#nickNameMessage1").text("사용중인 닉네임 입니다.");
							break;
					}
				},
				error : function() {
					$("#nickNameMessage1").text("중복 확인 중 문제 발생, 다시 시도해 주세요.");
				},
				complete : function() {
					$("#checkNickNameButton1").removeAttr("disabled");
					enableEdit();
				}
			});
		});
		
		// 암호, 암호확인
		
		$("#passwordInput1, #passwordInput2").keyup(function() {
			const pw1 = $("#passwordInput1").val();
			const pw2 = $("#passwordInput2").val();
			
			if(pw1 === pw2)	{
				$("#passwordMessage1").text("패스워드가 일치합니다.");
				passwordCheck = true;
			} else {
				$("#passwordMessage1").text("패스워드가 일치하지 않습니다.");
				passwordCheck = false;
			}
			
			enableEdit();
		});
		
		// 수정 버튼 활성화/비활성화
		const enableEdit = function () {
			if (passwordCheck && emailCheck && nickNameCheck) {
				$("#editButton1").removeAttr("disabled");
			} else {
				$("#editButton1").attr("disabled", "");
			}
		};
		
		// 수정 버튼 클릭시
		$("#editSubmitButton1").click(function(e) {
			e.preventDefault();
			const form2 = $("#form2");
			
			// input 값
			form2.find("[name=password]").val($("#passwordInput1").val());
			form2.find("[name=email]").val($("#emailInput1").val());
			form2.find("[name=nickName]").val($("#nickNameInput1").val());
			
			// submit
			form2.submit();
		});
	});
</script>
</head>
<body>
	<my:navBar></my:navBar>
	
	<c:if test="${not empty message }">
		<div class="alert alert-primary">
			${message }
		</div>
	</c:if>
	
	<div>
		ID : <input name="id" type="text" value="${member.id }"/><br />
		암호 : <input id="passwordInput1" type="text" value="${member.password }"/><br />
		암호 확인 : <input id="passwordInput2" type="text" value="${member.password }"/><br />
		<p id="passwordMessage1"></p>
		<br />
		Email : <input id="emailInput1" name="email" type="email" value="${member.email }"/> <button id="checkEmailButton1" disabled>이메일 중복 확인</button> <br />
		<p id="emailMessage1"></p>
		<br />
		닉네임 : <input id="nickNameInput1" name="nickName" type="text" value="${member.nickName }"/> <button id="checkNickNameButton1" disabled>닉네임 중복 확인</button> <br />
		<p id="nickNameMessage1"></p>
		<br />
		가입일 : <input type="datetime-local" value="${member.inserted }"/><br />
	</div>
	
	<div>
		<button id="editButton1" data-bs-toggle="modal" data-bs-target="#modal2" disabled>수정</button>
		<button data-bs-toggle="modal" data-bs-target="#modal1">삭제</button>
	</div>
	
	<!-- delete Modal -->
	<div class="modal fade" id="modal1" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel1">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form1" action="${appRoot }/member/remove" method="post">
						<input type="hidden" value="${member.id }" name="id"/>
						암호 : <input type="text" name="password"/>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">Close</button>
					<button form="form1" type="submit" class="btn btn-danger">탈퇴</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- edit Modal -->
	<div class="modal fade" id="modal2" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel2">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form2" action="${appRoot }/member/edit" method="post">
						<input type="hidden" value="${member.id }" name="id"/>
						<input type="hidden" name="password"/>
						<input type="hidden" name="email"/>
						<input type="hidden" name="nickName"/>
						암호 : <input type="text" name="oldPassword"/>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">Close</button>
					<button id="editSubmitButton1" form="form2" type="submit" class="btn btn-primary">수정</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>