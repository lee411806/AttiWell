<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<html>
<head>
<meta  charset="utf-8">

<!-- 부트스트랩 4.3.1 적용   -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <!-- style 파트 -->    
        
    <style>
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

        #search {
            text-align: center;
            margin-top: 20px;
        }

        #search input[type="submit"] {
            background: #1b7340;
            border: none;
            color: white;
            width: 150px;
            height: 40px;
            font-size: 16px;
            /* 추가로 필요한 스타일을 여기에 추가할 수 있습니다. */
        }
        
       
    </style>

 	  <style>

        .custom-btn {
            border-radius: 10px; /* radius 설정 */
        }
		
		
        .btn-primary.custom-btn {
            color: #1b7340; /* 텍스트 색을 녹색으로 지정 */
            background-color: #fff; /* 배경 색을 흰색으로 지정 */
            border: 1px solid #1b7340 !important; /* 테두리 색을 #1b7340으로 지정 */
        }

        .btn-primary.custom-btn:focus,
        .btn-primary.custom-btn:hover {
            color: #fff; /* 텍스트 색을 녹색으로 지정 */
            background-color: #1b7340; /* 초록색 배경색 설정 */
            border: none; /* 테두리 없애기 */
            border: 1px solid #1b7340 !important; /* 호버 또는 포커스 시 테두리 색을 #1b7340으로 지정 */
        }

        /* 테이블 글 씨 중앙정렬 */
        .center-align {
            text-align: center;
        }
        
        td {
		   
		     white-space: nowrap;
		}
    </style>
<c:choose>
<c:when test='${not empty order_goods_list}'>
<script  type="text/javascript">
window.onload=function()
{
	init();
}

//배송상태 색 바꾸기 함수
<script>
function getBackgroundColor(deliveryState) {
    switch (deliveryState) {
        case 'delivery_prepared':
            return 'lightgreen';
        case 'delivering':
            return 'lightgreen';
        case 'finished_delivering':
            return 'lightgray';    
        case 'cancel_order':
            return 'lightorange';
        case 'returning_goods':
            return 'lightorange';      
        default:
            return 'white';
        
        
    }
}


//화면이 표시되면서  각각의 주문건에 대한 배송 상태를 표시한다.
function init(){
	var frm_delivery_list=document.frm_delivery_list;
	var h_delivery_state=frm_delivery_list.h_delivery_state;
	var s_delivery_state=frm_delivery_list.s_delivery_state;
	
	
	if(h_delivery_state.length==undefined){
		s_delivery_state.value=h_delivery_state.value; //조회된 주문 정보가 1건인 경우
	}else{
		for(var i=0; s_delivery_state.length;i++){
			s_delivery_state[i].value=h_delivery_state[i].value;//조회된 주문 정보가 여러건인 경우
		}
	}
}
</script>


</script>
</c:when>
</c:choose>
<script>

function search_order_history(fixeSearchPeriod) {
    var formObj = document.createElement("form");
    var i_fixedSearch_period = document.createElement("input");
    i_fixedSearch_period.name = "fixedSearchPeriod";
    i_fixedSearch_period.value = fixeSearchPeriod;
    formObj.appendChild(i_fixedSearch_period);
    document.body.appendChild(formObj);
    formObj.method = "get";
    formObj.action = "${contextPath}/admin/order/adminOrderMain.do";
    formObj.submit();
}


/* function search_order_history(search_period){	
	temp=calcPeriod(search_period);
	var date=temp.split(",");
	beginDate=date[0];
	endDate=date[1];
	
    
	var formObj=document.createElement("form");
	var i_command = document.createElement("input");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
    
	i_beginDate.name="beginDate";
	i_beginDate.value=beginDate;
	i_endDate.name="endDate";
	i_endDate.value=endDate;
	
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/admin/order/adminOrderMain.do";
    formObj.submit();
} */


