<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
body{
    background:#f5f7fa;
}

.card{
    border:none;
    border-radius:15px;
}

.card-header{
    background:#0d6efd;
    color:white;
    font-size:24px;
    font-weight:bold;
    text-align:center;
    border-radius:15px 15px 0 0 !important;
}

#idcheck{
    font-size:13px;
    margin-top:5px;
}
</style>

</head>
<body>

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-6 col-lg-5">

            <div class="card shadow-lg">

                <div class="card-header">
                    회원가입
                </div>

                <div class="card-body">

                    <form action="member" method="post">
                    	<input type="hidden" name="param" value="regiAf"/>

                        <!-- 아이디 -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">아이디</label>

                            <div class="input-group">
                                <input type="text"
                                       class="form-control"
                                       id="id"
                                       name="id"
                                       placeholder="아이디를 입력하세요">

                                <button class="btn btn-outline-primary"
                                        type="button"
                                        id="id_chk_btn">
                                    중복확인
                                </button>
                            </div>

                            <div id="idcheck"></div>
                        </div>

                        <!-- 비밀번호 -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">비밀번호</label>

                            <input type="password"
                                   class="form-control"
                                   name="pw"
                                   placeholder="비밀번호를 입력하세요">
                        </div>

                        <!-- 이름 -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">이름</label>

                            <input type="text"
                                   class="form-control"
                                   name="name"
                                   placeholder="이름을 입력하세요">
                        </div>

                        <!-- 이메일 -->
                        <div class="mb-4">
                            <label class="form-label fw-bold">이메일</label>

                            <input type="email"
                                   class="form-control"
                                   name="email"
                                   placeholder="example@email.com">
                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100">
                            회원가입
                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

<script>

$(document).ready(function(){

    $("#id_chk_btn").click(function(){

        if($("#id").val().trim()==""){
            $("#idcheck")
                .css("color","red")
                .text("아이디를 입력해주세요.");
            $("#id").focus();
            return;
        }

        $.ajax({
            url:"./member",
            type:"post",
            data:{ param:"idcheck", id:$("#id").val() },
            success:function(data){
				//alert(data.str);
            	
                if(data.str=="YES"){
                    $("#idcheck")
                        .css("color","blue")
                        .text("사용 가능한 아이디입니다.");

                }else{
                    $("#idcheck")
                        .css("color","red")
                        .html("<b>이미 사용중인 아이디입니다.</b>");

                    $("#id").val("").focus();

                }

            },

            error:function(){
                alert("error");
            }

        });

    });

});

</script>

</body>
</html>