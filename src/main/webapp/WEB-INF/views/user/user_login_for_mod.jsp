<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/user_login.css" rel="stylesheet" type="text/css">
<title>로그인</title>
<script type="text/javascript">
function func() {
	alert("동작감지");
	var sId=document.getElementById('user_email').value;
	var passwd=document.getElementById('user_passwd').value;
	location.href='MyPage.us?sId='+sId+'&passwd='+passwd;
}

</script>
</head>
<body>
	<section class="login">
	
	   <h2>비밀번호 인증</h2>
		
		<form action="" method="get" id="join">
			<div class="log_tit">
		 		<input type="text" id="user_email" value="${param.sId }"required="required" title="아이디입력" >
		 		<input type="password" id="user_passwd" placeholder="비밀번호" title="비밀번호입력" "required="required">
			</div>
		 <div class="buttons">
		 <input type="button" value="마이페이지로" class="submit" onclick="func()">
		 </div> 
		</form>
	</section>
</body>
</html>