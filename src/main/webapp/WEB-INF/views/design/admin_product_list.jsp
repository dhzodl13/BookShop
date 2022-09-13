<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookShop_Admin</title>
<link href="resources/css/admin_product_list.css" rel="stylesheet"/>
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
		$(".search_submit").on("click", function() {
		var search_form = $(".search_form").serialize();
			$.ajax({
				type:"post",
				url:"GetProductList.ad",
				data:search_form,
				dataType:"text",
			}).done(function(response) {
				$("#pd_search_result").html(response);
			}).fail(function () {
				alert("AJAX 실패");
			});
		});
	})		
	function pageMove(pageNum) {
		$("#pdPageNum").val(pageNum);
		var form_page = $(".form_page").serialize();
		$.ajax({
			type:"post",
			url:"GetProductList.ad",
			data: form_page,
			dataType:"text",
		}).done(function(response) {
				$("#pd_search_result").html(response);
		}).fail(function () {
				alert("AJAX 실패");
		});
	};
	
	function selectProduct(pd_num){
		var ad_content = prompt("광고에 보여질 간략할 설명을 작성해주세요. (100자)");
		if(ad_content == null || ad_content == "") {
			alert("취소되었습니다.")
		}else{
			
		
		if(!confirm(pd_num + "번 상품을 광고글에 등록합니다.")) {
			alert("취소되었습니다.");
		}else{
			$.ajax({
				type:"post",
				url:"changeCenterAdPro.ad",
				data:{"ad_content" : ad_content,
						"ad_pd_num" : pd_num,
						"ad_index" : ${param.ad_index}},
			}).done(function(response) {
				location.href="Design.ad";
			}).fail(function () {
				alert("AJAX 실패");
			});
		}
	}
}
	
	
</script>

<body>




	
	<!-- 헤더 넣는 자리 -->
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"/>
	<!-- 헤더 넣는 자리 -->
	
	<!-- 검색란  -->
	<form class="search_form">
		<p>상품 선택</p>
		<div class="product_search">
			<div class="search_requirement">
				검색조건
			</div>
			<div class="cell">
				<div id="req_subject">
					등록일
				</div>
				<div class="start_date">
					시작일
					<input type="text" id="datePicker1" name="start_date">
				</div>
				<div class="end_date">
					종료일
					<input type="text" id="datePicker2" name="end_date">
				</div>
			</div>
			
			<div class="cell">
				<div id="req_subject">
					상태
				</div>
				<input type="radio" name="quan" value="all" class="type_select" checked="checked">전체&nbsp;&nbsp;
				<input type="radio" name="quan" value="true" class="type_select">재고있음&nbsp;&nbsp;
				<input type="radio" name="quan" value="false" class="type_select">품절&nbsp;&nbsp;
			</div>
			
			<div class="cell">
				<div id="req_subject">
					타입
				</div>
				<input type="radio" name="type" value="all" class="type_select" checked="checked">전체&nbsp;&nbsp;
				<input type="radio" name="type" value="국내도서" class="type_select">국내도서&nbsp;&nbsp;
				<input type="radio" name="type" value="해외도서" class="type_select">해외도서&nbsp;&nbsp;
				<input type="radio" name="type" value="eBook" class="type_select">eBook&nbsp;&nbsp;
			</div>
			
			<div class="cell">
				<div id="req_subject">
					검색
				</div>
				<input type="text" class="search_input" name="search_input" placeholder="상품이름으로 검색">
			</div>
			<hr>
			<div class="cell2">
				<input type="button" value="검색" class="search_submit">
			</div>
		</div>
	</form>
	<!-- 검색란  -->
	
	<!-- 상품표시란 -->
	
		<div id="pd_search_result">
		<!-- AJAX로 검색결과표시 -->
		
		<!-- AJAX로 검색결과표시 -->
		</div>
	<!-- 상품표시란 -->
</body>
</html>