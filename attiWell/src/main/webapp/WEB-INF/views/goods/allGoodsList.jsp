<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goodsVO}" />
<c:set var="imageList" value="${goodsMap.imageList }" />
<%
	//치환 변수 선언합니다.
	pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
	pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<html>

<head>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		// 현재 페이지 URL에서 sort 파라미터 추출
		const urlSearchParams = new URLSearchParams(window.location.search);
		const currentSortParam = urlSearchParams.get('sort');

		// 각 링크의 href에서 sort 파라미터 추출하여 비교
		const highPriceLink = document.getElementById('highPriceLink');
		const lowPriceLink = document.getElementById('lowPriceLink');

		if (currentSortParam === 'highPrice') {
			highPriceLink.style.color = 'red';
		} else if (currentSortParam === 'lowPrice') {
			lowPriceLink.style.color = 'red';
		} else {
			latestLink.style.color = 'red';
		}
	});
</script>
<style>

label:hover {
	color: red;
}

#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
}

#popup {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 50%;
	top: 45%;
	width: 300px;
	height: 200px;
	background-color: #ccffff;
	border: 3px solid #87cb42;
}

#close {
	z-index: 4;
	float: right;
}
</style>
<title>전체 상품 페이지</title>
<script type="text/javascript">
	function add_cart(goods_id) {
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/cart/addGoodsInCart.do",
			data : {
				goods_id : goods_id

			},
			success : function(data, textStatus) {
				//alert(data);
				//	$('#message').append(data);
				if (data.trim() == 'add_success') {
					imagePopup('open', '.layer01');
				} else if (data.trim() == 'already_existed') {
					alert("이미 카트에 등록된 상품입니다.");
				}

			},
			error : function(data, textStatus) {
				alert("로그인후 이용하세요.");
			},
			complete : function(data, textStatus) {
				// alert("장바구니에 등록됐습니다.");
			}
		}); //end ajax	
	}

	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');

			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer').height(jQuery(document).height());
		}

		else if (type == 'close') {

			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}

	function fn_order_each_goods(goods_id, goods_title, goods_sales_price,
			fileName) {
		var _isLogOn = document.getElementById("isLogOn");
		var isLogOn = _isLogOn.value;

		if (isLogOn == "false" || isLogOn == '') {
			alert("로그인 후 주문이 가능합니다!!!");
		}

		var total_price, final_total_price;
		var order_goods_qty = document.getElementById("order_goods_qty");

		var formObj = document.createElement("form");
		var i_goods_id = document.createElement("input");
		var i_goods_title = document.createElement("input");
		var i_goods_sales_price = document.createElement("input");
		var i_fileName = document.createElement("input");
		var i_order_goods_qty = document.createElement("input");

		i_goods_id.name = "goods_id";
		i_goods_title.name = "goods_title";
		i_goods_sales_price.name = "goods_sales_price";
		i_fileName.name = "goods_fileName";
		i_order_goods_qty.name = "order_goods_qty";

		i_goods_id.value = goods_id;
		i_order_goods_qty.value = order_goods_qty.value;
		i_goods_title.value = goods_title;
		i_goods_sales_price.value = goods_sales_price;
		i_fileName.value = fileName;

		formObj.appendChild(i_goods_id);
		formObj.appendChild(i_goods_title);
		formObj.appendChild(i_goods_sales_price);
		formObj.appendChild(i_fileName);
		formObj.appendChild(i_order_goods_qty);

		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "${contextPath}/order/orderEachGoods.do";
		formObj.submit();
	}
