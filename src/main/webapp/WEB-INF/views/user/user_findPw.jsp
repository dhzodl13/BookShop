<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 조회</title>
<link href="resources/css/user_findPw.css" rel="stylesheet" type="text/css">
</head>
<body>
	 <section class="pw_clear">
		<div class="logo" >
		<a href="./">
			<img alt="로고" src="resources/images/BookShopLogo2.png">
		</a>
		</div>
	<h1> 비밀번호 조회</h1>
	<div class="name1">
			${user.user_name }님의 비밀번호
	</div>
	<div class="passwd1">		
			${user.user_passwd}
	</div>
	</section>
</body>
</html>