<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리 게시판</title>
<link href="resources/css/admin_order_detail.css" rel="stylesheet" />
<link href="resources/css/admin_sidebar.css" rel="stylesheet" />

</head>
<body>
	<!-- 헤더부분 -->
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
	<!-- 헤더부분 -->
	
	<!-- 주문상세내용 -->
	<div id="result_subject">
		<p id="p01">주문상세내역</p>
		<c:choose>
			<c:when test="${param.order_status eq '결제완료' }">
				<input type="button" value="주문처리" onclick="location.href='OrderProcess.ad?order_num=${param.order_num}'">			
			</c:when>
			<c:otherwise>
			
			</c:otherwise>
		</c:choose>
	</div>
	<div class="search_result">
		<div id="table_subject">
			<div class="table_subject">도서번호</div>
			<div class="table_subject">도서표지</div>
			<div class="table_subject">도서명</div>
			<div class="table_subject">주문수량</div>
			<div class="table_subject">금액</div>
		</div>
		<c:forEach var="detail" items="${orderList }">
			<div id="table_content">
				<div class="table_content">${detail.order_pd_num }</div>
				<div class="table_content"><img src="resources/upload/${detail.pd_file }" width="60" height="75"></div>
				<div class="table_content">${detail.pd_subject }</div>
				<div class="table_content">${detail.order_quan }</div>
				<div class="table_content">${detail.order_pd_price }</div>
			</div>
		</c:forEach>
	</div>
	<!-- 주문상세내용 -->
	
	
</body>
</html>