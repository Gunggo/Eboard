<!DOCTYPE html>
<html>
<head>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <meta name="viewport"
          content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
			integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
			crossorigin="anonymous"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <link rel="stylesheet" href="default.css">
    <link rel="stylesheet" href="login_styles.css">
    <style>

    </style>
</head>
<body>
<form action="loginOk.mo" method="post" class="was-validated action">
    <div class="container">
        <div class="row">
            <div class="col-md-10 order-md-1">
                <fieldset>
                    <form class="needs-validation" novalidate>

                        <div class="mb-3">
                            <label for="lg_id"></label>
                            <input type="text" class="form-control" id="lg_id" name="id"
                                   value="<% if(session.getAttribute("id") != null)
																	out.println(session.getAttribute("id"));
															%>" placeholder="아이디" required>
                            <div class="invalid-feedback">
                                아이디를 입력하세요.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="lg_pw"></label>
                            <input type="password" class="form-control" id="lg_pw" name="pw" placeholder="비밀번호"
                                   required>
                            <div class="invalid-feedback" style="width: 100%;">
                                비밀번호를 입력하세요.
                            </div>
                        </div>
                        <div class="lg_btm">
                            <button class="btn btn-primary" type="submit">로그인</button>
                        </div>
                        <a id="kakao-login-btn">
                            <img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg"/>
                        </a>
                        <script type='text/javascript'>
                            var kakaoId = null;
                            var kakaoName = null;
                            //<![CDATA[
                            // 사용할 앱의 JavaScript 키를 설정해 주세요.
                            Kakao.init('9a0c09494cecb97f6fcc717ec158ef33');
                            // 카카오 로그인 버튼을 생성합니다.
                            Kakao.Auth.createLoginButton({
                                container: '#kakao-login-btn',
                                success: function (authObj) {
                                    // 로그인 성공시, API를 호출합니다.
                                    Kakao.API.request({
                                        url: '/v2/user/me',
                                        success: function (res) {
                                            JSON.stringify(res);
                                            kakaoId = res.id;
                                            kakaoName = res.properties['nickname'];
                                            // alert(JSON.stringify(authObj));
                                            // console.log(res.id);
                                            // console.log(res.kaccount_email);
                                            // console.log(res.properties['nickname']);
                                            // console.log(authObj.access_token);
                                        },
                                        fail: function (error) {
                                            alert(JSON.stringify(error));
                                        }
                                    });
                                },
                                fail: function (err) {
                                    alert(JSON.stringify(err));
                                }
                            });
                            //]]>
                        </script>
                        <div class="find">
                            <input type="button" value="아이디 찾기">
                            <input type="button" value="비밀번호 찾기">
                            <input type="button" id="join" value="회원가입" onclick="javascript:window.location='join.jsp'">
                            <input type="hidden" name="kakaoId">
                            <input type="hidden" name="kakaoName">
                            <script type='text/javascript'>
                                $('#kakaoId').val(kakaoId);
                                $('#kakaoName').val(kakaoName);
                            </script>
                        </div>
                    </form>
                </fieldset>
            </div>
        </div>
    </div>
</form>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>
</html>