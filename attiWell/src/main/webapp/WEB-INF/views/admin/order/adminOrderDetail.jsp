<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="orderList"  value="${orderMap.orderList}"  />
<c:set var="deliveryInfo"  value="${orderMap.deliveryInfo}"  />
<c:set var="orderer"  value="${orderMap.orderer}"  />


<head>
 <!-- 부트스트랩 4.3.1 적용   -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        
        
  <style>
		  .fixed_join {
		    background-color: #eee;
		}
    	.custom-select {
		    width: 200px; /* 필요한 가로 길이로 조정하세요 */
		    text-align : center;
		}
    	.input-form {
		  /*  max-width: 1050px; */
		   margin-top: 80px;
		   padding: 32px;
		   background: #fff;
		   -webkit-border-radius: 10px;
		   -moz-border-radius: 10px;
		   border-radius: 10px;
		   -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		   -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		   box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
		}
        a {
            color: grey; /* 또는 원하는 색상으로 변경 */
        }

        .h2 {
            font-size: 24px; /* Increase the font size to your desired value */
            font-weight: bold; /* 굴게 만들기 */
        }

        
       
    </style>

 	  <style>
	.btn-primary:hover {
    background-color: #1b7340; /* 이 부분을 비워두거나 다른 색상으로 지정하세요 */
    color: #ffffff; /* 이 부분을 비워두거나 다른 색상으로 지정하세요 */
    border-color: #1b7340; /* 이 부분을 비워두거나 다른 색상으로 지정하세요 */
}
       .btn-primary {
    background-color: #1b7340;
    border: 2px solid #1b7340;
    color: #ffffff;
    padding: 10px 20px;
    text-decoration: none;
    display: inline-block;
    text-align: center;
	}
		
		.centered {
   		 text-align: center;
			}
		
        .btn-primary.custom-btn {
            color: #1b7340; /* 텍스트 색을 녹색으로 지정 */
            background-color: #fff; /* 배경 색을 흰색으로 지정 */
            border: 1px solid #1b7340 !important; /* 테두리 색을 #1b7340으로 지정 */
        }

       

        /* 테이블 글 씨 중앙정렬 */
        .center-align {
            text-align: center;
        }
        
        td {
		   
		     white-space: nowrap;
		}
		 tr h2 {
        font-size: 15px; /* 예시로 24px로 설정. 원하는 크기로 조절하세요. */
    }
    </style>

