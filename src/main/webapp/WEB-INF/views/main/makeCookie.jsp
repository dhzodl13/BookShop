<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Cookie cookie = new Cookie("checkCookie","checked");
//기능 테스트용 유효시간 5초
//cookie.setMaxAge(5);
//쿠키 유효기간 하루
cookie.setMaxAge(60*60*24);
response.addCookie(cookie);
%>

<script type="text/javascript">
	window.close();
</script>