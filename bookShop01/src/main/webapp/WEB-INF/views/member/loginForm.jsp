<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>회원 로그인 창</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        .input-form {
            max-width: 680px;
            margin-top: 80px;
            padding: 32px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
        }
    </style>
    <c:if test="${not empty message}">
        <script>
            window.onload = function () {
                result();
            }

            function result() {
                alert("아이디나 비밀번호가 틀립니다. 다시 로그인해주세요");
            }
        </script>
    </c:if>
</head>
<body>
<div class="container" style="margin-left:80px">
    <div class="input-form">
        <h3 class="mb-4" style="font-size:30px; color:#660033">로그인</h3>
        <form action="${contextPath}/member/login.do" method="post">
            <div class="form-group row">
                <label for="member_id" class="col-sm-2 col-form-label" >아이디</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="member_id" name="member_id" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="member_pw" class="col-sm-2 col-form-label">비밀번호</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="member_pw" name="member_pw" required>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-10 offset-sm-2">
                    <button type="submit" class="btn btn-primary" style="background:#1b7340; border-style:hidden">로그인</button>
                    <input type="reset" class="btn btn-secondary" style="border-style:hidden" value="초기화"></button>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-10 offset-sm-2">
                    <a href="#">아이디 찾기</a> |
                    <a href="#">비밀번호 찾기</a> |
                    <a href="${contextPath}/member/memberForm.do">회원가입</a> |
                    <a href="#">고객 센터</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>