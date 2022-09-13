<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
String sId = request.getParameter("sId"); 
int order_num = Integer.parseInt(request.getParameter("order_num"));
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="resources/css/user_my_order_suc_cancel.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet">
<link href="resources/css/header.css" rel="stylesheet">
</head>
<body>
<!-- 헤더 a -->
<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
<!-- 헤더 끝 -->

<section class="cancelSection">
<h1><%=order_num%> 번 주문의 취소가 완료되었습니다</h1><br><br><br>
	<c:forEach var="list" items="${list }">
		<h4>주문 총 금액 : ${list.order_price }원</h4><br>
		<h4>사용하신 적립금 : ${list.order_mileage }원</h4><br>		
		<h4>
			<c:choose>
				<c:when test="${list.order_price ge 30000 }">
					환불된 금액: ${list.order_price - list.order_mileage }원<br>
				</c:when>
				<c:otherwise>
					환불된 금액: ${list.order_price - list.order_mileage + 3000}원<br>
				</c:otherwise>
			</c:choose>
			환불된 적립금 : ${list.order_mileage }원
		</h4>
	</c:forEach>
	<section class="buttonSection">
		<input type="button" value="주문내역으로 돌아가기" onclick="location.href='MyOrder.us?sId=' + '<%=sId %>'">
		<input type="button" value="메인화면으로 돌아가기" onclick="location.href='./'">
	</section>
</section>
	
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/inc/sidebar.jsp"/>
<!-- 사이드바 끝 -->

<!-- 푸터 -->
<jsp:include page="/WEB-INF/views/inc/footer.jsp"/>
<!-- 푸터 -->
</body>
</html>