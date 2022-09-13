<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

				<ul>
					<c:forEach var="productList" items="${productList }">
					<li>
						<div class="contentUnit">
							<div class="content_img">
								<img src="resources/upload/${productList.pd_file }">
							</div>
							<div class="content_info">
								<div class="info_subject">${productList.pd_subject }</div>
								<div class="info_name">${productList.pd_name }</div>
								<div class="info_price"><b>${productList.pd_price }</b>원</div>
								<div class="info_content">
								</div>
								<div class="info_button">
									<input type="button" value="상품보기" onclick="location.href='UserProductDetail.us?pd_num=${productList.pd_num }'">
								</div>
							</div>
						</div>
					</li>
					</c:forEach>
				</ul>