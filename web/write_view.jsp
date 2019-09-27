<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<table width="500" cellpadding="0" cellspacing="0" border="1">
    <form name="fmField" action="write.bo" method="post" onsubmit="return checkForm();">
        <tr>
            <td> 제목</td>
            <td><input type="text" name="bTitle" size="50"></td>
        </tr>
        <tr>
            <td> 내용</td>
            <td><textarea name="bContent" rows="10"></textarea></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="입력">&nbsp;&nbsp;
                <a href="list.bo">목록보기</a>
            </td>
        </tr>
    </form>
</table>

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