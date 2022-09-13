<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
function check(){
	// 하루동안 열지 않음 체크 시 check() 함수 실행되고 makeCookie.jsp로 포워딩
	// _self => 현재페이지를 대체
	window.open("MakeCookie.us","_self");
}
</script>
<title>이벤트</title>
</head>
<body>
	<img src="resources/images/popup.png" style="max-width:100%; height:auto;">
	<div align="right">
		<input type="checkbox" onclick="check()">하루동안 열지 않기 |
		<input type="button" value="닫기" onclick="window.close()">
	</div>
</body>
</html>
