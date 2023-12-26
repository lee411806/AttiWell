<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goodsVO}" />
<%-- <c:set var="cart" value="${cartMap.cartVO}" /> --%>
<c:set var="imageList" value="${goodsMap.imageList }" />
<%
	//치환 변수 선언합니다.
	//pageContext.setAttribute("crcn", "\r\n"); //개행문자
	pageContext.setAttribute("crcn", "\n"); //Ajax로 변경 시 개행 문자 
	pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<html>
<head>
<style>
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
	width: 400px;
	height: 220px;
	background-color: aliceblue;
	border: 3px solid #234F12;
	color: #234F12;
}

#close {
	z-index: 4;
	float: right;
}
</style>
<script type="text/javascript">
	function add_cart(goods_id) {

		var orderGoodsQty = document.getElementById('order_goods_qty').value;
		console.log('주문 수량:', orderGoodsQty);
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/cart/addGoodsInCart.do",
			data : {
				goods_id : goods_id,
				orderGoodsQty : orderGoodsQty
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
				alert("로그인 후 이용하세요.");
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
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
<link rel="s7tylesheet" href="${contextPath}/resources/css/main.css" />

</head>

<body>
	<hgroup>
		<h1 style="font-size: 30px; color: #1b7340">${goods.goods_sort }</h1>
		<h2>${goods.goods_sort }&gt;${goods.goods_status }</h2>
		<h3 style="font-size: 20px">${goods.goods_title }</h3>
	</hgroup>
	<div id="goods_image">
		<figure>
			<img style="width: 450px"
				src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_fileName}">
		</figure>
	</div>
	<div id="detail_table">
		<table>
			<tbody>
				<tr>
					<td class="fixed">정가</td>
					<td class="active"><span
						style="text-decoration: line-through;"> <fmt:formatNumber
								value="${goods.goods_price}" type="number" var="goods_price" />
							${goods_price}원
					</span></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">판매가</td>
					<td class="active"><c:set var="goodsPrice"
							value="${goods.goods_price}" /> <c:set var="goodsSalesPrice"
							value="${goods.goods_sales_price}" /> <c:set
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
							var="formattedRoundedDiscount" maxFractionDigits="0" /> <fmt:formatNumber
							value="${discountedPrice}" type="number"
							var="formattedDiscountedPrice" /> <fmt:formatNumber
							value="${roundedDiscount}" type="number"
							var="formattedRoundedDiscount" /> <span> <fmt:formatNumber
								value="${item.goods_price}" type="number" var="goods_price" />
							<c:choose>
								<c:when test="${item.goods_price == item.goods_sales_price }">
									<span style="color: blue; font-weight: bold">${formattedDiscountedPrice }원</span>
								</c:when>
								<c:otherwise>
									<span style="text-decoration: line-through;">${goods_price}원</span>
									<br>

									<span style="color: blue; font-weight: bold">${formattedDiscountedPrice }원(${formattedRoundedDiscount}%할인)</span>
								</c:otherwise>
							</c:choose>
					</span> <br>
				</tr>
				<%-- <tr>
					<td class="fixed">포인트적립</td>
					<td class="active">${goods.goods_point}P(5%적립)</td>
				</tr> --%>
				<!-- <tr class="dot_line">
					<td class="fixed">포인트 추가적립</td>
					<td class="fixed">만원이상 구매시 1,000P, 5만원이상 구매시 2,000P추가적립 편의점 배송
						이용시 300P 추가적립</td>
				</tr> -->
				<tr>
					<td class="fixed">배송료</td>
					<td class="fixed"><strong>무료</strong></td>
				</tr>
				<tr>
					<td class="fixed">배송안내</td>
					<td class="fixed"><strong>[당일배송]</strong> 당일배송 서비스 시작!<br>
						<br> <strong>[휴일배송]</strong> 휴일에도 배송받는 <img
						src="${contextPath}/resources/image/logo3_v2.png"
						style="width: 120px; height: 50px; margin: 10px 0px 0px 30px"></TD>
				</tr>
				<tr>
					<td class="fixed">도착예정일</td>
					<td class="fixed">지금 주문 시 내일 도착 예정</td>
				</tr>
				<tr>
					<td class="fixed">수량</td>
					<td class="fixed"><select style="width: 60px;"
						id="order_goods_qty">
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
					</select></td>
				</tr>
			</tbody>
		</table>
		<ul>
			<li><a class="buy"
				href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title }','${goods.goods_sales_price}','${goods.goods_fileName}');">구매하기
			</a></li>
			<li><a class="cart"
				href="javascript:add_cart('${goods.goods_id }')">장바구니</a></li>
		</ul>
	</div>
	<div class="clear"></div>
	<!-- 내용 들어 가는 곳 -->
	<div id="container">
		<ul class="tabs">
			<li><a href="#tab1">상품소개</a></li>
			<!-- <li><a href="#tab6">리뷰</a></li> -->
		</ul>
		<div class="tab_container">
			<div class="tab_content" id="tab1">
				<h4>상품소개</h4>
				<p>${fn:replace(goods.goods_intro,crcn,br)}</p>
				<c:forEach var="image" items="${imageList }">
					<img style="width: 900px; margin: auto"
						src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${image.fileName}">
				</c:forEach>
			</div>
			<!-- <div class="tab_content" id="tab6">
				<h4>리뷰</h4>
			</div> -->
		</div>
	</div>
	<div class="clear"></div>
	<div id="layer" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:"
				onClick="javascript:imagePopup('close', '.layer01');"> <img
				src="${contextPath}/resources/image/close.png" id="close" />
			</a> <br /> <font size="12" id="contents">&nbsp;장바구니에<br>담았습니다
			</font><br>
			<form action='${contextPath}/cart/myCartList.do'>
				<br> <input type="submit" value="장바구니 보기">
			</form>
		</div>
	</div>
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}" />