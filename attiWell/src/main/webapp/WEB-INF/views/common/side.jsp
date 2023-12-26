<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://kit.fontawesome.com/7d3291fd02.js"
   crossorigin="anonymous"></script>
<style>

ul hr {
background-color : green;
margin: 5px;
border: 0px;
height: 2px;
}

#menu li a {
color : gray;
font-size : 14px;
font-weight: bold;
}

#menu li a:hover {
color: rgb(255, 102, 0);
text-decoration : none;
}

</style>
<nav>
   <ul>
      <c:choose>
         <c:when test="${side_menu=='admin_mode' }">
            <li>
               <h3
                  style="background-color: #1b7340; color: white; line-height: 30px">
                  <i class="fa-solid fa-list"
                     style="color: #ffffff; padding: 0px 0px 4px 0px; font-size: 18px"></i>
                  주요기능
               </h3>
               <ul id="menu">
                  <li><a href="${contextPath}/admin/goods/adminGoodsMain.do">상품관리</a></li>
                  <hr>
                  <li><a href="${contextPath}/admin/order/adminOrderMain.do">주문관리</a></li>
                  <hr>
                  <li><a href="${contextPath}/admin/member/adminMemberMain.do">회원관리</a></li>
                  <hr>
                 <!--  <li><a href="#">배송관리</a></li> -->
               </ul>
            </li>
         </c:when>
         <c:when test="${side_menu=='my_page' }">
            <li>
               <h3
                  style="background-color: #1b7340; color: white; line-height: 30px">
                  <i class="fa-solid fa-list"
                     style="color: #ffffff; padding: 0px 0px 4px 0px; font-size: 18px"></i>
                  주문내역
               </h3>
               <ul id="menu">
                  <li><a
                     href="${contextPath}/mypage/listMyOrderHistory.do?delivery_state=delivery_prepared,delivering,finished_delivering">주문내역/배송
                        조회</a></li>
                  <hr>
                  <li><a
                     href="${contextPath}/mypage/listMyOrderHistory.do?delivery_state=returning_goods">반품/교환
                        신청 및 조회</a></li>
                  <hr>
                  <li><a
                     href="${contextPath}/mypage/listMyOrderHistory.do?delivery_state=cancel_order">취소
                        주문 내역</a></li>
               </ul>
            </li>
            <li>
               <h3
                  style="background-color: #1b7340; color: white; line-height: 30px">
                  <i class="fa-solid fa-list"
                     style="color: #ffffff; padding: 0px 0px 4px 0px; font-size: 18px"></i>
                  정보내역
               </h3>
               <ul id="menu">
                  <li><a href="${contextPath}/mypage/myDetailInfoDisabled.do">회원정보관리</a></li>
                  <hr>
                  <li><a href="#">개인정보 동의내역</a></li>
                  <hr>
                  <li>
                     <form action="${contextPath}/member/deleteMember.do"
                        method="post">
                        <input type="submit" value="회원탈퇴" id="deleteMem"
                           style="font-size : 14px; border: 0; background-color: transparent; color:#666666; cursor:pointer;">
                     </form>
                  </li>
               </ul>
            </li>
         </c:when>
         <c:otherwise>
            <li>
               <h3
                  style="background-color: #1b7340; color: white; line-height: 30px">
                  <i class="fa-solid fa-list"
                     style="color: #ffffff; padding: 0px 0px 4px 0px; font-size: 18px"></i>
                  전체 카테고리
               </h3>
               <ul id="menu">
                  <!-- 카테고리들 링크 걸음 -->
                  <li><a href="${contextPath}/goods/allGoodsList.do">전체상품</a></li>
                  <hr>
                  <li><a
                     href="${contextPath}/goods/selectGoodsList.do?category=전통건강식품">전통건강식품</a></li>
                  <hr>
                  <li><a
                     href="${contextPath}/goods/selectGoodsList.do?category=일반건강식품">일반건강식품</a></li>
                  <hr>
                  <li><a
                     href="${contextPath}/goods/selectGoodsList.do?category=한방차/커피">한방차/커피</a></li>
                  <hr>
                  <li><a
                     href="${contextPath}/goods/selectGoodsList.do?category=건강관리용품">건강관리용품</a></li>
               </ul>
            </li>
         </c:otherwise>
      </c:choose>
   </ul>
</nav>
<div class="clear"></div>
<div style="height:50px;"></div>


<div id="banner">
   <a href="#"><img width="250" height="350"
      src="${contextPath}/resources/image/side_banner08.png"></a>
</div>
<div id="banner">
   <a href="#"><img width="250" height="90"
      src="${contextPath}/resources/image/side_banner2.png"></a>
</div>
<div id="banner">
   <a href="#"><img width="250" height="130"
      src="${contextPath}/resources/image/main_banner4.png"></a>
</div>
</html>