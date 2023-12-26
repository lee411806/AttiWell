<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
   request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
   integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
   crossorigin="anonymous">
<style>
.input-form {
   max-width: 680px;
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
	color: gray;
}
.error {
   color: red;
}
</style>
</head>

<body>
   <div class="container">
      <div class="input-form-backgroud row">
         <div class="input-form col-md-12 mx-auto">
            <h3 class="mb-4" style="font-size: 30px; color: #1b7340">
               회원가입<span style="font-size: 16px; color: red"> ( * 표시는 필수)</span>
            </h3>
            <form action="${contextPath}/member/addMember.do" method="post"
               class="validation-form" novalidate>
               <div class="row">
                  <div class="col-md-9">

                     <label for="username">아이디<span style="color: red">*</span></label>
                     <input type="text" name="member_id" class="form-control"
                        id="member_id" placeholder="아이디를 입력해주세요." maxlength="15"
                        pattern="^[a-zA-Z0-9]{5,15}$" value="" oninput="checkId()"
                        required>
                     <div id="idError" style="font-size: 14px" class="error"></div>
                     <input type="hidden" id="overlappedCheck" name="overlappedCheck"
                        value="N">
                  </div>
                  <div class="col-md-3.md-2">
                     <div>
                        <div style="font-size: 22.5px;">&nbsp;</div>
                     </div>
                     <button class="btn-lg btn-block" type="button" id="btnOverlapped"
                        style="background: #1b7340; border-style: hidden; font-size: 14px; color: white"
                        onClick="fn_overlapped()">중복체크</button>
                  </div>
               </div>
               <hr class="mb-4">

               <!-- 비밀번호 유효성 검사 스크립트 -->
               <div class="row">
                  <div class="col-md-9">
                     <label for="password">패스워드<span style="color: red">
                           *</span></label> <input type="password" name="member_pw" class="form-control"
                        id="password" placeholder="패스워드를 입력해주세요." maxlength="15"
                        pattern="^(?=.*[a-zA-Z])(?=.*\d).{8,}$" value=""
                        oninput="checkPassword()" required>
                     <p id="passwordError" class="error"></p>
                     <label for="confirmPassword">패스워드 확인<span
                        style="color: red"> *</span></label> <input type="password"
                        name="confirmPassword" class="form-control" id="confirmPassword"
                        placeholder="패스워드를 입력해주세요." maxlength="15"
                        pattern="^(?=.*[a-zA-Z])(?=.*\d).{8,}$" value=""
                        oninput="checkPassword()" required>

                     <p id="confirmPasswordError" class="error"></p>
                  </div>
               </div>
               <hr class="mb-4">
               <div class="row">
                  <div class="col-md-4 mb-3">
                     <label for="birthYear">년도<span style="color: red">
                           *</span></label> <select class="form-control" id="birthYear"
                        name="member_birth_y" required>
                        <option value="" disabled selected>년도를 선택하세요</option>
                        <!-- 여기에 년도에 대한 선택지를 추가하세요 -->
                        <!-- 예: <option value="2023">2023</option> -->
                        <c:forEach var="year" begin="1" end="104">
                           <c:choose>
                              <c:when test="년도를 선택해주세요.">
                                 <option value="${ 1920+year}" selected>${ 1920+year}</option>
                              </c:when>
                              <c:otherwise>
                                 <option value="${ 1920+year}">${ 1920+year}</option>
                              </c:otherwise>
                           </c:choose>
                        </c:forEach>
                     </select>
                     <div class="invalid-feedback">년도를 선택해주세요.</div>
                  </div>
                  <div class="col-md-4 mb-3">
                     <label for="birthMonth">월<span style="color: red">
                           *</span></label> <select class="form-control" id="birthMonth"
                        name="member_birth_m" required>
                        <option value="" disabled selected>월을 선택하세요</option>
                        <!-- 여기에 월에 대한 선택지를 추가하세요 -->
                        <!-- 예: <option value="1">1월</option> -->
                        <c:forEach var="month" begin="1" end="12">
                           <c:choose>
                              <c:when test="월을 선택하세요">
                                 <option value="${month }" selected>${month }</option>
                              </c:when>
                              <c:otherwise>
                                 <option value="${month }">${month}</option>
                              </c:otherwise>
                           </c:choose>
                        </c:forEach>
                     </select>
                     <div class="invalid-feedback">월을 선택해주세요.</div>
                  </div>
                  <div class="col-md-4 mb-3">
                     <label for="birthDay">일<span style="color: red"> *</span></label>
                     <select class="form-control" id="birthDay" name="member_birth_d"
                        required>
                        <option value="" disabled selected>일을 선택하세요</option>
                        <!-- 여기에 일에 대한 선택지를 추가하세요 -->
                        <!-- 예: <option value="1">1일</option> -->
                        <c:forEach var="day" begin="1" end="31">
                           <c:choose>
                              <c:when test="일을 선택하세요">
                                 <option value="${day}" selected>${day}</option>
                              </c:when>
                              <c:otherwise>
                                 <option value="${day}">${day}</option>
                              </c:otherwise>
                           </c:choose>
                        </c:forEach>
                     </select>
                     <div class="invalid-feedback">일을 선택해주세요.</div>
                  </div>
               </div>

               <div class="row">
                  <div class="col-md-9">
                     <div class="custom-control custom-radio">
                        <input type="radio" id="solar" name="member_birth_gn"
                           class="custom-control-input" value="2" checked> <label
                           class="custom-control-label" for="solar">양력</label>
                     </div>
                     <div class="custom-control custom-radio">
                        <input type="radio" id="lunar" name="member_birth_gn"
                           class="custom-control-input" value="1"> <label
                           class="custom-control-label" for="lunar">음력</label>
                     </div>
                     <div class="invalid-feedback">음력/양력을 선택해주세요.</div>
                  </div>
               </div>

               <hr class="mb-4">
               <div class="row">
                  <div class="col-md-9">
                     <label for="name">이름<span style="color: red"> *</span></label> <input
                        type="text" name="member_name" class="form-control" id="name"
                        placeholder="이름을 입력해주세요." maxlength="6" pattern="^[가-힣]{2,6}$"
                        value="" required>
                     <div class="invalid-feedback">이름을 입력해주세요.</div>
                  </div>
                  <div class="col-md-3">
                     <label>성별</label>
                     <div class="custom-control custom-radio">
                        <input type="radio" id="male" name="member_gender"
                           class="custom-control-input" value="101" checked> <label
                           class="custom-control-label" for="male">남성</label>
                     </div>
                     <div class="custom-control custom-radio">
                        <input type="radio" id="female" name="member_gender"
                           class="custom-control-input" value="102"> <label
                           class="custom-control-label" for="female">여성</label>
                     </div>
                     <div class="invalid-feedback">성별을 선택해주세요.</div>
                  </div>
               </div>
               <hr class="mb-4">
               <div class="row">
                  <div class="col-md-3 mb-3">
                     <label for="">전화 번호 1<span style="color: red"> *</span></label> <input
                        type="tel" class="form-control" id="tel1" placeholder="010"
                        name="tel1" maxlength="3" pattern="^\d{3}$" required>
                     <div class="invalid-feedback">전화번호를 입력해주세요.</div>

                  </div>
                  <div>
                     <div>&nbsp;</div>
                     <span>&nbsp;_&nbsp;</span>
                  </div>
                  <div class="col-md-4 mb-3">
                     <label for="">&nbsp;</label> <input type="tel"
                        class="form-control" id="tel2" placeholder="1234" name="tel2"
                        maxlength="4" pattern="^\d{3,4}$" required>
                     <div class="invalid-feedback">전화 번호를 입력해주세요.</div>
                  </div>
                  <div>
                     <div>&nbsp;</div>
                     <span>&nbsp;_&nbsp;</span>
                  </div>
                  <div class="col-md-4 mb-3">
                     <label for="">&nbsp;</label> <input type="tel"
                        class="form-control" id="tel3" placeholder="5678" name="tel3"
                        maxlength="4" pattern="^\d{4}$" required>
                     <div class="invalid-feedback">전화번호를 입력해주세요.</div>
                  </div>
               </div>
               <hr class="mb-4">
               <div class="row">
                  <div class="col-md-3 mb-3">
                     <label for="phoneCountryCode">전화 번호 2<span
                        style="color: red"> *</span></label> <input type="tel"
                        class="form-control" id="phoneNumber1" placeholder="010"
                        name="hp1" maxlength="3" pattern="^\d{3}$" required>
                     <div class="invalid-feedback">전화번호를 입력해주세요.</div>
                  </div>
                  <div>
                     <div>&nbsp;</div>
                     <span>&nbsp;_&nbsp;</span>
                  </div>
                  <div class="col-md-4 mb-3">
                     <label for="phoneAreaCode">&nbsp;</label> <input type="tel"
                        class="form-control" id="phoneNumber2" placeholder="1234"
                        name="hp2" maxlength="4" pattern="^\d{3,4}$" required>
                     <div class="invalid-feedback">전화 번호를 입력해주세요.</div>
                  </div>
                  <div>
                     <div>&nbsp;</div>
                     <span>&nbsp;_&nbsp;</span>
                  </div>
                  <div class="col-md-4 mb-3">
                     <label for="phoneNumber">&nbsp;</label> <input type="tel"
                        class="form-control" id="phoneNumber3" placeholder="5678"
                        name="hp3" maxlength="4" pattern="^\d{4}$" required>
                     <div class="invalid-feedback">전화번호를 입력해주세요.</div>
                  </div>
               </div>

               <c:set var="smsStatus"
                  value="${not empty param.smssts_yn ? 'Y' : 'N'}" />
               <input type="checkbox" name="smssts_yn" id="smsCheckbox"
                  <c:if test="${smsStatus eq 'Y'}">checked</c:if>
                  onclick="updateSmsStatus()"> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다. <input
                  type="hidden" name="smssts_yn" id="smsCheckbox"
                  value="${smsStatus}">

               <hr class="mb-4">
               <div class="row">
                  <div class="col-md-6 mb-3">
                     <label for="email">이메일<span style="color: red"> *</span></label>
                     <div class="input-group">
                        <input type="text" class="form-control" id="emailSuffix"
                           name="email1" placeholder="도메인" pattern="/^[\w\.-]" required>
                        <div class="input-group-append">
                           <span class="input-group-text" id="basic-addon2">@</span>
                        </div>
                     </div>
                     <div class="invalid-feedback">도메인을 입력해주세요.</div>
                  </div>
                  <div class="col-md-6 mb-3">
                     <label for="email">&nbsp;</label> <input type="text"
                        class="form-control" id="emailPrefix" placeholder="이메일을 입력하세요."
                        name="email2" pattern="[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$" required>
                     <div class="invalid-feedback">이메일을 입력해주세요.</div>
                  </div>
               </div>

               <c:set var="emailStatus" value="N" />
               <c:if test="${not empty param.emailsts_yn}">
                  <c:set var="emailStatus" value="Y" />
               </c:if>
               <input type="checkbox" name="emailsts_yn" id="emailCheckbox"
                  <c:if test="${emailStatus eq 'Y'}">checked</c:if> /> 쇼핑몰에서 발송하는
               e-mail을 수신합니다. <input type="hidden" name="emailsts_yn"
                  id="emailStatus" value="${emailStatus}">

               <hr class="mb-4">



               <div class="row">
                  <div class="col-md-6 mb-3">
                     <label for="zipcode">우편번호<span style="color: red">
                           *</span></label> <input type="text" class="form-control" id="zipcode"
                        name="zipcode" placeholder="우편번호를 입력하세요." required>
                     <div class="invalid-feedback">우편번호를 입력해주세요.</div>
                  </div>
                  <div class="col-md-6 mb-3">
                     <div>
                        <div style="font-size: 22.5px;">&nbsp;</div>
                     </div>
                     <button type="button" class="btn btn-primary"
                        style="background: #1b7340; border-style: hidden"
                        onclick="openAddressSearch()">주소검색</button>
                  </div>
               </div>

               <div class="row">
                  <div class="col-md-12 mb-3">
                     <label for="jibunAddress">지번 주소<span style="color: red">
                           *</span></label> <input type="text" class="form-control" id="jibunAddress"
                        name="jibunAddress" placeholder="지번 주소를 입력하세요." required>
                     <div class="invalid-feedback">지번 주소를 입력해주세요.</div>
                  </div>
               </div>

               <div class="row">
                  <div class="col-md-12 mb-3">
                     <label for="roadAddress">도로명 주소<span style="color: red">
                           *</span></label> <input type="text" class="form-control" id="roadAddress"
                        name="roadAddress" placeholder="도로명 주소를 입력하세요." required>
                     <div class="invalid-feedback">도로명 주소를 입력해주세요.</div>
                  </div>
               </div>

               <div class="row">
                  <div class="col-md-12">
                     <label for="detailAddress">나머지 주소</label> <input type="text" name="namujiAddress" class="form-control"
                        id="detailAddress" placeholder="상세 주소를 입력하세요.">
                  </div>
               </div>
               <!-- 기존 코드에서 삭제한 부분 -->
               <div>
                  <div style="font-size:12px">&nbsp;</div>
               </div>

               <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" id="agreement"
                     required> <label class="custom-control-label"
                     for="agreement">개인정보 수집 및 이용에 동의합니다.</label>
               </div>
               <div class="mb-4"></div>
               <button class="btn-lg btn-block" type="submit" id="submitBtn"
                  style="background: #1b7340; border-style: hidden; color: white">가입완료</button>
            </form>
         </div>
      </div>
      <footer class="my-3 text-center text-small"> </footer>
   </div>















   <script>
   
   //============= 부트스트랩 폼 유효성검사 ==================
      
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
    
    

        
        
   // ================= ID 중복 체크 정규표현식 정의 ========================
   
        var idRegex = /^[a-zA-Z0-9]{5,15}$/;
        
        
   // 중복 체크 함수 수정
      function fn_overlapped() {
          var _id = $("#member_id").val();

          if (_id == '') {
              alert("ID를 입력하세요");
              return;
          }

          // 입력된 아이디가 정규표현식에 맞는지 검사
          if (!idRegex.test(_id)) {
              alert("아이디는 영문자와 숫자로 이루어지며, 최소 5자 이상, 최대 15자 이하여야 합니다.");
              return;
          }

          // 중복 체크를 위한 AJAX 코드
          $.ajax({
              type: "post",
              async: false,
              url: "${contextPath}/member/overlapped.do",
              dataType: "text",
              data: { id: _id },
              success: function (data, textStatus) {
                  if (data == 'false') {
                      alert("사용할 수 있는 ID입니다.");
                      $('#member_id').val(_id);

                      // 중복 체크 성공 시, 히든 필드에 값을 설정
                      $('#overlappedCheck').val('Y');

                      // 중복 체크 성공 시, 폼 제출 버튼 활성화
                      $('#submitBtn').prop('disabled', false);
                  } else {
                      alert("사용할 수 없는 ID입니다.");

                      // 중복 체크 실패 시, 히든 필드 값을 초기화
                      $('#overlappedCheck').val('N');

                      // 중복 체크 성공 시, 폼 제출 버튼 비활성화
                      $('#submitBtn').prop('disabled', true);
                      
                      // 중복 체크 실패 시, 메시지를 표시
                        $('#idError').text('사용할 수 없는 ID입니다.');
                  }
              },
              error: function (data, textStatus) {
                  alert("에러가 발생했습니다.");
              },
              complete: function (data, textStatus) {
                  //alert("작업을 완료했습니다");
              }
          });
      }

   
      
      
      
      
      
      
      
      
      
      function checkId() {
           var memberId = document.getElementById('member_id').value;
           var idError = document.getElementById('idError');

           if (!idRegex.test(memberId)) {
               idError.textContent = '영문자/숫자 5 ~ 15자로 입력하세요';
           } else {
               idError.textContent = '';
           }
       }

       document.getElementById('member_id').addEventListener('input', checkId);
   
   
   
      // ================= password 실시간 정규표현식 정의 ========================
      
         
      // passwordRegex 정의
       var passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d).{8,}$/;
      
       function checkPassword() {
          var password = document.getElementById('password').value;
          var confirmPassword = document.getElementById('confirmPassword').value;
          var passwordError = document.getElementById('passwordError');
          var confirmPasswordError = document.getElementById('confirmPasswordError');

          // 비밀번호가 8자 이상이어야 함
          if (password.length < 8 || !passwordRegex.test(password)) {
              passwordError.textContent = '비밀번호는 영문자+숫자 포함 8자 이상이어야 합니다.';
          } else {
              passwordError.textContent = '';
          }

          // 비밀번호와 비밀번호 확인이 일치해야 함
          if (password !== confirmPassword) {
              confirmPasswordError.textContent = '비밀번호는 영문자+숫자 포함 8자 이상이어야 합니다.';
          } else {
              confirmPasswordError.textContent = '';
          }
      }

      document.getElementById('signupForm').addEventListener('submit', function (event) {
          // 폼 제출 전에 마지막으로 한 번 더 확인
          checkPassword();

          // 유효성 검사 통과 여부 확인
          var passwordError = document.getElementById('passwordError').textContent;
          var confirmPasswordError = document.getElementById('confirmPasswordError').textContent;
      
          if (passwordError || confirmPasswordError) {
              // 유효성 검사 실패 시 폼 제출 취소
              event.preventDefault();
          }
      });
          
      
      
      
      
      // ================= 조건에 맞지않으면 회원가입 취소  ========================
      
      
      
      
      
      
   // ================= checkBox 체크여부 ========================
    
    function updateSmsStatus() {
        var smsCheckbox = document.getElementById("smsCheckbox");
        var smsStatus = document.getElementById("smsStatus");

        if (smsCheckbox.checked) {
           smsStatus.value = "Y";
        } else {
           smsStatus.value = "N";
        }
     }

     function updateEmailStatus() {
        var emailCheckbox = document.getElementById("emailCheckbox");
        var emailStatus = document.getElementById("emailStatus");

        if (emailCheckbox.checked) {
           emailStatus.value = "Y";
        } else {
           emailStatus.value = "N";
        }
     }
    
    
   
     // ================= 주소 API 호출 함수 ========================
     
     function openAddressSearch() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 선택된 주소를 각 필드에 채우기
                    document.getElementById('zipcode').value = data.zonecode;
                    document.getElementById('jibunAddress').value = data.jibunAddress;
                    document.getElementById('roadAddress').value = data.roadAddress;

                    // (옵션) 나머지 주소 필드에 포커스 주기
                    document.getElementById('detailAddress').focus();
                }
            }).open();
        }
  </script>

</body>

</html>