<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
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
</head>
<body>
	<my:navBar current="login"></my:navBar>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
				<h1>로그인</h1>
			
				<form action="${appRoot }/login" method="post">
					<label for="userIdInput1" class="form-label">
						ID 
					</label>
					<input id="userIdInput" class="form-control" type="text" name="username"/>
					
					<label for="userPwInput1" class="form-label">
						PassWord
					</label>
					<input id="userPwInput1" class="form-control" type="password" name="password"/>
					
					<div class="form-check">
						<input id="rememberMeCheck1" class="form-check-input" type="checkbox" name="remember-me" />
						 <label for="rememberMeCheck1">
							 자동로그인
						 </label>
					</div>
						<input class="btn btn-primary" type="submit" value="로그인"/>
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>