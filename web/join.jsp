<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script language="JavaScript" src="members.js"></script>
	<style>
		p, h1, form, button{border:0; margin:0; padding:0;}
		.spacer{clear:both; height:1px;}

		.myform{
			margin:10px;
			width:400px;
			padding:14px;
		}

		#stylized{
			border:solid 2px #b7ddf2;
			background:#ebf4fb;
		}
		#stylized h1 {
			font-size:16px;
			font-weight:bold;
			margin-bottom:8px;
			font-family:nanumgothic,dotum;

		}
		#stylized p{
			font-size:11px;
			color:#666666;
			margin-bottom:20px;
			border-bottom:solid 1px #b7ddf2;
			padding-bottom:10px;
			font-family:dotum;
		}
		#stylized label{
			display:block;
			font-weight:bold;
			text-align:right;
			width:140px;
			float:left;
			font-family:tahoma;
		}
		#stylized .small{
			color:#666666;
			display:block;
			font-size:11px;
			font-weight:normal;
			text-align:right;
			width:140px;
			font-family:dotum;
			letter-spacing:-1px;
		}
		#stylized input{
			float:left;
			font-size:12px;
			padding:4px 2px;
			border:solid 1px #aacfe4;
			width:200px;
			margin:2px 0 20px 10px;
		}
		#stylized .joinBtn{
			clear:both;
			margin-left:150px;
			width:125px;
			height:31px;
			text-align:center;
			line-height:31px;
			background-color:#000;
			color:#FFFFFF;
			font-size:11px;
			font-weight:bold;
			font-family:tahoma;
		}
	</style>
</head>
<body>
<form action="joinOk.mo" method="post" name="reg_frm">
	아이디 : <input type="text" name="id" size="20"><br>
	비밀번호 : <input type="password" name="pw" size="20"><br>
	비밀번호 확인 : <input type="password" name="pw_check" size="20"><br>
	이름 : <input type="text" name="name" size="20"><br>
	메일 : <input type="text" name="eMail" size="20"><br>
	주소 : <input type="text" name="address" size="50"><br><p>
	<input type="button" value="회원가입" onclick="infoConfirm()">&nbsp;&nbsp;&nbsp;
	<input type="reset" value="로그인" onclick="javascript:window.location='login.jsp'">
</form>


<%--<div id="stylized" class="myform">--%>
<%--	<form name="ref_frm" method="post" action="joinOk.mo">--%>
<%--		<h1>글쓰기 폼</h1>--%>
<%--		<p>기본적인 입력폼입니다.</p>--%>

<%--		<label>ID--%>
<%--			<span class="small">아이디 입력</span>--%>
<%--		</label>--%>
<%--		<input type="text" name="id" id="id" />--%>

<%--		<label>PassWord--%>
<%--			<span class="small">비밀번호</span>--%>
<%--		</label>--%>
<%--		<input type="password" name="pw"/>--%>

<%--		<label>PassWord--%>
<%--			<span class="small">비밀번호 확인</span>--%>
<%--		</label>--%>
<%--		<input type="text" name="pw_check"/>--%>

<%--		<label>Name--%>
<%--			<span class="small">이름 입력</span>--%>
<%--		</label>--%>
<%--		<input type="text" name="name"/>--%>

<%--		<label>EMAIL--%>
<%--			<span class="small">이메일 주소</span>--%>
<%--		</label>--%>
<%--		<input type="text" name="eMail"/>--%>

<%--		<label>Address--%>
<%--			<span class="small">주소 입력</span>--%>
<%--		</label>--%>
<%--		<input type="text" name="address"/>--%>

<%--		<input type="button" value="회원가입" class="joinBtn" onclick="infoConfirm()"/>--%>
<%--		<input type="reset" value="로그인" class="joinBtn" onclick="javascript:window.location='login.jsp'"/>--%>
<%--		<div class="spacer"></div>--%>

<%--	</form>--%>
<%--</div>--%>
</body>
</html>