<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String sId = (String)session.getAttribute("sId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS모음 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="resources/css/header.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet">
<link href="resources/css/user_my_review.css" rel="stylesheet">
<!-- CSS모음 끝 -->
<script src="resources/js/jquery-3.6.0.js"></script>
<script src="resources/js/bootstrap-datepicker.js"></script>
<script src="resources/js/bootstrap-datepicker.kr.min.js"></script>
</head>
<body>

<script type="text/javascript">
function modifyReview(review_num, pd_subject){
    var url = "ModifyMyReviewForm.us?review_num=" + review_num + "&pd_subject=" + pd_subject;
    var name = "";
    var option = "width = 950, height = 600, top = 100, left = 200, location = no"
    window.open(url, name, option);
}

function deleteReview(review_num, sId){
   		if(!window.confirm("정말 리뷰를 삭제하시겠습니까?")){
   		}
   		else{
   			 location.href="DeleteMyReview.us?review_num=" + review_num + "&sId=" + sId; 
   		}
}		
   
</script>

<jsp:include page="/WEB-INF/views/inc/header.jsp"/>

<section class="userMyReview">
	<section class="reviewSection">
	<h3><img src="resources/images/postIcon.png" width="30px">내 리뷰 관리</h3>
	<c:choose>
		<c:when test="${empty reviewList }">
			<h3 style="width: 900px; text-align: center; margin-top: 50px; margin-bottom: 50px;">작성한 리뷰가 없습니다</h3>
			<section style="position: relative; clear: both;"></section>
			<img alt="" src="resources/images/pageNull.png" width="300px" style="margin: 0px 300px;">
			<section style="position: relative; clear: both;"></section>
		</c:when>
		<c:otherwise>
			<section class="reviewListSection">
			<c:forEach var="reviewList" items="${reviewList }">
				<table>
					<tr>
						<td class="title2">책 제목 : ${reviewList.pd_subject }</td>
					</tr>
					<tr>
						<td class="title">리뷰 제목 : ${reviewList.review_subject }</td>
					</tr>
					<tr>
						<td>
							<div class="wrap-star_review">
							    <div class='star-rating_review'>
							        <span style ="width:${reviewList.review_score*20 }%"></span>
							    </div>
							</div>
							<em>|</em> ${reviewList.review_date }
						</td>
					</tr>
					<tr>
						<td> ${reviewList.review_content }</td>
					</tr>
					<tr>
						<td style="text-align: right;">
							<input type="button" value="수정하기" onclick="modifyReview(${reviewList.review_num}, '${fn:replace(reviewList.pd_subject,'\'','\\\'')}');">&nbsp
							<input type="button" value="삭제하기" onclick="deleteReview(${reviewList.review_num},'<%=sId%>');">
						</td>
					</tr>
				</table>
			</c:forEach>
			</section>
		<!-- 페이징 처리 -->
		<section class="page">
			<c:choose>
				<c:when test="${pageInfo.pageNum > 1}">
					<input class="num" type="button" value="이전" onclick="location.href='MyReview.us?sId=${sessionScope.sId}&pageNum=${pageInfo.pageNum - 1}'">
				</c:when>
				<c:otherwise>
					<input class="num noClick" type="button" value="이전">
				</c:otherwise>
			</c:choose>
				
			<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
				<c:choose>
					<c:when test="${pageInfo.pageNum eq i}">
						<strong class="num noClick">${i }</strong>
					</c:when>
					<c:otherwise>
						<a class="num" href="MyReview.us?sId=${sessionScope.sId}&pageNum=${i }">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<c:choose>
				<c:when test="${pageInfo.pageNum < pageInfo.maxPage}">
					<input class="num" type="button" value="다음" onclick="location.href='MyReview.us?sId=${sessionScope.sId}&pageNum=${pageInfo.pageNum + 1}'">
				</c:when>
				<c:otherwise>
					<input class="num noClick" type="button" value="다음">
				</c:otherwise>
			</c:choose>
		</section>
		<!-- 페이징 처리 -->
		</c:otherwise>
		</c:choose>
	</section>
</section>
<!-- 여백의 미 시작 -->
<section style="width:900px; height: 500px; margin:0px auto;">
<h1 style="position:relative; top:50%; left:50%;">
 
</h1>
</section>
<!-- 여백의 미 끝 -->
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/inc/sidebar.jsp"/>
<!-- 사이드바 끝 -->
<jsp:include page="/WEB-INF/views/inc/footer.jsp"/>
</body>
</html>