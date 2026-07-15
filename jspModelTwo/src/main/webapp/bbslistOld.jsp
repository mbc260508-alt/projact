<%@page import="com.mbc.project.util.Util"%>
<%@page import="com.mbc.project.dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="com.mbc.project.dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
String category = request.getParameter("category");
String keyword = request.getParameter("keyword");
if(category == null){
	category = "title";
}
if(keyword == null){
	keyword = "";
}


String sPageNumber = request.getParameter("pageNumber");
// 페이지 넘버
int pageNumber = 0;
if(sPageNumber != null && sPageNumber.equals("") == false){ // 넘어온 값이 있을 때
	pageNumber = Integer.parseInt(sPageNumber);
}

BbsDao dao = BbsDao.getInstance();
//List<BbsDto> list = dao.getBbsList();
//List<BbsDto> list = dao.getBbsList(category, keyword);
List<BbsDto> list = dao.getBbsList(category, keyword, pageNumber);

// 글의 총수
int count = dao.getAllBbs(category, keyword);

// 페이지(수)를 계산	글10개당 -> 1페이지    14개 -> 2페이지	
int pageBbs = count / 10;
if((count % 10) > 0){
	pageBbs += 1;
}
--%>

<%
// 짐풀자!
List<BbsDto> list = (List<BbsDto>)request.getAttribute("list");
int pageBbs = (Integer)request.getAttribute("pageBbs");
int pageNumber = (Integer)request.getAttribute("pageNumber");
String category = (String)request.getAttribute("category");
String keyword = (String)request.getAttribute("keyword");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbslist</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
.center{
	margin: auto;
	width: 1000px;
	text-align: center;
}
th{
	background-color: royalblue;
	color: white;
}
tr{
	line-height: 16px;
}
td{
	text-align: center;
	line-height: 20px;
}
a{
	text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	// let category = "<%=category %>";
	let select = document.getElementById("category");
	select.value = "<%=category %>";
	select.setAttribute("selected", "selected");
});
</script>

</head>
<body>

<h1>게시판</h1>

<div class="center">

<table class="table table-hover">
<col width="70"/><col width="50"/><col width="600"/><col width="100"/><col width="150"/>

<thead>
<tr>
	<th>번호</th><th>seq</th><th>제목</th><th>조회수</th><th>작성자</th>
</tr>
</thead>

<tbody>
<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="4">작성된 글이 없습니다</td>
	</tr>
	<%
}else{
	for(int i = 0;i < list.size(); i++){	
		BbsDto dto = list.get(i);
		%>
		<tr>
			<td><%=i + 1 %></td>
			<td><%=dto.getSeq() %></td>
			<td style="text-align: left">&nbsp;&nbsp;
				<%=Util.arrow(dto.getDepth()) %>
			
				<% if(dto.getDel() == 0){ %>			
					<a href="bbsdetail.jsp?seq=<%=dto.getSeq() %>">
						<%=Util.dot3(dto.getTitle()) %>
					</a>
				<% }else{ %>
					<font color="#ff0000">***이 글은 작성자에 의해서 삭제되었습니다***</font>
				<% } %>	
			</td>
			<td><%=dto.getReadcount() %></td>
			<td><%=dto.getId() %></td>
		</tr>
		<%
	}
}
%>
</tbody>
</table>
<br/>
<%
	// 페이징
	for(int i = 0;i < pageBbs; i++){
		if(pageNumber == i){	// 현재 페이지		[1] [2] 3
			%>
			<span style="font-size: 15pt; color: blue;font-weight: bold;">
				<%=i + 1 %>
			</span>
			<%
		}else{					// 그외 페이지
			%>
			<a href="#none" title="<%=i + 1 %>페이지"	onclick="goPage(<%=i %>)"
				style="font-size: 15pt; color: #000;font-weight: bold;text-decoration: none;">
				[<%=i + 1 %>]
			</a>		
			<%
		}
	}
%>

<br/><br/>

<div class="d-flex justify-content-center align-items-center gap-2">
    <select id="category" class="form-select" style="width:150px;">
        <option value="title">제목</option>
        <option value="content">내용</option>
        <option value="writer">작성자</option>
    </select>

    <input type="text"
           id="keyword"
           class="form-control"
           style="width:280px;"
           value="<%=keyword %>">

    <button type="button" class="btn btn-success" onclick="searchBtn()">검색</button>
</div>
<br/><br/>

<a href="bbswrite.jsp">글쓰기</a>

</div>

<script type="text/javascript">
function searchBtn() {
	let category = document.getElementById("category").value;
	let keyword = document.getElementById("keyword").value;
	
	//alert(category + " " + keyword);
	/*
	if(keyword.trim() === ""){
		alert('검색어를 입력해 주십시오');
		return;
	}*/
	
	location.href = "bbs?param=bbslist&category=" + category + "&keyword=" + keyword;	
}

function goPage( pageNum ) {
	let category = document.getElementById("category").value;
	let keyword = document.getElementById("keyword").value;

	location.href = "bbs?param=bbslist&category=" + category + "&keyword=" + keyword + "&pageNumber=" + pageNum;	
}

</script>

</body>
</html>

    
    