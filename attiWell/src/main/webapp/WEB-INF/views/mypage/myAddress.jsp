<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<style>
a {
	color: grey; /* 또는 원하는 색상으로 변경 */
}

.input-form {
	max-width: 1200px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
}
</style>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 도로명 조합형 주소 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
						if (fullRoadAddr !== '') {
							fullRoadAddr += extraRoadAddr;
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('roadAddress').value = fullRoadAddr;
						document.getElementById('jibunAddress').value = data.jibunAddress;

						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							//예상되는 도로명 주소에 조합형 주소를 추가한다.
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';

						} else {
							document.getElementById('guide').innerHTML = '';
						}
					}
				}).open();
	}

	function fn_modify_member_info(attribute) {
		var value;
		// alert(member_id);
		// alert("mod_type:"+mod_type);
		var frm_mod_member = document.frm_mod_member;
		if (attribute == 'address') {
			var zipcode = frm_mod_member.zipcode;
			var roadAddress = frm_mod_member.roadAddress;
			var jibunAddress = frm_mod_member.jibunAddress;
			var namujiAddress = frm_mod_member.namujiAddress;

			value_zipcode = zipcode.value;
			value_roadAddress = roadAddress.value;
			value_jibunAddress = jibunAddress.value;
			value_namujiAddress = namujiAddress.value;
			value = value_zipcode + "," + value_roadAddress + ","
					+ value_jibunAddress + "," + value_namujiAddress;
		}
		console.log(attribute);

		var data = {
			attribute : 'multiple_attributes', // 여러 속성을 수정하는 요청임을 나타내는 값

			value_zipcode : value_zipcode,
			value_roadAddress : value_roadAddress,
			value_jibunAddress : value_jibunAddress,
			value_namujiAddress : value_namujiAddress,
		};

		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/mypage/myAdddress.do",
			data : data,
			success : function(data, textStatus) {
				if (data.trim() == 'mod_success') {
					alert("회원 정보를 수정했습니다.");
				} else if (data.trim() == 'failed') {
					alert("다시 시도해 주세요.");
				}

			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다." + data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");

			}
		}); //end ajax
	}
</script>
</head>
<body>
	<div class="container" style="margin-left: 40px">
		<div class="input-form">
			<table>
				<thead>
					<tr>
						<th scope="cols">기본 배송지</th>
					</tr>
				</thead>
				<tbody>
					<tr class="dot_line">
						<td class="fixed_join">주소</td>
						<td><input type="text" id="zipcode" name="zipcode" size=5
							value="${memberInfo.zipcode }" disabled> <a
							href="javascript:execDaumPostcode()">우편번호검색</a> <br>
							<p>
								지번 주소:<br> <input type="text" id="roadAddress"
									name="roadAddress" size="50" value="${memberInfo.roadAddress }"
									disabled><br> <br> 도로명 주소: <input type="text"
									id="jibunAddress" name="jibunAddress" size="50"
									value="${memberInfo.jibunAddress }" disabled><br>
								<br> 나머지 주소: <input type="text" name="namujiAddress"
									size="50" value="${memberInfo.namujiAddress }" />
							</p></td>
						<td><input type="button" value="수정하기"
							onClick="fn_modify_member_info('address')" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>