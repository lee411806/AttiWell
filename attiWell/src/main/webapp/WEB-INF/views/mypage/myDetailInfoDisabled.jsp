<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script>
	function goBack() {
		window.location.href = "${contextPath}/mypage/myPageMain.do";
	}

	function goModifyPage() {
		window.location.href = "${contextPath}/mypage/myDetailInfo.do";
	}
</script>
</head>

<body>
	<h3>내 상세 정보</h3>
	<form name="frm_mod_member">
		<div id="detail_table">
			<table>
				<tbody>
					<tr class="dot_line">
						<td class="fixed_join">아이디</td>
						<td><input name="member_id" type="text" size="20"
							value="${memberInfo.member_id }" disabled /></td>
						<td></td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">비밀번호</td>
						<td><input name="member_pw" type="password" size="20"
							value="${memberInfo.member_pw }" disabled /></td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">이름</td>
						<td><input name="member_name" type="text" size="20"
							value="${memberInfo.member_name.substring(0, 1)}*${memberInfo.member_name.substring(2)}"
							disabled /></td>
						<td></td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">성별</td>
						<td><c:choose>
								<c:when test="${memberInfo.member_gender =='101' }">
									<input type="radio" name="member_gender" value="102" />
						  여성 <span style="padding-left: 30px"></span>
									<input type="radio" name="member_gender" value="101" checked
										disabled />남성
					    </c:when>
								<c:otherwise>
									<input type="radio" name="member_gender" value="102" checked
										disabled />
						   여성 <span style="padding-left: 30px"></span>
									<input type="radio" name="member_gender" value="101" disabled />남성
					   </c:otherwise>
							</c:choose></td>

					</tr>
					<tr class="dot_line">
						<td class="fixed_join">법정생년월일</td>
						<td><input name="member_birth_y" type="text"
							value="${memberInfo.member_birth_y}" disabled />년 <input
							name="member_birth_y" type="text"
							value="${memberInfo.member_birth_m}" disabled />월 <input
							name="member_birth_y" type="text"
							value="${memberInfo.member_birth_d}" disabled />일 <c:choose>
								<c:when test="${memberInfo.member_birth_gn=='2' }">
									<input type="radio" name="member_birth_gn" value="2" checked
										disabled />양력
						<span style="padding-left: 20px"></span>
									<input type="radio" name="member_birth_gn" value="1" disabled />음력
						</c:when>
								<c:otherwise>
									<input type="radio" name="member_birth_gn" value="2" disabled />양력
						  <input type="radio" name="member_birth_gn" value="1" checked
										disabled />음력
						</c:otherwise>
							</c:choose></td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">전화번호</td>
						<td><input type="text" size=4 name="tel1"
							value="${memberInfo.tel1 }" disabled /> <input type="text"
							size=4 name="tel2" value="${memberInfo.tel2 }" disabled /> <input
							type="text" size=4 name="tel3" value="${memberInfo.tel3 }"
							disabled /></td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">휴대폰번호</td>
						<td><input type="text" name="hp1" size=4
							value="${memberInfo.hp1 }" disabled /> <input type="text"
							name="hp2" size=4 value="${memberInfo.hp2 }" disabled /> <input
							type="text" name="hp3" size=4 value="${memberInfo.hp3 }" disabled /><br>
							<br> <c:choose>
								<c:when test="${memberInfo.smssts_yn=='true' }">
									<input type="checkbox" name="smssts_yn" value="Y" checked
										disabled /> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
						</c:when>
								<c:otherwise>
									<input type="checkbox" name="smssts_yn" value="N" disabled /> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
						</c:otherwise>
							</c:choose></td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">이메일<br>(e-mail)
						</td>
						<td><input type="text" name="email1" size=10
							value="${memberInfo.email1 }" disabled /> @ <input type="text"
							size=10 name="email2" value="${memberInfo.email2 }" disabled />
							<br> <br> <c:choose>
								<c:when test="${memberInfo.emailsts_yn=='true' }">
									<input type="checkbox" name="emailsts_yn" value="Y" checked
										disabled /> 쇼핑몰에서 발송하는 e-mail을 수신합니다.
						</c:when>
								<c:otherwise>
									<input type="checkbox" name="emailsts_yn" value="N" disabled /> 쇼핑몰에서 발송하는 e-mail을 수신합니다.
						</c:otherwise>
							</c:choose></td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">주소</td>
						<td>우편번호: <input type="text" id="zipcode" name="zipcode"
							size=5 value="${memberInfo.zipcode }" disabled />
							<p>
								지번 주소:<br> <input type="text" id="roadAddress"
									name="roadAddress" size="50" value="${memberInfo.roadAddress }"
									disabled /><br> <br> 도로명 주소: <input type="text"
									id="jibunAddress" name="jibunAddress" size="50"
									value="${memberInfo.jibunAddress }" disabled /><br> <br>
								나머지 주소: <input type="text" name="namujiAddress" size="50"
									value="${memberInfo.namujiAddress }" disabled />
							</p>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear">
			<br> <br>
			<table align=center>
				<tr>
					<button type="button" onclick="goModifyPage()">수정하기</button>
					<button type="button" onclick="goBack()">이전으로</button>

				</tr>
			</table>
		</div>
		<input type="hidden" name="h_tel1" value="${memberInfo.tel1}" /> <input
			type="hidden" name="h_hp1" value="${memberInfo.hp1}" />
	</form>
</body>
</html>
