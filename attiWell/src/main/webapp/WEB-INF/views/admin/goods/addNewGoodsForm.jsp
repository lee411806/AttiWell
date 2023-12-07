<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />	
<!DOCTYPE html>

<meta charset="utf-8">
<head>
<style>
.input-form {
   max-width: 850px;
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
</style>

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

<BODY>
<div class="input-form ">
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
						  <option value="bestseller"  >전체상품</option>
						  <option value="steadyseller" >전통건강식품</option>
						  <option value="newbook" selected >일반건강식품</option>
						  <option value="on_sale" >한방차/커피</option>
						  <option value="buy_out" >건강관리용품</option>
						  <option value="out_of_print" >품절</option>
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
</div>