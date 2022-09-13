<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/user_qna_write.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet">
<link href="resources/css/header.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="css/user_qna_write.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(function(){
	if("${sessionScope.sId}" == "") {
		alert("로그인이 필요한 기능입니다.");
		location.href= "UserLogin.us";
	}
})
$(document).ready(function(){
	$(".type_select").on("change",function(){
		let type = $(".type_select").val();
		if(type == "상품"){
			window.name = "parentQna";
			childQna = window.open("UserQnaSelectProduct.us", "chilsQna", "width=815px, height=895px ");
		}else {
			$("#pd_subject").val(null);
		}
	})
	$("#pd_subject").on("click",function(){
		let type = $(".type_select").val();
		if(type == "상품"){
			window.name = "parentQna";
			childQna = window.open("UserQnaSelectProduct.us", "chilsQna", "width=815px, height=895px ");
		}else{
			$("#pd_subject").val(null);
		}
	})
});

function check() {
	if(${sessionScope.sId == null}) {
		alert("로그인이 필요한 기능입니다.")
		location.href= "UserLogin.us";
		return false;}
 if(fr.qna_subject.value == "") {
			alert("제목을 입력해 주세요.");
			fr.qna_subject.focus();
			return false;
		}
 else if(fr.qna_user.value == "") {
		alert("이름을 입력해 주세요.");
		fr.qna_user.focus();
		return false;
	}
 else if(fr.qna_type.value == "") {
		alert("문의 분류를 선택 주세요");
		fr.qna_type.focus();
		return false;
	}
 else if(fr.qna_type.value == "상품"){
		if(fr.pd_subject.value == "" || fr.qna_pd_num.value == ""){
			alert("상품을 선택해 주세요");
			childQna = window.open("UserQnaSelectProduct.us", "chilsQna", "width=800px, height=850px ");
			return false;
		}
	}
 else if(fr.qna_content.value == "") {
		alert("문의 내용을 작성해 주세요.");
		fr.qna_content.focus();
		return false;
	}
	return true;
}


</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
	<form name="fr" action="QnaWritePro.us" method="post" onsubmit="return check();">
	<input type="hidden" value="${sessionScope.sId }" name="qna_user_email">
	<input type="hidden" value="${sessionScope.sName }" name="qna_user">
	<div id="write_section">
		<div class="qna_subject">
			제 목 <input type="text" placeholder="최대 50자 제한" name="qna_subject" id="subject_write" maxlength="50"  >
		</div>
		<div class="qna_subject">
			작성자 : ${sessionScope.sName }
		</div>
		<div class="qna_subject" >아이디 : ${sessionScope.sId }</div>
		<div class="qna_disclosure">공개 여부 :	
			<input type="radio" value="public" id="public" name="qna_accesspermission" checked="checked"><label for="public">공개</label>&nbsp;&nbsp;
			<input type="radio" value="private" id="private" name="qna_accesspermission"><label for="private">비공개</label>
		</div>
		<div id="qna_type">문의 분류
			<select name="qna_type" class="type_select">
				<option value="" selected="selected" disabled="disabled">선택해주세요</option>
				<option value="상품" class="product_select">상품</option>
				<option value="계정">계정</option>
			</select>
			<div class="selected_product">
				<input type="text"  readonly="readonly"  name="pd_subject" placeholder="상품 선택란" id="pd_subject">
				<input type="hidden" name="qna_pd_num" id="pd_num">
			</div>
			
		</div>
		
		<textarea name="qna_content" placeholder="문의 내용을 입력해주세요."></textarea><br>
		<div class="submit">
			<input type="submit" value="작성" class="submit_button" >
		</div>
	</div>
	</form>
	
	<jsp:include page="/WEB-INF/views/inc/footer.jsp"/>
</body>
</html>