</script>
</head>
<body>
	<hgroup>
		<h1>전체 상품</h1>
		<h2>오늘의 상품</h2>
	</hgroup>
	<section id="new_book">
		<h3>새로나온 책</h3>
		<div id="left_scroll">
			<a href='javascript:slide("left");'><img
				src="${contextPath}/resources/image/left.gif"
				style="width: 30px; height: 40px; margin: 45px 25px 0px 0px"></a>
		</div>
		<div id="carousel_inner">
			<ul id="carousel_ul">
				<c:forEach var="item" items="${goodsList }">
					<li>
						<div id="book">
							<a
								href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
								<img width="250px" alt="" style="border-radius: 8px"
								src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
							</a>
							<div class="sort">${goods.goods_sort }</div>
							<div class="title">
								<a
									href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
									${item.goods_title} </a>
							</div>
							<div class="price">
								<c:set var="goodsPrice" value="${item.goods_price}" />
								<c:set var="goodsSalesPrice" value="${item.goods_sales_price}" />
								<c:set var="discountedPrice"
									value="${goodsPrice - (goodsPrice - goodsSalesPrice)}" />
								<c:set var="discount"
									value="${(goodsPrice - goodsSalesPrice) / goodsPrice * 100}" />

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
											<span style="color: black; font-weight: bold">${formattedDiscountedPrice }원</span>
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
					</li>
				</c:forEach>

			</ul>
		</div>
		<div id="right_scroll">
			<a href='javascript:slide("right");'><img
				src="${contextPath}/resources/image/right.gif"
				style="width: 30px; height: 40px; margin-top: 45px"></a>
		</div>
		<input id="hidden_auto_slide_seconds" type="hidden" value="0">

		<div class="clear"></div>
	</section>
	<div class="clear"></div>
	<div id="sorting">
		<ul>
			<li><a href="${contextPath}/goods/allGoodsList.do?sort=latest"
				id="latestLink">최신순</a></li>
			<li><a
				href="${contextPath}/goods/allGoodsList.do?sort=highPrice"
				id="highPriceLink">높은가격순</a></li>
			<li><a href="${contextPath}/goods/allGoodsList.do?sort=lowPrice"
				id="lowPriceLink">낮은가격순</a></li>
		</ul>
	</div>
	<table id="list_view">
		<tbody>
			<c:forEach var="item" items="${goodsList }">
				<tr>
					<td class="goods_image"><a
						href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
							<img width="150" alt="" style="border-radius: 8px"
							src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
					</a></td>
					<td class="goods_description">
						<h2>
							<a
								href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">&nbsp;&nbsp;${item.goods_title }</a>
						</h2>
					</td>
					<td class="price"><c:set var="goodsPrice"
							value="${item.goods_price}" /> <c:set var="goodsSalesPrice"
							value="${item.goods_sales_price}" /> <c:set
							var="discountedPrice"
							value="${goodsPrice - (goodsPrice - goodsSalesPrice)}" /> <c:set
							var="discount"
							value="${(goodsPrice - goodsSalesPrice) / goodsPrice * 100}" />

						<%
							double roundedDiscount = Math.ceil(Double.parseDouble(pageContext.getAttribute("discount").toString()));
								pageContext.setAttribute("roundedDiscount", roundedDiscount);
						%> <fmt:formatNumber value="${discountedPrice}" type="number"
							var="formattedDiscountedPrice" /> <fmt:formatNumber
							value="${roundedDiscount}" type="number"
							var="formattedRoundedDiscount" maxFractionDigits="0" /> <span>
							<fmt:formatNumber value="${item.goods_price}" type="number"
								var="goods_price" /> <c:choose>
								<c:when test="${item.goods_price == item.goods_sales_price }">
									<span style="color: black; font-weight: bold">${formattedDiscountedPrice }원</span>
								</c:when>
								<c:otherwise>
									<span style="text-decoration: line-through;">${goods_price}원</span>

									<span style="color: red; font-weight: bold">${formattedDiscountedPrice }원(${formattedRoundedDiscount}%할인)</span>
								</c:otherwise>
							</c:choose>
					</span> <br></td>
					<td><input type="hidden" id="order_goods_qty" value="1" /></td>
					<td class="buy_btns">
						<UL>
							<li><a class="cart"
								href="javascript:add_cart('${item.goods_id }')">장바구니</a></li>
							<li><a class="buy"
								href="javascript:fn_order_each_goods('${item.goods_id }','${item.goods_title }','${item.goods_sales_price}','${item.goods_fileName}');">구매하기</a></li>
						</UL>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="clear"></div>
	<div id="page_wrap">
		<ul id="page_control">
			<c:forEach var="page" begin="1" end="${(totalCount + 9) / 10}"
				step="1">
				<c:url value="allGoodsList.do" var="pagingUrl">
					<c:param name="section" value="${section}" />
					<c:param name="pageNum" value="${page}" />
					<c:param name="sort" value="${sort}" />
				</c:url>
				<c:if test="${section > 1 && page == 1}">
					<a href="${pagingUrl}">&nbsp;&nbsp;</a>
				</c:if>
				<a href="${pagingUrl}">${(section - 1) * 10 + page}</a>
				<c:if test="${page == 10}">
					<c:url value="allGoodsList.do" var="nextPageUrl">
						<c:param name="section" value="${section + 1}" />
						<c:param name="pageNum" value="${section * 10 + 1}" />
						<c:param name="sort" value="${sort}" />
					</c:url>
					<a href="${nextPageUrl}">&nbsp;next</a>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	<div class="clear"></div>
	<div id="layer" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:"
				onClick="javascript:imagePopup('close', '.layer01');"> <img
				src="${contextPath}/resources/image/close.png" id="close" />
			</a> <br /> <font size="12" id="contents">장바구니에 담았습니다.</font><br>
			<form action='${contextPath}/cart/myCartList.do'>
				<input type="submit" value="장바구니 보기">
			</form>
		</div>
	</div>
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}" />