<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<link href="resources/css/admin_main_design.css" rel="stylesheet">
<script src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"/>
<div class="wrapper">
<form action="ChangeMainAdPro.ad"  method="post" enctype="multipart/form-data">
<input type="hidden" name="ad_num" value=${param.main_ad_num }>
	
	
	<input type="text" class="text" name="ad_subject"  placeholder="슬라이드에 표시될 제목" required="required">
	<br>
	<input type="file" class="file" name="ad_file" required="required" >	
	<input type="submit">
</form>
</div>
</body>
</html>