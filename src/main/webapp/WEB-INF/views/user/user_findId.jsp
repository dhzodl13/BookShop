<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 조회</title>
	<link href="resources/css/user_findId.css" rel="stylesheet" type="text/css">
</head>
<body>
 <section class="id_clear">
		<div class="logo" >
		<a href="./">
			<img alt="로고" src="resources/images/BookShopLogo2.png">
		</a>
		</div>
	<h1> ID 조회</h1>
		<div class="id1">	
			${user.user_name }님의 아이디
		</div>
		<div class="email1">
			${user.user_email }
		</div>
 </section>
</body>
</html>