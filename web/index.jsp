<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="default.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <style>
        @media (min-width: 768px) {
            .container {
                width: 750px;
            }
        }

        @media (min-width: 992px) {
            .container {
                width: 940px;
            }
        }

        @media (min-width: 1200px) {
            .container {
                width: 940px;
            }
        }

        .container {
            width: 1100px;
            height: 750px;
            margin: 0 185px;
            padding: 0 16px;
        }

        .container_right {
            margin-top: 60px;
            float: right;
            width: 330px;
            text-align: center;
            border: 1px solid;
        }

        .container_left {
            float: left;
            margin-top: 20px;
            width: 700px;
        }

        .footer {
        }

        @media (min-width: 768px) {
            .footer {
                width: 750px;
            }
        }

        @media (min-width: 992px) {
            .footer {
                width: 940px;
            }
        }

        @media (min-width: 1200px) {
            .footer {
                width: 940px;
            }
        }
    </style>
</head>
<body>
<%if (request.getAttribute("list") == null) {%>
<script>
    location.href = "list.bo";
</script>
<% } %>

<div class="wrap">
    <div class="header">
        <%@include file="header.jsp" %>
    </div>
    <div class="container">
        <div class="container_left">
            <%@include file="list.jsp" %>

            <div class="searchForm">
                <%--                <form action="search.bo">--%>
                <%--                    <select name="search" class="form-control">--%>
                <%--                        <option value="0">제목</option>--%>
                <%--                        <option value="1">내용</option>--%>
                <%--                        <option value="2">작성자</option>--%>
                <%--                        <option value="3">제목 + 내용</option>--%>
                <%--                    </select>--%>
                <%--                    <input type="text" name="keyWord" class="form-control">--%>
                <%--                    <input type="hidden" name="page" value="${page.curPage}">--%>
                <%--                    <input type="submit" value="검색">--%>
                <%--                </form>--%>
                <form action="search.bo">
                    <div class="form-group row justify-content-center">
                        <div class="w100" style="padding-right:10px">
                            <select class="form-control form-control-sm" name="search" id="searchType">
                                <option value="0">제목</option>
                                <option value="1">내용</option>
                                <option value="2">작성자</option>
                                <option value="3">제목 + 내용</option>
                            </select>
                        </div>
                        <div class="w300" style="padding-right:10px">
                            <input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
                            <input type="hidden" name="page" value="${page.curPage}">
                        </div>
                        <div>
                            <button type="submit" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색
                            </button>
                        </div>
                    </div>
                </form>
            </div>

        </div>


        <div class="container_right">
            <% if (session.getAttribute("name") == null) {%>
            <%@include file="main_login.jsp" %>
            <% } else {%>
            <%@include file="main_loginAfter.jsp" %>
            <%}%>
        </div>
    </div>
    <div class="footer">
    </div>
</div>

<script>
    $('.loginCheck').click(function () {
        <% if (session.getAttribute("ValidMem") == null) {%>
        alert("로그인 후 이용하세요.")
        return false;
        <%} %>
    });
</script>


<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
</body>
</html>