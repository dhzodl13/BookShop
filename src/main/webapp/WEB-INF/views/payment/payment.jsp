<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String sId = request.getParameter("sId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

</style>
<link href="resources/css/header.css" rel="stylesheet">
<link href="resources/css/payment.css" rel="stylesheet">
<link rel="shortcut icon" href="resources/images/a.ico.jpg">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="resources/js/jquery-3.6.0.js"></script>
<script type='text/javascript'>
var totalPrice = 0;
var pd_nums = new Array();
var deli = 0;
var point = 0;
var rTotalPrice =0;
var price = 0;
var pd_num = 0;
$(function(){
	/////////////////////////////////////////////////////////////////
	var array = $("input[type='checkbox']").get();
	for(var checkbox in array){
		totalPrice = totalPrice + parseInt($("input[type='checkbox']").get(checkbox).value);
		pd_nums.push($("input[type='checkbox']").get(checkbox).id);
	}
	if(totalPrice < 30000){
		deli = 3000;
	}else{
		deli = 0;
	}
	$(".result").html(
			`<table class="jur2">
				<tr>
					<td><div id="ex1" >가격: `+totalPrice+`원</div></td>
					<td><div id="ex2" >-사용 포인트  `+ point +`</div></td>
					<td><div id="ex3" >+배송비`+deli+`원=</div></td>
					<td rowspan="2"><div id="ex4" >최종가격  <div class="ex">`+(totalPrice + deli - point)+`원</div></div></td> 
				</tr>
				</tr>
	               <tr>
	               <td><div id="ex">　</div></td>
	               <td><div id="ex">　</div></td>
	               <td><div id="ex">　</div></td>
	               
	               </tr>
			</table>`
	);
	rTotalPrice =  (totalPrice + deli - point);
	/////////////////////////////////////////////////////////////////
	$("input[type='checkbox']").on("click",function() {
			price = + $(this).val();
			pd_num = $(this).attr("id");
		// 체크박스 체크시 값 변경
		if ($(this).is(":checked") == true){
			totalPrice = totalPrice + price;
			pd_nums.push(pd_num);
		}else{
			totalPrice = totalPrice - price;
			var index = pd_nums.indexOf(pd_num);
			pd_nums.splice(index,1);
		}
		if(totalPrice < 30000){
			deli = 3000;
		}else{
			deli = 0;
		}
		

		$(".result").html(
				`<table class="jur2">
					<tr>
						<td><div id="ex1" >가격: `+totalPrice+`원</div></td>
						<td><div id="ex2" >-사용 포인트  `+ point +`</div></td>
						<td><div id="ex3" >+배송비`+deli+`원=</div></td>
						<td rowspan="2"><div id="ex4" >최종가격  <div class="ex">`+(totalPrice + deli - point)+`원</div></div></td> 
					</tr>
					</tr>
		               <tr>
		               <td><div id="ex">　</div></td>
		               <td><div id="ex">　</div></td>
		               <td><div id="ex">　</div></td>
		               
		               </tr>
				</table>`
		);
		rTotalPrice =  (totalPrice + deli - point);
	})
	// 포인트 사용시 값 변경
	$(".point").on("change",function(){
		point = + $(".point").val();
		$(".result").html(
			`<table class="jur2">
				<tr>
					<td><div id="ex1" >가격: `+totalPrice+`원</div></td>
					<td><div id="ex2" >-사용 포인트  `+ point +`</div></td>
					<td><div id="ex3" >+배송비`+deli+`원=</div></td>
					<td rowspan="2"><div id="ex4" >최종가격  <div class="ex">`+(totalPrice + deli - point)+`원</div></div></td>
				</tr>
				</tr>
	               <tr>
	               <td><div id="ex">　</div></td>
	               <td><div id="ex">　</div></td>
	               <td><div id="ex">　</div></td>
	             </tr>
			  </table>`
		);
		rTotalPrice =  (totalPrice + deli - point);
		
		
	})
	
	
})

function goForward(){
  location.href="PaymentResult.us?pd_nums="+pd_nums+"&totalPrice="+totalPrice;
}
	</script>
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
	<div class="cart">
	<img alt="결제" src="resources/images/point.png" >
	<hr>
	<table class="jur"width="100%">
               <tr class="text1">
               	  <td class="space" width="40px">선택</td>
                  <td class="space" width="120px">표지</td>
                  <td class="space" width="240px">제목</td>
                  <td class="space" width="140px">작가</td>
                  <td class="space" width="130px">가격</td>
                  <td class="space" width="90px">수량</td>
                  <td class="space" width="130px"></td>
               </tr>

	<c:forEach var="pd" items="${cartList }">
				<tr class="text1">
					<td><input class="total_price" type="checkbox" checked="checked" value=${pd.pd_price * pd.cart_pd_quan } id=${pd.pd_num }></td>
					<td><a href="UserProductDetail.us?pd_num=${pd.pd_num }"><img src="resources/upload/${pd.pd_file }" width="100" height="150"></a></td>	
					<td><div class="product">${pd.pd_subject}</div></td>
					<td><div class="product">${pd.pd_name}</div></td>
					<td><div class="product">${pd.cart_pd_quan}</div></td>
					<td><div class="product">${pd.pd_price}</div></td>
				</tr>	
	</c:forEach>
	
	</table>
		
		<input type="text" name="point" class="point" placeholder="숫자만 입력">
		<input type="text" readonly="readonly" value="현재 적립금${userPoint }">	
		<div class="result"></div>
		
		
	
	
	<section id="button2">
	<a href="#" role="button" id="check_module">결제진행</a>
	</section>
	<section style="position: relative; clear: both;"></section>
	<script>
	$("#check_module").click(function() {
		var IMP = window.IMP; // 생략가능
		IMP.init("imp11426028");
		// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
		IMP.request_pay({
			pg : 'inicis' , // version 1.1.0부터 지원.
			/*	
			 'kakao':카카오페이,
			 html5_inicis':이니시스(웹표준결제)
			 'nice':나이스페이
			 'jtnet':제이티넷
			 'uplus':LG유플러스
			 'danal':다날
			 'payco':페이코
			 'syrup':시럽페이
			 'paypal':페이팔
			 */

			pay_method : 'card',
			/*
			 'samsung':삼성페이,
			 'card':신용카드,
			 'trans':실시간계좌이체,
			 'vbank':가상계좌,
			 'phone':휴대폰소액결제
			 */
			merchant_uid : 'merchant_' + new Date().getTime(),
			/*
			 merchant_uid에 경우
			 https://docs.iamport.kr/implementation/payment
			 위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
			 참고하세요.
			 나중에 포스팅 해볼게요.
			 */				
			name : '도서 금액',
			//결제창에서 보여질 이름
			amount : rTotalPrice,
			//가격
			buyer_email : '${sessionScope.sId}',
            buyer_name : '${sessionScope.sName}',
            buyer_tel : '${sessionScope.user_phone}',
            buyer_addr : '${sessionScope.user_address}',
            buyer_postcode : '${sessionScope.user_postcode}',
			m_redirect_url : 'www.naver.com'
		/*
		 모바일 결제시,
		 결제가 끝나고 랜딩되는 URL을 지정
		 (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
		 */
		}, function(rsp) {
			console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				msg += '결제 금액 : ' + rsp.paid_amount;
				msg += '카드 승인번호 : ' + rsp.apply_num;
				location.href="PaymentResult.us?pd_nums="+pd_nums+"&totalPrice="+totalPrice+"&sId="+"${sessionScope.sId}"+"&point="+point;
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
				history.back();
			}
			alert(msg);
		});
	}); 
</script>
</div>
<jsp:include page="/WEB-INF/views/inc/footer.jsp"/>
</body>
</html>