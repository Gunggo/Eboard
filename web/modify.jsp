<%@ page import="com.study.jsp.dto.MDto" %>
<%@ page import="com.study.jsp.dao.MDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String id = (String)session.getAttribute("id");
	MDao dao = new MDao();
	MDto dto = dao.getMember(id);
%>
<script>
	var inputstring = prompt("비밀번호를 입력하세요.");
	if (inputstring != <%=dto.getPw()%>) {
		alert("비밀번호를 확인하세요.");
		<jsp:forward page="list.bo"></jsp:forward>
	}
</script>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>

	<script language="JavaScript" src="members.js"></script>
</head>
<body>
<form action="modifyOk.mo" method="post" name="reg_frm">
	아이디 : <%= dto.getId() %><br>
	비밀번호 : <input type="password" name = "pw" size="20"><br>
	비밀번호 확인: <input type="password" name = "pw_check" size="20"><br>
	이름 : <%= dto.getName() %><br>
	메일 : <input type="text" name = "eMail" size="20" value="<%= dto.geteMail() %>"/><br>
	주소 : <input type="text" name = "address" size="50" value="<%= dto.getAddress()%>"/><br>
	<input type="button" value="수정" onclick="updateInfoConfirm()"/>&nbsp;&nbsp;&nbsp;
	<input type="reset" value="취소" onclick="javascript:window.location='index.jsp'"/>
	<input type="button" value="회원탈퇴" onclick="delUser(<%=dto.getId()%>)"/>
</form>
<script>
	function delUser(id) {
		location.replace("deluser.mo?id=" + id);
		alert("삭제되었습니다.");
	}
</script>
</body>
</html>