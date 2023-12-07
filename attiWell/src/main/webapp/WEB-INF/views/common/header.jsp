<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	var loopSearch = true;
	function keywordSearch() {
		if (loopSearch == false)
			return;
		var value = document.frmSearch.searchWord.value;
		$.ajax({
			type : "get",
			async : true, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/goods/keywordSearch.do",
			data : {
				keyword : value
			},
			success : function(data, textStatus) {
				var jsonInfo = JSON.parse(data);
				displayResult(jsonInfo);
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다." + data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");

			}
		}); //end ajax	
	}

	function displayResult(jsonInfo) {
		var count = jsonInfo.keyword.length;
		if (count > 0) {
			var html = '';
			for ( var i in jsonInfo.keyword) {
				html += "<a href=\"javascript:select('" + jsonInfo.keyword[i]
						+ "')\">" + jsonInfo.keyword[i] + "</a><br/>";
			}
			var listView = document.getElementById("suggestList");
			listView.innerHTML = html;
			show('suggest');
		} else {
			hide('suggest');
		}
	}

	function select(selectedKeyword) {
		document.frmSearch.searchWord.value = selectedKeyword;
		loopSearch = false;
		hide('suggest');
	}

	function show(elementId) {
		var element = document.getElementById(elementId);
		if (element) {
			element.style.display = 'block';
		}
	}

	function hide(elementId) {
		var element = document.getElementById(elementId);
		if (element) {
			element.style.display = 'none';
		}
	}
</script>
<body>

	<div id="head_link">
		<ul>
			<c:choose>
				<c:when test="${isLogOn==true and not empty memberInfo }">
					<li><a href="${contextPath}/member/logout.do">로그아웃</a></li>
					<li><a href="${contextPath}/mypage/myPageMain.do">마이페이지</a></li>
					<li><a href="${contextPath}/cart/myCartList.do">장바구니</a></li>
					<li><a href="#">주문배송</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${contextPath}/member/loginForm.do">로그인</a></li>
					<li><a href="${contextPath}/member/memberForm.do">회원가입</a></li>
				</c:otherwise>
			</c:choose>
			<li><a href="#">고객센터</a></li>
			<c:if test="${isLogOn==true and memberInfo.member_id =='admin' }">
				<li class="no_line"><a
					href="${contextPath}/admin/goods/adminGoodsMain.do">관리자</a></li>
			</c:if>

		</ul>
	</div>
	<br>
	<%-- <div id="search" style="margin:0px 180px 0px 0px">
		<div id="logo" style="margin:0px 0px 20px 200px">
			<a href="${contextPath}/main/main.do"> <img width="200"
				height="90" alt="booktopia"
				src="${contextPath}/resources/image/logo3_v2.png">
			</a>
		</div>
		<form name="frmSearch" action="${contextPath}/goods/searchGoods.do">
			<input name="searchWord" class="main_input" type="text"
				onKeyUp="keywordSearch()"> <input type="submit"
				name="search" class="btn1" value="검 색">
		</form>
	</div> --%>
	
	<div id="search" style="margin: 0px 180px 0px 0px">
      <div id="logo" style="margin: 0px 0px 20px 200px">
         <a href="${contextPath}/main/main.do"> <img width="200"
            height="90" alt="booktopia"
            src="${contextPath}/resources/image/logo3_v2.png">
         </a>
      </div>
      <form name="frmSearch" action="${contextPath}/goods/searchGoods.do" >
         <!-- <input name="searchWord" class="main_input" type="text"
            onKeyUp="keywordSearch()"> <input type="submit"
            name="search" class="btn1" value="검 색"> -->

         <div class="search_11">
            <input name="searchWord" class="main_input"  style="position:relative; font-size:13px;  text-indent: 10px; border-radius: 18px;" type="text"
               onKeyUp="keywordSearch()" placeholder="검색어를 입력해주세요."> 
               <input type="image" class="search_img"
               src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"
               style="border: none; position:absolute; margin: 8px 0px 0px -35px; height:20px">
			</div>
		</form>
		<div id="suggest">
			<div id="suggestList"></div>
		</div>
	</div>
</body>
</html>