<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인화면</title>
<!-- CSS모음 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="resources/css/main.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet">
<link href="resources/css/header.css" rel="stylesheet">
<!-- CSS모음 끝 -->
<%
//팝업창을 띄울지 결정하는 bool 변수 선언
boolean bool = false;
Cookie[] ck = request.getCookies();

// 쿠키가 존재할 경우 bool을 true로 설정
if(ck !=null){
	for(Cookie c : ck){
		if(c.getName().equals("checkCookie")){
			bool = true;
		}
	}
}

//bool이 true 가 아닐경우 popup.jsp 팝업창을 띄움
if(!bool){ %>
	<script type="text/javascript">
		window.open("Popup.us","","width=330,height=400");
	</script>
<%
}
%>
<script src="resources/js/jquery-3.6.0.js"></script>
<script src="resources/js/bootstrap-datepicker.js"></script>
<script src="resources/js/bootstrap-datepicker.kr.min.js"></script>
<body>
<!-- 헤더 a -->
<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
<!-- 헤더 끝 -->

<!-- 메인 시작 -->
<section class="main">
	<!-- main_top  -->
	<section class="main_top">
		<!-- 제일 중요한 현재 페이지의 메인 HTML 태그들 -->
		<section class="main_content">
		<!-- 메인 슬라이더  -->
		<div class="mainContainer">
		
			<!-- 메인 슬라이더의 보여줄 화면들(여러개) -->
			<div class="mainSlides">
				<a href="ChangeMainAd.ad?main_ad_num=1">
					<img src="resources/upload/ad/${ad[0].ad_file }" onerror="this.src='resources/images/main/main_book1.jpg' " style="width:100%">
				</a>
			</div>
		
			<div class="mainSlides">
				<a href="ChangeMainAd.ad?main_ad_num=2">
					<img src="resources/upload/ad/${ad[1].ad_file }" onerror="this.src='resources/images/main/main_book2.jpg' " style="width:100%">
				</a>
			</div>
		
			<div class="mainSlides">
				<a href="ChangeMainAd.ad?main_ad_num=3">
					<img src="'resources/upload/ad/${ad[2].ad_file }" onerror="this.src='resources/images/main/main_book3.jpg' " style="width:100%">
				</a>
			</div>
			  
			<div class="mainSlides">
				<a href="ChangeMainAd.ad?main_ad_num=4">
					<img src="resources/upload/ad/${ad[3].ad_file }" onerror="this.src='resources/images/main/main_book4.jpg' " style="width:100%">
				</a>
			</div>
			
			<div class="mainSlides">
				<a href="ChangeMainAd.ad?main_ad_num=5">
					<img src="resources/upload/ad/${ad[4].ad_file }" onerror="this.src='resources/images/main/main_book5.jpg' " style="width:100%">
				</a>
			</div>
			  
			<div class="mainSlides">
				<a href="ChangeMainAd.ad?main_ad_num=6">
					<img src="resources/upload/ad/${ad[5].ad_file }" onerror="this.src='resources/images/main/main_book6.jpg' " style="width:100%">
				</a>
			</div>
			<!-- 메인 슬라이더의 보여줄 화면들(여러개) 끝-->
			
			
			<!-- 메인 슬라이더의 보여줄 화면안의 화살표 오른쪽 왼쪽-->
			<a class="prev" onclick="plusMainSlides(-1)">❮</a>
			<a class="next" onclick="plusMainSlides(1)">❯</a>
			<!-- 메인 슬라이더의 보여줄 화면안의 화살표 오른쪽 왼쪽 끝-->
		
		
			
			<!-- 메인 슬라이더의 밑의 메뉴바 -->
			<div class="row">
			<!-- 메인 슬라이더의 보여줄 메뉴 텍스트들(여러개) -->
				<div class="column">
					<button class="mainDemo cursor" onmouseover="showMainSlides(1)">
					<c:if test="${not empty ad[0].ad_subject }">
						${ad[0].ad_subject }
					</c:if>
					<c:if test="${empty ad[0].ad_subject }">
					이 달의 신간
					</c:if>
					</button>
				</div>
				<div class="column">
					<button class="mainDemo cursor" onmouseover="showMainSlides(2)">
					<c:if test="${not empty ad[1].ad_subject }">
						${ad[1].ad_subject }
					</c:if>
					<c:if test="${empty ad[1].ad_subject }">
						이 달의 베스트
					</c:if>
					</button>
				</div>
				<div class="column">
					<button class="mainDemo cursor" onmouseover="showMainSlides(3)">
					<c:if test="${not empty ad[2].ad_subject }">
						${ad[2].ad_subject }
					</c:if>
					<c:if test="${empty ad[2].ad_subject }">
						홍쥬 작가의 추천
					</c:if>
					</button>
				</div>
				<div class="column">
					<button class="mainDemo cursor" onmouseover="showMainSlides(4)">
					<c:if test="${not empty ad[3].ad_subject }">
						${ad[3].ad_subject }
					</c:if>
					<c:if test="${empty ad[3].ad_subject }">
						20대 필독 도서
					</c:if>
					</button>
				</div>
				<div class="column">
					<button class="mainDemo cursor" onmouseover="showMainSlides(5)">
					<c:if test="${not empty ad[4].ad_subject }">
						${ad[4].ad_subject }
					</c:if>
					<c:if test="${empty ad[4].ad_subject }">
						베스트 자기 계발서
					</c:if>
					</button>
				</div>
				<div class="column">
					<button class="mainDemo cursor" onmouseover="showMainSlides(6)">
					<c:if test="${not empty ad[5].ad_subject }">
						${ad[5].ad_subject }
					</c:if>
					<c:if test="${empty ad[5].ad_subject }">
						작년도 베스트
					</c:if>
					</button>
				</div>
			<!-- 메인 슬라이더의 보여줄 메뉴 텍스트들(여러개) 끝-->
			</div>
			<!-- 메인 슬라이더의 밑의 메뉴바 끝-->
		</div>
		<!-- 메인 슬라이더 끝 -->
		</section>
		<!-- 제일 중요한 현재 페이지의 메인 HTML 태그들 끝 -->
	</section>
	<!-- main_top 끝 -->
	<section style="position: relative; clear: both;"></section>
	
	<!-- main_middle  -->
	<section class="main_middle">
		<!-- 현재 페이지의 중간 HTML 태그들 -->
		<section class="middle_content">
		
			<h3><a href="">오늘의 책 ></a></h3>
			<!-- 책 메뉴 옮기기 1 -->
		<c:choose>
			<c:when test="${not empty center_ad[0]}">
	
			<div class="todayBUnits" onmouseover="showMiddleSlides(1)">
				<div class="tBThumb">
					<a href="UserProductDetail.us?pd_num=${center_ad[0].ad_pd_num }">
						<img src="resources/upload/${center_ad[0].pd_file }" width="51px">
					</a>
				</div>
				<div class="tBContent">
					<div class="tBImgArea">
						<a href="UserProductDetail.us?pd_num=${center_ad[0].ad_pd_num }">
							<img src="resources/upload/${center_ad[0].pd_file }">
						</a>
					</div>
					<div class="tBInfo">
						<p class="book_subject">
							${center_ad[0].pd_subject }
						</p>
						<p class="book_content">
							${center_ad[0].ad_content }
						</p>
						<p class="book_name">
							${center_ad[0].pd_name }
						</p>
						<p class="book_price">
							${center_ad[0].pd_price }원
						</p>
					</div>
				</div>
			</div>
			</c:when>
			<c:otherwise>
			<div class="todayBUnits" onmouseover="showMiddleSlides(1)">
				<div class="tBThumb">
					<a href="#">
						<img src="resources/images/book/book_img1.jpg" width="51px">
					</a>
				</div>
				<div class="tBContent">
					<div class="tBImgArea">
						<a href="#">
							<img src="resources/images/book/book_img1.jpg">
						</a>
					</div>
					<div class="tBInfo">
						<p class="book_subject">
							이별을 떠날 때
						</p>
						<p class="book_content">
							책 간단 내용1 책 간단 내용1 책 간단 내용1 책 간단 내용1 책 간단 내용1 책 간단 내용1 책 간단 내용1 책 간단 내용1 책 간단 내용1 
						</p>
						<p class="book_name">
							한창훈
						</p>
						<p class="book_price">
							11,700원
						</p>
					</div>
				</div>
			</div>
			</c:otherwise>
				</c:choose>
			<!-- 책 메뉴 옮기기 1 끝-->
			
			<!-- 책 메뉴 옮기기 2 -->
			<c:choose>
			<c:when test="${not empty center_ad[1]}">
	
			<div class="todayBUnits" onmouseover="showMiddleSlides(2)">
				<div class="tBThumb">
					<a href="UserProductDetail.us?pd_num=${center_ad[1].ad_pd_num }">
						<img src="resources/upload/${center_ad[1].pd_file }" width="51px">
					</a>
				</div>
				<div class="tBContent">
					<div class="tBImgArea">
						<a href="UserProductDetail.us?pd_num=${center_ad[1].ad_pd_num }">
							<img src="resources/upload/${center_ad[1].pd_file }">
						</a>
					</div>
					<div class="tBInfo">
						<p class="book_subject">
							${center_ad[1].pd_subject }
						</p>
						<p class="book_content">
							${center_ad[1].ad_content }
						</p>
						<p class="book_name">
							${center_ad[1].pd_name }
						</p>
						<p class="book_price">
							${center_ad[1].pd_price }원
						</p>
					</div>
				</div>
			</div>
			</c:when>
			<c:otherwise>
			<div class="todayBUnits" onmouseover="showMiddleSlides(2)">
				<div class="tBThumb">
					<a href="#">
						<img src="resources/images/book/book_img2.jpg" width="51px">
					</a>
				</div>
				<div class="tBContent">
					<div class="tBImgArea">
						<a href="#">
							<img src="resources/images/book/book_img2.jpg">
						</a>
					</div>
					<div class="tBInfo">
						<p class="book_subject">
							아름답고 죽은 그녀
						</p>
						<p class="book_content">
							책 간단 내용2 책 간단 내용2 책 간단 내용2 책 간단 내용2 책 간단 내용2 책 간단 내용2 책 간단 내용2 책 간단 내용2 책 간단 내용2 
						</p>
						<p class="book_name">
							책 지은이2
						</p>
						<p class="book_price">
							20,000원
						</p>
					</div>
				</div>
			</div>
			</c:otherwise>
			</c:choose>
			<!-- 책 메뉴 옮기기 2 끝-->
			
			<!-- 책 메뉴 옮기기 3 -->
		<c:choose>
			<c:when test="${not empty center_ad[2]}">
	
			<div class="todayBUnits" onmouseover="showMiddleSlides(3)">
				<div class="tBThumb">
					<a href="UserProductDetail.us?pd_num=${center_ad[2].ad_pd_num }">
						<img src="resources/upload/${center_ad[2].pd_file }" width="51px">
					</a>
				</div>
				<div class="tBContent">
					<div class="tBImgArea">
						<a href="UserProductDetail.us?pd_num=${center_ad[2].ad_pd_num }">
							<img src="resources/upload/${center_ad[2].pd_file }">
						</a>
					</div>
					<div class="tBInfo">
						<p class="book_subject">
							${center_ad[2].pd_subject }
						</p>
						<p class="book_content">
							${center_ad[2].ad_content }
						</p>
						<p class="book_name">
							${center_ad[2].pd_name }
						</p>
						<p class="book_price">
							${center_ad[2].pd_price }원
						</p>
					</div>
				</div>
			</div>
			</c:when>
			<c:otherwise>
			<div class="todayBUnits" onmouseover="showMiddleSlides(3)">
				<div class="tBThumb">
					<a href="#">
						<img src="resources/images/book/book_img3.jpg" width="51px">
					</a>
				</div>
				<div class="tBContent">
					<div class="tBImgArea">
						<a href="#">
							<img src="resources/images/book/book_img3.jpg">
						</a>
					</div>
					<div class="tBInfo">
						<p class="book_subject">
							마음 로그인
						</p>
						<p class="book_content">
							책 간단 내용3 책 간단 내용3 책 간단 내용3 책 간단 내용3 책 간단 내용3 책 간단 내용3 책 간단 내용3 책 간단 내용3 책 간단 내용3 
						</p>
						<p class="book_name">
							책 지은이3
						</p>
						<p class="book_price">
							30,000원
						</p>
					</div>
				</div>
			</div>
			</c:otherwise>
			</c:choose>
			<!-- 책 메뉴 옮기기 3 끝-->
			
			<!-- 책 메뉴 옮기기 4 -->
						<c:choose>
			<c:when test="${not empty center_ad[1]}">
	
			<div class="todayBUnits" onmouseover="showMiddleSlides(4)">
				<div class="tBThumb">
					<a href="UserProductDetail.us?pd_num=${center_ad[3].ad_pd_num }">
						<img src="resources/upload/${center_ad[3].pd_file }" width="51px">
					</a>
				</div>
				<div class="tBContent">
					<div class="tBImgArea">
						<a href="UserProductDetail.us?pd_num=${center_ad[3].ad_pd_num }">
							<img src="resources/upload/${center_ad[3].pd_file }">
						</a>
					</div>
					<div class="tBInfo">
						<p class="book_subject">
							${center_ad[3].pd_subject }
						</p>
						<p class="book_content">
							${center_ad[3].ad_content }
						</p>
						<p class="book_name">
							${center_ad[3].pd_name }
						</p>
						<p class="book_price">
							${center_ad[3].pd_price }원
						</p>
					</div>
				</div>
			</div>
			</c:when>
			<c:otherwise>
			
			<div class="todayBUnits" onmouseover="showMiddleSlides(4)">
				<div class="tBThumb">
					<a href="#">
						<img src="resources/images/book/book_img4.jpg" width="51px">
					</a>
				</div>
				<div class="tBContent">
					<div class="tBImgArea">
						<a href="#">
							<img src="resources/images/book/book_img4.jpg">
						</a>
					</div>
					<div class="tBInfo">
						<p class="book_subject">
							변화는 있어도 변함은 없기를
						</p>
						<p class="book_content">
							책 간단 내용4 책 간단 내용4 책 간단 내용4 책 간단 내용4 책 간단 내용4 책 간단 내용4 책 간단 내용4 책 간단 내용4 책 간단 내용4 
						</p>
						<p class="book_name">
							책 지은이4
						</p>
						<p class="book_price">
							40,000원
						</p>
					</div>
				</div>
			</div>
			</c:otherwise>
			</c:choose>

			<!-- 책 메뉴 옮기기 4 끝-->
		</section>
		<!-- 현재 페이지의 중간 HTML 태그들 끝 -->
	
		<!-- 현재 페이지의 중간 오른쪽 박스 -->
		<section class="middle_right_content">
			<div class="right_content_menu">
				<!-- 판매 순위 영역 클릭 -->
				<div class="right_sides" onclick="showMiddleRightSlides(1)">
					<div>
						<span>판매 순위</span>
					</div>
				</div>
				<!-- 판매 순위 영역 클릭 끝 -->
				<!-- 베스트셀러 영역 클릭 -->
				<div class="right_sides" onclick="showMiddleRightSlides(2)">
					<div>
						<span>베스트 셀러</span>
					</div>
				</div>
				<!-- 베스트셀러 영역 클릭 끝 -->
			</div>
			<section style="position: relative; clear: both;"></section>
			<div>
				<!-- 판매 순위 영역 콘텐츠 -->
				<div class="right_contents">
					<ol>
						<c:set var="rank" value="1" />
						<c:forEach var="productList" items="${productList }">
						<li class="ranking">
							<strong>${rank }위</strong>
							<span class="ranking_image">
								<img src="resources/upload/${productList.pd_file }" width="40" height="40">
							</span>
							<span class="ranking_infomation">
								<strong>${productList.pd_subject }</strong>
								<em>${productList.pd_name }</em>
							</span>
							<a href="UserProductDetail.us?pd_num=${productList.pd_num }" class="ranking_link">
							</a>
							<c:set var="rank" value="${rank + 1 }"/>
						</li>
						</c:forEach>
					</ol>
				</div>
				<!-- 판매 순위 영역 콘텐츠 끝 -->
				
				<!-- 베스트셀러 영역 콘텐츠 -->
				<div class="right_contents">
					<ol>
						
					</ol>
				</div>
				<!-- 베스트셀러 영역 콘텐츠 끝 -->
			</div>
				
		</section>
		<!-- 현재 페이지의 중간 오른쪽 박스 끝 -->
	</section>
	<!-- main_middle 끝 -->
</section>
<!-- 메인 끝 -->


<section style="position: relative; clear: both;"></section>


<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/inc/sidebar.jsp"/>
<!-- 사이드바 끝 -->

<!-- 푸터 -->
<jsp:include page="/WEB-INF/views/inc/footer.jsp"/>
<!-- 푸터 -->
</body>
<!-- 
	슬라이드에 필요한 JS라 BODY가 모두 로딩되었을 때 슬라이드가 작동되게 만들어서 
	오류(로딩 안된 태그 건드리는 오류) 없앰 
-->
<script src="resources/js/main.js" type="text/javascript"></script>
<!-- 자바스크립트 실행 구역 끝-->
</html>











