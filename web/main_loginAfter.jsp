<%--
  Created by IntelliJ IDEA.
  User: kosmo_15
  Date: 2019-09-24
  Time: 오전 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //    }
    String name = (String) session.getAttribute("name");
    String id = (String) session.getAttribute("id");
%>
<style>
    .section_login {
        padding: 5px 20px;
    }
    .lg_btm h1 {
        font-size: 20px;
        font-weight: bold;
    }
    .lg_links input {
        float: right;
        background-color: white;
    }
    #frm_logout {
        padding: 0 10px;
    }
</style>
    <style>
        .section_login {
            padding: 5px 20px;
        }

        .lg_btm h1 {
            font-size: 20px;
            font-weight: bold;
        }
        .lg_links input {
            float: right;
            background-color: white;
        }
        #frm_logout {
            padding: 0 10px;
        }
    </style>
</head>
<body>
<div class="section_login">
    <div class="lg_btm">
        <h1><%=name%>님 안녕하세요.</h1><br>
    </div>
    <div class="lg_links">
        <form action="logout.mo" method="post">
            <input type="submit" value="로그아웃" id="frm_logout">&nbsp;&nbsp;
                <input type="button" value="정보수정"
                onclick="javascript:window.location='modify.jsp'">
        </form>
    </div>

    <%--	<h1><%=name%>님 안녕하세요.--%>
    <%--	</h1>--%>
    <%--	<br>--%>
    <%--	<form action="logout.do" method="post">--%>
    <%--		<input type="submit" value="로그아웃">&nbsp;&nbsp;&nbsp; <input--%>
    <%--			type="button" value="정보수정"--%>
    <%--			onclick="javascript:window.location='modify.jsp'">--%>
</div>
