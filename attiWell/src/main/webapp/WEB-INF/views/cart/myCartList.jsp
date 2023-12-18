<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  /> 

<c:set  var="totalGoodsNum" value="0" />  <!--주문 개수 -->
<c:set  var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 --> 
<c:set  var="totalDiscountedPrice" value="0" /> <!-- 총 할인금액 -->
<head>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script> 
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>  -->
<!-- 부트스트랩 4.3.1 적용   -->
 <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
          crossorigin="anonymous">
    <title>Your Page Title</title>


<style>
.input-form {

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
.table {
    width: calc(100% - 20px); /* 부모의 padding을 고려하여 계산 */
}
 		a {
            color: grey; /* 또는 원하는 색상으로 변경 */
        }
        .h2 {
            font-size: 24px; /* Increase the font size to your desired value */
            font-weight: bold; /* 굴게 만들기 */
        }
       

        .custom-btn {
            border-radius: 10px; /* radius 설정 */
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
        
        tr {
		   
		     white-space: nowrap;
		}
</style>



<script type="text/javascript">

function calcGoodsPrice(bookPrice,obj){
	var totalPrice,final_total_price,totalNum;
	var goods_qty=document.getElementById("select_goods_qty");
	//alert("총 상품금액"+goods_qty.value);
	var p_totalNum=document.getElementById("p_totalNum");
	var p_totalPrice=document.getElementById("p_totalPrice");
	var p_final_totalPrice=document.getElementById("p_final_totalPrice");
	var h_totalNum=document.getElementById("h_totalNum");
	var h_totalPrice=document.getElementById("h_totalPrice");
	var h_totalDelivery=document.getElementById("h_totalDelivery");
	var h_final_total_price=document.getElementById("h_final_totalPrice");
	if(obj.checked==true){
	//	alert("체크 했음")
		
		totalNum=Number(h_totalNum.value)+Number(goods_qty.value);
		//alert("totalNum:"+totalNum);
		totalPrice=Number(h_totalPrice.value)+Number(goods_qty.value*bookPrice);
		//alert("totalPrice:"+totalPrice);
		final_total_price=totalPrice+Number(h_totalDelivery.value);
		//alert("final_total_price:"+final_total_price);

	}else{
	//	alert("h_totalNum.value:"+h_totalNum.value);
		totalNum=Number(h_totalNum.value)-Number(goods_qty.value);
	//	alert("totalNum:"+ totalNum);
		totalPrice=Number(h_totalPrice.value)-Number(goods_qty.value)*bookPrice;
	//	alert("totalPrice="+totalPrice);
		final_total_price=totalPrice-Number(h_totalDelivery.value);
	//	alert("final_total_price:"+final_total_price);
	}
	
	h_totalNum.value=totalNum;
	
	h_totalPrice.value=totalPrice;
	h_final_total_price.value=final_total_price;
	
	p_totalNum.innerHTML=totalNum;
	p_totalPrice.innerHTML=totalPrice;
	p_final_totalPrice.innerHTML=final_total_price;
}





/* var totalQuantity = 0;

 window.onload = function() {
    updateTotalQuantity(goodsId, goodsSalesPrice); // 총 개수 업데이트 함수 호출
}; 
 */

/* function updateTotalQuantity(goodsId, goodsSalesPrice) {
	<c:forEach var="item" items="${myGoodsList}" varStatus="cnt">



	    var checkbox = document.getElementById("checkbox_${item.goods_id}");     
	    
	    // 체크박스가 있는 경우에만 이벤트 핸들러 등록
	    if (checkbox) {
	    	console.log(checkbox);
	        checkbox.onclick = function() {
	         	
	        	   var goodsId = '${item.goods_id}';
	               var goodsSalesPrice = ${item.goods_sales_price};
	               var cartGoodsQty = ${myCartList[cnt.count-1].cart_goods_qty};
	               var discountedPrice = ${item.goods_sales_price} * cartGoodsQty;
	        		console.log(discountedPrice);

			            // 여기에서 각 항목에 대한 정보를 활용하여 필요한 작업 수행
			            console.log('상품 ID:', goodsId);
			            console.log('판매 가격:', goodsSalesPrice);
			            console.log('장바구니 상품 수량:', cartGoodsQty);
			            console.log('할인 가격:', discountedPrice);
		
			            // 체크박스가 체크되어 있는지 여부를 확인합니다.
			            if (!checkbox.checked) {
			                // 체크가 해제되면 총 수량에서 cartGoodsQty를 뺍니다.
			                totalQuantity -= cartGoodsQty;
			            	console.log(totalQuantity);
			                if (p_totalGoodsNum && h_totalGoodsNum) {
			                    p_totalGoodsNum.innerHTML = new Intl.NumberFormat('ko-KR').format(totalQuantity) + '개';
			                    h_totalGoodsNum.value = totalQuantity;
			                }
			                  
			            }else if(checkbox.checked){
			            	
			            	  totalQuantity += cartGoodsQty;
			            	  console.log(totalQuantity);
			            	    if (p_totalGoodsNum && h_totalGoodsNum) {
			            	        p_totalGoodsNum.innerHTML = new Intl.NumberFormat('ko-KR').format(totalQuantity) + '개';
			            	        h_totalGoodsNum.value = totalQuantity;
			            	    }
			      			
			            }
		
			            // 총 수량 표시를 업데이트합니다.
			          
			            // 필요한 로직에 따라 updateTotalQuantity 함수를 호출합니다.
			         
			        };
	    }
	</c:forEach>
	  
	  
	} */

function modify_cart_qty(goods_id,bookPrice,index){
   //alert(index);
   var length=document.frm_order_all_cart.cart_goods_qty.length;
   var _cart_goods_qty=0;
   if(length>1){ //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
      _cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index].value;      
   }else{
      _cart_goods_qty=document.frm_order_all_cart.cart_goods_qty.value;
   }
      
   var cart_goods_qty=Number(_cart_goods_qty);
   
   $.ajax({
      type : "post",
      async : false, //false인 경우 동기식으로 처리한다.
      url : "${contextPath}/cart/modifyCartQty.do",
      data : {
         goods_id:goods_id,
         cart_goods_qty:cart_goods_qty
      },
      
      success : function(data, textStatus) {
         //alert(data);
         if(data.trim()=='modify_success'){
            alert("수량을 변경했습니다!!");   
            location.reload(); // 페이지 새로고침
         }else{
            alert("다시 시도해 주세요!!");   
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

function delete_cart_goods(cart_id){
   var cart_id=Number(cart_id);
   var formObj=document.createElement("form");
   var i_cart = document.createElement("input");
   i_cart.name="cart_id";
   i_cart.value=cart_id;
   
   formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartGoods.do";
    formObj.submit();
}

function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
   var total_price,final_total_price,_goods_qty;
   var cart_goods_qty=document.getElementById("cart_goods_qty");
   
   _order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
   var formObj=document.createElement("form");
   var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=_order_goods_qty;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
}

function fn_order_all_cart_goods(){
//   alert("모두 주문하기");
   var order_goods_qty;
   var order_goods_id;
   var objForm=document.frm_order_all_cart;
   var cart_goods_qty=objForm.cart_goods_qty;
   var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
   var checked_goods=objForm.checked_goods;
   
    var length=checked_goods.length; 
   
   
   //alert(length);
  if(length>1){
      for(var i=0; i<length;i++){
         if(checked_goods[i].checked==true){
            order_goods_id=checked_goods[i].value;
            order_goods_qty=cart_goods_qty[i].value;
            cart_goods_qty[i].value="";
            cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
           
         }
      }   
   }else{
      order_goods_id=checked_goods.value;
      order_goods_qty=cart_goods_qty.value;
      cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
      //alert(select_goods_qty.value);
   } 
      
    objForm.method="post";
    objForm.action="${contextPath}/order/orderAllCartGoods.do";
   objForm.submit();
}
</script>
</head>
<body>
<div class="input-form ">
 <h3 class="mb-4" style="font-size:30px; color:#660033">장바구니</h3>
   <table class="table">
      <tbody align=center >
         <tr style="background:#1b7340; color :white;"  >
            <td class="fixed" style="display: none;" >구분</td> 
            <td colspan=2 class="fixed">상품명</td>
            <td>정가</td>
            <td>판매가</td>
            <td>수량</td>
            <td>합계</td>
            <td>주문</td>
         </tr>
         
          <c:choose>
                <c:when test="${ empty myCartList }">
                <tr>
                   <td colspan=8 class="fixed">
                     <strong>장바구니에 상품이 없습니다.</strong>
                   </td>
                 </tr>
                </c:when>
                 <c:otherwise>
          <tr>       
               <form name="frm_order_all_cart">
                  <c:forEach var="item" items="${myGoodsList }" varStatus="cnt">
                   <c:set var="cart_goods_qty" value="${myCartList[cnt.count-1].cart_goods_qty}" />
                   <c:set var="cart_id" value="${myCartList[cnt.count-1].cart_id}" />
                   <!--체크박스 수정-->
				
				      
						<td style="display: none;"><input type="checkbox" name="checked_goods"  checked  value="${item.goods_id }"  onClick="calcGoodsPrice(${item.goods_sales_price },this)"></td>
					<%-- <input type="checkbox" id="checkbox_${item.goods_id}" checked onclick="updateTotalQuantity('${item.goods_id}', ${item.goods_sales_price})"> --%>
			
               <td class="goods_image">
               <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
                  <img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"  />
               </a>
               </td>
               <td>
                  <h2>
                     <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
                  </h2>
               </td>
               <td class="price"><span style="text-decoration: line-through;">${item.goods_price }원</span></td>
               <td>
                  <strong>
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
								<fmt:formatNumber value="${item.goods_sales_price*cart_goods_qty}" type="number"
									var="formattedInvidualTotal" />

								<span> <fmt:formatNumber value="${item.goods_price}"
										type="number" var="goods_price" /> <c:choose>
										<c:when test="${item.goods_price == item.goods_sales_price }">
											<span>${formattedDiscountedPrice }원</span>
										</c:when>
										<c:otherwise>

											<span>${formattedDiscountedPrice }원(${formattedRoundedDiscount}%할인)</span>
										</c:otherwise>
									</c:choose>
								</span>
                     </strong>
               </td>
               <td>
                  <input type="text" id="cart_goods_qty" name="cart_goods_qty" size=3 value="${cart_goods_qty}"><br>           
                  <a href="javascript:modify_cart_qty(${item.goods_id },${item.goods_sales_price*0.9 },${cnt.count-1 });" >
                      <img width=25 alt=""  src="${contextPath}/resources/image/btn_modify_qty.jpg">
                      
                     
                    
                  </a>
               </td>
               <td>
                  <strong>
                   <fmt:formatNumber  value="${item.goods_sales_price*0.9*cart_goods_qty}" type="number" var="total_sales_price" />
                     ${item.goods_sales_price*cart_goods_qty}원
               </strong>
                <input type="hidden" id="h_discounted_price" value="${item.goods_sales_price*cart_goods_qty}"> 
                </td>
               
               <td>
   <a href="javascript:fn_order_each_goods('${item.goods_id }','${item.goods_title }','${item.goods_sales_price}','${item.goods_fileName}');" style="margin-bottom: 10px;">
    <button type="button" style="background-color: #1b7340; border:#1b7340; margin-bottom: 10px;" class="btn btn-primary btn-sm">주문하기</button>
</a>
<br>
<a href="javascript:delete_cart_goods('${cart_id}');" style="margin-top: 10px;"> 
    <button type="button" class="btn btn-secondary btn-sm">삭제</button>
</a>
               </td>
         </tr>
            <c:set  var="totalGoodsPrice" value="${totalGoodsPrice+item.goods_sales_price*cart_goods_qty}" />
            <c:set  var="totalGoodsNum" value="${totalGoodsNum }" />
            
            </c:forEach>
          
          
      </tbody>
   </table>
        
   <div class="clear"></div>
    </c:otherwise>
   </c:choose> 
   <br>
   <br>
   
   
   <!-- 아래 테이블 --------------------------------------------------------------------------------------------  -->
   
   <table  width=70%   class="list_view" style="background:#fff">
   <tbody>
        <tr  align=center  class="fixed" >
          <td class="fixed">총 상품수 </td>
          <td>총 상품금액</td>
          <td>  </td>
          <td>총 배송비</td>
          <td>  </td>
         <!--  <td>총 할인 금액 </td>
          <td>  </td> -->
          <td>최종 결제금액</td>
        </tr>
      <tr cellpadding=40  align=center >
         <td id="">
           <p id="p_totalGoodsNum">${totalGoodsNum}개 </p>
           <input id="h_totalGoodsNum"type="hidden" value="${totalGoodsNum}"  />
         </td>
          <td>
             <p id="p_totalGoodsPrice">
             <fmt:formatNumber  value="${totalGoodsPrice}" type="number" var="total_goods_price" />
                     ${total_goods_price}원
             </p>
             <input id="h_totalGoodsPrice"type="hidden" value="${totalGoodsPrice}" />
          </td>
          <td> 
             <img width="25" alt="" src="${contextPath}/resources/image/plus.jpg">  
          </td>
          <td>
            <p id="p_totalDeliveryPrice">${totalDeliveryPrice}원  </p>
            <input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
          </td>
        <%--   <td> 
            <img width="25" alt="" src="${contextPath}/resources/image/minus.jpg"> 
          </td> 
          <td>  
            <p id="p_totalSalesPrice"> 
                     ${totalDiscountedPrice}원
            </p>
            <input id="h_totalSalesPrice"type="hidden" value="${totalSalesPrice}" />
          </td>--%>
          <td>  
            <img width="25" alt="" src="${contextPath}/resources/image/equal.jpg">
          </td>
          <td>
             <p id="p_final_totalPrice">
             <fmt:formatNumber  value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}" type="number" var="total_price" />
               ${total_price}원
             </p>
             <input id="h_final_totalPrice" type="hidden" value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}" />
          </td>
      </tr>
      </tbody>
   </table>
      <!-- Add your additional content here -->
   <center>
  <br><br>
<button type="button" class="btn btn-primary" style="background-color: #1b7340; border:#1b7340" onclick="fn_order_all_cart_goods()">
    <%-- <img width="75" alt="" src="${contextPath}/resources/image/btn_order_final.jpg"> --%>
    주문하기
</button>
<a href="${contextPath}/main/main.do"  class="btn btn-secondary">
    <%-- <img width="75" alt="" src="${contextPath}/resources/image/btn_shopping_continue.jpg"> --%>
    쇼핑계속하기
</a>
   </center>
</form>   
</div>
</body>
</html>
<script>

var totalQuantity = 0;

 window.onload = function() {
    <c:forEach var="item" items="${myGoodsList}" varStatus="cnt">
        var cartGoodsQty2 = ${myCartList[cnt.count-1].cart_goods_qty};
       
        totalQuantity += cartGoodsQty2;
    </c:forEach>

    var p_totalGoodsNum = document.getElementById("p_totalGoodsNum");
    var h_totalGoodsNum = document.getElementById("h_totalGoodsNum");

    if (p_totalGoodsNum && h_totalGoodsNum) {
        p_totalGoodsNum.innerHTML = new Intl.NumberFormat('ko-KR').format(totalQuantity) + '개';
        h_totalGoodsNum.value = totalQuantity;
    }
    
  
    
};



/* <c:forEach var="item" items="${myGoodsList}" varStatus="cnt">
var checkbox = document.getElementById("checkbox_${item.goods_id}");
if (checkbox) {
    checkbox.onclick = function() {
        updateTotalQuantity('${item.goods_id}', ${item.goods_sales_price}, checkbox, ${myCartList[cnt.count-1].cart_goods_qty});
    };
}
</c:forEach> */



//총 수량 초기화는 위에 window.function 에서 지정해놓았음





</script>