function  calcPeriod(search_period){
	var dt = new Date();
	var beginYear,endYear;
	var beginMonth,endMonth;
	var beginDay,endDay;
	var beginDate,endDate;
	
	endYear = dt.getFullYear();
	endMonth = dt.getMonth()+1;
	endDay = dt.getDate();
	if(search_period=='today'){
		beginYear=endYear;
		beginMonth=endMonth;
		beginDay=endDay;
	}else if(search_period=='one_week'){
		beginYear=dt.getFullYear();
		beginMonth=dt.getMonth()+1;
		dt.setDate(endDay-7);
		beginDay=dt.getDate();
		
	}else if(search_period=='two_week'){
		beginYear = dt.getFullYear();
		beginMonth = dt.getMonth()+1;
		dt.setDate(endDay-14);
		beginDay=dt.getDate();
	}else if(search_period=='one_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-1);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}else if(search_period=='two_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-2);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}else if(search_period=='three_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-3);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}else if(search_period=='four_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-4);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}
	
	if(beginMonth <10){
		beginMonth='0'+beginMonth;
		if(beginDay<10){
			beginDay='0'+beginDay;
		}
	}
	if(endMonth <10){
		endMonth='0'+endMonth;
		if(endDay<10){
			endDay='0'+endDay;
		}
	}
	endDate=endYear+'-'+endMonth +'-'+endDay;
	beginDate=beginYear+'-'+beginMonth +'-'+beginDay;
	//alert(beginDate+","+endDate);
	return beginDate+","+endDate;
}

