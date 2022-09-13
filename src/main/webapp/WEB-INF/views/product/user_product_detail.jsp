<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
String sId = (String)session.getAttribute("sId");
%>
<!DOCTYPE html>
<div class="fragment">
<html>
<head>
<meta charset="UTF-8">
<title>상품게시판</title>
<!-- CSS모음 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="resources/css/header.css" rel="stylesheet">
<link href="resources/css/productList.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet">
<link href="resources/css/user_product_etc.css" rel="stylesheet">
<link href="resources/css/productDetail.css" rel="stylesheet">
<!-- CSS모음 끝 -->
<script src="resources/js/jquery-3.6.0.js"></script>
<script src="resources/js/bootstrap-datepicker.js"></script>
<script src="resources/js/bootstrap-datepicker.kr.min.js"></script>
<script type='text/javascript'>
function quanCount(){
	let quanVal = document.querySelector(".quanInput");
	// 입력된 값이 빈칸 이라면
	if(isNaN(parseInt(quanVal.value))){
		alert("값은 하나이상 입력하셔야 합니다.")
		quanVal.value = parseInt(1);
		return;
	}
	// 입력된 값이 0이하라면 1로 초기화
	if(parseInt(quanVal.value) < 1){
		alert("값은 하나이상 입력하셔야 합니다.")
		quanVal.value = parseInt(1);
	}
	// 입력된 값이 재고 이상이라면 재고수량으로 초기화
	if(quanVal.value > ${product.pd_quan}){
		alert("재고 이상으로 선택할수 없습니다.")
		quanVal.value = parseInt(${product.pd_quan});
		return;
	}
	
	quanVal.value = quanVal.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
}

function quanPlus(current){
	let quanVal = document.querySelector(".quanInput");
	// 값이 하나 이상 없을 시 0으로 초기화
	if(isNaN(parseInt(quanVal.value))){
		quanVal.value = parseInt(0);
	}
	
	// 입력된 값 더함
	quanVal.value = parseInt(quanVal.value) +  parseInt(current);
	// 입력된 값이 0이하라면 1로 초기화
	if(parseInt(quanVal.value) < 1){
		quanVal.value = parseInt(1);
	}
	// 입력된 값이 재고 이상이라면 재고수량으로 초기화
	if(quanVal.value > ${product.pd_quan}){
		quanVal.value = parseInt(${product.pd_quan});
		return;
	}
}
</script>
</head>
<body>
<!-- 헤더 a -->
<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
<!-- 헤더 끝 -->

