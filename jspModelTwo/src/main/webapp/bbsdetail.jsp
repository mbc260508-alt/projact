<%@page import="com.mbc.project.dto.MemberDto"%>
<%@page import="com.mbc.project.dao.BbsDao"%>
<%@page import="com.mbc.project.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
    int seq = Integer.parseInt(request.getParameter("seq"));
    BbsDao dao = BbsDao.getInstance();
    dao.readcount(seq);
    BbsDto dto = dao.getBbs(seq);
    MemberDto login = (MemberDto)session.getAttribute("login");
--%>

<%
BbsDto dto = (BbsDto)request.getAttribute("dto");
MemberDto login = (MemberDto)session.getAttribute("login");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

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
}

textarea{
    resize:none;
}

.table th{
    width:180px;
    background:#f8f9fa;
    text-align:center;
    vertical-align:middle;
}
</style>

</head>
<body>

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-lg-9">

            <div class="card shadow">

                <div class="card-header">
                    게시글 상세보기
                </div>

                <div class="card-body">

                    <table class="table table-bordered align-middle">

                        <tr>
                            <th>작성자</th>
                            <td><%=dto.getId()%></td>
                        </tr>

                        <tr>
                            <th>작성일</th>
                            <td><%=dto.getWdate()%></td>
                        </tr>

                        <tr>
                            <th>조회수</th>
                            <td><%=dto.getReadcount()%></td>
                        </tr>

                        <tr>                            
                            <td colspan="2" class="fs-5 fw-semibold"><%=dto.getTitle()%></td>
                        </tr>

                        <tr>                            
                            <td colspan="2">
                                <textarea class="form-control fs-5"
                                          rows="12"
                                          readonly><%=dto.getContent()%></textarea>
                            </td>
                        </tr>

                    </table>

                    <div class="text-center mt-4">

                        <% if(login.getId().equals(dto.getId())) { %>

                            <button class="btn btn-warning me-2"
                                    onclick="bbsupdate()">
                                수정
                            </button>

                            <button class="btn btn-danger me-2"
                            		onclick="bbsdelete()">
                                삭제
                            </button>

                        <% } %>

                        <button class="btn btn-primary"
                                onclick="answer(<%=dto.getSeq()%>)">
                            답글작성
                        </button>
                        
                        <button class="btn btn-primary"
                                onclick="location.href='bbs?param=bbslist'">
                            글목록
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function answer(seq){
    location.href="bbs?param=bbsanswer&seq="+seq;
}

// 수정
function bbsupdate(){
    location.href="bbsupdate.jsp?seq=<%=dto.getSeq()%>";
}
// 삭제
function bbsdelete() {
	location.href="bbsdelete.jsp?seq=<%=dto.getSeq()%>";
}

</script>

</body>
</html>