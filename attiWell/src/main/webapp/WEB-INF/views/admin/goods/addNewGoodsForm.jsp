

<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />   
<!DOCTYPE html>

<meta charset="utf-8">
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
<form action="${contextPath}/admin/goods/addNewGoods.do" method="post"  enctype="multipart/form-data">
      <!-- <h1>새상품 등록창</h1> -->
       <!-- <p class="h2">새상품 등록창</p> -->
<div class="tab_container">
   <!-- 내용 들어 가는 곳 -->
   <div class="tab_container" id="container">
      <ul class="tabs">
         <li><a href="#tab1">상품정보</a></li>
      <!--    <li><a href="#tab4">상품소개</a></li> -->
         <li><a href="#tab7">상품이미지</a></li>
      </ul>
      <div class="tab_container">
         <div class="tab_content" id="tab1">
            <table  class="table">
         <tr >
            <td width=200 class="fixed_join">제품분류</td>
            <td width=500><select name="goods_sort">
                  <option value="전통건강식품" selected>전통건강식품
                  <option value="일반건강식품">일반건강식품
                  <option value="한방차/커피">한방차/커피
                  <option value="건강관리용품">건강관리용품
               </select>
            </td>
         </tr>
         <tr >
            <td class="fixed_join">제품이름</td>
            <td><input name="goods_title" type="text" size="40" /></td>
         </tr>
         
            <td class="fixed_join">제품정가</td>
            <td><input name="goods_price" type="text" size="40" /></td>
         </tr>
         
         <tr>
            <td class="fixed_join">제품판매가격</td>
            <td><input name="goods_sales_price" type="text" size="40" /></td>
         </tr>
         
         
         <tr>
            <td class="fixed_join">제품종류</td>
            <td>
            <select name="goods_status">
              <option value="할인상품"  >할인상품</option>
              <option value="인기상품" >인기상품</option>
              <option value="일반상품" selected >일반상품</option>
<!--               <option value="on_sale" >판매중</option>
              <option value="buy_out" >품절</option> -->
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
            <table class="table" >
               <tr>
                  <td align="right" class="fixed_join">이미지파일 첨부</td>
                     <td>
                     </td>
                     <td>
                     </td>
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