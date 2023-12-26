<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<head>

<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>

<!-- <style>
* { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
</style> -->

</head>

<script>
   var array_index=0;
   var SERVER_URL="${contextPath}/thumbnails.do";
   function fn_show_next_goods(){
      var img_sticky=document.getElementById("img_sticky");
      var cur_goods_num=document.getElementById("cur_goods_num");
      var _h_goods_id=document.frm_sticky.h_goods_id;
      var _h_goods_fileName=document.frm_sticky.h_goods_fileName;
      if(array_index <_h_goods_id.length-1)
         array_index++;
          
      var goods_id=_h_goods_id[array_index].value;
      var fileName=_h_goods_fileName[array_index].value;
      img_sticky.src=SERVER_URL+"?goods_id="+goods_id+"&fileName="+fileName;
      cur_goods_num.innerHTML=array_index+1;
   }


 function fn_show_previous_goods(){
   var img_sticky=document.getElementById("img_sticky");
   var cur_goods_num=document.getElementById("cur_goods_num");
   var _h_goods_id=document.frm_sticky.h_goods_id;
   var _h_goods_fileName=document.frm_sticky.h_goods_fileName;
   
   if(array_index >0)
      array_index--;
   
   var goods_id=_h_goods_id[array_index].value;
   var fileName=_h_goods_fileName[array_index].value;
   img_sticky.src=SERVER_URL+"?goods_id="+goods_id+"&fileName="+fileName;
   cur_goods_num.innerHTML=array_index+1;
}

function goodsDetail(){
   var cur_goods_num=document.getElementById("cur_goods_num");
   arrIdx=cur_goods_num.innerHTML-1;
   
   var img_sticky=document.getElementById("img_sticky");
   var h_goods_id=document.frm_sticky.h_goods_id;
   var len=h_goods_id.length;
   
   if(len>1){
      goods_id=h_goods_id[arrIdx].value;
   }else{
      goods_id=h_goods_id.value;
   }
   
   
   var formObj=document.createElement("form");
   var i_goods_id = document.createElement("input"); 
    
   i_goods_id.name="goods_id";
   i_goods_id.value=goods_id;
   
    formObj.appendChild(i_goods_id);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/goods/goodsDetail.do?goods_id="+goods_id;
    formObj.submit();
   
   
}
</script>




<body>
   <div id="sticky"">



      <div class="recent">
         <h3 style="padding-bottom: 3px; border-bottom: solid #5c5452 1px;">최근 본 상품</h3>
         
         <ul>
            <!--   상품이 없습니다. -->
            <c:choose>
               <c:when test="${ empty quickGoodsList }">
                  <strong style="display: inline-block; width: 110px; height: 180px; font-size:16px; text-align: center; line-height: 26px;">
                  최근 조회한<br>상품이<br>없습니다.</strong>
               </c:when>


               <c:otherwise>
                  <form name="frm_sticky">
                     <c:forEach var="item" items="${quickGoodsList }"
                        varStatus="itemNum">
                        <c:choose>
                           <c:when test="${itemNum.count==1 }">
                              <a href="javascript:goodsDetail();"> <img width="105"
                                 height="130" id="img_sticky"
                                 src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
                              </a>
                              <input type="hidden" name="h_goods_id"
                                 value="${item.goods_id}" />
                              <input type="hidden" name="h_goods_fileName"
                                 value="${item.goods_fileName}" />
                              <br>
                           </c:when>
                           <c:otherwise>
                              <input type="hidden" name="h_goods_id"
                                 value="${item.goods_id}" />
                              <input type="hidden" name="h_goods_fileName"
                                 value="${item.goods_fileName}" />
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
               </c:otherwise>
            </c:choose>
         </ul>
         </form>
      </div>



      <div style="color:white">
         <c:choose>
            <c:when test="${ empty quickGoodsList }">
               <span> &nbsp;&nbsp;0/0 &nbsp;</span>
            </c:when>
            <c:otherwise>
               <h5>
                  <span id="cur_goods_num">1</span> | ${quickGoodsListNum}&nbsp;
               </h5>
               <br>
               <a style="color:white" href='javascript:fn_show_previous_goods();'>  &nbsp;이전 </a>&nbsp;<a style="color:white"
                  href='javascript:fn_show_next_goods();'> 다음 </a>
            </c:otherwise>
         </c:choose>
      </div>
   </div>




</body>
</html>
