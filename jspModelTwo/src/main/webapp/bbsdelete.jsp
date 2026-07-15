<%@page import="com.mbc.project.dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

int seq = Integer.parseInt(request.getParameter("seq"));

BbsDao dao = BbsDao.getInstance();

int count = dao.bbsdelete(seq);

if(count > 0){
%>
<script>
alert("삭제되었습니다.");
location.href = "bbs?param=bbslist";
</script>
<%
}else{
%>
<script>
alert("삭제되지 않았습니다.");
location.href = "bbs?param=bbsdetail&seq=<%=seq%>";
</script>
<%
}
%>