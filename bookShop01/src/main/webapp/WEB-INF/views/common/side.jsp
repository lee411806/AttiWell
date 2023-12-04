<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<script src="https://kit.fontawesome.com/7d3291fd02.js" crossorigin="anonymous"></script>
   
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
      <ul>
         <li><a href="${contextPath}/admin/goods/adminGoodsMain.do">상품관리</a></li>
         <li><a href="${contextPath}/admin/order/adminOrderMain.do">주문관리</a></li>
         <li><a href="${contextPath}/admin/member/adminMemberMain.do">회원관리</a></li>
         <li><a href="#">배송관리</a></li>
         <li><a href="#">게시판관리</a></li>
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
      <ul>
         <li><a href="${contextPath}/mypage/listMyOrderHistory.do">주문내역/배송 조회</a></li>
         <li><a href="#">반품/교환 신청 및 조회</a></li>
         <li><a href="#">취소 주문 내역</a></li>
         <li><a href="#">세금 계산서</a></li>
      </ul>
   </li>
   <li>
      <h3
                  style="background-color: #1b7340; color: white; line-height: 30px">
                  <i class="fa-solid fa-list"
                     style="color: #ffffff; padding: 0px 0px 4px 0px; font-size: 18px"></i>
                  정보내역
               </h3>
      <ul>
         <li><a href="${contextPath}/mypage/myDetailInfoDisabled.do">회원정보관리</a></li>
         <!-- 주소록 추가 -->
         <li><a href="${contextPath}/mypage/myAddress.do">나의 주소록</a></li>
         <li><a href="#">개인정보 동의내역</a></li>
         <li>
         <form action="${contextPath}/member/deleteMember.do" method="post">
             <input type="submit" value="회원탈퇴" style="border:0; background-color: transparent;">
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
      <ul>
      <!-- 카테고리들 링크 걸음 -->
         <li><a href="${contextPath}/goods/allGoodsList.do">전체상품</a></li>
         <li><a href="${contextPath}/goods/selectGoodsList.do?category=전통건강식품">전통건강식품</a></li>
         <li><a href="${contextPath}/goods/selectGoodsList.do?category=일반건강식품">일반건강식품</a></li>
         <li><a href="${contextPath}/goods/selectGoodsList.do?category=한방차/커피">한방차/커피</a></li>
         <li><a href="${contextPath}/goods/selectGoodsList.do?category=건강관리용품">건강관리용품</a></li>
      </ul>
   </li>
 </c:otherwise>
</c:choose>   
</ul>
</nav>
<div class="clear"></div>
<DIV id="notice">
   <H2>공지사항</H2>
   <UL>
   
   <c:forEach  var="i" begin="1" end="5" step="1">
      <li><a href="#">공지사항입니다.${ i}</a></li>
   </c:forEach>
   </ul>
</div>


<div id="banner">
   <a href="#"><img width="190" height="250" src="${contextPath}/resources/image/side_banner08.png"></a>
</div>
<div id="banner">
   <a href="#"><img width="190" height="69" src="${contextPath}/resources/image/side_banner2.png"></a>
</div>
<div id="banner">
   <a href="#"><img width="190" height="104" src="${contextPath}/resources/image/main_banner4.png"></a>
</div>
</html>