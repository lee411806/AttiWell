<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<style>
a {
	color: grey; /* 또는 원하는 색상으로 변경 */
}

.input-form {
	max-width: 1200px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
}
</style>
<c:if test="${message=='cancel_order'}">
	<script>
		window.onload = function() {
			init();
		}

		function init() {
			alert("주문을 취소했습니다.");
		}
	</script>
</c:if>
<script>
	function fn_cancel_order(order_id) {
		var answer = confirm("주문을 취소하시겠습니까?");
		if (answer == true) {
			var formObj = document.createElement("form");
			var i_order_id = document.createElement("input");

			i_order_id.name = "order_id";
			i_order_id.value = order_id;

			formObj.appendChild(i_order_id);
			document.body.appendChild(formObj);
			formObj.method = "post";
			formObj.action = "${contextPath}/mypage/cancelMyOrder.do";
			formObj.submit();
		}
	}
</script>
</head>
<body>
	<div class="container" style="margin-left: 40px">
		<div class="input-form">
			<h1>
				최근주문내역
				<!-- 전체 주문내역 조회 수정 -->
				<A href="${contextPath}/mypage/listMyOrderHistoryAll.do"> <IMG
					src="${contextPath}/resources/image/btn_more_see.jpg">
				</A>
			</h1>
			<table class="list_view">
				<tbody align=center>
					<tr style="background: #EFE7E1">
						<td>주문번호</td>
						<td>주문일자</td>
						<td>주문상품</td>
						<td>주문상태</td>
						<td>주문취소</td>
					</tr>
					<c:choose>
						<c:when test="${ empty myOrderList  }">
							<tr>
								<td colspan=5 class="fixed"><strong>주문한 상품이 없습니다.</strong></td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="item" items="${myOrderList }" varStatus="i" begin="0" end="4">
								<c:choose>
									<c:when test="${ pre_order_id != item.order_id}">
										<c:choose>
											<c:when test="${item.delivery_state=='delivery_prepared' }">
												<tr bgcolor="lightgreen">
											</c:when>
											<c:when test="${item.delivery_state=='finished_delivering' }">
												<tr bgcolor="lightgray">
											</c:when>
											<c:otherwise>
												<tr bgcolor="orange">
											</c:otherwise>
										</c:choose>
										<tr>
											<td><a
												href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }"><span>${item.order_id }</span>
											</a></td>
											<td><span>${item.pay_order_time }</span></td>
											<td align="left"><strong> <c:forEach
														var="item2" items="${myOrderList}" varStatus="j">
														<c:if test="${item.order_id ==item2.order_id}">
															<a
																href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title }/${item.order_goods_qty }개</a>
															<br>
														</c:if>
													</c:forEach>
											</strong></td>
											<td><c:choose>
													<c:when test="${item.delivery_state=='delivery_prepared' }">
			       배송준비중
			    </c:when>
													<c:when test="${item.delivery_state=='delivering' }">
			       배송중
			    </c:when>
													<c:when
														test="${item.delivery_state=='finished_delivering' }">
			       배송완료
			    </c:when>
													<c:when test="${item.delivery_state=='cancel_order' }">
			       주문취소
			    </c:when>
													<c:when test="${item.delivery_state=='returning_goods' }">
			       반품완료
			    </c:when>
												</c:choose></td>
											<td><c:choose>
													<c:when test="${item.delivery_state=='delivery_prepared'}">
														<input type="button"
															onClick="fn_cancel_order('${item.order_id}')"
															value="주문취소" />
													</c:when>
													<c:otherwise>
														<input type="button"
															onClick="fn_cancel_order('${item.order_id}')"
															value="주문취소" disabled />
													</c:otherwise>
												</c:choose></td>
										</tr>
										<c:set var="pre_order_id" value="${item.order_id}" />
									</c:when>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>

			<br> <br> <br>
			<h1>
				나의 정보 <a href="${contextPath}/mypage/myDetailInfoDisabled.do"> <img
					src="${contextPath}/resources/image/btn_more_see.jpg" />
				</a>
			</h1>
			<table border=0 width=100% cellpadding=10 cellspacing=10>
				<tr>
					<td>이메일:</td>
					<td><strong>${memberInfo.email1 }@${memberInfo.email2 }</strong>
					</td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><strong>${memberInfo.hp1 }-${memberInfo.hp2}-${memberInfo.hp3 }</strong>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td>도로명: &nbsp;&nbsp; <strong>${memberInfo.roadAddress }</strong>
						<br> 지번: &nbsp;&nbsp; <strong>${memberInfo.jibunAddress }</strong>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
