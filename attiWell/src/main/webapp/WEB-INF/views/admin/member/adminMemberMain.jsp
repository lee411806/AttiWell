<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <!-- 부트스트랩 4.3.1 적용   -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        
 <!-- style 파트 -->    
        
    <style>
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
        
       /* 페이지 선택 호버 안먹게 해줌 */
       .no-hover:hover {
       background-color: transparent !important; /* 특정 행의 hover 배경색을 투명으로 설정 */
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
        
        tr {
       
            white-space: nowrap; 
      }
    </style>

<script>
/* function search_member(search_period){   
   var temp=calcPeriod(search_period);
   console.log(temp);
   var date=temp.split(",");
   beginDate=date[0];
   endDate=date[1];
   //alert("beginDate:"+beginDate+",endDate:"+endDate);
   //return ;
   
   var formObj=document.createElement("form");
    
   var formObj=document.createElement("form");
   var i_beginDate = document.createElement("input"); 
   var i_endDate = document.createElement("input");
    
   i_beginDate.name="beginDate";
   i_beginDate.value=beginDate;
   i_endDate.name="endDate";
   i_endDate.value=endDate;
   
   console.log(i_beginDate.name);
   
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="/attiWell/admin/member/adminMemberMain.do";
    formObj.submit();
} */

function search_member(fixeSearchPeriod) {
    var formObj = document.createElement("form");
    var i_fixedSearch_period = document.createElement("input");
    i_fixedSearch_period.name = "fixedSearchPeriod";
    i_fixedSearch_period.value = fixeSearchPeriod;
    formObj.appendChild(i_fixedSearch_period);
    document.body.appendChild(formObj);
    formObj.method = "get";
    formObj.action = "${contextPath}/admin/member/adminMemberMain.do";
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
      if(endDay-7<1){
         beginMonth=dt.getMonth();   
      }else{
         beginMonth=dt.getMonth()+1;
      }
      
      dt.setDate(endDay-7);
      beginDay=dt.getDate();
      
   }else if(search_period=='two_week'){
      beginYear = dt.getFullYear();
      if(endDay-14<1){
         beginMonth=dt.getMonth();   
      }else{
         beginMonth=dt.getMonth()+1;
      }
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
   }else if(search_period=='three__month'){
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
   console.log(beginDate);
   return beginDate+","+endDate;
}



function fn_member_detail(order_id){
   //alert(order_id);
   var frm_delivery_list=document.frm_delivery_list;
   

   var formObj=document.createElement("form");
   var i_order_id = document.createElement("input");
   
   i_order_id.name="order_id";
   i_order_id.value=order_id;
   
    formObj.appendChild(i_order_id);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="/attiWell/admin/member/memberDetail.do";
    formObj.submit();
   
}


</script>
</head>
<body>
<div class="input-form ">
    <br>
    <br>
   <!-- <H3>회원 조회</H3>  -->
   <p class="h2">회원 조회</p><br>
   <form name="frm_delivery_list" >   
      <table cellpadding="10" cellspacing="10"  >
           <tbody>

                <!-- <div class="btn-group" role="group" aria-label="Search Buttons"> -->
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="search_member('today')">
                    오늘
                </button>
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3"
                    onclick="search_member('one_month')">
                    최근 1개월
                </button>
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3"
                    onclick="search_member('two_month')">
                    최근 2개월
                </button>
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3"
                    onclick="search_member('three_month')">
                    최근 3개월
                </button>
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3"
                    onclick="search_member('six_month')">
                    최근 6개월
                </button>
       

            </tbody>
            
       <br>   
        <br>   
       
   

<table  class="table table-hover center-align">
      <tbody align=center >
         <tr style="background:#eee">
            <td class="fixed" >회원아이디</td>
            <td class="fixed">회원이름</td>
            <td>휴대폰번호</td>
            <td>주소</td>
            <td>가입일</td>
            <td>탈퇴여부</td>
         </tr>
   <c:choose>
     <c:when test="${empty member_list}">         
         <tr>
             <td colspan=5 class="fixed">
              <strong>조회된 회원이 없습니다.</strong>
            </td>
           </tr>
    </c:when>
    <c:otherwise>
        <c:forEach var="item" items="${member_list}" varStatus="item_num">
               <tr >       
               <td width=10%>
               
                 <a href="${pageContext.request.contextPath}/admin/member/memberDetail.do?member_id=${item.member_id}">
                    <strong>${item.member_id}</strong>
                 </a>
               </td>
               <td width=10%>
                 <strong>${item.member_name}</strong><br>
               </td>
               <td width=10% >
                 <strong>${item.hp1}-${item.hp2}-${item.hp3}</strong><br>
               </td>
               <td width=50%>
                 <strong>${item.roadAddress}</strong><br>
                 <strong>${item.jibunAddress}</strong><br>
                 <strong>${item.namujiAddress}</strong><br>
               </td>
               <td width=10%>
                  <c:set var="join_date" value="${item.joinDate}" />
                  <c:set var="arr" value="${fn:split(join_date,' ')}" />
                  <strong><c:out value="${arr[0]}" /></strong>
                </td>
                <td width=10%>
                   <c:choose>
                     <c:when test="${item.del_yn=='N' }">
                       <strong>활동중</strong>  
                     </c:when>
                     <c:otherwise>
                       <strong>탈퇴</strong>
                     </c:otherwise>
                   </c:choose>
                </td>
            </tr>
      </c:forEach>
   </c:otherwise>
  </c:choose>   
         <tr  class="no-hover">
             <td colspan=8 class="fixed">
                    <c:forEach   var="page" begin="1" end="10" step="1" >
               <c:if test="${section >1 && page==1 }">
                <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; &nbsp;</a>
               </c:if>
                <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
               <c:if test="${page ==10 }">
                <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp; next</a>
               </c:if> 
               </c:forEach> 
           </td>
        </tr>           
      </tbody>
   </table>
  </form>      
 <br>
 <br>
</div>
</body>
</html>