<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">

<!-- 부트스트랩 4.3.1 적용   -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <style>
    a {
        color: grey; /* 또는 원하는 색상으로 변경 */
    }
    
     .h2 {
        font-size: 24px; /* Increase the font size to your desired value */
        font-weight: bold; /* 굴게 만들기 */
    }

</style>


<!-- style 파트 -->
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
</style>

<!--스크립트 파트  -->
<script>
function search_goods_list(fixeSearchPeriod){
	var formObj=document.createElement("form");
	var i_fixedSearch_period = document.createElement("input");
	i_fixedSearch_period.name="fixedSearchPeriod";
	i_fixedSearch_period.value=fixeSearchPeriod;
    formObj.appendChild(i_fixedSearch_period);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/admin/goods/adminGoodsMain.do";
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
	}else if(search_period=='six_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-6);
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



</script>
<script type="text/javascript">
  var cnt=0;
  function fn_addFile(){
	  if(cnt == 0){
		  $("#d_file").append("<br>"+"<input  type='file' name='main_image' id='f_main_image' />");	  
	  }else{
		  $("#d_file").append("<br>"+"<input  type='file' name='detail_image"+cnt+"' />");
	  }
  	
  	cnt++;
  }
  
  
  function fn_add_new_goods(obj){
		 fileName = $('#f_main_image').val();
		 if(fileName != null && fileName != undefined){
			 obj.submit();
		 }else{
			 alert("메인 이미지는 반드시 첨부해야 합니다.");
			 return;
		 }
		 
	}
</script>    

</head>
<body>
<br>
<br>

	<p class="h2">상품관리</p><br>
	
	<form  method="post">	
		<TABLE cellpadding="10" cellspacing="10"  >
			<TBODY>
			
			
					
		<!-- 		<div class="btn-group" role="group" aria-label="Search Buttons"> -->
    <button type="button"  class="btn btn-primary btn-sm custom-btn mr-3"  onclick="search_goods_list('today')">
        오늘
    </button>
    <button type="button"  class="btn btn-primary btn-sm custom-btn mr-3"  onclick="search_goods_list('one_month')">
        최근 1개월
    </button>
    <button type="button"  class="btn btn-primary btn-sm custom-btn mr-3"  onclick="search_goods_list('two_month')">
        최근 2개월
    </button>
    <button type="button"  class="btn btn-primary btn-sm custom-btn mr-3"  onclick="search_goods_list('three_month')">
        최근 3개월
    </button>
    <button type="button"  class="btn btn-primary btn-sm custom-btn mr-3"  onclick="search_goods_list('six_month')">
       최근 6개월
    </button>
<!-- </div> -->
				
		</TR>
				
				</tr>
				
			</TBODY>
		</TABLE>
		<DIV class="clear">
	</DIV>
</form>	

<br>

<!-- <TABLE class="list_view"> -->
<table class="table table-hover center-align">
  <thead>
    <tr style="background:#eee">
      <th>상품번호</th>
      <th>상품이름</th>
      <th>상품가격</th>
      <th>입고일자</th>
    </tr>
  </thead>
		
		<!-- 	<tr style="background:#33ff00" >
				<td>상품번호</td>
				<td>상품이름</td>
				<td>상품가격</td>
				<td>입고일자</td>
			</tr> -->
			<TBODY align=center >
   <c:choose>
     <c:when test="${empty newGoodsList }">			
			<TR>
		       <TD colspan=8 class="fixed">
				  <strong>조회된 상품이 없습니다.</strong>
			   </TD>
		     </TR>
	 </c:when>
	 <c:otherwise>
     <c:forEach var="item" items="${newGoodsList }">
			 <TR>       
				<TD>
				  <strong>${item.goods_id }</strong>
				</TD>
				<TD >
				 <a href="${pageContext.request.contextPath}/admin/goods/modifyGoodsForm.do?goods_id=${item.goods_id}">
				    <strong>${item.goods_title } </strong>
				 </a> 
				</TD>
				<td>
				  <strong>${item.goods_sales_price }</strong>
				</td>
				<td>
				 <strong>${item.goods_credate }</strong> 
				</td>
				
			</TR>
	</c:forEach>
	</c:otherwise>
  </c:choose>
           <tr>
             <td colspan=8 class="fixed">
                 <c:forEach   var="page" begin="1" end="10" step="1" >
		         <c:if test="${section >1 && page==1 }">
		          <a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; &nbsp;</a>
		         </c:if>
		          <a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
		         <c:if test="${page ==10 }">
		          <a href="${contextPath}/admin/goods/adminGooodsMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp; next</a>
		         </c:if> 
	      		</c:forEach> 
     
		</TBODY>
		
	</TABLE>
	<DIV class="clear"></DIV>
	<br><br><br>
<H3>상품등록하기</H3>
<DIV id="search">
	<form action="${contextPath}/admin/goods/addNewGoodsForm.do">
		<input   type="submit" value="상품 등록하기">
	</form>
</DIV>


<form action="${contextPath}/admin/goods/addNewGoods.do" method="post"  enctype="multipart/form-data">
		<h1>새상품 등록창</h1>
<div class="tab_container">
	<!-- 내용 들어 가는 곳 -->
	<div class="tab_container" id="container">
		<ul class="tabs">
			<li><a href="#tab1">상품정보</a></li>
			<li><a href="#tab4">상품소개</a></li>
			<li><a href="#tab7">상품이미지</a></li>
		</ul>
		<div class="tab_container">
			<div class="tab_content" id="tab1">
				<table >
		<!-- 	<tr >
				<td width=200 >제품분류</td>
				<td width=500><select name="goods_sort">
						<option value="컴퓨터와 인터넷" selected>컴퓨터와 인터넷
						<option value="디지털 기기">디지털 기기
					</select>
				</td>
			</tr> -->
			<tr >
				<td >제품이름</td>
				<td><input name="goods_title" type="text" size="40" /></td>
			</tr>
			
				<td >제품정가</td>
				<td><input name="goods_price" type="text" size="40" /></td>
			</tr>
			
			<tr>
				<td >제품판매가격</td>
				<td><input name="goods_sales_price" type="text" size="40" /></td>
			</tr>
			
			
			<tr>
				<td >제품종류</td>
				<td>
				<select name="goods_status">
				  <option value="bestseller"  >전통건강식품</option>
				  <option value="steadyseller" >일반건강식품</option>
				  <option value="newbook"  >한방차/커피</option>
				  <option value="on_sale" >건강관리 용품</option>
				  <option value="buy_out" >품절</option>
				  <option value="out_of_print" >절판</option>
				</select>
				</td>
			</tr>
			<tr>
			 <td>
			   <br>
			 </td>
			</tr>
				</table>	
			</div>
			<div class="tab_content" id="tab4">
				<H4>제품소개</H4>
				<table>
					<tr>
						<td >제품소개</td>
						<td><textarea  rows="100" cols="80" name="goods_intro"></textarea></td>
				    </tr>
			    </table>
			</div>
			<div class="tab_content" id="tab7">
				<h4>상품이미지</h4>
				<table >
					<tr>
						<td align="right">이미지파일 첨부</td>
			            
			            <td  align="left"> <input type="button"  value="파일 추가" onClick="fn_addFile()"/></td>
			            <td>
				            <div id="d_file">
				            </div>
			            </td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="clear"></div>
<center>	
	 <table>
	 <tr>
			  <td align=center>
				<!--   <input  type="submit" value="상품 등록하기"> --> 
				  <input  type="button" value="상품 등록하기"  onClick="fn_add_new_goods(this.form)">
			  </td>
			</tr>
	 </table>
</center>	 
</div>
</form>	 

</body>
</html>