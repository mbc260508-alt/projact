<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js"></script>

<style>
body{
    background:#f5f7fa;
}

.login-box{
    max-width:450px;
    margin:80px auto;
}

.card{
    border:none;
    border-radius:15px;
    box-shadow:0 8px 20px rgba(0,0,0,.15);
}

.card-header{
    background:#0d6efd;
    color:white;
    text-align:center;
    font-size:28px;
    font-weight:bold;
    padding:20px;
}

.btn-login{
    width:100%;
}

.signup{
    text-align:center;
    margin-top:15px;
}
</style>

</head>
<body>

<div class="container">
    <div class="login-box">
        <div class="card">
            <div class="card-header">
                Login
            </div>

            <div class="card-body p-4">
                <form action="member" method="post">
                	<input type="hidden" name="param" value="loginAf">                
                
                    <div class="mb-3">
                        <label class="form-label fw-bold">ID</label>
                        <input type="text"
                               class="form-control"
                               id="id"
                               name="id"
                               placeholder="아이디를 입력하세요">
                    </div>

                    <div class="form-check mb-3">
                        <input class="form-check-input"
                               type="checkbox"
                               id="chk_save_id">
                        <label class="form-check-label" for="chk_save_id">
                            아이디 저장
                        </label>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Password</label>
                        <input type="password"
                               class="form-control"
                               name="pw"
                               value="123"
                               placeholder="비밀번호">
                    </div>

                    <button type="submit"
                            class="btn btn-primary btn-lg btn-login">
                        Log In
                    </button>

                    <div class="signup">
                        아직 회원이 아니신가요?
                        <a href="member?param=regi" class="text-decoration-none fw-bold">
                            회원가입
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
/*
    session : 서버 저장
    cookie  : 브라우저 저장
*/

let user_id = $.cookie("user_id");

if(user_id != null){
    $("#id").val(user_id);
    $("#chk_save_id").prop("checked", true);
}

$("#chk_save_id").click(function(){

    if($("#chk_save_id").is(":checked")){

        if($("#id").val().trim() === ""){
            alert("아이디를 입력해 주십시오");
            $("#chk_save_id").prop("checked", false);
        }else{
            $.cookie("user_id",
                     $("#id").val().trim(),
                     {expires:7, path:'/'});
        }

    }else{

        $.removeCookie("user_id",{path:'/'});

    }

});
</script>

</body>
</html>