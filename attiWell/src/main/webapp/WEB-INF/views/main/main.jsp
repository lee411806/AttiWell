<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goodsVO}" />
<%
	request.setCharacterEncoding("UTF-8");
%>

<div id="ad_main_banner">
	<ul class="bjqs">
		<li><img width="960" height="345"
			src="${contextPath}/resources/image/main_banner2.png"></li>
		<li><img width="960" height="345"
			src="${contextPath}/resources/image/main_banner1.png"></li>
		<li><img width="960" height="345"
			src="${contextPath}/resources/image/main_banner3.png"></li>
	</ul>
</div>


<div class="main_book">
	<c:set var="goods_count" value="0" />
	<div style="font: bold 25px Arial, sans-serif;">인기 상품</div>
	<hr>
	<c:forEach var="item" items="${goodsMap.hot }">
		<c:set var="goods_count" value="${goods_count+1 }" />
		<div class="book">
			<a
				href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
				<img class="link" src="${contextPath}/resources/image/1px.gif">
			</a> <img style="size: 220, 250" width="220" height="240"
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
				style="border-radius:8px">
			<div class="title" style="font-size: 16px">${item.goods_title }</div>
			<div class="price">

				<c:set var="goodsPrice" value="${item.goods_price}" />
				<c:set var="goodsSalesPrice" value="${item.goods_sales_price}" />

				<c:set var="discountedPrice"
					value="${goodsPrice - (goodsPrice - goodsSalesPrice)}" />
				<c:set var="discount"
					value="${(goodsPrice - goodsSalesPrice) / goodsPrice * 100}" />

				<%-- 올림된 discount 값을 얻기 위해 Java 스크립트릿을 사용합니다. --%>
				<%
					double roundedDiscount = Math.ceil(Double.parseDouble(pageContext.getAttribute("discount").toString()));
						pageContext.setAttribute("roundedDiscount", roundedDiscount);
				%>

				<fmt:formatNumber value="${discountedPrice}" type="number"
					var="formattedDiscountedPrice" />

				<fmt:formatNumber value="${roundedDiscount}" type="number"
					var="formattedRoundedDiscount" />


				<span> <fmt:formatNumber value="${item.goods_price}"
						type="number" var="goods_price" /> <c:choose>
						<c:when test="${item.goods_price == item.goods_sales_price }">
							<span style="color: red; font-weight: bold">${formattedDiscountedPrice }원</span>
						</c:when>
						<c:otherwise>
							<span style="text-decoration: line-through;">${goods_price}원</span>
							<br>

							<span style="color: red; font-weight: bold">${formattedDiscountedPrice }원(${formattedRoundedDiscount}%할인)</span>
						</c:otherwise>
					</c:choose>
				</span> <br>
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
	<c:forEach var="item" items="${goodsMap.discount }">
		<c:set var="goods_count" value="${goods_count+1 }" />
		<div class="book">
			<a
				href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
				<img class="link" src="${contextPath}/resources/image/1px.gif">
			</a> <img style="size: 220, 250" width="220" height="240"
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
				style="border-radius:8px">
			<div class="title" style="font-size: 16px">${item.goods_title }</div>
			<div class="price">

				<c:set var="goodsPrice" value="${item.goods_price}" />
				<c:set var="goodsSalesPrice" value="${item.goods_sales_price}" />

				<c:set var="discountedPrice"
					value="${goodsPrice - (goodsPrice - goodsSalesPrice)}" />
				<c:set var="discount"
					value="${(goodsPrice - goodsSalesPrice) / goodsPrice * 100}" />

				<%-- 올림된 discount 값을 얻기 위해 Java 스크립트릿을 사용합니다. --%>
				<%
					double roundedDiscount = Math.ceil(Double.parseDouble(pageContext.getAttribute("discount").toString()));
						pageContext.setAttribute("roundedDiscount", roundedDiscount);
				%>

				<fmt:formatNumber value="${discountedPrice}" type="number"
					var="formattedDiscountedPrice" />

				<fmt:formatNumber value="${roundedDiscount}" type="number"
					var="formattedRoundedDiscount" />


				<span> <fmt:formatNumber value="${item.goods_price}"
						type="number" var="goods_price" /> <c:choose>
						<c:when test="${item.goods_price == item.goods_sales_price }">
							<span style="color: red; font-weight: bold">${formattedDiscountedPrice }원</span>
						</c:when>
						<c:otherwise>
							<span style="text-decoration: line-through;">${goods_price}원</span>
							<br>

							<span style="color: red; font-weight: bold">${formattedDiscountedPrice }원(${formattedRoundedDiscount}%할인)</span>
						</c:otherwise>
					</c:choose>
				</span> <br>
			</div>
		</div>
		<c:if test="${goods_count==15   }">
			<div class="book">
				<font size=20> <a href="#">more</a></font>
			</div>
		</c:if>
	</c:forEach>
</div>






