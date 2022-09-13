<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
int totalPrice = 0;
String order_status = request.getParameter("order_status");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="resources/css/user_my_order_detail.css" rel="stylesheet">
</head>
<body>
<section class="myOrderDetail">
	<h3>주문 상세 정보</h3>
	<table border="1">
		<tr>
			<th width="100px">상품표지</th>
			<th width="380px">상품제목</th>
			<th width="110px">상품가격</th>
			<th width="65px">주문수량</th>
			<th width="140px">총 금액</th>
			<th width="70px">리뷰작성</th>
		</tr>
		<c:set var ="totalPrice" value = "0" />
		<c:set var = "order_status" value = "<%=order_status %>"/>
		<c:forEach var="ordDetaillist" items="${ordDetaillist }">
			<tr>
				<td><img src="resources/upload/${ordDetaillist.pd_file }" width="70px"></td>
				<td title="${ordDetaillist.pd_subject }">${ordDetaillist.pd_subject }</td>
				<td>${ordDetaillist.pd_price } 원</td>
				<td>${ordDetaillist.order_quan }</td>
				<td>${ordDetaillist.order_pd_price } 원</td>
				<c:choose>
				<c:when test="${order_status eq '배송완료' }">						
				<td><input class="review_button" type="button" value="리뷰작성" onclick="location.href='WriteReviewForm.us?pd_subject=${fn:replace(ordDetaillist.pd_subject,'\'','\\\'')}&pd_num=${ordDetaillist.order_pd_num}'"></td>
					</c:when>
					<c:otherwise>
						<td><input class="review_button noClick" type="button" value="리뷰작성" disabled="disabled"></td>
					</c:otherwise>
				</c:choose>
			</tr>
			<c:set var= "totalPrice" value="${totalPrice + ordDetaillist.order_pd_price }" />
		</c:forEach>
	</table>
	<h4>총 결제 금액 : <c:out value="${totalPrice } 원" /></h4><input type="button" style="float:right;" value="닫기" onclick="window.close()">
	<br>
	<h5>※ 배송 완료된 상품만 리뷰 작성이 가능합니다.</h5>

</section>
</body>
</html>