<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>

<div id="ad_main_banner">
	<ul class="bjqs">
		<li><img width="960" height="345"
			src="${contextPath}/resources/image/main_banner1.png"></li>
		<li><img width="960" height="345"
			src="${contextPath}/resources/image/main_banner2.png"></li>
		<li><img width="960" height="345"
			src="${contextPath}/resources/image/main_banner3.png"></li>
	</ul>
</div>





<div class="main_book">
	<c:set var="goods_count" value="0" />
	<div style="font: bold 25px Arial, sans-serif;">인기 상품</div>
	<hr>
	<c:forEach var="item" items="${goodsMap.bestseller }">
		<c:set var="goods_count" value="${goods_count+1 }" />
		<div class="book">
			<a
				href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
				<img class="link" src="${contextPath}/resources/image/1px.gif">
			</a> <img width="121" height="154"
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">

			<div class="title">${item.goods_title }</div>
			<div class="price">
				<fmt:formatNumber value="${item.goods_price}" type="number"
					var="goods_price" />
				${goods_price}원
			</div>
		</div>
		<c:if test="${goods_count==15   }">
			<div class="book">
				<font size=20> <a href="#">more</a></font>
			</div>
		</c:if>
	</c:forEach>
</div>






<div class="clear"></div>
<div class="clear"></div>
<div id="ad_sub_banner">
	<img width="960" height="250"
		src="${contextPath}/resources/image/main_banner5.jpg">
</div>


<div class="main_book">
	<c:set var="goods_count" value="0" />
	<div style="font: bold 25px Arial, sans-serif;">할인 상품</div>
	<hr>
	<c:forEach var="item" items="${goodsMap.newbook }">
		<c:set var="goods_count" value="${goods_count+1 }" />
		<div class="book">
			<a
				href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
				<img class="link" src="${contextPath}/resources/image/1px.gif">
			</a> <img width="121" height="154"
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
			<div class="title">${item.goods_title }</div>
			<div class="price">
				<fmt:formatNumber value="${item.goods_price}" type="number"
					var="goods_price" />
				${goods_price}원
			</div>
		</div>
		<c:if test="${goods_count==15   }">
			<div class="book">
				<font size=20> <a href="#">more</a></font>
			</div>
		</c:if>
	</c:forEach>
</div>





