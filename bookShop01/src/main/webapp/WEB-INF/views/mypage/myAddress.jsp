<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

						// ���θ� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
						// �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
						var fullRoadAddr = data.roadAddress; // ���θ� �ּ� ����
						var extraRoadAddr = ''; // ���θ� ������ �ּ� ����

						// ���������� ���� ��� �߰��Ѵ�. (�������� ����)
						// �������� ��� ������ ���ڰ� "��/��/��"�� ������.
						if (data.bname !== '' && /[��|��|��]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// ���θ�, ���� ������ �ּҰ� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// ���θ�, ���� �ּ��� ������ ���� �ش� ������ �ּҸ� �߰��Ѵ�.
						if (fullRoadAddr !== '') {
							fullRoadAddr += extraRoadAddr;
						}

						// �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
						document.getElementById('zipcode').value = data.zonecode; //5�ڸ� �������ȣ ���
						document.getElementById('roadAddress').value = fullRoadAddr;
						document.getElementById('jibunAddress').value = data.jibunAddress;

						// ����ڰ� '���� ����'�� Ŭ���� ���, ���� �ּҶ�� ǥ�ø� ���ش�.
						if (data.autoRoadAddress) {
							//����Ǵ� ���θ� �ּҿ� ������ �ּҸ� �߰��Ѵ�.
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							document.getElementById('guide').innerHTML = '(���� ���θ� �ּ� : '
									+ expRoadAddr + ')';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							document.getElementById('guide').innerHTML = '(���� ���� �ּ� : '
									+ expJibunAddr + ')';

						} else {
							document.getElementById('guide').innerHTML = '';
						}
					}
				}).open();
	}
	
	function fn_modify_member_info(attribute){
		var value;
		// alert(member_id);
		// alert("mod_type:"+mod_type);
			var frm_mod_member=document.frm_mod_member;
			if(attribute=='address'){
				var zipcode=frm_mod_member.zipcode;
				var roadAddress=frm_mod_member.roadAddress;
				var jibunAddress=frm_mod_member.jibunAddress;
				var namujiAddress=frm_mod_member.namujiAddress;
				
				value_zipcode=zipcode.value;
				value_roadAddress=roadAddress.value;
				value_jibunAddress=jibunAddress.value;
				value_namujiAddress=namujiAddress.value;
				value=value_zipcode+","+value_roadAddress+","+value_jibunAddress+","+value_namujiAddress;
			}
			console.log(attribute);
		 	
			var data = {
			        attribute: 'multiple_attributes',  // ���� �Ӽ��� �����ϴ� ��û���� ��Ÿ���� ��

			        value_zipcode: value_zipcode,
			        value_roadAddress: value_roadAddress,
			        value_jibunAddress: value_jibunAddress,
			        value_namujiAddress: value_namujiAddress,
			    };
			
			$.ajax({
				type : "post",
				async : false, //false�� ��� ��������� ó���Ѵ�.
				url : "${contextPath}/mypage/myAdddress.do",
				data : data,
				success : function(data, textStatus) {
					if(data.trim()=='mod_success'){
						alert("ȸ�� ������ �����߽��ϴ�.");
					}else if(data.trim()=='failed'){
						alert("�ٽ� �õ��� �ּ���.");	
					}
					
				},
				error : function(data, textStatus) {
					alert("������ �߻��߽��ϴ�."+data);
				},
				complete : function(data, textStatus) {
					//alert("�۾����Ϸ� �߽��ϴ�");
					
				}
			}); //end ajax
	}
</script>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th scope="cols">�⺻ �����</th>
			</tr>
		</thead>
		<tbody>
			<tr class="dot_line">
				<td class="fixed_join">�ּ�</td>
				<td><input type="text" id="zipcode" name="zipcode" size=5
					value="${memberInfo.zipcode }" disabled> <a
					href="javascript:execDaumPostcode()">�����ȣ�˻�</a> <br>
					<p>
						���� �ּ�:<br> <input type="text" id="roadAddress"
							name="roadAddress" size="50" value="${memberInfo.roadAddress }"
							disabled><br> <br> ���θ� �ּ�: <input type="text"
							id="jibunAddress" name="jibunAddress" size="50"
							value="${memberInfo.jibunAddress }" disabled><br> <br>
						������ �ּ�: <input type="text" name="namujiAddress" size="50"
							value="${memberInfo.namujiAddress }" />
					</p></td>
				<td><input type="button" value="�����ϱ�"
					onClick="fn_modify_member_info('address')" /></td>
			</tr>
		</tbody>
	</table>
</body>
</html>