<%@page import="com.mbc.project.dto.BbsDto"%>
<%@page import="com.mbc.project.dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>    

<%
int seq = Integer.parseInt(request.getParameter("seq"));
String title = request.getParameter("title");
String content = request.getParameter("content");

System.out.println(seq + " " + title + " " + content);

BbsDao dao = BbsDao.getInstance();
boolean isS = dao.bbsupdate(new BbsDto(seq, title, content));
if(isS){
	%>    
 	<script>
 	alert("수정되었습니다");
 	location.href = "bbs?param=bbsdetail&seq=" + <%=seq %>;
 	</script>   
	<%
}else{	
	%>
	<script>
	alert("수정되지 않았습니다");
	location.href = "bbsupdate.jsp?seq=" + <%=seq %>;
 	</script>
	<%
}
	%>
    