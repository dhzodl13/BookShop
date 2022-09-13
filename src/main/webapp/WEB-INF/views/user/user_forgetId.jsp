<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookshop : ID 찾기</title>
<link href="resources/css/user_forgetId.css" rel="stylesheet" type="text/css">
</head>
<body>

	<section class="forgetid">
		<div class="logo" >
		<a href="./">
			<img alt="로고" src="resources/images/BookShopLogo2.png">
		</a>
		</div>
	<h1>ID 찾기</h1>
	
		
	<form action="UserFindId.us" method="post" name="fr">
		
		<div class="name1"><input type="text" name="name" placeholder="이름" required="required"></div>
			
		<div class="jumin">
		
		<div class="jumin1">		
	    	<input type="text" name="jumin1"  placeholder="주민번호"required="required" maxlength="6">
	    </div>
	    <div class="sp"> - </div>
	   	<div class="jumin2"><input type="password" name="jumin2" required="required" maxlength="7"></div>
   			
		</div>
		
		<div class =find>
		<input type="submit" value="ID 찾기" name="idFind">
		</div>
	</form>
	</section>
</body>
</html>