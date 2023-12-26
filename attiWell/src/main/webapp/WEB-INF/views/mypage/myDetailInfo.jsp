<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 부트스트랩 4.3.1 적용   -->
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
   integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
   crossorigin="anonymous">

<style>
.fixed_join {
   background-color: #eee;
}

.custom-select {
   width: 200px; /* 필요한 가로 길이로 조정하세요 */
   text-align: center;
}

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
</style>

<style>
.btn-primary:hover {
   background-color: #1b7340; /* 이 부분을 비워두거나 다른 색상으로 지정하세요 */
   color: #ffffff; /* 이 부분을 비워두거나 다른 색상으로 지정하세요 */
   border-color: #1b7340; /* 이 부분을 비워두거나 다른 색상으로 지정하세요 */
}

.btn-primary {
   background-color: #1b7340;
   border: 2px solid #1b7340;
   color: #ffffff;
   padding: 10px 20px;
   text-decoration: none;
   display: inline-block;
   text-align: center;
}

.centered {
   text-align: center;
}

.btn-primary.custom-btn {
   color: #1b7340; /* 텍스트 색을 녹색으로 지정 */
   background-color: #fff; /* 배경 색을 흰색으로 지정 */
   border: 1px solid #1b7340 !important; /* 테두리 색을 #1b7340으로 지정 */
}

/* 테이블 글 씨 중앙정렬 */
.center-align {
   text-align: center;
}

td {
   white-space: nowrap;
}

tr h2 {
   font-size: 15px; /* 예시로 24px로 설정. 원하는 크기로 조절하세요. */
}
</style>



