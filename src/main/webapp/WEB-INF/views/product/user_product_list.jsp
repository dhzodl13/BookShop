<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String searchType = request.getParameter("searchType");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품목록</title>
<!-- CSS모음 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="resources/css/header.css" rel="stylesheet">
<link href="resources/css/productList.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet">
<!-- CSS모음 끝 -->
<script src="resources/js/jquery-3.6.0.js"></script>
<script src="resources/js/bootstrap-datepicker.js"></script>
<script src="resources/js/bootstrap-datepicker.kr.min.js"></script>
<script type='text/javascript'>
var pageNum = 1;

var isVisible = false;

function load(){
	$.ajax({
		type:"get",
		url:"UserProductListPro.us",
		data: {"pd_type":"${param.pd_type}",
			   "sort_type":"${param.sort_type}",
			   "search":"${param.search}",
			   "searchType":"${param.searchType}",
			   "pageNum" : pageNum
			   },
		dataType:"text",
	}).done(function(response) {
		pageNum = pageNum + 1;
		$(".infinity_page").before(response);
	}).fail(function () {
			alert("AJAX 실패");
	});	
}

$(function(){
	load();
	
	$(window).scroll(function(){
		var scrollTop = $(window).scrollTop();
		var windowHeight = $(window).height();
		var documentHeight = $(document).height();
		
		if(scrollTop + windowHeight + 1 >= documentHeight){
			load();
		}
	});
});
					
</script>
</head>
<body>
	<!-- 헤더 a -->
	<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
	<!-- 헤더 끝 -->
	<!-- 검색 제목 -->
	<div class="productList_title">
		<c:if test="${param.pd_type eq 'all'}">
			<h1>전체상품</h1>
		</c:if>
		<c:if test="${param.pd_type ne 'all'}">
			<h1>${param.pd_type }</h1>
		</c:if>
		<c:if test="${not empty param.search}">
			<h1>"${param.search }" 에 대한 검색결과</h1>
		</c:if>
	</div>
	<!-- 검색 제목 끝 -->
	
	<!-- 상품 전체 시작 -->
	<section class="productList_body">
		
		<!-- 왼쪽 통합 검색(분야)에 관한 메뉴 (국내, 해외, 베스트, 작가) -->
		<section class="productList_menu">
			<dl>
				<dt>
					<a>분야</a>
				</dt>
				<dd>
					<ul>
						<li><a href="UserSearchProductList.us?sort_type=last&pd_type=all"><span class="txt">전체</span></a></li>
						<li><a href="UserSearchProductList.us?sort_type=last&pd_type=국내도서"><span class="txt">국내 도서</span></a></li>
						<li><a href="UserSearchProductList.us?sort_type=last&pd_type=해외도서"><span class="txt">해외 도서</span></a></li>
					</ul>
				</dd>
			</dl>
			
		</section>
		<!-- 왼쪽 통합 검색(분야)에 관한 메뉴 끝 -->
		
		
		<!-- 상품 목록 전체에 관한 내용 -->
		<section class="productList_content">
			<!-- productList_content_area -->
			<section class="productList_content_area">
			
			<!-- 상품이 몇개인지 알려주는 용도 -->
			<div class="contentInfo">
				<h3>상품</h3>
			</div>
			<!-- 상품이 몇개인지 알려주는 용도 끝 -->
			
			<!-- 정렬에 관한 메뉴 -->
			<div class="contentMenu">
				<a href="UserSearchProductList.us?sort_type=last&searchType=${param.searchType}&pd_type=${param.pd_type }">
					등록일순
				</a>
				<span>|</span>
				<a href="UserSearchProductList.us?sort_type=price&searchType=${param.searchType}&pd_type=${param.pd_type }">
					가격낮은순 
				</a>
				<span>|</span>
				<a href="UserSearchProductList.us?sort_type=count&searchType=${param.searchType}&pd_type=${param.pd_type }">
					판매량순
				</a>
			</div>
			<!-- 정렬에 관한 메뉴 끝 -->
		
			<!-- 상품 목록 -->
			<div class="contentList">
			<div class="infinity_page"></div>
			</div>
			<!-- 상품 목록 끝 -->
			
			
			</section>
			<!-- productList_content_area 끝 -->
		</section>
		<!-- 상품 목록 전체에 관한 내용 끝 -->
	</section>
	
	<section style="position: relative; clear: both;"></section>

	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/inc/footer.jsp"/>
	<!-- 푸터 -->
</body>
</html>