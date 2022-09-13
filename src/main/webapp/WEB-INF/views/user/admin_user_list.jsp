<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>

<link href="resources/css/admin_user_list.css" rel="stylesheet"/>
<link href="resources/css/bootstrap-datepicker3.css" rel="stylesheet"/>
<link href="resources/css/bootstrap-datepicker3.standalone.css" rel="stylesheet"/>
<script src="resources/js/jquery-3.6.0.js"></script>
<script src="resources/js/bootstrap-datepicker.js"></script>
<script src="resources/js/bootstrap-datepicker.kr.min.js"></script>
<script type='text/javascript'>
$(function(){
	$('#datePicker1').datepicker({
		calendarWeeks: false,
		todayHighlight: true,
		autoclose: true,
		format: "yyyy-mm-dd",
		language: "kr"
	});
});
$(function(){
	$('#datePicker2').datepicker({
		calendarWeeks: false,
		todayHighlight: true,
		autoclose: true,
		format: "yyyy-mm-dd",
		language: "kr"
	});
});

$(function(){
	$("#search").on("click", function(){
	var formdata = $(".form_search").serialize();
	$.ajax({
		type:"post",
		url:"UserGetList.ad",
		data: formdata,
		dataType:"text",
	}).done(function(response) {
		$("#user_search_result").html(response);
	}).fail(function () {
		alert("AJAX 실패");
		});
	});
})
		function pageMove(pageNum) {
		$("#userPageNum").val(pageNum);
		var formdata = $(".form_page").serialize();
		$.ajax({
			type:"post",
			url:"UserGetList.ad",
			data: formdata,
			dataType:"text",
		}).done(function(response) {
				$("#user_search_result").html(response);
		}).fail(function () {
				alert("AJAX 실패");
			});
		};

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"/>
<form class="form_search">
<p>회원 관리</p>
	<div class="user_option">
		<div class="user_option_subject">
		검색 조건
		</div>
		<div class="cell">
			<div class="option_first">가입일자</div>
			<div class="option_second">시작일 <input type="text" id="datePicker1" name="startDate"></div>
			<div class="option_third">종료일 <input type="text" id="datePicker2" name="endDate"></div>
		</div>
		
		<div class="cell">
			<div class="option_first">총구매액</div>
			<div class="option_second nl"><input type="text"placeholder="이상"name="startWon">￦</div>
			<div class="option_third nl"><input type="text"placeholder="이하"name="endWon">￦</div>
		</div>
		
		<div class="cell">
			<div class="option_first">성별</div>
				<input type="radio" name="gender" value="남" checked="checked">남&nbsp;&nbsp;
				<input type="radio" name="gender" value="여">여
		</div>
		
		<div class="cell">
			<div class="option_first">검색</div>
			<div class="option_second">
				<select name="searchType" class="searchType">
					<option value="전체">전체</option>
					<option value="user_name">이름</option>
					<option value="user_email">아이디</option>
				</select>
				<input type="text" name="searchObject">
			</div>
		</div>
		<div class="cell2">
			<input type="button" value="찾기" id="search">
		</div>
	</div>
	
</form>
<div id="result_subject">
	<p>검색결과</p>
</div>
<form class="form_page">
	<div id="user_search_result"><!-- AJAX로 출력할 userList --></div>
</form>


</body>
</html>