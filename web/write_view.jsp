<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
          integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <meta charset="UTF-8">
    <script>
        $(document).on('click', '#btnSave', function (e) {
            e.preventDefault();
            $("#form").submit();
        });
        $(document).on('click', '#btnList', function (e) {
            e.preventDefault();
            location.href = "${pageContext.request.contextPath}/board/getBoardList";
        });
    </script>
    <style>
        body {
            padding-top: 70px;
            padding-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="header">
    <%@include file="header.jsp" %>
    ;
</div>
<%--<div class="container">--%>
<%--    <table width="500" cellpadding="0" cellspacing="0" border="1">--%>
<%--        <form name="fmField" action="write.bo?bgno=${param.bgno}" method="post" enctype="multipart/form-data"--%>
<%--              onsubmit="return checkForm();">--%>
<%--            <tr>--%>
<%--                <td> 제목</td>--%>
<%--                <td><input type="text" name="bTitle" size="50"></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td> 내용</td>--%>
<%--                <td><textarea name="bContent" rows="10" cols="50" style="resize: none"></textarea></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <c:if test="${param.bgno == 2 }">--%>
<%--                    <td><input type="file" name="filename"></td>--%>
<%--                </c:if>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="2">--%>
<%--                    <input type="submit" value="입력">&nbsp;&nbsp;--%>
<%--                    <a href="list.bo">목록보기</a>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--        </form>--%>
<%--    </table>--%>
<%--</div>--%>
<article>
    <div class="container" role="main">
        <form name="fmField" id="form" role="form" method="post"
              action="write.bo?bgno=${param.bgno}" enctype="multipart/form-data" onsubmit="return checkForm();">
            <div class="mb-3">
                <label for="title">제목</label>
                <input type="text" class="form-control" name="bTitle" id="title" placeholder="제목을 입력해 주세요">
            </div>
            <div class="mb-3">
                <label for="content">내용</label>
                <textarea class="form-control" rows="5" name="bContent" id="content"
                          placeholder="내용을 입력해 주세요"></textarea>

                <div class="mb-3">
                    <tr>
                        <c:if test="${param.bgno == 2 }">
                            <label for="tag">File</label>
                            <td><input type="file" name="filename" id="tag" class="form-control"></td>
                        </c:if>
                    </tr>
                </div>
            </div>
        </form>
        <div>
            <button type="submit" class="btn btn-sm btn-primary" id="btnSave">저장</button>
            <button type="button" class="btn btn-sm btn-primary" onclick="window.location.href='list.bo'">목록</button>
        </div>
    </div>
</article>
<script>
    function checkForm() {
        var bTitle = document.fmField.bTitle.value;
        var bContent = document.fmField.bContent.value;
        if (!bTitle) {
            window.alert("제목을 입력하세요.");
            document.fmField.bTitle.focus();
            return false;
        } else if (!bContent) {
            window.alert("내용을 입력하세요.");
            document.fmField.bContent.focus();
            return false;
        } else {
            return true;
        }
    }
</script>
</body>
</html>