<!-- 상품 조회 시작 -->
<section class="productDetail">
	<h1><img src="resources/images/product_img.png"></h1>
	
	<section class="productContentDetail">
		<section class="productImg">
			<img src="resources/upload/${product.pd_file }">
		</section>
		<section class="productInfo">
			<div class="productTitle">
				책 제목
				<h1>${product.pd_subject }</h1>
			</div>
			<div class="productName">
				지은이 (작가명)
				<em>${product.pd_name }</em>
			</div>
			<div class="productType">
				분류
				<em>${product.pd_type }</em>
			</div>
			<div class="productContent">
				평점
				<div class="wrap-star">
				    <div class='star-rating'>
				        <span style ="width:${product.avg_score*20 }%"></span>
				    </div>
				</div>
				
			</div>
			<div class="productPrice">
				가격
				<em>${product.pd_price }원</em>
			</div>
			<!-- 수량 및 버튼 -->
			<form action="">
			<input type="hidden" name="pd_num" value=${product.pd_num }>
			<input type="hidden" name="sId" value=<%=sId %>>
				<div class="productQuan">
					판매중
					<c:choose>
						<c:when test="${sId eq 'admin'}">
							<div>
								<c:choose>
									<c:when test="${product.pd_quan gt 0 }">
										<h5>[남은재고 : ${product.pd_quan }]</h5>
									</c:when>
									<c:otherwise>
										<h5 style="color:red;">[품절]</h5>
									</c:otherwise>
								</c:choose>
							</div>
						</c:when>
						<c:when test="${empty sId}">
							<div>
								<!-- 수량 선택 -->
								<div class="productQuanButton">
									<span class="quanText">수량</span>
									<input type="button" value="-" class="quanButton" onclick="quanPlus(-1)">
									<input type="text" name="quantity" value="1" class="quanInput" maxlength="4" onkeyup="quanCount()" onchange="quanCount()">
									<input type="button" value="+" class="quanButton" onclick="quanPlus(1)">
								</div>
								<!-- 수량 선택 끝 -->
								<c:choose>
									<c:when test="${product.pd_quan gt 0 }">
										<h5>[남은재고 : ${product.pd_quan }]</h5><br>
										<div class="productButton">
											<input type="submit" value="비회원으로구매하기" formaction="">
										</div>
									</c:when>
									<c:otherwise>
										<h5 style="color:red;">[품절]</h5><br>
										<div class="productButton">
											<input type="submit" disabled="disabled" value="비회원으로구매하기" formaction="">
										</div>
									</c:otherwise>
								</c:choose>
								<br>
							</div>
						</c:when>
						<c:otherwise>
							<div>
								<c:choose>
									<c:when test="${product.pd_quan gt 0 }">
										<!-- 수량 선택 -->
										<div class="productQuanButton">
											<span class="quanText">수량</span>
											<input type="button" value="-" class="quanButton" onclick="quanPlus(-1)">
											<input type="text" name="quantity" value="1" class="quanInput" maxlength="4" onkeyup="quanCount()" onchange="quanCount()">
											<input type="button" value="+" class="quanButton" onclick="quanPlus(1)">
										</div>
										<!-- 수량 선택 끝 -->
										<h5>[남은재고 : ${product.pd_quan }]</h5>
										<br>
										<div class="productButton">
											<input type="submit" value="바로구매" formaction="CartToPayment.us">
											<input type="submit" value="장바구니" formaction="CartOn.us">
											<input type="submit" value="찜하기" formaction="InterestOn.us">
										</div>
									</c:when>
									<c:otherwise>
										<!-- 수량 선택 -->
										<div class="productQuanButton">
											<span class="quanText">수량</span>
											<input type="button" value="-" disabled="disabled" class="quanButton" onclick="quanPlus(-1)">
											<input type="text" name="quantity" value="1" class="quanInput" maxlength="4" onkeyup="quanCount()"onchange="quanCount()">
											<input type="button" value="+" disabled="disabled" class="quanButton" onclick="quanPlus(1)">
										</div>
										<!-- 수량 선택 끝 -->
										<h5 style="color:red;">[품절]</h5>
										<br>
										<div class="productButton">
											<input type="submit" value="바로구매" formaction="CartToPayment.us">
											<input type="submit" value="장바구니" formaction="CartOn.us">
											<input type="submit" value="찜하기" formaction="InterestOn.us">
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</form>
			<!-- 수량 및 버튼 끝 -->
		</section>
	</section>
	<section class="productContentImg">
		<img src="resources/upload/${product.pd_content }">
	</section>
	
	<jsp:include page="/WEB-INF/views/inc/user_product_etc.jsp"/>
	
	<script>
	
	function buttonsClick(type) {
		$.ajax({
			type:"get",
			url:"UserProductDetail.us",
			data:{"reviewQnaPageNum":1,
				    "type":type,
				    "pd_num":${param.pd_num}},
			dataType:"text"
		}).done(function(fragment){
			$(".fragment").replaceWith(fragment)
			if(type == "qna"){
				$(".qna").css("background","#ffffb5");
				$(".review").css("background","#f8f8f8");
			}else {
				$(".review").css("background","#ffffb5");
				$(".qna").css("background","#f8f8f8");
			}
			
		}).fail(function(){
				alert("실패!! 비상비상 쵸비상!");
			})
	}
	
	function pageMove(page) {
		let type = $(".type2").val()
		$.ajax({
			type:"get",
			url:"UserProductDetail.us",
			data:{"reviewQnaPageNum" : page,
				    "type":type,
				    "pd_num":${param.pd_num}},
			dataType:"text"
		}).done(function(fragment){
			$(".fragment").replaceWith(fragment)
			if(type == "qna"){
				$(".qna").css("background","#ffffb5");
				$(".review").css("background","#f8f8f8");
			}else {
				$(".review").css("background","#ffffb5");
				$(".qna").css("background","#f8f8f8");
			}
		}).fail(function(){
			alert("실패!! 비상비상 쵸비상!");
		})
	}
	
	</script>

	<section class="reviewSection">
	
	<h3>리뷰 및 Q&amp;A</h3>
	<div class="reviewqna">
		<div id="buttons" class="review" onclick="buttonsClick('review')">REVIEW</div>
		<div id="buttons" class="qna" onclick="buttonsClick('qna')">Q&amp;A</div>
	</div>
	
	<c:choose>
		<c:when test="${not empty reviewList }">
			<section class="reviewListSection">
			<c:forEach var="reviewList" items="${reviewList }">
			<table>
				<tr>
					<td class="title">${reviewList.review_subject }</td>
				</tr>
				<tr>
					<td>
						<div class="wrap-star_review">
						    <div class='star-rating_review'>
						        <span style ="width:${reviewList.review_score*20 }%"></span>
						    </div>
						</div>
						<em>|</em> ${reviewList.user_name } 
						<em>|</em> ${reviewList.review_date }
					</td>
				</tr>
				<tr>
					<td> ${reviewList.review_content }</td>
				</tr>
			</table> 
			<br>
			</c:forEach>
			
			</section>
		</c:when>	
		<c:when test="${not empty qnaList }">
			<section class="reviewListSection">
			<c:forEach var="qna" items="${qnaList }">
			<div class="set">
				<div class="qnareview_subject">제목 : ${qna.qna_subject }</div>
				<div class="user_name">${qna.qna_user }(${qna.qna_user_email })님의 질문</div>
				<div class="wrtie_date">작성일${qna.qna_date }</div>
				<div class=" content">${qna.qna_content }</div>
				<c:choose>
					<c:when test="${not empty qna.qna_rep }">
							<div class="rep">${qna.qna_rep }</div>
					</c:when>
					<c:otherwise>
						<h2>답변 대기중 입니다</h2>
					</c:otherwise>
				</c:choose>
			</div>
			</c:forEach>
			</section>
		</c:when>
		<c:otherwise>
			<h2>게시글이 없습니다</h2>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${not empty reviewList or not empty qnaList}">
		<div class="page" style="text-align: center;" >
			<c:choose>
				<c:when test="${pageInfo.pageNum > 1}">
					<input class="num" type="button" value="이전" onclick="pageMove('${pageInfo.pageNum - 1}')">
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
						<a class="num" href="javascript:void(0)" onclick="pageMove(${i})">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
	
			<c:choose>
				<c:when test="${pageInfo.pageNum < pageInfo.maxPage}">
					<input class="num" type="button" value="다음" onclick="pageMove('${pageInfo.pageNum + 1}')">
				</c:when>
				<c:otherwise>
					<input class="num noClick" type="button" value="다음">
				</c:otherwise>
			</c:choose>
		</div>
		</c:when>
	</c:choose>
	<input type="hidden" value="${type }" class="type2">
	
	</section>

</section>
<!-- 상품 조회 시작 끝 -->

<section style="position: relative; clear: both;"></section>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/inc/sidebar.jsp"/>
<!-- 사이드바 끝 -->

<section style="position: relative; clear: both;"></section>

<!-- 푸터 -->
<jsp:include page="/WEB-INF/views/inc/footer.jsp"/>
<!-- 푸터 -->
</body>
</html>
</div>