function fn_modify_order_state(order_id,select_id){
	var s_delivery_state=document.getElementById(select_id);
    var index = s_delivery_state.selectedIndex;
    var value = s_delivery_state[index].value;
    //console.log("value: "+value );
	 
	$.ajax({
		type : "post",
		async : false,
		url : "${contextPath}/admin/order/modifyDeliveryState.do",
		data : {
			order_id:order_id,
			"delivery_state":value
		},
		success : function(data, textStatus) {
			if(data.trim()=='mod_success'){
				alert("주문 정보를 수정했습니다.");
				location.href="${contextPath}/admin/order/adminOrderMain.do";
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



function fn_detail_order(order_id){
	//alert(order_id);
	var frm_delivery_list=document.frm_delivery_list;
	

	var formObj=document.createElement("form");
	var i_order_id = document.createElement("input");
	
	i_order_id.name="order_id";
	i_order_id.value=order_id;
	
    formObj.appendChild(i_order_id);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/admin/order/orderDetail.do";
    formObj.submit();
	
}


</script>
</head>
<body>
<div class="input-form ">
<br>
<br>
	<p class="h2">주문 조회</p><br>
	<form name="frm_delivery_list" action="${contextPath }/admin/admin.do" method="post">	
		<table   >
			
								<!-- 상품 목록 검색을 위한 버튼들 -->
<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('today')">
    오늘
</button>

<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('one_month')">
    최근 1개월
</button>

<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('two_month')">
    최근 2개월
</button>

<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('three_month')">
    최근 3개월
</button>

<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('six_month')">
    최근 6개월
</button>
					
					</td>
				</tr>
				
				<tr>
				 
					

			</tbody>
		</table>
		<div class="clear">
	</div>
	
<div class="clear"></div>
<br>
<table class="table center-align">
		 <thead>
			<tr style="background:#eee" >
				<td class="fixed" >주문번호</td>
				<td class="fixed">주문일자</td>
				<td>주문내역</td>
				<td>배송상태</td>
				<td>-<!-- 배송수정 --></td>
			</tr>
			</thead>
			<tbody align=center >
   <c:choose>
     <c:when test="${empty newOrderList}">			
			<tr>
		       <td colspan=5 class="fixed">
				  <strong>주문한 상품이 없습니다.</strong>
			   </td>
		     </tr>
	 </c:when>
	 <c:otherwise>
     <c:forEach var="item" items="${newOrderList}" varStatus="i">
        <c:choose>
          <c:when test="${item.order_id != pre_order_id }">  
            <c:choose>
              <c:when test="${item.delivery_state=='delivery_prepared' }">
                <tr >    
              </c:when>
              <c:when test="${item.delivery_state=='finished_delivering' }">
                <tr  >    
              </c:when>
              <c:otherwise>
                <tr >   
              </c:otherwise>
            </c:choose>   
				 <td width=10%>
				   <a href="javascript:fn_detail_order('${item.order_id}')">
				     <strong>${item.order_id}</strong>
				   </a>
				</td>
				<td width=20%>
				 <strong>${item.pay_order_time }</strong> 
				</td>
				<td width=50% align=left >
				    <strong>주문자:${item.orderer_name}</strong><br>
				  <strong>주문자 번화번호:${item.orderer_hp}</strong><br>
				  <strong>수령자:${item.receiver_name}</strong><br>
				  <strong>수령자 번화번호:${item.receiver_hp1}-${item.receiver_hp2}-${item.receiver_hp3}</strong><br>
				  <strong>주문상품명(수량):${item.goods_title}(${item.order_goods_qty})</strong><br>
				     <c:forEach var="item2" items="${newOrderList}" varStatus="j">
				       <c:if test="${j.index > i.index }" >
				          <c:if  test="${item.order_id ==item2.order_id}" >
				            <strong>주문상품명(수량):${item2.goods_title}(${item2.order_goods_qty})</strong><br>
				      </c:if>   
				       </c:if>
				    </c:forEach> 
				</td>
				 <c:choose>
              <c:when test="${item.delivery_state=='delivery_prepared' }">
                <td width=10% bgcolor="lightgreen">    
              </c:when>
              <c:when test="${item.delivery_state=='finished_delivering' }">
                <td width=10%  bgcolor="lightgray">    
              </c:when>
              <c:when test="${item.delivery_state=='delivering' }">
                <td width=10%  bgcolor="lightgreen">    
              </c:when>
              <c:when test="${item.delivery_state=='cancel_order' }">
                <td width=10%  bgcolor="#FFA07A">    
              </c:when>
                <c:when test="${item.delivery_state=='returning_goods' }">
                <td width=10%  bgcolor="#FFA07A">    
              </c:when>
              <c:otherwise>
                <td width=10% bgcolor="white">   
              </c:otherwise>
            </c:choose>   
			<!-- 	<td width=10%  class="colorChange"> -->
				 <select name="s_delivery_state${i.index }"  class="custom-select" id="s_delivery_state${i.index }" >
				 <c:choose>
				   <c:when test="${item.delivery_state=='delivery_prepared' }">
				     <option  value="delivery_prepared" selected>배송준비중</option>
				     <option  value="delivering">배송중</option>
				     <option  value="finished_delivering">배송완료</option>
				     <option  value="cancel_order">주문취소</option>
				     <option  value="returning_goods">반품</option>
				   </c:when>
				    <c:when test="${item.delivery_state=='delivering' }">
				    <option  value="delivery_prepared" >배송준비중</option>
				     <option  value="delivering" selected >배송중</option>
				     <option  value="finished_delivering">배송완료</option>
				     <option  value="cancel_order">주문취소</option>
				     <option  value="returning_goods">반품</option>
				   </c:when>
				   <c:when test="${item.delivery_state=='finished_delivering' }">
				    <option  value="delivery_prepared" >배송준비중</option>
				     <option  value="delivering"  >배송중</option>
				     <option  value="finished_delivering" selected>배송완료</option>
				     <option  value="cancel_order">주문취소</option>
				     <option  value="returning_goods">반품</option>
				   </c:when>
				   <c:when test="${item.delivery_state=='cancel_order' }">
				    <option  value="delivery_prepared" >배송준비중</option>
				     <option  value="delivering"  >배송중</option>
				     <option  value="finished_delivering" >배송완료</option>
				     <option  value="cancel_order" selected>주문취소</option>
				     <option  value="returning_goods">반품</option>
				   </c:when>
				   <c:when test="${item.delivery_state=='returning_goods' }">
				    <option  value="delivery_prepared" >배송준비중</option>
				     <option  value="delivering"  >배송중</option>
				     <option  value="finished_delivering" >배송완료</option>
				     <option  value="cancel_order" >주문취소</option>
				     <option  value="returning_goods" selected>반품</option>
				   </c:when>
				   </c:choose>
				 </select> 
				</td>
				<td width=10% style="vertical-align: middle;">
			     <input  type="button" value="배송수정"  onClick="fn_modify_order_state('${item.order_id}','s_delivery_state${i.index}')" class="btn btn-primary" 
			     style="background-color: #1b7340; border: none; "/>
			    </td>
			</tr>
		</c:when>
		</c:choose>	
		<c:set  var="pre_order_id" value="${item.order_id }" />
	</c:forEach>
	</c:otherwise>
  </c:choose>	
         <tr>
             <td colspan=8 class="fixed">
                 <c:forEach   var="page" begin="1" end="10" step="1" >
		         <c:if test="${section >1 && page==1 }">
		          <a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;&nbsp;</a>
		         </c:if>
		          <a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
		         <c:if test="${page ==10 }">
		          <a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp; next</a>
		         </c:if> 
	      		</c:forEach> 
           </td>
        </tr>  		   
		</tbody>
	</table>
  </form>   	
	<div class="clear"></div>
</div>	

</body>
</html>