<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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

   window.onload = function() {
      selectBoxInit();
   }

   function selectBoxInit() {

      var tel1 = '${memberInfo.tel1 }';
      var hp1 = '${memberInfo.hp1}';
      var selTel1 = document.getElementById('tel1');
      var selHp1 = document.getElementById('hp1');
      var optionTel1 = selTel1.options;
      var optionHp1 = selHp1.options;
      var val;
      for (var i = 0; i < optionTel1.length; i++) {
         val = optionTel1[i].value;
         if (tel1 == val) {
            optionTel1[i].selected = true;
            break;
         }
      }

      for (var i = 0; i < optionHp1.length; i++) {
         val = optionHp1[i].value;
         if (hp1 == val) {
            optionHp1[i].selected = true;
            break;
         }
      }

   }

   function fn_modify_member_info(attribute) {
      var value;
      // alert(member_id);
      // alert("mod_type:"+mod_type);
      var frm_mod_member = document.frm_mod_member;
      if (attribute == 'member_pw') {
         value = frm_mod_member.member_pw.value;
         //alert("member_pw:"+value);
      } else if (attribute == 'member_gender') {
         var member_gender = frm_mod_member.member_gender;
         for (var i = 0; member_gender.length; i++) {
            if (member_gender[i].checked) {
               value = member_gender[i].value;
               break;
            }
         }

      } else if (attribute == 'member_birth') {
         var member_birth_y = frm_mod_member.member_birth_y;
         var member_birth_m = frm_mod_member.member_birth_m;
         var member_birth_d = frm_mod_member.member_birth_d;
         var member_birth_gn = frm_mod_member.member_birth_gn;

         for (var i = 0; member_birth_y.length; i++) {
            if (member_birth_y[i].selected) {
               value_y = member_birth_y[i].value;
               break;
            }
         }
         for (var i = 0; member_birth_m.length; i++) {
            if (member_birth_m[i].selected) {
               value_m = member_birth_m[i].value;
               break;
            }
         }

         for (var i = 0; member_birth_d.length; i++) {
            if (member_birth_d[i].selected) {
               value_d = member_birth_d[i].value;
               break;
            }
         }

         //alert("수정 년:"+value_y+","+value_m+","+value_d);
         for (var i = 0; member_birth_gn.length; i++) {
            if (member_birth_gn[i].checked) {
               value_gn = member_birth_gn[i].value;
               break;
            }
         }
         //alert("생년 양음년 "+value_gn);
         value = +value_y + "," + value_m + "," + value_d + "," + value_gn;
      } else if (attribute == 'tel') {
         var tel1 = frm_mod_member.tel1;
         var tel2 = frm_mod_member.tel2;
         var tel3 = frm_mod_member.tel3;

         for (var i = 0; tel1.length; i++) {
            if (tel1[i].selected) {
               value_tel1 = tel1[i].value;
               break;
            }
         }
         value_tel2 = tel2.value;
         value_tel3 = tel3.value;
         value = value_tel1 + "," + value_tel2 + "," + value_tel3;
      } else if (attribute == 'hp') {
         var hp1 = frm_mod_member.hp1;
         var hp2 = frm_mod_member.hp2;
         var hp3 = frm_mod_member.hp3;
         var smssts_yn = frm_mod_member.smssts_yn;

         for (var i = 0; hp1.length; i++) {
            if (hp1[i].selected) {
               value_hp1 = hp1[i].value;
               break;
            }
         }
         value_hp2 = hp2.value;
         value_hp3 = hp3.value;
         value_smssts_yn = smssts_yn.checked;
         value = value_hp1 + "," + value_hp2 + "," + value_hp3 + ","
               + value_smssts_yn;
      } else if (attribute == 'email') {
         var email1 = frm_mod_member.email1;
         var email2 = frm_mod_member.email2;
         var emailsts_yn = frm_mod_member.emailsts_yn;

         value_email1 = email1.value;
         value_email2 = email2.value;
         value_emailsts_yn = emailsts_yn.checked;
         value = value_email1 + "," + value_email2 + "," + value_emailsts_yn;
         //alert(value);
      } else if (attribute == 'address') {
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

      $.ajax({
         type : "post",
         async : false, //false인 경우 동기식으로 처리한다.
         url : "${contextPath}/mypage/modifyMyInfo.do",
         data : {
            attribute : attribute,
            value : value,
         },
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

   function goBack() {
      window.location.href = "${contextPath}/mypage/myDetailInfoDisabled.do";
   }
   
   function updateEmail2(select) {
        var email2Input = document.getElementById('email2');
        var selectedValue = select.value;
        
        if (selectedValue === 'non') {
            email2Input.value = ''; // 선택 "직접입력"인 경우, 빈 값으로 설정
            email2Input.disabled = false; // 활성화
        } else {
            email2Input.value = selectedValue;
            email2Input.disabled = true; // 비활성화
        }
    }
   
</script>
</head>

<body>
   <div class="input-form ">
      <!-- <h3>내 상세 정보</h3> -->
      <p class="h2">내 상세 정보</p>
      <br>
      <form name="frm_mod_member">
         <div>
            <table class="table">
               <tbody>
                  <tr>
                     <td class="fixed_join">아이디</td>
                     <td><input name="member_id" type="text" size="20"
                        value="${memberInfo.member_id }" disabled /></td>
                     <td><input type="button" class="btn btn-secondary"
                        value="수정하기" disabled
                        onClick="fn_modify_member_info('${memberInfo.member_id }','member_name')" />
                     </td>
                  </tr>
                  <tr>
                     <td class="fixed_join">비밀번호</td>
                     <td><input name="member_pw" type="password" size="20"
                        value="${memberInfo.member_pw }" /></td>
                     <td><input type="button" class="btn btn-secondary"
                        value="수정하기" onClick="fn_modify_member_info('member_pw')" /></td>
                  </tr>
                  <tr class="dot_line">
                     <td class="fixed_join">이름</td>
                     <td><input name="member_name" type="text" size="20"
                        value="${memberInfo.member_name.substring(0, 1)}*${memberInfo.member_name.substring(2)}"
                        disabled /></td>
                     <td><input type="button" class="btn btn-secondary"
                        value="수정하기" disabled
                        onClick="fn_modify_member_info('${memberInfo.member_id }','member_name')" />
                     </td>
                  </tr>
                  <tr>
                     <td class="fixed_join">성별</td>
                     <td><c:choose>
                           <c:when test="${memberInfo.member_gender =='101' }">
                              <input type="radio" name="member_gender" value="102" />
                    여성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="radio" name="member_gender" value="101"
                                 checked />남성
                   </c:when>
                           <c:otherwise>
                              <input type="radio" name="member_gender" value="102" checked />
                     여성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <input type="radio" name="member_gender"
                                 value="101" />남성
                  </c:otherwise>
                        </c:choose></td>
                     <td><input type="button" class="btn btn-secondary"
                        value="수정하기" onClick="fn_modify_member_info('member_gender')" />
                     </td>
                  </tr>
                  <tr>
                     <td class="fixed_join">법정생년월일</td>
                     <td><select name="member_birth_y">
                           <c:forEach var="i" begin="1" end="100">
                              <c:choose>
                                 <c:when test="${memberInfo.member_birth_y==1920+i }">
                                    <option value="${ 1920+i}" selected>${ 1920+i}</option>
                                 </c:when>
                                 <c:otherwise>
                                    <option value="${ 1920+i}">${ 1920+i}</option>
                                 </c:otherwise>
                              </c:choose>
                           </c:forEach>
                     </select>년 <select name="member_birth_m">
                           <c:forEach var="i" begin="1" end="12">
                              <c:choose>
                                 <c:when test="${memberInfo.member_birth_m==i }">
                                    <option value="${i }" selected>${i }</option>
                                 </c:when>
                                 <c:otherwise>
                                    <option value="${i }">${i }</option>
                                 </c:otherwise>
                              </c:choose>
                           </c:forEach>
                     </select>월 <select name="member_birth_d">
                           <c:forEach var="i" begin="1" end="31">
                              <c:choose>
                                 <c:when test="${memberInfo.member_birth_d==i }">
                                    <option value="${i }" selected>${i }</option>
                                 </c:when>
                                 <c:otherwise>
                                    <option value="${i }">${i }</option>
                                 </c:otherwise>
                              </c:choose>
                           </c:forEach>
                     </select>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <c:choose>
                           <c:when test="${memberInfo.member_birth_gn=='2' }">
                              <input type="radio" name="member_birth_gn" value="2" checked />양력
                  &nbsp;&nbsp;&nbsp; 
                  <input type="radio" name="member_birth_gn" value="1" />음력
                  </c:when>
                           <c:otherwise>
                              <input type="radio" name="member_birth_gn" value="2" />양력
                     &nbsp;&nbsp;&nbsp; 
                  <input type="radio" name="member_birth_gn" value="1"
                                 checked />음력
                  </c:otherwise>
                        </c:choose></td>
                     <td><input type="button" class="btn btn-secondary"
                        value="수정하기" onClick="fn_modify_member_info('member_birth')" />
                     </td>
                  </tr>
                  <tr>
                     <td class="fixed_join">전화번호</td>
                     <td><select name="tel1">
                           <c:choose>
                              <c:when test="${memberInfo.tel1 eq '02'}">
                                 <option value="02" selected>02</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '031'}">
                                 <option value="031" selected>031</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '032'}">
                                 <option value="032" selected>032</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '033'}">
                                 <option value="033" selected>033</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '041'}">
                                 <option value="041" selected>041</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '042'}">
                                 <option value="042" selected>042</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '043'}">
                                 <option value="043" selected>043</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '044'}">
                                 <option value="044" selected>044</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '051'}">
                                 <option value="051" selected>051</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '052'}">
                                 <option value="052" selected>052</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '053'}">
                                 <option value="053" selected>053</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '054'}">
                                 <option value="054" selected>054</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '055'}">
                                 <option value="055" selected>055</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '061'}">
                                 <option value="061" selected>061</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '062'}">
                                 <option value="062" selected>062</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '063'}">
                                 <option value="063" selected>063</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '064'}">
                                 <option value="064" selected>064</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '0502'}">
                                 <option value="0502" selected>0502</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '0503'}">
                                 <option value="0503" selected>0503</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '0505'}">
                                 <option value="0505" selected>0505</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '0506'}">
                                 <option value="0506" selected>0506</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '0507'}">
                                 <option value="0507" selected>0507</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '0508'}">
                                 <option value="0508" selected>0508</option>
                              </c:when>
                              <c:when test="${memberInfo.tel1 eq '070'}">
                                 <option value="070" selected>070</option>
                              </c:when>
                           </c:choose>
                           <option value="02">02</option>
                           <option value="031">031</option>
                           <option value="032">032</option>
                           <option value="033">033</option>
                           <option value="041">041</option>
                           <option value="042">042</option>
                           <option value="043">043</option>
                           <option value="044">044</option>
                           <option value="051">051</option>
                           <option value="052">052</option>
                           <option value="053">053</option>
                           <option value="054">054</option>
                           <option value="055">055</option>
                           <option value="061">061</option>
                           <option value="062">062</option>
                           <option value="063">063</option>
                           <option value="064">064</option>
                           <option value="0502">0502</option>
                           <option value="0503">0503</option>
                           <option value="0505">0505</option>
                           <option value="0506">0506</option>
                           <option value="0507">0507</option>
                           <option value="0508">0508</option>
                           <option value="070">070</option>
                     </select> - <input type="text" size=4 name="tel2"
                        value="${memberInfo.tel2 }"> - <input type="text" size=4
                        name="tel3" value="${memberInfo.tel3 }"></td>
                     <td><input type="button" class="btn btn-secondary"
                        value="수정하기" onClick="fn_modify_member_info('tel')" /></td>
                  </tr>
                  <tr>
                     <td class="fixed_join">휴대폰번호</td>
                     <td><select name="hp1">
                           <c:choose>
                              <c:when test="${memberInfo.hp1 eq '010'}">
                                 <option value="010" selected>010</option>
                              </c:when>
                              <c:when test="${memberInfo.hp1 eq '011'}">
                                 <option value="011" selected>011</option>
                              </c:when>
                              <c:when test="${memberInfo.hp1 eq '016'}">
                                 <option value="016" selected>016</option>
                              </c:when>
                              <c:when test="${memberInfo.hp1 eq '017'}">
                                 <option value="017" selected>017</option>
                              </c:when>
                              <c:when test="${memberInfo.hp1 eq '018'}">
                                 <option value="018" selected>018</option>
                              </c:when>
                              <c:when test="${memberInfo.hp1 eq '019'}">
                                 <option value="019" selected>019</option>
                              </c:when>
                           </c:choose>
                           <option value="010">010</option>
                           <option value="011">011</option>
                           <option value="016">016</option>
                           <option value="017">017</option>
                           <option value="018">018</option>
                           <option value="019">019</option>
                     </select> - <input type="text" name="hp2" size=4
                        value="${memberInfo.hp2 }"> - <input type="text"
                        name="hp3" size=4 value="${memberInfo.hp3 }"><br> <br>
                        <c:choose>
                           <c:when test="${memberInfo.smssts_yn=='true' }">
                              <input type="checkbox" name="smssts_yn" value="Y" checked /> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
                  </c:when>
                           <c:otherwise>
                              <input type="checkbox" name="smssts_yn" value="N" /> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
                  </c:otherwise>
                        </c:choose></td>
                     <td><input type="button" class="btn btn-secondary"
                        value="수정하기" onClick="fn_modify_member_info('hp')" /></td>
                  </tr>
                  <tr>
                     <td class="fixed_join">이메일(e-mail)</td>
                     <td><input type="text" name="email1" size=10
                        value="${memberInfo.email1 }" /> @ <input type="text" size=10
                        name="email2" value="${memberInfo.email2 }" id="email2"/> <select
                        name="select_email2" onChange="updateEmail2(this)" title="직접입력">
                           <option value="non">직접입력</option>
                           <option value="hanmail.net">hanmail.net</option>
                           <option value="naver.com">naver.com</option>
                           <option value="yahoo.co.kr">yahoo.co.kr</option>
                           <option value="hotmail.com">hotmail.com</option>
                           <option value="paran.com">paran.com</option>
                           <option value="nate.com">nate.com</option>
                           <option value="google.com">google.com</option>
                           <option value="gmail.com">gmail.com</option>
                           <option value="empal.com">empal.com</option>
                           <option value="korea.com">korea.com</option>
                           <option value="freechal.com">freechal.com</option>
                     </select><Br> <br> <c:choose>
                           <c:when test="${memberInfo.emailsts_yn=='true' }">
                              <input type="checkbox" name="emailsts_yn" value="Y" checked /> 쇼핑몰에서 발송하는 e-mail을 수신합니다.
                  </c:when>
                           <c:otherwise>
                              <input type="checkbox" name="emailsts_yn" value="N" /> 쇼핑몰에서 발송하는 e-mail을 수신합니다.
                  </c:otherwise>
                        </c:choose></td>
                     <td><input type="button" class="btn btn-secondary"
                        value="수정하기" onClick="fn_modify_member_info('email')" /></td>
                  </tr>
                  <tr>
                     <td class="fixed_join">주소</td>
                     <td><input type="text" id="zipcode" name="zipcode" size=5
                        value="${memberInfo.zipcode }"> <a
                        href="javascript:execDaumPostcode()">우편번호검색</a> <br>
                        <p>
                           지번 주소:<br> <input type="text" id="roadAddress"
                              name="roadAddress" size="50"
                              value="${memberInfo.roadAddress }"><br> <br>
                           도로명 주소: <input type="text" id="jibunAddress"
                              name="jibunAddress" size="50"
                              value="${memberInfo.jibunAddress }"><br> <br>
                           나머지 주소: <input type="text" name="namujiAddress" size="50"
                              value="${memberInfo.namujiAddress }" /> <span id="guide"
                              style="color: #999"></span>
                        </p></td>
                     <td><input type="button" class="btn btn-secondary"
                        value="수정하기" onClick="fn_modify_member_info('address')" /></td>
                  </tr>
               </tbody>
            </table>
         </div>
         <div class="clear">
            <br> <br>
            <table align=center>
               <tr>
                  <td><input type="hidden" name="command"
                     value="modify_my_info" /> <input name="btn_cancel_member"
                     type="button" class="btn btn-secondary" value="이전으로"
                     onclick="goBack()"></td>
               </tr>
            </table>
         </div>

         <input type="hidden" name="h_tel1" value="${memberInfo.tel1}" /> <input
            type="hidden" name="h_hp1" value="${memberInfo.hp1}" />
      </form>
   </div>
</body>
</html>