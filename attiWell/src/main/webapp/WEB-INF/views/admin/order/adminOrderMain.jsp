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
 <style>
    a {
        color: grey; /* 또는 원하는 색상으로 변경 */
    }
</style>
<style>
    .custom-btn {
        background-color: #1b7340; /* 초록색 배경색 설정 */
         border: none; /* 테두리 없애기 */
         border-radius: 15px; /* radius 설정 */ 
    }
    
    
</style>
<c:choose>
<c:when test='${not empty order_goods_list}'>
<script  type="text/javascript">
window.onload=function()
{
	init();
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
</c:when>
</c:choose>
<script>
function search_order_history(search_period){	
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
}


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
				location.href="${contextPath}//admin/order/adminOrderMain.do";
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

function fn_enable_detail_search(r_search){
	var frm_delivery_list=document.frm_delivery_list;
	t_beginYear=frm_delivery_list.beginYear;
	t_beginMonth=frm_delivery_list.beginMonth;
	t_beginDay=frm_delivery_list.beginDay;
	t_endYear=frm_delivery_list.endYear;
	t_endMonth=frm_delivery_list.endMonth;
	t_endDay=frm_delivery_list.endDay;
	s_search_type=frm_delivery_list.s_search_type;
	t_search_word=frm_delivery_list.t_search_word;
	btn_search=frm_delivery_list.btn_search;
	
	if(r_search.value=='detail_search'){
		//alert(r_search.value);
		t_beginYear.disabled=false;
		t_beginMonth.disabled=false;
		t_beginDay.disabled=false;
		t_endYear.disabled=false;
		t_endMonth.disabled=false;
		t_endDay.disabled=false;
		
		s_search_type.disabled=false;
		t_search_word.disabled=false;
		btn_search.disabled=false;
	}else{
		t_beginYear.disabled=true;
		t_beginMonth.disabled=true;
		t_beginDay.disabled=true;
		t_endYear.disabled=true;
		t_endMonth.disabled=true;
		t_endDay.disabled=true;
		
		s_search_type.disabled=true;
		t_search_word.disabled=true;
		btn_search.disabled=true;
	}
		
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

//상세조회 버튼 클릭 시 수행
function fn_detail_search(){
	var frm_delivery_list=document.frm_delivery_list;
	
	beginYear=frm_delivery_list.beginYear.value;
	beginMonth=frm_delivery_list.beginMonth.value;
	beginDay=frm_delivery_list.beginDay.value;
	endYear=frm_delivery_list.endYear.value;
	endMonth=frm_delivery_list.endMonth.value;
	endDay=frm_delivery_list.endDay.value;
	search_type=frm_delivery_list.s_search_type.value;
	search_word=frm_delivery_list.t_search_word.value;

	var formObj=document.createElement("form");
	var i_command = document.createElement("input");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
	var i_search_type = document.createElement("input");
	var i_search_word = document.createElement("input");
    
	//alert("beginYear:"+beginYear);
	//alert("endDay:"+endDay);
	//alert("search_type:"+search_type);
	//alert("search_word:"+search_word);
	
    i_command.name="command";
    i_beginDate.name="beginDate";
    i_endDate.name="endDate";
    i_search_type.name="search_type";
    i_search_word.name="search_word";
    
    i_command.value="list_detail_order_goods";
	i_beginDate.value=beginYear+"-"+beginMonth+"-"+beginDay;
    i_endDate.value=endYear+"-"+endMonth+"-"+endDay;
    i_search_type.value=search_type;
    i_search_word.value=search_word;
	
    formObj.appendChild(i_command);
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    formObj.appendChild(i_search_type);
    formObj.appendChild(i_search_word);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/admin/order/detailOrder.do";
    formObj.submit();
    //alert("submit");
	
}
</script>
</head>
<body>
	<H3>주문 조회</H3>
	<form name="frm_delivery_list" action="${contextPath }/admin/admin.do" method="post">	
		<table   >
			
								<!-- 상품 목록 검색을 위한 버튼들 -->
<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('today')">
    오늘
</button>

<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('today')">
    최근 1개월
</button>

<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('today')">
    최근 2개월
</button>

<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('today')">
    최근 3개월
</button>

<button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="javascript:search_order_history('today')">
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
<table class="list_view">
		<tbody align=center >
			<tr style="background:#33ff00" >
				<td class="fixed" >주문번호</td>
				<td class="fixed">주문일자</td>
				<td>주문내역</td>
				<td>배송상태</td>
				<td>배송수정</td>
			</tr>
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
                <tr  bgcolor="lightgreen">    
              </c:when>
              <c:when test="${item.delivery_state=='finished_delivering' }">
                <tr  bgcolor="lightgray">    
              </c:when>
              <c:otherwise>
                <tr  bgcolor="orange">   
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
				<td width=10%>
				 <select name="s_delivery_state${i.index }"  id="s_delivery_state${i.index }">
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
				<td width=10%>
			     <input  type="button" value="배송수정"  onClick="fn_modify_order_state('${item.order_id}','s_delivery_state${i.index}')"/>
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
</body>
</html>