<script  type="text/javascript">
function fn_modify_order_state(order_id){
	var s_delivery_state=document.getElementById("s_delivery_state");
    var index = s_delivery_state.selectedIndex;   //선택한 옵션의 인덱스를 구합니다.
    var value = s_delivery_state[index].value;    //선택한 옵션의 값을 구합니다.
	console.log("value: " +value);
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/admin/order/modifyDeliveryState.do",
		data : {
			order_id:order_id,
			'delivery_state':value
		},
		success : function(data, textStatus) {
			if(data.trim()=='mod_success'){
				alert("주문 정보를 수정했습니다.");
				location.href="${contextPath}/admin/order/orderDetail.do?order_id="+order_id;
			}else if(data.trim()=='failed'){
				alert("다시 시도해 주세요.");	
			}
			
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax		
}

</script>
</head>
<body>
<div class="input-form ">
	<!--  <H1>1. 주문 상세정보</H1> <br>
	-->
 	<p class="h2">1. 주문 상세정보</p><hr><br>

	<table  class="table">
		<tbody align=center>
			<tr style="background:#eee">
			     <td>주문번호 </td>
				<td colspan=2 class="fixed">주문상품명</td>
				<td>수량</td>
				<td>주문금액</td>
				<td>배송비</td>
				<td>예상적립금</td>
				<td>주문금액합계</td>
			</tr>
			<tr>
				<c:forEach var="item" items="${orderList }">
				    <td> ${item.order_id }</td>
					<td class="goods_image">
					  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
					    <img width="75" alt=""  src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
					  </a>
					</td>
					<td>
					  <h2>
					     <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
					  </h2>
					</td>
					<td>
					  <h2>${item.order_goods_qty }개<h2>
					</td>
					<td><h2>${item.order_goods_qty *item.goods_sales_price}원 (10% 할인)</h2></td>
					<td><h2>0원</h2></td>
					<td><h2>${1500 *item.order_goods_qty }원</h2></td>
					<td>
					  <h2>${item.order_goods_qty *item.goods_sales_price}원</h2>
					</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="clear"></div>
<form name="frm_delivery_list" >	
	<br>
	<br>
	
	<div >
	  <br><br>
	  	<p class="h2">2. 주문고객</p>
		<hr>
		<br>
		
		<table class="table">
    <tbody>
        <tr  style="background:#eee">
            <td><h2>이름</h2></td>
             <td><h2>핸드폰</h2></td>
             <td><h2>이메일</h2></td>
            
         </tr>
          
          <tr>
        <td><h2>${orderer.member_name}</h2></td>
        <td><h2>${orderer.hp1}-${orderer.hp2}-${orderer.hp3}</h2></td>
        <td><h2>${orderer.email1}@${orderer.email2}</h2></td>
        </tr>
       
    </tbody>
</table>
	</div>
		<br>
	<br>
	<br>
	<p class="h2">3.배송지 정보</p><hr>
	<!-- <h1>2.배송지 정보</h1> -->
	<div>
	<!-- <div class="detail_table"> -->
		<table class="table table-bordered">
    <tbody>
        <tr class="dot_line">
            <td class="fixed_join">배송방법</td>
            <td>${deliveryInfo.delivery_method}</td>
        </tr>
        <tr class="dot_line">
            <td class="fixed_join">받으실 분</td>
            <td>${deliveryInfo.receiver_name}</td>
        </tr>
        <tr class="dot_line">
            <td class="fixed_join">휴대폰번호</td>
            <td>${deliveryInfo.receiver_hp1}-${deliveryInfo.receiver_hp2}-${deliveryInfo.receiver_hp3}</td>
        </tr>
        <tr class="dot_line">
            <td class="fixed_join">유선전화(선택)</td>
            <td>${deliveryInfo.receiver_tel1}-${deliveryInfo.receiver_tel2}-${deliveryInfo.receiver_tel3}</td>
        </tr>
        <tr class="dot_line">
            <td class="fixed_join">주소</td>
            <td>${deliveryInfo.delivery_address}</td>
        </tr>
        <tr class="dot_line">
            <td class="fixed_join">배송 메시지</td>
            <td>${deliveryInfo.delivery_message}</td>
        </tr>
        <tr class="dot_line">
            <td class="fixed_join">선물 포장</td>
            <td>${deliveryInfo.gift_wrapping}</td>
        </tr>
    </tbody>
</table>
		
	</div>
	
	<div class="clear"></div>
	<br>
	<br>
	<br>
	
	<p class="h2">4.결제정보</p><hr>
	<!-- <h1>3.결제정보</h1> -->
	<div>
		<table class="table">
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">결제방법</td>
					<td>
					   ${deliveryInfo.pay_method }
				    </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">결제카드</td>
					<td>
					   ${deliveryInfo.card_com_name}
				    </TD>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">할부기간</td>
					<td>
					   ${deliveryInfo.card_pay_month }
				    </td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="clear"></div>
	 <br>
	<br>
	<br> 
	<%-- <h1>3.배송상태</h1>
	<div class="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td>
				<select name="s_delivery_state"  id="s_delivery_state">
				 <c:choose>
				   <c:when test="${deliveryInfo.delivery_state=='delivery_prepared' }">
				     <option  value="delivery_prepared" selected>배송준비중</option>
				     <option  value="delivering">배송중</option>
				     <option  value="finished_delivering">배송완료</option>
				     <option  value="cancel_order">주문취소</option>
				     <option  value="returning_goods">반품</option>
				   </c:when>
				    <c:when test="${deliveryInfo.delivery_state=='delivering' }">
				    <option  value="delivery_prepared" >배송준비중</option>
				     <option  value="delivering" selected >배송중</option>
				     <option  value="finished_delivering">배송완료</option>
				     <option  value="cancel_order">주문취소</option>
				     <option  value="returning_goods">반품</option>
				   </c:when>
				   <c:when test="${deliveryInfo.delivery_state=='finished_delivering' }">
				    <option  value="delivery_prepared" >배송준비중</option>
				     <option  value="delivering"  >배송중</option>
				     <option  value="finished_delivering" selected>배송완료</option>
				     <option  value="cancel_order">주문취소</option>
				     <option  value="returning_goods">반품</option>
				   </c:when>
				   <c:when test="${deliveryInfo.delivery_state=='cancel_order' }">
				    <option  value="delivery_prepared" >배송준비중</option>
				     <option  value="delivering"  >배송중</option>
				     <option  value="finished_delivering" >배송완료</option>
				     <option  value="cancel_order" selected>주문취소</option>
				     <option  value="returning_goods">반품</option>
				   </c:when>
				   <c:when test="${deliveryInfo.delivery_state=='returning_goods' }">
				    <option  value="delivery_prepared" >배송준비중</option>
				     <option  value="delivering"  >배송중</option>
				     <option  value="finished_delivering" >배송완료</option>
				     <option  value="cancel_order" >주문취소</option>
				     <option  value="returning_goods" selected>반품</option>
				   </c:when>
				   </c:choose>
				 </select> 
				  <input  type="hidden" name="h_delivery_state" value="${deliveryInfo.delivery_state }" />
				</td>
				<td width=10%>
			     <input  type="button" value="배송수정"  onClick="fn_modify_order_state('${deliveryInfo.order_id}')"/>
			    </td>
				</tr> --%>
									<div class="centered">
				    <a href="${contextPath}/main/main.do" class="btn btn-primary">
				        쇼핑계속하기
				    </a>
</div>
			</tbody>
		</table>
	</div>
</form>
  
		<%-- <a href="${contextPath}/main/main.do"> 
		   <IMG width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
		</a> --%>
			

<div class="clear"></div>		
	
			
</div>
<br>
<br>

			