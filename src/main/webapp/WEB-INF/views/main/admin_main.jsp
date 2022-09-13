<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 마이페이지</title>
<!-- 구글차트 활용 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 구글차트 활용 -->
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart', 'bar']});
      google.charts.setOnLoadCallback(drawStuff);

      function drawStuff() {
        var button = document.getElementById('change-chart');
        var chartDiv = document.getElementById('chart_div');
        
        var userCount1 = '<c:out value="${userCountList[0].user_count}"/>';
        var userCount2 = '<c:out value="${userCountList[1].user_count}"/>';
        var userCount3 = '<c:out value="${userCountList[2].user_count}"/>';
        var userCount4 = '<c:out value="${userCountList[3].user_count}"/>';
        var userCount5 = '<c:out value="${userCountList[4].user_count}"/>';
        
       	var chartDate1 = '<c:out value="${salesList[0].order_date}"/>';
       	var chartDate2 = '<c:out value="${salesList[1].order_date}"/>';
       	var chartDate3 = '<c:out value="${salesList[2].order_date}"/>';
       	var chartDate4 = '<c:out value="${salesList[3].order_date}"/>';
       	var chartDate5 = '<c:out value="${salesList[4].order_date}"/>';
        
       	// 많은 데이터를 넣기보다 매출과 가입자 수 데이터에 *(곱셈)을 하여 표현
        var data = google.visualization.arrayToDataTable([
          ['날짜', '매출', '가입자'],
          [chartDate1,${salesList[0].order_price*5},(userCount1*100)],
          [chartDate2,${salesList[1].order_price*5},(userCount2*100)],
          [chartDate3,${salesList[2].order_price*5},(userCount3*100)],
          [chartDate4,${salesList[3].order_price*5},(userCount4*100)],
//           [chartDate5,${salesList[4].order_price*5},(userCount5*100)]
          ['2022-09-07', 2500000,400]
      	]);
        var materialOptions = {
                chart: {
                  subtitle: 'L = 매출 / R = 가입자 수'
                },
                series: {
                  0: { axis: '매출' }, 
                  1: { axis: '가입자' } 
                }
              };

              var classicOptions = {
				series: {
				  0: {targetAxisIndex: 0},
				  1: {targetAxisIndex: 1}
				}
              };

              function drawMaterialChart() {
                var materialChart = new google.charts.Bar(chartDiv);
                materialChart.draw(data, google.charts.Bar.convertOptions(materialOptions));
                button.innerText = 'Change to Classic';
                button.onclick = drawClassicChart;
              }

              function drawClassicChart() {
                var classicChart = new google.visualization.ColumnChart(chartDiv);
                classicChart.draw(data, classicOptions);
                button.innerText = 'Change to Material';
                button.onclick = drawMaterialChart;
              }

              drawMaterialChart();
          };
    </script>
<link href="resources/css/admin_page.css" rel="stylesheet"/>
</head>
<body>
	<!-- 헤더 넣는 자리 -->
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"/>
	<!-- 헤더 넣는 자리 -->
	
	<div class="wrapper">
		<!-- 주문관리 자리 -->
		<div class="table">
			<a href="OrderList.ad?order_status=all">
			    <div class="row header">
		      		<div class="cell">
		        		주문관리 &gt;
		      		</div>
		      	</div>
			</a>
			<a href="OrderList.ad?order_status=yes">
		      	<div class="row">
			      	<div class="cell">
			        	당일 신규주문
			      	</div>
			      	<div class="cell2">
			        	${ordNoArr[0] } 건
			        </div>
			   	</div>
			</a>
			<a href="OrderList.ad?order_status=no">
		      	<div class="row">
			      	<div class="cell">
			        	당일 주문취소
			      	</div>
			      	<div class="cell2">
			        	${ordNoArr[1] } 건
			        </div>
			   	</div>
			</a>
		</div>
		<!-- 주문관리 자리 -->
		
		<!-- 상품관리 게시판자리 -->
	 		<div class="table">
	 		<a href="ProductList.ad?type=all&quan=all">
		    	<div class="row header">
		      		<div class="cell">상품관리 &gt;
		      		</div>
		      	</div>
	      	</a>
		    <a href="ProductList.ad?type=all&quan=false" >
			    <div class="row">
			      	<div class="cell">
			        	상품품절
			      	</div>
			      	<div class="cell2">
			        	${pdNoArr[0] } 건
			        </div>
			    </div>
		    </a>
		</div>
		<!-- 교환/취소 게시판자리 -->
		
		<!-- 고객문의 게시판자리 -->
 		<div class="table">
	 		<a href="QnaList.ad?qna_type=전체">
		    	<div class="row header">
		      		<div class="cell">
		        		고객문의 &gt;
		      		</div>
		      	</div>
	      	</a>
	      	<a href="QnaList.ad?qna_type=계정" >
			    <div class="row">
			      	<div class="cell">
			        	계정문의 미답변
			      	</div>
			      	<div class="cell2">
			        	${qnaNoArr[0] } 건
			        </div>
			    </div>
			</a>
			<a href="QnaList.ad?qna_type=상품" >
			    <div class="row">
			      	<div class="cell">
			        	상품문의 미답변
			      	</div>
			      	<div class="cell2">
			        	${qnaNoArr[1] } 건
			        </div>
			   	</div>
			</a>
		</div>
		<!-- 고객문의 게시판자리 -->
	</div>
	
	<div class=veiw_chart>
		<div id="chart_subject">
			<a href ="">&lt; 일별 매출 / 일별 가입자 수 차트 &gt;</a>
		</div>
		<!-- 매출그래프 자리 -->
		<div class="chart1" id="chart_div"  style="width: 1000px; height: 400px;"></div>
		<!-- 매출그래프 자리  -->
	</div>
</body>
</html>