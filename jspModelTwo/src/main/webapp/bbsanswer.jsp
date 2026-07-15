<%@page import="com.mbc.project.dto.MemberDto"%>
<%@page import="com.mbc.project.dao.MemberDao"%>
<%@page import="com.mbc.project.dto.BbsDto"%>
<%@page import="com.mbc.project.dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%--
int seq = Integer.parseInt(request.getParameter("seq"));

BbsDao dao = BbsDao.getInstance();
BbsDto dto = dao.getBbs(seq);
--%>

<%
BbsDto dto = (BbsDto)request.getAttribute("dto");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div align="center">

<h1>기본글</h1>

<table border="1">
<colgroup>
	<col width="200px"/>
	<col width="400px"/>
</colgroup>

<tr>
	<th>작성자</th>
	<td><%=dto.getId() %></td>
</tr>

<tr>	
	<th>작성일</th>
	<td><%=dto.getWdate() %></td>
</tr>

<tr>
	<th>조회수</th>
	<td><%=dto.getReadcount() %></td>
</tr>

<tr>
	<th>제목</th>
	<td><%=dto.getTitle() %></td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="15" cols="90" readonly="readonly"><%=dto.getContent() %></textarea>
	</td>
</tr>

</table>

<h1>답글</h1>

<%
MemberDto login = (MemberDto)session.getAttribute("login");
%>

<form action="bbs?param=bbsanswerAf" method="post">

<!-- 기본글의 sequence를 전송 -->
<input type="hidden" name="seq" value="<%=dto.getSeq() %>"/>

<table class="table mytable">
<col width="120"/><col width="400"/>

<!-- id, title, content -->
<tr>
	<th>ID</th>
	<td>
		<input type="text" name="id" class="form-control" size="50px" value="<%=login.getId() %>" readonly="readonly"/>
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" class="form-control" size="50px"/>
	</td>
</tr>
<tr>	
	<td colspan="2">
		<textarea rows="16" cols="50px" name="content" class="form-control" placeholder="내용을 기입"></textarea>
	</td>
</tr>

</table>
<br/>

<input type="submit" class="btn btn-primary" value="답글작성완료"/>

</form>

</div>



</body>
</html>



