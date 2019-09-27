<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<% if (session.getAttribute("ValidMem") == null) {%>
<jsp:forward page="index.jsp"></jsp:forward>
<% } %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>Insert title here</title>
    <style>
        .w3-border {
            border: 1px solid black;
        }

        .cmt_btn {
            float: right;
            width: 60px;
        }
    </style>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		  integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<title>Insert title here</title>
</head>
<body>
<div class="header">
    <%@include file="header.jsp" %>
</div>
<div class="container">
    <div class="content">
        <table width="500" cellpadding="0" cellspacing="0" border="1">
            <tr>
                <td> 번호</td>
                <td> ${content_view.bId } </td>
            </tr>
            <tr>
                <td> 히트</td>
                <td> ${content_view.bHit } </td>
            </tr>
            <tr>
                <td> 작성자</td>
                <td> ${content_view.bName } </td>
            </tr>
            <tr>
                <td> 제목</td>
                <td> ${content_view.bTitle } </td>
            </tr>
            <tr>
                <td> 내용</td>
                <td>
                    ${content_view.bContent }
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <a href="modify_view.bo?bId=${content_view.bId }">수정</a>&nbsp;&nbsp;
                    <a href="list.bo?page=<%= session.getAttribute("cpage")%>">목록보기</a>&nbsp;&nbsp;
                    <a href="delete.bo?bId=${content_view.bId }">삭제</a>&nbsp;&nbsp;
                    <a href="reply_view.bo?bId=${content_view.bId }">답변</a>&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" type="text/javascript"></script>
    <div class="w3-border w3-padding">댓글</div>
    <div class="w3-border w3-padding">
        <c:if test="${ id == null }">
            <textarea rows="5" cols="50" class="w3-input w3-border newLogin" readonly>로그인 후 댓글 달기</textarea>
        </c:if>
        <c:if test="${ id != null }">
            <i class="fa fa-user w3-padding-16"></i> ${ id }
            <form>
                <input type="hidden" name="no" id="no" value="${ content_view.bId }">
                <input type="hidden" name="id" id="id" value="${ id }">
                <textarea rows="5" cols="50" class="w3-input w3-border" placeholder="댓글 작성" name="reply_content"
                          id="reply_content"></textarea>
                <input type="button" class="w3-button w3-border reply_btn" id="reply_btn" value="댓글 등록">
            </form>
        </c:if>
    </div>
    <div id="replyList">
    </div>
</div>
<script>
    $("#reply_btn").click(function () {
        if ($("#reply_content").val().trim() === "") {
            alert("댓글을 입력하세요.");
            $("#reply_content").val("").focus();
        } else {
            $.ajax({
                url: "comment.bo",
                type: "POST",
                data: {
                    no: $("#no").val(),
                    id: $("#id").val(),
                    reply_content: $("#reply_content").val()
                },
                success: function () {
                    $("#reply_content").val("");
                    getReply();
                },
            })
        }
    })

    function getReply() {
        $.ajax({
            url: "getReply.bo",
            type: "POST",
            data: {
                bNum: ${ content_view.bId }
            },
            success: function (json) {
                json = json.replace(/\n/gi, "\\r\\n");
                $("#replyList").text("");
                var obj = JSON.parse(json);
                var replyList = obj.replyList;
                var output = "";
                for (var i = 0; i < replyList.length; i++) {
                    output += "<table class='table' id='rep" + replyList[i][3].reply_no + ">";
                    var reply_no = replyList[i][3].reply_no;
                    console.log(reply_no);
                    for (var j = 0; j < replyList[i].length; j++) {
                        var reply = replyList[i][j];
                        if (j === 0) {
                            output += "<tr>";
                            output += "<th>작성자 : " + reply.id + "</th>";
                        } else if (j === 1) {
                            output += "<th colspan='2'>" + reply.reply_date + "</th>";
                            output += '<th><button type="button" value="'+ reply_no +'" class="repDelete">삭제</button>';
                            output += "<input type='button' value='수정' class='repUpdate'></td>";
                            output += "</tr>";
                        } else if (j === 2) {
                            output += "<tr>";
                            output += "<td colspan='3'><pre style='font-size: 20px;'>" + reply.reply_content + "</pre></td>";
                            output += "<td><div class='updateReplyDiv" + replyList[i] + "'></div></td>";
                            output += "</tr>";
                        }
                    }
                    ;
                    output += "</table>";
                }
                $("#replyList").html(output);

                $('.repDelete').on('click', function () {
                    var num = $(this).attr('value');
                    console.log(num);
                    $.ajax({
                        url: "delReply.bo",
                        type: "POST",
                        data: {
                            num: num
                        },
                        success: function () {
                            alert("삭제했습니다.");
                            getReply();
                        },
                        error: function (error) {
                            console.log(error);
                        }

                    });

                });
                $('.repUpdate').on('click', function () {

                    var num = $(this).attr('data_num');
                    var text = $(this).attr('data_text');
                    var index = $(this).attr('data_index');

                    var str = '';
                    console.log(num);
                    console.log(text);
                    console.log(index);

                    str = '<input type="hidden" id ="num"  value="' + num + '">';
                    str += '<input type="text" id ="text2"  value="' + text + '" >';
                    str += '<input type="button" value="수정완료" id="updateComment" > ';

                    $('.updateReplyDiv' + index).html(str);
                    console.log(str);

                    $('#updateComment').on('click', function () {

                        var num = $('#num').val();
                        var text = $('#text2').val();
                        console.log(num);
                        console.log(text);

                        $.ajax({

                            url: "upReply.bo",
                            type: "POST",
                            data: JSON.stringify({
                                num: num,
                                text: text
                            }),
                            success: function () {
                                alert("수정 완료");
                                getReply();
                            },
                            error: function (error) {
                                console.log(error);
                            }

                        });

                    });

                });
            },
            error: function (err) {

                console.log(err);
            }
        });
    }

    getReply();
</script>
</body>
</html>
