<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
   //치환 변수 선언합니다.
   pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
   pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<head>
<title>전체 상품 페이지</title>
</head>
<body>
   <hgroup>
      <h1>전체 상품</h1>
      <h2>오늘의 상품</h2>
   </hgroup>
   <section id="new_book">
      <h3>새로나온 책</h3>
      <div id="left_scroll">
         <a href='javascript:slide("left");'><img
            src="${contextPath}/resources/image/left.gif"
            style="width: 30px; height: 40px; margin: 45px 25px 0px 0px"></a>
      </div>
      <div id="carousel_inner">
         <ul id="carousel_ul">
            <c:forEach var="item" items="${goodsList }">
               <li>
                  <div id="book">
                     <a
                        href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
                        <img width="250px" alt="" style="border-radius: 8px"
                        src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
                     </a>
                     <div class="sort">${goods.goods_sort }</div>
                     <div class="title">
                        <a
                           href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
                           ${item.goods_title} </a>
                     </div>
                     <div class="price">
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


                        <span> <fmt:formatNumber value="${item.goods_price}"
                              type="number" var="goods_price" /> <c:choose>
                              <c:when test="${item.goods_price == item.goods_sales_price }">
                                 <span style="color: black; font-weight: bold">${formattedDiscountedPrice }원</span>
                              </c:when>
                              <c:otherwise>
                                 <span style="text-decoration: line-through;">${goods_price}원</span>
                                 <br>

                                 <span style="color: red; font-weight: bold">${formattedDiscountedPrice }원(${formattedRoundedDiscount}%할인)</span>
                              </c:otherwise>
                           </c:choose>
                        </span> <br>
                     </div>
                  </div>
               </li>
            </c:forEach>

         </ul>
      </div>
      <div id="right_scroll">
         <a href='javascript:slide("right");'><img
            src="${contextPath}/resources/image/right.gif"
            style="width: 30px; height: 40px; margin-top: 45px"></a>
      </div>
      <input id="hidden_auto_slide_seconds" type="hidden" value="0">

      <div class="clear"></div>
   </section>
   <div class="clear"></div>
   <div id="sorting">
      <ul>
         <li><a class="active" href="#">인기순</a></li>
         <li><a href="#">최신순</a></li>
         <li><a style="border: currentColor; border-image: none;"
            href="#">가격순</a></li>
      </ul>
   </div>
   <table id="list_view">
      <tbody>
         <c:forEach var="item" items="${goodsList }">
            <tr>
               <td class="goods_image"><a
                  href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
                     <img width="150" alt="" style="border-radius: 8px"
                     src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
               </a></td>
               <td class="goods_description">
                  <h2>
                     <a
                        href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">&nbsp;&nbsp;${item.goods_title }</a>
                  </h2>
               </td>
               <td class="price"><c:set var="goodsPrice"
                     value="${item.goods_price}" /> <c:set var="goodsSalesPrice"
                     value="${item.goods_sales_price}" /> <c:set
                     var="discountedPrice"
                     value="${goodsPrice - (goodsPrice - goodsSalesPrice)}" /> <c:set
                     var="discount"
                     value="${(goodsPrice - goodsSalesPrice) / goodsPrice * 100}" />

                  <%
                     double roundedDiscount = Math.ceil(Double.parseDouble(pageContext.getAttribute("discount").toString()));
                        pageContext.setAttribute("roundedDiscount", roundedDiscount);
                  %> <fmt:formatNumber value="${discountedPrice}" type="number"
                     var="formattedDiscountedPrice" /> <fmt:formatNumber
                     value="${roundedDiscount}" type="number"
                     var="formattedRoundedDiscount" maxFractionDigits="0" /> <span>
                     <fmt:formatNumber value="${item.goods_price}" type="number"
                        var="goods_price" /> <c:choose>
                        <c:when test="${item.goods_price == item.goods_sales_price }">
                           <span style="color: black; font-weight: bold">${formattedDiscountedPrice }원</span>
                        </c:when>
                        <c:otherwise>
                           <span style="text-decoration: line-through;">${goods_price}원</span>

                           <span style="color: red; font-weight: bold">${formattedDiscountedPrice }원(${formattedRoundedDiscount}%할인)</span>
                        </c:otherwise>
                     </c:choose>
               </span> <br></td>
               <td><div></div></td>
               <td class="buy_btns">
                  <UL>
                     <li><a href="#">장바구니</a></li>
                     <li><a href="#">구매하기</a></li>
                     <li><a href="#">비교하기</a></li>
                  </UL>
               </td>
            </tr>
         </c:forEach>
      </tbody>
   </table>
   <div class="clear"></div>

   <div id="page_wrap">
      <%-- <ul id="page_control">
         <li><a class="no_border" href="#">Prev</a></li>
         <c:set var="page_num" value="0" />
         <c:forEach var="count" begin="1" end="10" step="1">
            <c:choose>
               <c:when test="${count==1 }">
                  <li><a class="page_contrl_active" href="#">${count+page_num*10 }</a></li>
               </c:when>
               <c:otherwise>
                  <li><a href="#">${count+page_num*10 }</a></li>
               </c:otherwise>
            </c:choose>
         </c:forEach>
         <li><a class="no_border" href="#">Next</a></li>
      </ul> --%>
      <c:forEach var="page" begin="1" end="10" step="1">
         <c:if test="${section >1 && page==1 }">
            <a
               href="${contextPath}/goods/allGoodsList.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
               &nbsp;</a>
         </c:if>
         <a
            href="${contextPath}/goods/allGoodsList.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page }
         </a>
         <c:if test="${page ==10 }">
            <a
               href="${contextPath}/goods/allGoodsList.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp;
               next</a>
         </c:if>
      </c:forEach>
   </div>