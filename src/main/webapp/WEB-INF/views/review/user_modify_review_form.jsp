<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
String sId = (String)session.getAttribute("sId");
String pd_subject = request.getParameter("pd_subject");
int review_num = Integer.parseInt(request.getParameter("review_num"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정하기</title>
<link href="resources/css/user_modify_review_form.css" rel="stylesheet">
</head>
<body>
<h2>리뷰 수정하기</h2>
<h3>상품명 : <%=pd_subject %></h3>
	<form action="ModifyMyReviewPro.us">
	<input type="hidden" name="review_num" value=<%=review_num %>>
	<input type="hidden" name="sId" value=<%=sId %>>
	<input type="hidden" name="pd_subject" value=<%=pd_subject %>>
		<h3 style="margin-bottom: 0px;">별점</h3>
		<div class="starpoint_wrap">
		  <div class="starpoint_box">
			  <label for="starpoint_1" class="label_star" title="0.5"><span class="blind">0.5점</span></label>
			  <label for="starpoint_2" class="label_star" title="1.0"><span class="blind">1점</span></label>
			  <label for="starpoint_3" class="label_star" title="1.5"><span class="blind">1.5점</span></label>
			  <label for="starpoint_4" class="label_star" title="2.0"><span class="blind">2점</span></label>
			  <label for="starpoint_5" class="label_star" title="2.5"><span class="blind">2.5점</span></label>
			  <label for="starpoint_6" class="label_star" title="3.0"><span class="blind">3점</span></label>
			  <label for="starpoint_7" class="label_star" title="3.5"><span class="blind">3.5점</span></label>
			  <label for="starpoint_8" class="label_star" title="4.0"><span class="blind">4점</span></label>
			  <label for="starpoint_9" class="label_star" title="4.5"><span class="blind">4.5점</span></label>
			  <label for="starpoint_10" class="label_star" title="5.0"><span class="blind">5점</span></label>
			  <input type="radio" name="score" id="starpoint_1" value="0.5" class="star_radio">
			  <input type="radio" name="score" id="starpoint_2" value="1.0" class="star_radio">
			  <input type="radio" name="score" id="starpoint_3" value="1.5" class="star_radio">
			  <input type="radio" name="score" id="starpoint_4" value="2.0" class="star_radio">
			  <input type="radio" name="score" id="starpoint_5" value="2.5" class="star_radio">
			  <input type="radio" name="score" id="starpoint_6" value="3.0" class="star_radio" checked="checked">
			  <input type="radio" name="score" id="starpoint_7" value="3.5" class="star_radio">
			  <input type="radio" name="score" id="starpoint_8" value="4.0" class="star_radio">
			  <input type="radio" name="score" id="starpoint_9" value="4.5" class="star_radio">
			  <input type="radio" name="score" id="starpoint_10" value="5.0" class="star_radio">
		    <span class="starpoint_bg"></span>
		  </div> 
		</div>
		<h3>제목</h3>
		<input class="subject_input" type="text"  value="${review.review_subject }" name="subject" placeholder="제목을 입력하세요">
		
		
		<h3>내용</h3>
		<textarea class="content_input" name="content" rows="30" cols="70" placeholder="내용을 입력하세요">${review.review_content }</textarea>
		<br>
		<input type="submit" value="수정완료">&nbsp;<input type="button" value="돌아가기" onclick="window.close()">
	</form>
	<br>
	<h5>※ 리뷰는 한 상품당 한번씩만 등록할 수 있습니다.</h5>
</body>
</html>