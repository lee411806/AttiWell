<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		<!-- 주문자 휴대폰 번호 -->
		<c:set var="orderer_hp" value="" />
		<!-- 최종 결제 금액 -->
		<c:set var="final_total_order_price" value="0" />

		<!-- 총 주문 금액 -->
		<c:set var="total_order_price" value="0" />
		<!-- 총 상품수 -->
		<c:set var="total_order_goods_qty" value="0" />
		<!-- 총할인금액 -->
		<c:set var="total_discount_price" value="0" />
		<!-- 총 배송비 -->
		<c:set var="total_delivery_price" value="2500" />

		<!DOCTYPE html>
		<html lang="ko">

		<head>
			<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
				integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
				crossorigin="anonymous">
			<style>
				.lableBox {
					margin: 20px 20px 10px 20px;
				}

				.lableBox_payment_phoneNum {
					margin: 5px 20px 0 0;
				}


				.inputBox {
					border: solid 1px #c0c0c0;
					border-radius: 5px;
					width: 350px;
					height: 38px;
					margin: 10px 0 0 0;
				}

				.inputBox_select {
					border: solid 1px #c0c0c0;
					border-radius: 5px;
					width: 110px;
					height: 38px;
					margin: 10px 5px 0 0;
				}

				.inputBox_address {
					border: solid 1px #c0c0c0;
					border-radius: 5px;
					width: 350px;
					height: 38px;
					margin: 10px 0 0 130px;
				}

				.button {
					background-color: white;
					border: 1px solid green;
					color: green;
					width: 100px;
					height: 25px;
					margin-top: 10px;
				}

				.book_line {
					border: 1px dashed #c0c0c0;
					/* 점선 스타일 및 테두리 색상 설정 */
					margin: 20px 0;
					/* 위아래 여백 설정 */
					height: 0.5px;
				}

				.inputBox_discount {
					border: solid 1px #c0c0c0;
					border-radius: 5px;
					width: 100px;
					height: 38px;
					margin: 10px 0 0 -20px;
					text-align: right;
				}

				.square-box {
					width: 615px;
					height: 50px;
					background-color: gray;
					border: 2px solid gray;
					border-radius: 5px;
					display: flex;
					justify-content: center;
					align-items: center;
					color: #fff;
				}

				.col_width {
					width: 145px;
				}

				.tr_height {
					height: 40px;
				}

				.table_margin {
					margin-left: 50px;

				}

				.square_box2 {
					margin: 15px 0 20px 15px;
					width: 615px;
					height: 100px;
					background-color: rgb(230, 230, 230);
					border: 2px solid rgb(230, 230, 230);
					border-radius: 5px;
					display: flex;
					justify-content: center;
					align-items: center;
					color: #000;

				}

				div .inputBox_select_card {
					border: solid 1px #c0c0c0;
					border-radius: 5px;
					width: 110px;
					height: 38px;
					margin: 2px 5px 0 0;
				}

				.order_line {
					border-top: 1px dashed #ccc;
					/* 구분선의 스타일 및 색상 설정 */
					margin-top: 10px;
					/* 구분선 위쪽 여백 설정 (선택사항) */
					margin-bottom: 10px;
					/* 구분선 아래쪽 여백 설정 (선택사항) */
				}

				#tr_pay_card {
					display: block;
				}

				#tr_pay_phone {
					display: none;
				}
			</style>
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
			<script>
				function execDaumPostcode() {
					new daum.Postcode({
						oncomplete: function (data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 도로명 조합형 주소 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== '' && data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
							}
							// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}
							// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
							if (fullRoadAddr !== '') {
								fullRoadAddr += extraRoadAddr;
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
							document.getElementById('roadAddress').value = fullRoadAddr;
							document.getElementById('jibunAddress').value = data.jibunAddress;

							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							if (data.autoRoadAddress) {
								//예상되는 도로명 주소에 조합형 주소를 추가한다.
								var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
								document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

							} else if (data.autoJibunAddress) {
								var expJibunAddr = data.autoJibunAddress;
								document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

							} else {
								document.getElementById('guide').innerHTML = '';
							}
						}
					}).open();
				}

				window.onload = function () {
					init();
				}

				function init() {
					var form_order = document.form_order;
					var h_tel1 = form_order.h_tel1;
					var h_hp1 = form_order.h_hp1;
					var tel1 = h_tel1.value;
					var hp1 = h_hp1.value;
					var select_tel1 = form_order.tel1;
					var select_hp1 = form_order.hp1;
					select_tel1.value = tel1;
					select_hp1.value = hp1;
				}

				function reset_all() {
					var e_receiver_name = document.getElementById("receiver_name");
					var e_hp1 = document.getElementById("hp1");
					var e_hp2 = document.getElementById("hp2");
					var e_hp3 = document.getElementById("hp3");

					var e_tel1 = document.getElementById("tel1");
					var e_tel2 = document.getElementById("tel2");
					var e_tel3 = document.getElementById("tel3");

					var e_zipcode = document.getElementById("zipcode");
					var e_roadAddress = document.getElementById("roadAddress");
					var e_jibunAddress = document.getElementById("jibunAddress");
					var e_namujiAddress = document.getElementById("namujiAddress");

					e_receiver_name.value = "";
					e_hp1.value = 0;
					e_hp2.value = "";
					e_hp3.value = "";
					e_tel1.value = "";
					e_tel2.value = "";
					e_tel3.value = "";
					e_zipcode.value = "";
					e_roadAddress.value = "";
					e_jibunAddress.value = "";
					e_namujiAddress.value = "";
				}

				function restore_all() {
					var e_receiver_name = document.getElementById("receiver_name");
					var e_hp1 = document.getElementById("hp1");
					var e_hp2 = document.getElementById("hp2");
					var e_hp3 = document.getElementById("hp3");

					var e_tel1 = document.getElementById("tel1");
					var e_tel2 = document.getElementById("tel2");
					var e_tel3 = document.getElementById("tel3");

					var e_zipcode = document.getElementById("zipcode");
					var e_roadAddress = document.getElementById("roadAddress");
					var e_jibunAddress = document.getElementById("jibunAddress");
					var e_namujiAddress = document.getElementById("namujiAddress");

					var h_receiver_name = document.getElementById("h_receiver_name");
					var h_hp1 = document.getElementById("h_hp1");
					var h_hp2 = document.getElementById("h_hp2");
					var h_hp3 = document.getElementById("h_hp3");

					var h_tel1 = document.getElementById("h_tel1");
					var h_tel2 = document.getElementById("h_tel2");
					var h_tel3 = document.getElementById("h_tel3");

					var h_zipcode = document.getElementById("h_zipcode");
					var h_roadAddress = document.getElementById("h_roadAddress");
					var h_jibunAddress = document.getElementById("h_jibunAddress");
					var h_namujiAddress = document.getElementById("h_namujiAddress");
					//alert(e_receiver_name.value);
					e_receiver_name.value = h_receiver_name.value;
					e_hp1.value = h_hp1.value;
					e_hp2.value = h_hp2.value;
					e_hp3.value = h_hp3.value;

					e_tel1.value = h_tel1.value;
					e_tel2.value = h_tel2.value;
					e_tel3.value = h_tel3.value;
					e_zipcode.value = h_zipcode.value;
					e_roadAddress.value = h_roadAddress.value;
					e_jibunAddress.value = h_jibunAddress.value;
					e_namujiAddress.value = h_namujiAddress.value;

				}

				function fn_pay_phone() {


					var e_card = document.getElementById("tr_pay_card");
					var e_phone = document.getElementById("tr_pay_phone");
					e_card.style.visibility = "hidden";
					e_phone.style.visibility = "visible";
				}

				function fn_pay_card() {
					var e_card = document.getElementById("tr_pay_card");
					var e_phone = document.getElementById("tr_pay_phone");
					e_card.style.visibility = "visible";
					e_phone.style.visibility = "hidden";
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


				var goods_id = "";
				var goods_title = "";
				var goods_fileName = "";

				var order_goods_qty
				var each_goods_price;
				var total_order_goods_price;
				var total_order_goods_qty;
				var orderer_name
				var receiver_name
				var hp1;
				var hp2;
				var hp3;

				var tel1;
				var tel2;
				var tel3;

				var receiver_hp_num;
				var receiver_tel_num;
				var delivery_address;
				var delivery_message;
				var delivery_method;
				var gift_wrapping;
				var pay_method;
				var card_com_name;
				var card_pay_month;
				var pay_orderer_hp_num;

				function fn_show_order_detail() {
					goods_id = "";
					goods_title = "";

					var frm = document.form_order;
					var h_goods_id = frm.h_goods_id;
					var h_goods_title = frm.h_goods_title;
					var h_goods_fileName = frm.h_goods_fileName;
					var r_delivery_method = frm.delivery_method;
					var h_order_goods_qty = document.getElementById("h_order_goods_qty");
					var h_total_order_goods_qty = document.getElementById("h_total_order_goods_qty");
					var h_total_sales_price = document.getElementById("h_total_sales_price");
					var h_final_total_Price = document.getElementById("h_final_total_Price");
					var h_orderer_name = document.getElementById("h_orderer_name");
					var i_receiver_name = document.getElementById("receiver_name");


					if (h_goods_id.length < 2 || h_goods_id.length == null) {
						goods_id += h_goods_id.value;
					} else {
						for (var i = 0; i < h_goods_id.length; i++) {
							goods_id += h_goods_id[i].value + "<br>";

						}
					}

					if (h_goods_title.length < 2 || h_goods_title.length == null) {
						goods_title += h_goods_title.value;
					} else {
						for (var i = 0; i < h_goods_title.length; i++) {
							goods_title += h_goods_title[i].value + "<br>";

						}
					}


					if (h_goods_fileName.length < 2 || h_goods_fileName.length == null) {
						goods_fileName += h_goods_fileName.value;
					} else {
						for (var i = 0; i < h_goods_fileName.length; i++) {
							goods_fileName += h_goods_fileName[i].value + "<br>";

						}
					}


					total_order_goods_price = h_final_total_Price.value;
					total_order_goods_qty = h_total_order_goods_qty.value;

					for (var i = 0; i < r_delivery_method.length; i++) {
						if (r_delivery_method[i].checked == true) {
							delivery_method = r_delivery_method[i].value
							break;
						}
					}

					var r_gift_wrapping = frm.gift_wrapping;


					for (var i = 0; i < r_gift_wrapping.length; i++) {
						if (r_gift_wrapping[i].checked == true) {
							gift_wrapping = r_gift_wrapping[i].value
							break;
						}
					}

					var r_pay_method = frm.pay_method;

					for (var i = 0; i < r_pay_method.length; i++) {
						if (r_pay_method[i].checked == true) {
							pay_method = r_pay_method[i].value
							if (pay_method == "신용카드") {
								var i_card_com_name = document.getElementById("card_com_name");
								var i_card_pay_month = document.getElementById("card_pay_month");
								card_com_name = i_card_com_name.value;
								card_pay_month = i_card_pay_month.value;
								pay_method += "<Br>" +
									"카드사:" + card_com_name + "<br>" +
									"할부개월수:" + card_pay_month;
								pay_orderer_hp_num = "해당없음";

							} else if (pay_method == "휴대폰결제") {
								var i_pay_order_tel1 = document.getElementById("pay_order_tel1");
								var i_pay_order_tel2 = document.getElementById("pay_order_tel2");
								var i_pay_order_tel3 = document.getElementById("pay_order_tel3");
								pay_orderer_hp_num = i_pay_order_tel1.value + "-" +
									i_pay_order_tel2.value + "-" +
									i_pay_order_tel3.value;
								pay_method += "<Br>" + "결제휴대폰번호:" + pay_orderer_hp_num;
								card_com_name = "해당없음";
								card_pay_month = "해당없음";
							} //end if
							break;
						}// end for
					}

					var i_hp1 = document.getElementById("hp1");
					var i_hp2 = document.getElementById("hp2");
					var i_hp3 = document.getElementById("hp3");

					var i_tel1 = document.getElementById("tel1");
					var i_tel2 = document.getElementById("tel2");
					var i_tel3 = document.getElementById("tel3");

					var i_zipcode = document.getElementById("zipcode");
					var i_roadAddress = document.getElementById("roadAddress");
					var i_jibunAddress = document.getElementById("jibunAddress");
					var i_namujiAddress = document.getElementById("namujiAddress");
					var i_delivery_message = document.getElementById("delivery_message");
					var i_pay_method = document.getElementById("pay_method");

					//   alert("총주문 금액:"+total_order_goods_price);
					order_goods_qty = h_order_goods_qty.value;
					//order_total_price=h_order_total_price.value;

					orderer_name = h_orderer_name.value;
					receiver_name = i_receiver_name.value;
					hp1 = i_hp1.value;
					hp2 = i_hp2.value;
					hp3 = i_hp3.value;

					tel1 = i_tel1.value;
					tel2 = i_tel2.value;
					tel3 = i_tel3.value;

					receiver_hp_num = hp1 + "-" + hp2 + "-" + hp3;
					receiver_tel_num = tel1 + "-" + tel2 + "-" + tel3;

					delivery_address = "우편번호:" + i_zipcode.value + "<br>" +
						"도로명 주소:" + i_roadAddress.value + "<br>" +
						"[지번 주소:" + i_jibunAddress.value + "]<br>" +
						i_namujiAddress.value;

					delivery_message = i_delivery_message.value;

					var p_order_goods_id = document.getElementById("p_order_goods_id");
					var p_order_goods_title = document.getElementById("p_order_goods_title");
					var p_order_goods_qty = document.getElementById("p_order_goods_qty");
					var p_total_order_goods_qty = document.getElementById("p_total_order_goods_qty");
					var p_total_order_goods_price = document.getElementById("p_total_order_goods_price");
					var p_orderer_name = document.getElementById("p_orderer_name");
					var p_receiver_name = document.getElementById("p_receiver_name");
					var p_delivery_method = document.getElementById("p_delivery_method");
					var p_receiver_hp_num = document.getElementById("p_receiver_hp_num");
					var p_receiver_tel_num = document.getElementById("p_receiver_tel_num");
					var p_delivery_address = document.getElementById("p_delivery_address");
					var p_delivery_message = document.getElementById("p_delivery_message");
					var p_gift_wrapping = document.getElementById("p_gift_wrapping");
					var p_pay_method = document.getElementById("p_pay_method");

					p_order_goods_id.innerHTML = goods_id;
					p_order_goods_title.innerHTML = goods_title;
					p_total_order_goods_qty.innerHTML = total_order_goods_qty + "개";
					p_total_order_goods_price.innerHTML = total_order_goods_price + "원";
					p_orderer_name.innerHTML = orderer_name;
					p_receiver_name.innerHTML = receiver_name;
					p_delivery_method.innerHTML = delivery_method;
					p_receiver_hp_num.innerHTML = receiver_hp_num;
					p_receiver_tel_num.innerHTML = receiver_tel_num;
					p_delivery_address.innerHTML = delivery_address;
					p_delivery_message.innerHTML = delivery_message;
					p_gift_wrapping.innerHTML = gift_wrapping;
					p_pay_method.innerHTML = pay_method;
					imagePopup('open');
				}

				function fn_process_pay_order() {

					alert("최종 결제하기");
					var formObj = document.createElement("form");
					var i_receiver_name = document.createElement("input");

					var i_receiver_hp1 = document.createElement("input");
					var i_receiver_hp2 = document.createElement("input");
					var i_receiver_hp3 = document.createElement("input");

					var i_receiver_tel1 = document.createElement("input");
					var i_receiver_tel2 = document.createElement("input");
					var i_receiver_tel3 = document.createElement("input");

					var i_delivery_address = document.createElement("input");
					var i_delivery_message = document.createElement("input");
					var i_delivery_method = document.createElement("input");
					var i_gift_wrapping = document.createElement("input");
					var i_pay_method = document.createElement("input");
					var i_card_com_name = document.createElement("input");
					var i_card_pay_month = document.createElement("input");
					var i_pay_orderer_hp_num = document.createElement("input");

					i_receiver_name.name = "receiver_name";
					i_receiver_hp1.name = "receiver_hp1";
					i_receiver_hp2.name = "receiver_hp2";
					i_receiver_hp3.name = "receiver_hp3";

					i_receiver_tel1.name = "receiver_tel1";
					i_receiver_tel2.name = "receiver_tel2";
					i_receiver_tel3.name = "receiver_tel3";

					i_delivery_address.name = "delivery_address";
					i_delivery_message.name = "delivery_message";
					i_delivery_method.name = "delivery_method";
					i_gift_wrapping.name = "gift_wrapping";
					i_pay_method.name = "pay_method";
					i_card_com_name.name = "card_com_name";
					i_card_pay_month.name = "card_pay_month";
					i_pay_orderer_hp_num.name = "pay_orderer_hp_num";

					i_receiver_name.value = receiver_name;
					i_receiver_hp1.value = hp1;
					i_receiver_hp2.value = hp2;
					i_receiver_hp3.value = hp3;

					i_receiver_tel1.value = tel1;
					i_receiver_tel2.value = tel2;
					i_receiver_tel3.value = tel3;
					;
					i_delivery_address.value = delivery_address;
					i_delivery_message.value = delivery_message;
					i_delivery_method.value = delivery_method;
					i_gift_wrapping.value = gift_wrapping;
					i_pay_method.value = pay_method;
					i_card_com_name.value = card_com_name;
					i_card_pay_month.value = card_pay_month;
					i_pay_orderer_hp_num.value = pay_orderer_hp_num;

					formObj.appendChild(i_receiver_name);
					formObj.appendChild(i_receiver_hp1);
					formObj.appendChild(i_receiver_hp2);
					formObj.appendChild(i_receiver_hp3);
					formObj.appendChild(i_receiver_tel1);
					formObj.appendChild(i_receiver_tel2);
					formObj.appendChild(i_receiver_tel3);

					formObj.appendChild(i_delivery_address);
					formObj.appendChild(i_delivery_message);
					formObj.appendChild(i_delivery_method);
					formObj.appendChild(i_gift_wrapping);

					formObj.appendChild(i_pay_method);
					formObj.appendChild(i_card_com_name);
					formObj.appendChild(i_card_pay_month);
					formObj.appendChild(i_pay_orderer_hp_num);


					document.body.appendChild(formObj);
					formObj.method = "post";
					formObj.action = "${contextPath}/order/payToOrderGoods.do";
					formObj.submit();
					imagePopup('close');
				}


				// 주소 찾는 코드
				function findAddr() {
					new daum.Postcode({
						oncomplete: function (data) {

							console.log(data);

							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var jibunAddr = data.jibunAddress; // 지번 주소 변수
							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('h_zipcode').value = data.zonecode;
							if (roadAddr !== '') {
								document.getElementById("h_roadAddress").value = roadAddr;
							}
							else if (jibunAddr !== '') {
								document.getElementById("namujiAddress").value = jibunAddr;
							}
						}
					}).open();
				}


				// 선택된 결제 방법에 따라 옵션이 다르게 보이게 하는 방법
				function checkedPaymentMethod() {
					var creditCardRadio = document.getElementById('credit_card');
					var mobilePaymentRadio = document.getElementById('mobile_payment');
					var squareBox1 = document.getElementById('tr_pay_card');
					var squareBox2 = document.getElementById('tr_pay_phone');

					if (creditCardRadio.checked) {
						squareBox1.style.display = 'block';
						squareBox2.style.display = 'none';
					} else if (mobilePaymentRadio.checked) {
						squareBox1.style.display = 'none';
						squareBox2.style.display = 'block';
					} else {
						squareBox1.style.display = 'none';
						squareBox2.style.display = 'none';
					}
				}


			</script>

		</head>

		<body>
			<div class="container">
				<div class="input-form-backgroud row">
					<div class="input-form col-md-12 mx-auto">
						<h1 class="mb-3">주문 / 결제</h1>






						<br>


						<form name="form_order">


							<p>
								<strong>주문자 정보</strong>
							</p>


							<div>
								<div class="row">
									<div>
										<label class="lableBox">이름 &nbsp;&nbsp;&nbsp;</label> <input type="text"
											class="inputBox" placeholder=" 이름을 입력해주세요."
											value="&nbsp; ${orderer.member_name}" readonly="readonly">
									</div>


									<div>
										<label class="lableBox">휴대폰</label> <input type="text" class="inputBox"
											placeholder=" 휴대폰 번호를 입력해주세요."
											value="&nbsp; ${orderer.hp1}-${orderer.hp2}-${orderer.hp3}"
											readonly="readonly">
									</div>


									<div>
										<label class="lableBox">이메일</label> <input type="text" class="inputBox"
											placeholder=" 이메일을 입력해주세요."
											value="&nbsp; ${orderer.email1}@${orderer.email2}" readonly="readonly">
									</div>
								</div>
							</div>



							<br>


							<hr class="mb-4">




							<p>
								<strong>배송지 정보</strong>
							</p>


							<div>
								<div class="row">
									<div>
										<label class="lableBox">배송 방법</label> &nbsp;&nbsp;
										<span>
											<input type="radio" name="delivery_method" value="일반택배" checked> 일반택배
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" name="delivery_method" value="해외배송"> 해외배송
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" name="delivery_method" value="편의점택배"> 편의점택배
										</span>
									</div>

									<div>
										<label class="lableBox">배송지 선택</label> <input type="radio"
											onClick="restore_all()" name="delivery_place" value="기본배송지" checked> 기본 배송지
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" onClick="restore_all()"
											name="delivery_place" value="새로입력"> 새로입력 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" onClick="restore_all()" name="delivery_place" value="최근배송지">
										최근 배송지
									</div>

									<div>
										<label class="lableBox">받는 분</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
											type="text" class="inputBox" id="receiver_name" name="receiver_name"
											placeholder=" 이름을 입력해주세요." value="&nbsp; ${orderer.member_name }"> <input
											type="hidden" class="inputBox" id="h_orderer_name" name="h_orderer_name"
											placeholder=" 이름을 입력해주세요." value="&nbsp; ${orderer.member_name }"> <input
											type="hidden" class="inputBox" id="h_receiver_name" name="h_receiver_name"
											placeholder=" 이름을 입력해주세요." value="&nbsp; ${orderer.member_name }">
									</div>

									<div>
										<label class="lableBox">휴대폰 번호</label> <select id="hp1" name="hp1"
											class="inputBox_select">
											<option value="010" selected>&nbsp; 010</option>
											<option value="011">&nbsp; 011</option>
											<option value="016">&nbsp; 016</option>
											<option value="017">&nbsp; 017</option>
											<option value="018">&nbsp; 018</option>
											<option value="019">&nbsp; 019</option>
										</select> <input type="text" class="inputBox_select" id="hp2" name="hp2"
											value="&nbsp; ${orderer.hp2 }" required> <input type="text"
											class="inputBox_select" id="hp3" name="hp3" value="&nbsp; ${orderer.hp3 }"
											required> <input type="hidden" class="inputBox_select" id="h_hp2"
											name="h_hp2" value="&nbsp; ${orderer.hp2 }" /> <input type="hidden"
											class="inputBox_select" id="h_hp3" name="h_hp3"
											value="&nbsp; ${orderer.hp3 }" />
										<c:set var="orderer_hp"
											value="&nbsp; ${orderer.hp1}-${orderer.hp2}-${orderer.hp3 }" />

									</div>

									<div>
										<p>
											<label class="lableBox">주소</label>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="text" class="inputBox_select" id="h_zipcode" name="h_zipcode"
												value="&nbsp; ${orderer.zipcode }" placeholder="우편번호" />
											<button onclick="findAddr()" class="button"> 우편번호검색 </button>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
											<input type="text" class="inputBox_address" id="h_roadAddress"
												name="h_roadAddress" value="&nbsp; ${orderer.roadAddress }"
												placeholder="도로명 주소" /><br>
											<input type="text" class="inputBox_address" id="namujiAddress"
												name="namujiAddress" value="&nbsp; ${orderer.namujiAddress }"
												placeholder="상세 주소" />
										</p>
										<input type="hidden" class="inputBox_address" id="h_zipcode" name="h_zipcode"
											value="${orderer.zipcode }" />
										<input type="hidden" class="inputBox_address" id="h_roadAddress"
											name="h_roadAddress" value="${orderer.roadAddress }" />
										<input type="hidden" class="inputBox_address" id="h_namujiAddress"
											name="h_namujiAddress" value="${orderer.namujiAddress }" />

									</div>

									<div>
										<label class="lableBox">배송 메시지</label>
										<input type="text" id="delivery_message" name="delivery_message"
											class="inputBox" placeholder="&nbsp; 택배 기사님께 전달할 메시지를 남겨주세요.">
									</div>

									<div>
										<label class="lableBox">선물 포장</label>

										<input type="radio" id="gift_wrapping_yes" name="gift_wrapping" value="yes"
											checked> 예
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

										<input type="radio" id="gift_wrapping_no" name="gift_wrapping" value="no"> 아니요
									</div>
								</div>
							</div>




							<br>



							<hr class="mb-4">





							<p>
								<strong>주문 상품</strong>
							</p>


							<table class="list_view">
								<tbody align=center>
									<c:forEach var="item" items="${myOrderList }">
										<tr>
											<td class="goods_image">
												<a
													href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
													<img style="margin-left: 20px; margin-right: 20px; margin-bottom: 10px"
														width="75" alt=""
														src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
													<input type="hidden" id="h_goods_id" name="h_goods_id"
														value="${item.goods_id }" />
													<input type="hidden" id="h_goods_fileName" name="h_goods_fileName"
														value="${item.goods_fileName }" />
												</a>
											</td>



											<td style="text-align: left">
												<strong style="color: black">주문상품명 : </strong>
												<a
													href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title
													}</a>
												<input type="hidden" id="h_goods_title" name="h_goods_title"
													value="${item.goods_title }" />

												<br>
												<br>



												<strong style="color: black">수량 : </strong>
												${item.order_goods_qty}개
												<input type="hidden" id="h_order_goods_qty" name="h_order_goods_qty"
													value="${item.order_goods_qty}" />

												<br>

												<strong style="color: black">주문금액 : </strong>
												${item.goods_sales_price}원 (10% 할인)

												<br>


												<strong style="color: black">예상적립금 : </strong>
												${1500 *item.order_goods_qty}원


												<br>

												<!--                <hr class="book_line"> -->
												<hr class="order_line">
											</td>
										</tr>




										<c:set var="final_total_order_price"
											value="${final_total_order_price + item.goods_sales_price * item.order_goods_qty}" />
										<c:set var="total_order_price"
											value="${total_order_price + item.goods_sales_price * item.order_goods_qty}" />
										<c:set var="total_order_goods_qty"
											value="${total_order_goods_qty + item.order_goods_qty}" />
									</c:forEach>

								</tbody>

							</table>



							<br>


							<hr class="mb-4">





							<p>
								<strong>할인 정보</strong>
							</p>


							<div>
								<div class="row">
									<div>
										<label class="lableBox">적립금
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input
											type="text" name="discount_juklip" class="inputBox_discount"
											placeholder="0&nbsp;&nbsp;">
										<label class="lableBox">원 / 1000원</label>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

									</div>

									<div>
										<label class="lableBox">예치금
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input
											type="text" name="discount_yechi" class="inputBox_discount"
											placeholder="0&nbsp;&nbsp;">
										<label class="lableBox">원 / 1000원</label>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</div>

									<div>
										<label class="lableBox">기프트카드 &nbsp;&nbsp;&nbsp;</label> <input type="text"
											name="discount_sangpum" class="inputBox_discount"
											placeholder="0&nbsp;&nbsp;">
										<label class="lableBox">원 / 1000원</label>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
								</div>

								<br>

								<div class="square-box">
									총 상품 금액 ${total_order_price} 원
									<input id="h_totalPrice" type="hidden"
										value="${total_order_price}" />&nbsp;&nbsp;&nbsp;&nbsp;

									<c:if test="${total_order_price > 50000}">
										<c:set var="total_delivery_price" value="0" />
									</c:if>

									+ &nbsp;&nbsp;&nbsp;&nbsp; 총 배송비 ${total_delivery_price} 원
									<input id="h_totalDelivery" type="hidden"
										value="${total_delivery_price}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

									<c:set var="final_total_order_price"
										value="${final_total_order_price + total_delivery_price}" />

									= &nbsp;&nbsp;&nbsp;&nbsp; ${final_total_order_price} 원
									<input id="h_total_sales_price" type="hidden" value="${final_total_order_price}" />
								</div>
							</div>


							<br>





							<hr class="mb-4">




							<p>
								<strong>결제 정보</strong>
							</p>


							<div>
								<div class="row">
									<div>


										<table class="table_margin">
											<colgroup>
												<col class="col_width">
												<col class="col_width">
												<col class="col_width">
												<col class="col_width">
											</colgroup>
											<tbody>
												<tr class="tr_height">
													<td><input type="radio" onclick="checkedPaymentMethod()"
															id="credit_card" name="pay_method" value="신용카드"
															checked="checked"> 신용카드</td>
													<td><input type="radio" onclick="checkedPaymentMethod()"
															id="bank_transfer" name="pay_method" value="계좌이체"> 계좌이체</td>
													<td><input type="radio" onclick="checkedPaymentMethod()" id="payco"
															name="pay_method" value="PAYCO"> PAYCO</td>
													<td><input type="radio" onclick="checkedPaymentMethod()"
															id="toss_pay" name="pay_method" value="tossPay"> toss pay
													</td>

												</tr>

												<tr class="tr_height">
													<td><input type="radio" onclick="checkedPaymentMethod()"
															id="kakao_pay" name="pay_method" value="카카오페이"> 카카오페이</td>
													<td><input type="radio" onclick="checkedPaymentMethod()"
															id="naver_pay" name="pay_method" value="네이버페이"> 네이버페이</td>
													<td><input type="radio" onclick="checkedPaymentMethod()"
															id="bank_deposit" name="pay_method" value="무통장입금"> 무통장입금
													</td>
													<td><input type="radio" onclick="checkedPaymentMethod()"
															id="mobile_payment" name="pay_method" value="휴대폰결제"> 휴대폰결제
													</td>
												</tr>
											</tbody>
										</table>





									</div>



									<div id="tr_pay_card">
										<div class="square_box2">카드 선택 : &nbsp;&nbsp; <select
												class="inputBox_select_card" id="card_com_name" name="card_com_name"
												style="margin-right: 70px">
												<option value="&nbsp; 삼성" selected>삼성</option>
												<option value="&nbsp; 하나SK">하나SK</option>
												<option value="&nbsp; 현대">현대</option>
												<option value="&nbsp; KB">KB</option>
												<option value="&nbsp; 신한">신한</option>
												<option value="&nbsp; 롯데">롯데</option>
												<option value="&nbsp; BC">BC</option>
												<option value="&nbsp; 시티">시티</option>
												<option value="&nbsp; NH농협">NH농협</option>
											</select>

											할부 기간 : &nbsp;&nbsp; <select class="inputBox_select_card"
												id="card_pay_month" name="card_pay_month">
												<option value="&nbsp; 일시불" selected>일시불</option>
												<option value="&nbsp; 2개월">2개월</option>
												<option value="&nbsp; 3개월">3개월</option>
												<option value="&nbsp; 4개월">4개월</option>
												<option value="&nbsp; 5개월">5개월</option>
												<option value="&nbsp; 6개월">6개월</option>
											</select>
										</div>

									</div>




									<div id="tr_pay_phone">
										<div class="square_box2">
											휴대폰 번호 &nbsp;&nbsp; <select class="inputBox_select_card" id="hp1"
												name="hp1">
												<option value="010" selected>&nbsp; 010</option>
												<option value="011">&nbsp; 011</option>
												<option value="016">&nbsp; 016</option>
												<option value="017">&nbsp; 017</option>
												<option value="018">&nbsp; 018</option>
												<option value="019">&nbsp; 019</option>
											</select>
											<input class="inputBox_select_card" type="text" class="inputBox_select"
												id="hp2" name="hp2" value="&nbsp; ${orderer.hp2 }" readonly="readonly">
											<input class="inputBox_select_card" type="text" class="inputBox_select"
												id="hp3" name="hp3" value="&nbsp; ${orderer.hp3 }" readonly="readonly">
											<c:set var="orderer_hp"
												value="&nbsp; ${orderer.hp1}-${orderer.hp2}-${orderer.hp3 }" />
										</div>
									</div>










								</div>
							</div>





							<hr class="mb-12">





							<br>
							<div class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" id="agreement" required> <label
									class="custom-control-label" for="agreement">위 주문내용을 확인하였으며, 결제에 동의합니다.</label>
							</div>
							<br>

							<button class="btn btn-warning btn-lg btn-block" type="submit">가입완료</button>
						</form>


					</div>
				</div>
				<footer class="my-3 text-center text-small"> </footer>
			</div>







			<center>
				<br>
				<br> <a href="javascript:fn_show_order_detail();">
					<img width="125" alt="" src="${contextPath}/resources/image/btn_gulje.jpg">
				</a> <a href="${contextPath}/main/main.do">
					<img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
				</a>

				<div class="clear"></div>
				<div id="layer" style="visibility:hidden">
					<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
					<div id="popup_order_detail">
						<!-- 팝업창 닫기 버튼 -->
						<a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');">
							<img src="${contextPath}/resources/image/close.png" id="close" />
						</a>
						<br />
						<div class="detail_table">
							<h1>최종 주문 사항</h1>
							<table>
								<tbody align=left>
									<tr>
										<td width=200px>
											주문상품번호:
										</td>
										<td>
											<p id="p_order_goods_id"> 주문번호 </p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											주문상품명:
										</td>
										<td>
											<p id="p_order_goods_title"> 주문 상품명 </p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											주문상품개수:
										</td>
										<td>
											<p id="p_total_order_goods_qty"> 주문 상품개수 </p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											주문금액합계:
										</td>
										<td>
											<p id="p_total_order_goods_price">주문금액합계</p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											주문자:
										</td>
										<td>
											<p id="p_orderer_name"> 주문자 이름</p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											받는사람:
										</td>
										<td>
											<p id="p_receiver_name">받는사람이름</p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											배송방법:
										</td>
										<td>
											<p id="p_delivery_method">배송방법</p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											받는사람 휴대폰번호:
										</td>
										<td>
											<p id="p_receiver_hp_num"></p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											받는사람 유선번화번호:
										</td>
										<td>
											<p id="p_receiver_tel_num">배송방법</p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											배송주소:
										</td>
										<td align=left>
											<p id="p_delivery_address">배송주소</p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											배송메시지:
										</td>
										<td align=left>
											<p id="p_delivery_message">배송메시지</p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											선물포장 여부:
										</td>
										<td align=left>
											<p id="p_gift_wrapping">선물포장</p>
										</td>
									</tr>
									<tr>
										<td width=200px>
											결제방법:
										</td>
										<td align=left>
											<p id="p_pay_method">결제방법</p>
										</td>
									</tr>
									<tr>
										<td colspan=2 align=center>
											<input name="btn_process_pay_order" type="button"
												onClick="fn_process_pay_order()" value="최종결제하기">
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="clear"></div>
						<br>





						<!--    <script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  </script> -->

		</body>

		</html>
		<!-- 출처: https://7942yongdae.tistory.com/86 [개발자 일지:티스토리] -->