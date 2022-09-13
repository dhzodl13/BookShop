<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/user_customersupporter.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet">
<link href="resources/css/header.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">

//FAQ

var j = 0;
function addFaq() {
   j += 4;
   $.ajax({
      type: "get",
      url: "resources/json/faq_json.txt",
      dataType: "json"
   })
   .done(function(data) {
      for(var i = j;i <= data.length-1 ;i+=4){
         $(".more").before(
            "<div class='content_flex'>"+
                  "<div class='content''>"+data[i].name+
                        "<div class='ex'>"+data[i].acceptedAnswer.text+"</div>"+
                  "</div>"+
                  "<div class='content'>"+data[i+1].name+
                        "<div class='ex'>"+data[i+1].acceptedAnswer.text+"</div>"+
                  "</div>"+
                  "<div class='content'>"+data[i+3].name+
                        "<div class='ex'>"+data[i+2].acceptedAnswer.text+"</div>"+
                  "</div>"+
                  "<div class='content'>"+data[i+4].name+
                        "<div class='ex'>"+data[i+4].acceptedAnswer.text+"</div>"+
                  "</div>"+
               "</div>"
         )
      }
      $(".more").hide();
   })
   .fail(function() {
      alert("json 실패");
   })
};
   
$(function(){
   
   $.ajax({
      type: "get",
      url: "resources/json/faq_json.txt",
      dataType: "json"
   })
   .done(function(data) { 
      for(var i = j;i < 4 ;i+=4){
         $(".subject").after(
            "<div class='content_flex'>"+
                  "<div class='content''>"+data[i].name+
                        "<div class='ex'>"+data[i].acceptedAnswer.text+"</div>"+
                  "</div>"+
                  "<div class='content'>"+data[i+1].name+
                        "<div class='ex'>"+data[i+1].acceptedAnswer.text+"</div>"+
                  "</div>"+
                  "<div class='content'>"+data[i+3].name+
                        "<div class='ex'>"+data[i+2].acceptedAnswer.text+"</div>"+
                  "</div>"+
                  "<div class='content'>"+data[i+3].name+
                        "<div class='ex'>"+data[i+3].acceptedAnswer.text+"</div>"+
                  "</div>"+
            "</div>"+
            "<div class='more' onclick='addFaq()'>더보기</div>"
         )
      }
   })
   .fail(function() {
      alert("json 실패");
   });

$(document).on("click",".content",function(){
   $(this).children("div").css("display","block");
   $(".modal").css("display","inline");
});

$(document).on("click",".modal",function(){
   $(".ex").css("display","none");   
   $(".modal").css("display","none");
});
})

	// QNA
	$(function(){
		$.ajax({
			type:"post",
			url:"QnaGetList.us",
			data:{"sId":"${sessionScope.sId}"},
			dataType:"text"
			
		}).done(function(response){
			$(".qna").html(response)
		}).fail(function(){
			alert("ajax 실패!!");
		})
	
	
	$(".qna_button1").on("click",function(){
		$(".qna_button1").css("background","#3d6dd6");
		$(".qna_button1").css("color","white");
		$(".qna_button2").css("background","white");
		$(".qna_button2").css("color","black");
		
		$.ajax({
			type:"post",
			url:"QnaGetList.us",
			data: {"qap":"public",
						"sId":"${sessionScope.sId}"},
			dataType:"text"
		}).done(function(response){
			$(".qna").html(response)
		}).fail(function(){
			alert("실패ㅜㅠ");
		})
	});
	
	$(".qna_button2").on("click",function(){
		$(".qna_button2").css("background","#3d6dd6");
		$(".qna_button2").css("color","white");
		$(".qna_button1").css("background","white");
		$(".qna_button1").css("color","black");
		$.ajax({
			type:"post",
			url:"QnaGetList.us",
			data: {"qap":"private",
						"sId":"${sessionScope.sId}"},
			dataType:"text"
		}).done(function(response){
			$(".qna").html(response)
		}).fail(function(){
			alert("실패ㅜㅠ!!");
		})
	});
});
	
	
	
	
	function pageMovePublic(pageNum) {
		$(".qna_button1").css("background","gray");
		$(".qna_button1").css("color","white");
		$(".qna_button2").css("background","white");
		$(".qna_button2").css("color","black");
		
		$.ajax({
			type:"post",
			url:"QnaGetList.us",
			data: {"qap":"public",
						"sId":"${sessionScope.sId}",
						"qnaPageNum" : pageNum
			},
			dataType:"text"
		}).done(function(response){
			$(".qna").html(response)
		}).fail(function(){
			alert("실패ㅜㅠ");
		})
	}
	function pageMovePrivate(pageNum) {
		$(".qna_button2").css("background","gray");
		$(".qna_button2").css("color","white");
		$(".qna_button1").css("background","white");
		$(".qna_button1").css("color","black");
		$.ajax({
			type:"post",
			url:"QnaGetList.us",
			data: {"qap":"private",
						"sId":"${sessionScope.sId}",
						"qnaPageNum" : pageNum			
			},
			dataType:"text"
		}).done(function(response){
			$(".qna").html(response)
		}).fail(function(){
			alert("실패ㅜㅠ!!");
		})
	}
		
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
<div class="modal" onclick="hide()"></div>
	
	<div id="wrapper">
	<section class="askhelp">
		<div id = "subject" class="subject">
			자주 찾는 도움말
		</div>
		<div class="text"></div>
		
		</section>
		<section class="qnahelp">
		<div id="subject">
			Q&amp;A <a href="QnaWrite.us" class="writeqna">문의 하기</a>
		</div>
		<div class="qna_flex">	
			<div id="qna_button"  class="qna_button1">공개 문의 내역</div>
			<div id="qna_button"  class="qna_button2">비공개 문의 내역</div>
		</div>
		<div class="qna"></div>
		</section>
</div>
<!-- 푸터 -->
<jsp:include page="/WEB-INF/views/inc/footer.jsp"/>
<!-- 푸터 -->
</body>
</html>