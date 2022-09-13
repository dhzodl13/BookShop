<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 QnA 리스트</title>



<link href="resources/css/admin_qna_list.css" rel="stylesheet"/>
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
			if("${param.qna_type}" == "상품"){
			var productform = $(".form_product").serialize();
				$.ajax({
					type:"post",
					url:"QnaGetList.ad",
					data: productform,
					dataType:"text",
				}).done(function(response) {
						$("#qna_search_result").html(response);
				}).fail(function () {
						alert("AJAX 실패");
				});
			}
			else if("${param.qna_type}" == "계정"){
			$(".qna_type").val("계정").prop("selected",true);
			var normalform = $(".form_normal").serialize();
				$.ajax({
					type:"post",
					url:"QnaGetList.ad",
					data: normalform,
					dataType:"text",
				}).done(function(response) {
						$("#qna_search_result").html(response);
				}).fail(function () {
						alert("AJAX 실패");
				});
			}
			else if("${param.qna_type}" == "전체"){
				$(".qna_type").val("계정").prop("selected",true);
				var form_all = $(".form_all").serialize();
					$.ajax({
						type:"post",
						url:"QnaGetList.ad",
						data: form_all,
						dataType:"text",
					}).done(function(response) {
							$("#qna_search_result").html(response);
					}).fail(function () {
							alert("AJAX 실패");
					});
				}
			$("#search").on("click", function(){
			var formdata = $(".form_search").serialize();
				$.ajax({
					type:"post",
					url:"QnaGetList.ad",
					data: formdata,
					dataType:"text",
				}).done(function(response) {
						$("#qna_search_result").html(response);
				}).fail(function () {
						alert("AJAX 실패");
					});
				});
			});
		
		function pageMove(pageNum) {
			$("#qnaPageNum").val(pageNum);
			var formdata = $(".form_page").serialize();
			$.ajax({
				type:"post",
				url:"QnaGetList.ad",
				data: formdata,
				dataType:"text",
			}).done(function(response) {
					$("#qna_search_result").html(response);
			}).fail(function () {
					alert("AJAX 실패");
				});
			};
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"/>
<!-- 파라미터가 상품일경우 넘겨줄 파라미터 정의 -->
	<form class="form_product">
		<input type="hidden" name="startDate">
		<input type="hidden" name="endDate">
		<input type="hidden" name="searchObject">
		<input type="hidden" name="qna_rep" value="repno">	
		<input type="hidden" name="order_by" value="ASC">	
		<input type="hidden" name="qna_type" value="상품">	
	</form>
<!-- ------------------------------ -->
<!-- 파라미터가 계정일경우 넘겨줄 파라미터 정의 -->
	<form class="form_normal">
		<input type="hidden" name="startDate">
		<input type="hidden" name="endDate">
		<input type="hidden" name="searchObject">
		<input type="hidden" name="qna_rep" value="repno">	
		<input type="hidden" name="order_by" value="ASC">	
		<input type="hidden" name="qna_type" value="계정">	
	</form>
<!-- ------------------------------ -->
<!-- 파라미터가 전체일경우 넘겨줄 파라미터 정의 -->
	<form class="form_all">
		<input type="hidden" name="startDate">
		<input type="hidden" name="endDate">
		<input type="hidden" name="searchObject">
		<input type="hidden" name="qna_rep" value="repno">	
		<input type="hidden" name="order_by" value="ASC">	
		<input type="hidden" name="qna_type" value="전체">	
	</form>
<!-- ------------------------------ -->
<form class="form_search">
<p>QnA관리</p>
	<div class="qna_option">
		<div class="qna_option_subject">
		검색조건
		</div>
			<div class="cell">
				<div class="option_first">등록일</div>
				<div class="option_second">시작일 <input type="text" id="datePicker1" name="startDate"></div>
				<div class="option_third">종료일 <input type="text" id="datePicker2" name="endDate"></div>
			</div>
			<div class="cell">
				<div class="option_first">구분</div>
					<input type="radio" name="qna_rep" value ="repno" checked="checked">답변대기&nbsp;&nbsp;
					<input type="radio" name="qna_rep" value ="repok">답변완료&nbsp;&nbsp;

			</div>
			<div class="cell">
				<div class="option_first">분류</div>
					<input type="radio" name="order_by" value ="ASC" checked="checked" >오래된순&nbsp;&nbsp;
					<input type="radio" name="order_by" value ="DESC">최신순&nbsp;&nbsp;
					<div style="width:295px;"></div>
					<input type="radio" name="qna_type" value="전체" checked="checked">전체&nbsp;&nbsp;
					<input type="radio" name="qna_type" value="계정">계정&nbsp;&nbsp;
					<input type="radio" name="qna_type" value="상품">상품&nbsp;&nbsp;

			</div>
			<div class="cell">
				<div class="option_first">검색</div>
				<input class="search_input" type="text" name="searchObject">
				
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
	<div id="qna_search_result"><!-- AJAX로 출력할 QNA DB --></div>
</form>
	
</body>
</html>