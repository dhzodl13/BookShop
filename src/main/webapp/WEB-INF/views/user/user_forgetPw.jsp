<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookshop : 비밀번호 찾기</title>
<link href="resources/css/user_forgetPw.css" rel="stylesheet" type="text/css">
</head>
<body>
	
	<section class="forgerpw">
		<div class="logo" >
		<a href="./">
			<img alt="로고" src="resources/images/BookShopLogo2.png">
		</a>
		</div>
	<h1>비밀번호 찾기</h1>
	
	<form action="UserFindPw.us" method="post" name="fr">
	
			
			<div class="email1"><input type="text" name="email" placeholder="이메일" required="required"></div>
		
			<div class="jumin">
			
			<div class="jumin1"><input type="text" name="jumin1" placeholder="주민번호" required="required" maxlength="6"></div> 
			<div class="sp"> - </div>			
			<div class="jumin2"><input type="password" name="jumin2" required="required" maxlength="7"></div>
				
			</div>
			<div class =find>
			<input type="submit" value="비밀번호 찾기" name="pwFind">
			</div>
	</form>
	</section>
</body>
</html>