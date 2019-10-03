<%--
  Created by IntelliJ IDEA.
  User: kosmo_15
  Date: 2019-09-24
  Time: 오전 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<title>Title</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<style>
    .nav_con {
        border-bottom: 1px solid #d1d8e4;
        background-color: #f8f9fa;
    }

    /*.container {*/
    /*    width: 1100px;*/
    /*    height: 100px;*/
    /*    margin: 0 185px;*/
    /*    padding: 0 16px;*/
    /*}*/
</style>
</head>
<body>
<div class="nav_con">
    <ul class="nav">
        <li class="nav-item">
            <a class="nav-link active" href="#">Active</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="list.bo?bgno=1">자유게시판</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="list.bo?bgno=2">자료게시판</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="list.bo?bgno=3">공지게시판</a>
        </li>
        <c:set var="adminCheck" value="${id}"/>
        <c:if test="${adminCheck == 'master'}">
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="javascript:window.location='admin.jsp'">관리자</a>
            </li>
        </c:if>
    </ul>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
