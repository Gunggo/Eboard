<%--
  Created by IntelliJ IDEA.
  User: kosmo_15
  Date: 2019-10-01
  Time: 오후 12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
            width: 1200px;
            height: 750px;
            margin: 0 185px;
            padding: 0 16px;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="header">
        <%@include file="header.jsp" %>
    </div>
    <div class="container">
        <div class="container_select" style="margin-top: 20px;">
            <div class="btn-group" role="group" aria-label="Basic example" style="margin-bottom: 20px;">
                <button type="button" class="btn btn-secondary allUser" onclick="getResult()">회원조회</button>
                <button type="button" class="btn btn-secondary delCont">게시글 삭제</button>
                <button type="button" class="btn btn-secondary ctnUser">게시왕</button>
                <button type="button" class="btn btn-secondary repUser">댓글왕</button>
            </div>
        </div>
        <div class="selResult">

        </div>
        <div class="serachBox">
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js" type="text/javascript"></script>
<script>
    function getResult(searchType, keyWord) {
        $.ajax({
            url: "checkUser.ao",
            type: "POST",
            data: {
                searchType : searchType,
                keyWord : keyWord
            },
            success: function (json) {
                json = json.replace(/\n/gi, "\\r\\n");
                $(".selResult").text("");
                var obj = JSON.parse(json);
                var userList = obj.userList;
                var output = "";
                output += "<table class='table table-hover' id='userTable'>";
                output += '<tr style="text-align: center;">';
                output += '<th scope="col">아이디</th>';
                output += '<th scope="col">비밀번호</th>';
                output += '<th scope="col">이름</th>';
                output += '<th scope="col">이메일</th>';
                output += '<th scope="col">가입날짜</th>';
                output += '<th scope="col">주소</th>';
                output += '<th scope="col">차단여부</th>';
                output += '<th scope="col"></th>';
                output += '</tr>';
                for (var i = 0; i < userList.length; i++) {
                    for (var j = 0; j < userList[i].length; j++) {
                        var user = userList[i][j];
                        if (j === 0) {
                            output += '<tr style="text-align: center;">'
                            output += '<td>' + user.userId + '</td>';
                        } else if (j == 1) {
                            output += '<td>' + user.userPw + '</td>';
                        } else if (j == 2) {
                            output += '<td>' + user.userName + '</td>';
                        } else if (j == 3) {
                            output += '<td>' + user.userEmail + '</td>';
                        } else if (j == 4) {
                            output += '<td>' + user.userRdate + '</td>';
                        } else if (j == 5) {
                            output += '<td>' + user.userAddress + '</td>';
                        } else if (j == 6) {
                            var userArr = [userList[i][0].userId, user.userBlock];
                            output += '<td>' + user.userBlock + '</td>';
                            if (user.userBlock == 'X') {
                                output += '<td><button type="button" value="' + userArr + '" class="blockUser">차단</button>';
                            } else {
                                output += '<td><button type="button" value="' + userArr + '" class="blockUser">차단해제</button>';
                            }
                            output += '<button type="button" value="' + userList[i][0].userId + '" class="deleteUser">삭제</button>';
                            output += '</td>'
                            output += '</tr>'
                        }
                    }
                    ;
                    output += "</table>";
                }
                var str = "";
                str += '<div class="form-group row justify-content-center">';
                str += '<div class="w100" style="padding-right:10px">';
                str += '<select class="form-control form-control-sm" name="searchType" id="searchType">';
                str += '<option value="0">아이디</option>';
                str += '<option value="1">이름</option>';
                str += '<option value="2">이메일</option>';
                str += '</select>';
                str += '</div>';
                str += '<div class="w300" style="padding-right:10px">';
                str += '<input type="text" class="form-control form-control-sm" name="keyword" id="keyword">';
                str += '</div>';
                str += '<div>';
                str += '<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색</input>';
                str += '</div>';
                str += '</div>';

                $(".selResult").html(output);
                $(".serachBox").html(str);

                $('#btnSearch').on('click', function(e){
                    searchType = $('#searchType').val();
                    keyWord = $('#keyword').val();
                    getResult(searchType, keyWord);
                });

                $('.blockUser').on('click', function () {
                    var up;
                    var userArr = $(this).attr('value');
                    userArr = userArr.split(',');
                    var userId = userArr[0];
                    var block = userArr[1];
                    console.log(userId);
                    console.log(block);
                    if (block == 'O') {
                        up = confirm("차단을 해제하시겠습니까?")
                        if (!up) {
                            return false;
                        }
                    } else {
                        up = confirm("차단하시겠습니까 ?");
                        if (!up) {
                            return false;
                        }
                    }
                    $.ajax({
                        url: "blockUser.ao",
                        type: "POST",
                        data: {
                            userId: userId,
                            block: block
                        },
                        success: function (json) {
                            if (block == 'O') {
                                alert("차단이 해제되었습니다.");
                            } else {
                                alert("차단되었습니다.");
                            }
                            getResult();
                        }
                    })
                });

                $('.deleteUser').on('click', function () {
                    var up;
                    up = confirm("정말 탈퇴시키시겠습니까?\n저장된 정보는 모두 삭제됩니다.");
                    if (!up) {
                        return false;
                    }
                    var userId = $(this).attr('value');
                    $.ajax({
                        url: "delUser.ao",
                        type: "POST",
                        data: {
                            userId: userId
                        },
                        success: function () {
                            alert("삭제되었습니다.");
                            getResult();
                        },
                        error: function (error) {
                            console.log(error);
                        }

                    });
                });

            },
            error: function (request, status, error) {
                alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
            },
        });
    };

    $('.ctnUser').on('click', function () {
        alert("ctnUserCheck")
    });

    $('.repUser').on('click', function () {
        alert("repUserCheck")
    });
</script>
</body>
</html>