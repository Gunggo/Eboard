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

        .w100 div {
            float: left;
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
                searchType: searchType,
                keyWord: keyWord
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

                $('#btnSearch').on('click', function (e) {
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
        $(".selResult").text("");
        var str = "";
        str += '<div class="form-group row justify-content-center">';
        str += '<div class="w100" style="padding-right:10px; float: left;">';
        str += '<div class="searchType">';
        str += '<select class="form-control form-control-sm" name="searchType" id="searchType"style="display: inline-block;">';
        str += '<option value="0">게시왕</option>';
        str += '<option value="1">댓글왕</option>';
        str += '</select>';
        str += '<input type="date" name="startDate" id="startDate">';
        str += '<input type="date" name="endDate" id="endDate" >';
        str += '<button type="button" name="btnSearch" id="btnSearch">검색';
        str += '</div>';
        str += '<div class="startYear">';
        str += '</div>';
        str += '</div>';

        $(".selResult").html(str);
        $(".serachBox").text("");
    });

    $('#btnSearch').on('click', function () {
        var searchType = $('#searchType').val();
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();
        alert(searchType);
        alert(startDate);
        alert(endDate);
    });

    $('#btnDateSearch').on('click', function () {
        var checkNum = 2;//3개월이면 2로 셋팅
        //선택된 값을 가져온다.
        var startYear = $("#start_year").val();
        var startMonth = $("#start_month").val();
        var endYear = $("#end_year").val();
        var endMonth = $("#end_month").val();
        alert(startMonth);
        //계산을 위해 명시적으로 형변환
        var startYearNum = Number(startYear);
        var startMonthNum = Number(startMonth);
        var endYearNum = Number(endYear);
        var endMonthNum = Number(endMonth);

        //일단 차이를 재서 위에서 정한 월이 넘어가는지 확인
        var result = ((endYearNum * 12) + endMonthNum) - ((startYearNum * 12) + startMonthNum);
        if (result > checkNum) {
            alert("날짜 검색 범위는 " + (checkNum + 1) + "개월 입니다.");
            if (endMonthNum <= checkNum) {
                startYearNum = endYearNum - 1;
                startMonthNum = 12 - (checkNum - endMonthNum)
            } else {
                startYearNum = endYearNum;
                startMonthNum = endMonthNum - checkNum;
            }
            $("#start_year").val(startYearNum).attr("selected", "selected");
            $("#start_month").val(startMonthNum).attr("selected", "selected");
        }
        ;
    });

    $('.repUser').on('click', function () {
        alert("repUserCheck")
    });
</script>
</body>
</html>



<%--// str += '<select id="start_year" name="start_year" class="form-control form-control-sm">';--%>
<%--// str += '<option value="2019" >2019</option>';--%>
<%--// str += '<option value="2018" >2018</option>';--%>
<%--// str += '<option value="2017" >2017</option>';--%>
<%--// str += '<option value="2016" >2016</option>';--%>
<%--// str += '<option value="2015" >2015</option>';--%>
<%--// str += '<option value="2014" >2014</option>';--%>
<%--// str += '<option value="2013" >2013</option>';--%>
<%--// str += '</select>';--%>
<%--// str += '</div>';--%>
<%--// str += '<div class="startMonth">';--%>
<%--// str += '<select id="start_month" name="start_month" class="form-control form-control-sm">';--%>
<%--// str += '<option value="1" >1</option>';--%>
<%--// str += '<option value="2" >2</option>';--%>
<%--// str += '<option value="3" >3</option>';--%>
<%--// str += '<option value="4" >4</option>';--%>
<%--// str += '<option value="5" >5</option>';--%>
<%--// str += '<option value="6" >6</option>';--%>
<%--// str += '<option value="7" >7</option>';--%>
<%--// str += '<option value="8" >8</option>';--%>
<%--// str += '<option value="9" >9</option>';--%>
<%--// str += '<option value="10" >10</option>';--%>
<%--// str += '<option value="11" >11</option>';--%>
<%--// str += '<option value="12" >12</option>';--%>
<%--// str += '</select>';--%>
<%--// str += '</div>';--%>
<%--// str += '<div class="endYear">';--%>
<%--// str += '<select id="end_year" name="end_year" class="form-control form-control-sm">';--%>
<%--// str += '<option value="2019" >2019</option>';--%>
<%--// str += '<option value="2018" >2018</option>';--%>
<%--// str += '<option value="2017" >2017</option>';--%>
<%--// str += '<option value="2016" >2016</option>';--%>
<%--// str += '<option value="2015" >2015</option>';--%>
<%--// str += '<option value="2014" >2014</option>';--%>
<%--// str += '<option value="2013" >2013</option>';--%>
<%--// str += '</select>';--%>
<%--// str += '</div>';--%>
<%--// str += '<div class="endMonth">';--%>
<%--// str += '<select id="end_month" name="end_month" class="form-control form-control-sm">';--%>
<%--// str += '<option value="1" >1</option>';--%>
<%--// str += '<option value="2" >2</option>';--%>
<%--// str += '<option value="3" >3</option>';--%>
<%--// str += '<option value="4" >4</option>';--%>
<%--// str += '<option value="5" >5</option>';--%>
<%--// str += '<option value="6" >6</option>';--%>
<%--// str += '<option value="7" >7</option>';--%>
<%--// str += '<option value="8" >8</option>';--%>
<%--// str += '<option value="9" >9</option>';--%>
<%--// str += '<option value="10" >10</option>';--%>
<%--// str += '<option value="11" >11</option>';--%>
<%--// str += '<option value="12" >12</option>';--%>
<%--// str += '</select>';--%>
<%--// str += '</div>';--%>
<%--// str += '<div class="searchBtn">';--%>
<%--// str += '<button class="btn btn-sm btn-primary" name="btnDateSearch" id="btnDateSearch" onclick="btnDateSearch()">검색</input>';--%>
<%--// str += '</div>';--%>