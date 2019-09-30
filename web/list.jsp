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
            } else {
                bname = "자유게시판";
            }
        }
    %>
    <legend><%=bname%>
    </legend>
    <table class="table table-hover" width="500" cellpadding="0" cellsapcing="0" border="1">
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">작성자</th>
            <th scope="col">제목</th>
            <th scope="col">날짜</th>
            <th scope="col">히트</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="dto">
            <tr>
                <th scope="row">${ dto.bId }</th>
                <td>${ dto.bName }</td>
                <td>
                    <c:forEach begin="1" end="${ dto.bIndent }">-</c:forEach>

                    <a class="loginCheck" href="content_view.bo?bId=${ dto.bId }">${ dto.bTitle }</a></td>
                <script>
                </script>
                <td>${ dto.bDate }</td>
                <td>${ dto.bHit }</td>
            </tr>
        </c:forEach>
        <tr>
            <%
                if (bgno.equals("2")) { %>
            <td colspan="5"><a class="loginCheck" href="write_view.bo?bgno=2">글작성</a></td>
            <%} else {%>
            <td colspan="5"><a class="loginCheck" href="write_view.bo">글작성</a></td>
            <%}%>
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
</fieldset>