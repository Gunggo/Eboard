<%--
  Created by IntelliJ IDEA.
  User: kosmo_15
  Date: 2019-09-24
  Time: 오전 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <style>
        .section_login {
            padding: 5px 20px;
        }

        .lg_btm .btn {
            width: 100%;
        }
        .lg_links input {
            float: right;
            background-color: white;
        }
    </style>
</head>
<body>
<div class="section_login">
    <div class="lg_btm">
        <button class="btn btn-primary" type="button" onclick="location.href='login.jsp'">로그인</button>
    </div>
    <div class="lg_links">
        <a href="#" class="id_find">아이디</a>
        /
        <a href="#" class="pw_find">비밀번호 찾기</a>
        <input type="button" value="회원가입" onclick="javascript:window.location='join.jsp'">
    </div>
</div>
