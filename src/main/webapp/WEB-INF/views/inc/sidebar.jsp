<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="resources/js/jquery-3.6.0.js"></script>
<script src="resources/js/bootstrap-datepicker.js"></script>
<script src="resources/js/bootstrap-datepicker.kr.min.js"></script>
<script type='text/javascript'>

</script>
<section class="sidebar">
	<!-- 리모콘 영역 시작 -->
	<section class="remote_area">
		<!-- 찜 -->
      <div class="remote_title">
         <c:choose>
            <c:when test="${empty sessionScope.sId}">
               <!-- 로그인 상태가 아닐 시 로그인 페이지로 -->
               <a href="UserLogin.us">찜</a>
               <!-- 로그인 상태가 아닐 시 로그인 페이지로 끝-->
            </c:when>
            <c:otherwise>
               <!-- 로그인 상태일 시 찜 페이지로 -->
               <a href="MyInter.us?sId=${sessionScope.sId }" class="tab">찜</a>
               <!-- 로그인 상태일 시 찜 페이지로 -->
            </c:otherwise>
         </c:choose>
      </div>
      <!-- 찜 끝 -->
		
		
	</section>
	<!-- 리모콘 영역 끝 -->
</section>
<script type="text/javascript" src="resources/js/sidebar.js"></script>