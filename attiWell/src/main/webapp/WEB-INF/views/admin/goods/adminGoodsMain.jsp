<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <!-- 부트스트랩 4.3.1 적용   -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        
        
      <!-- style 파트 -->    
        
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

        a {
            color: grey; /* 또는 원하는 색상으로 변경 */
        }

        .h2 {
            font-size: 24px; /* Increase the font size to your desired value */
            font-weight: bold; /* 굴게 만들기 */
        }

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
    </style>

    <!--스크립트 파트  -->
    <script>
        function search_goods_list(fixeSearchPeriod) {
            var formObj = document.createElement("form");
            var i_fixedSearch_period = document.createElement("input");
            i_fixedSearch_period.name = "fixedSearchPeriod";
            i_fixedSearch_period.value = fixeSearchPeriod;
            formObj.appendChild(i_fixedSearch_period);
            document.body.appendChild(formObj);
            formObj.method = "get";
            formObj.action = "${contextPath}/admin/goods/adminGoodsMain.do";
            formObj.submit();
        }

        function calcPeriod(search_period) {
            var dt = new Date();
            var beginYear, endYear;
            var beginMonth, endMonth;
            var beginDay, endDay;
            var beginDate, endDate;

            endYear = dt.getFullYear();
            endMonth = dt.getMonth() + 1;
            endDay = dt.getDate();
            if (search_period == 'today') {
                beginYear = endYear;
                beginMonth = endMonth;
                beginDay = endDay;
            } else if (search_period == 'one_week') {
                beginYear = dt.getFullYear();
                beginMonth = dt.getMonth() + 1;
                dt.setDate(endDay - 7);
                beginDay = dt.getDate();

            } else if (search_period == 'two_week') {
                beginYear = dt.getFullYear();
                beginMonth = dt.getMonth() + 1;
                dt.setDate(endDay - 14);
                beginDay = dt.getDate();
            } else if (search_period == 'one_month') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 1);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            } else if (search_period == 'two_month') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 2);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            } else if (search_period == 'three_month') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 3);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            } else if (search_period == 'six_month') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 6);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            }

            if (beginMonth < 10) {
                beginMonth = '0' + beginMonth;
                if (beginDay < 10) {
                    beginDay = '0' + beginDay;
                }
            }
            if (endMonth < 10) {
                endMonth = '0' + endMonth;
                if (endDay < 10) {
                    endDay = '0' + endDay;
                }
            }
            endDate = endYear + '-' + endMonth + '-' + endDay;
            beginDate = beginYear + '-' + beginMonth + '-' + beginDay;
            // alert(beginDate+","+endDate);
            return beginDate + "," + endDate;
        }

    </script>
    <script type="text/javascript">
        var cnt = 0;

        function fn_addFile() {
            if (cnt == 0) {
                $("#d_file").append("<br>" + "<input  type='file' name='main_image' id='f_main_image' />");
            } else {
                $("#d_file").append("<br>" + "<input  type='file' name='detail_image" + cnt + "' />");
            }

            cnt++;
        }

        function fn_add_new_goods(obj) {
            fileName = $('#f_main_image').val();
            if (fileName != null && fileName != undefined) {
                obj.submit();
            } else {
                alert("메인 이미지는 반드시 첨부해야 합니다.");
                return;
            }

        }
    </script>

</head>
<body>
<div class="input-form ">
    <br>
    <br>

    <p class="h2">상품관리</p><br>

    <form method="post">
        <table cellpadding="10" cellspacing="10">
            <tbody>

                <!-- <div class="btn-group" role="group" aria-label="Search Buttons"> -->
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3" onclick="search_goods_list('today')">
                    오늘
                </button>
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3"
                    onclick="search_goods_list('one_month')">
                    최근 1개월
                </button>
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3"
                    onclick="search_goods_list('two_month')">
                    최근 2개월
                </button>
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3"
                    onclick="search_goods_list('three_month')">
                    최근 3개월
                </button>
                <button type="button" class="btn btn-primary btn-sm custom-btn mr-3"
                    onclick="search_goods_list('six_month')">
                    최근 6개월
                </button>
       

            </tbody>
        </table>
        <div class="clear">
        </div>
    </form>

    <br>

    <!-- <table class="list_view"> -->
    <table class="table table-hover center-align">
        <thead>
            <tr style="background:#eee">
                <th>상품번호</th>
                <th>상품이름</th>
                <th>상품가격</th>
                <th>입고일자</th>
            </tr>
        </thead>

        <!-- <tr style="background:#33ff00" >
                <td>상품번호</td>
                <td>상품이름</td>
                <td>상품가격</td>
                <td>입고일자</td>
            </tr> -->
        <tbody align=center>
            <c:choose>
                <c:when test="${empty newGoodsList }">
                    <tr>
                        <td colspan=8 class="fixed">
                            <strong>조회된 상품이 없습니다.</strong>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${newGoodsList }">
                        <tr>
                            <td>
                                <strong>${item.goods_id }</strong>
                            </td>
                            <td>
                                <a
                                    href="${pageContext.request.contextPath}/admin/goods/modifyGoodsForm.do?goods_id=${item.goods_id}">
                                    <strong>${item.goods_title } </strong>
                                </a>
                            </td>
                            <td>
                                <strong>${item.goods_sales_price }</strong>
                            </td>
                            <td>
                                <strong>${item.goods_credate }</strong>
                            </td>

                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <tr  class="no-hover">
                <td colspan=8 class="fixed">
                    <c:forEach var="page" begin="1" end="10" step="1">
                        <c:if test="${section >1 && page==1 }">
                            <a
                                href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; &nbsp;</a>
                        </c:if>
                        <a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page }
                        </a>
                        <c:if test="${page ==10 }">
                            <a
                                href="${contextPath}/admin/goods/adminGooodsMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp;
                                next</a>
                        </c:if>
                    </c:forEach>
                </td>

            </tbody>

        </table>
        <div class="clear"></div>
        <br><br><br>

        <div id="search">
            <form action="${contextPath}/admin/goods/addNewGoodsForm.do">
                <input type="submit" value="상품 등록하기"
                    style="background: #1b7340; border: none; color: white;">
            </form>

        </div>

    </div>
</div>
</body>
</html>