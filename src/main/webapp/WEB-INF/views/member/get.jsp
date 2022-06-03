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
	<my:navBar current="memberInfo"></my:navBar>
	
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
			
				<h1>회원 정보 보기</h1>
				
				<div>
					<p>${message }</p>
				</div>
				
				<div>
					<label for="idInput1" class="form-label">
						ID
					</label>
					<input id="idInput1" class="form-control" type="text" value="${member.id }" readonly/>
					
					<label for="passwordInput1" class="form-label">
						PassWord
					</label>
					<input class="form-control" id="passwordInput1" type="text" value=""  />

					<label for="passwordInput2" class="form-label">
						PassWord Check
					</label>
					<input class="form-control" id="passwordInput2" type="text" value=""  />
					
					<p class="form-text" id="passwordMessage1"></p>
					
					<label for="emailInput1" class="form-label">
						Email
					</label>
					<div class="input-group">
						<input id="emailInput1" class="form-control" type="email" value="${member.email }" /> 
						<button id="emailCheckButton1"  class="btn btn-secondary" disabled>이메일 중복확인</button>
					</div>
					
					<p class="form-text" id="emailMessage1"></p>
					
					<label for="nickNameInput1" class="form-label">
						NickName
					</label>
					<div class="input-group">
						<input id="nickNameInput1" class="form-control" type="text" value="${member.nickName }" /> 
						<button id="nickNameCheckButton1" class="btn btn-secondary" disabled>닉네임중복확인</button>
					</div>
					
					<p id="nickNameMessage1" class="form-text"></p>

					<label for="" class="form-label">
						가입일
					</label>
					<input class="form-control" type="datetime-local" value="${member.inserted }" readonly />
				</div>
				
				<div class="mt-3">
					<button id="editButton1" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modal2" disabled>수정</button>
					<button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modal1">삭제</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- delete Modal -->
	<div class="modal fade" id="modal1" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel1">기존 암호 입력</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form1" action="${appRoot }/member/remove" method="post">
						<input type="hidden" value="${member.id }" name="id"/>
						<label for="passwordInput3" class="form-label">
				        	PassWord
				        </label>
				        <input id="passwordInput3" class="form-control" type="text" name="password" />
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
					<h5 class="modal-title" id="exampleModalLabel2">기존 암호 입력</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form2" action="${appRoot }/member/modify" method="post">
						<input type="hidden" value="${member.id }" name="id"/>
						<input type="hidden" name="password"/>
						<input type="hidden" name="email"/>
						<input type="hidden" name="nickName"/>
						<label for="passwordInput4" class="form-label">
		     				기존 암호 
	        			</label>
	        			<input id="passwordInput4" class="form-control" type="text" name="oldPassword" />
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