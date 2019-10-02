<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<fieldset>
    <%
        String bgno = "1";
        String bname = "자유게시판";
        if (request.getParameter("bgno") != null) {
            bgno = request.getParameter("bgno");
            if (bgno.equals("2")) {
                bname = "자료게시판";
            } else if (bgno.equals("3")) {
                bname = "공지사항";
            } else {
                bname = "자유게시판";
            }
        }
    %>
    <style>
        table {
            /*table-layout: fixed;*/
        }
    </style>
    <legend><%=bname%>
    </legend>
    <div class="tableTop">
        <table class="table table-hover" width="500" cellpadding="0" cellsapcing="0" border="1"
               style="margin-bottom: 0px; background-color: #f9f9f8;">
            <thead>
            <tr>
                <th scope="col" style="width: 55px; padding-left: 11px;">번호</th>
                <th scope="col" style="width: 115px;">작성자</th>
                <th scope="col" style="width: 233px;">제목</th>
                <th scope="col" style="width: 232px;">날짜</th>
                <th scope="col">히트</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${topList}" var="dtot">
                <tr>
                    <th scope="row" style="width: 55px;">${ dtot.bId }</th>
                    <td style="width: 115px;">${ dtot.bName }</td>
                    <td style="width: 233px;">
                        <c:forEach begin="1" end="${ dtot.bIndent }">-</c:forEach>

                        <a class="loginCheck" href="content_view.bo?bId=${ dtot.bId }"><span id="printNew${dtot.bId}"></span>${ dtot.bTitle }<span id="printReply"></span></a></td>
                    <td style="width: 232px;">${ dtot.bDate }</td>
                    <td>${ dtot.bHit }</td>
                </tr>
                <script>
                    var date = "${dtot.bDate}".split(" ");
                    var conDate = date[0];
                    var nowDate = new Date();
                    nowDate = nowDate.getFullYear() + '-' + (nowDate.getMonth() + 1) + '-0' + nowDate.getDate();
                    if (nowDate == conDate) {
                        document.getElementById("printNew${dtot.bId}").innerHTML='<img src="https://t1.daumcdn.net/cfile/tistory/992DB133599974E636"/> '
                    }
                </script>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="tableLow">
        <table class="table table-hover" width="500" cellpadding="0" cellsapcing="0" border="1">
            <thead>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="dto">
                <tr>
                    <th scope="row" style="width: 55px;">${ dto.bId }</th>
                    <td style="width: 115px;">${ dto.bName }</td>
                    <td style="width: 233px;">
                        <c:forEach begin="1" end="${ dto.bIndent }">-</c:forEach>
                        <a class="loginCheck" href="content_view.bo?bId=${ dto.bId }"><span id="printNew${dto.bId}"></span>${ dto.bTitle }<span id="printReply"></span></a></td>
                    <td style="width: 232px;">${ dto.bDate }</td>
                    <td>${ dto.bHit }</td>
                </tr>
                <script>
                    var date = "${dto.bDate}".split(" ");
                    var conDate = date[0];
                    var nowDate = new Date();
                    nowDate = nowDate.getFullYear() + '-' + (nowDate.getMonth() + 1) + '-0' + nowDate.getDate();
                    if (nowDate == conDate) {
                        document.getElementById("printNew${dto.bId}").innerHTML='<img src="https://t1.daumcdn.net/cfile/tistory/992DB133599974E636"/> '
                    }
                </script>
            </c:forEach>
            <tr>
                <c:set var="bgno" value="${bgno}"/>
                <td colspan="5"><a class="loginCheck" href="write_view.bo?bgno=${bgno}">글작성</a></td>
                <%--                    if (bgno.equals("2")) { %>--%>
                <%--                <td colspan="5"><a class="loginCheck" href="write_view.bo?bgno=2">글작성</a></td>--%>
                <%--                <%} else if(bgno.equals("3")){ %>--%>
                <%--                <td colspan="5"><a class="loginCheck" href="write_view.bo?bgno=3">글작성</a></td>--%>
                <%--                <%} else {%>--%>
                <%--                <td colspan="5"><a class="loginCheck" href="write_view.bo?bgno=1">글작성</a></td>--%>
                <%--                <%}%>--%>
            </tr>

            <tr>
                <td colspan="5">
                    <ul class="pagination">
                        <!-- 처음 -->
                        <c:choose>
                            <c:when test="${(page.curPage - 1) < 1}">
                                <li class="page-item"><a class="page-link">First</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="list.bo?page=1">First</a></li>
                            </c:otherwise>
                        </c:choose>
                        <!-- 이전 -->
                        <c:choose>
                            <c:when test="${(page.curPage -1) < 1}">
                                <li class="page-item"><a class="page-link">Previous</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link"
                                                         href="list.bo?page=${page.curPage - 1}">Previous</a>
                                </li>
                            </c:otherwise>
                        </c:choose>

                        <!-- 개별 페이지 -->
                        <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
                            <c:choose>
                                <c:when test="${page.curPage == fEach}">
                                    <li class="page-item active"><a class="page-link">${fEach}<span
                                            class="sr-only">(current)</span></a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link"
                                                             href="list.bo?page=${fEach}">${fEach}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- 다음 -->
                        <c:choose>
                            <c:when test="${(page.curPage -1) > page.totalPage}">
                                <li class="page-item"><a class="page-link">Next</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link"
                                                         href="list.bo?page=${page.curPage + 1}">Next</a></li>
                            </c:otherwise>
                        </c:choose>
                        <!-- 끝 -->
                        <c:choose>
                            <c:when test="${page.curPage == page.totalPage}">
                                <li class="page-item"><a class="page-link">Last</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link"
                                                         href="list.bo?page=${page.totalPage}">Last</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</fieldset>