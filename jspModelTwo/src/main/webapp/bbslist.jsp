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
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
	body {
		background-color: #f4f6f9;
	}
	.page-wrap {
		max-width: 1000px;
		margin: 40px auto;
	}
	.board-header {
		background: linear-gradient(135deg, #4e73df, #224abe);
		color: #fff;
		border-radius: .75rem .75rem 0 0;
		padding: 1.75rem 2rem;
	}
	.board-header h1 {
		font-size: 1.6rem;
		font-weight: 700;
		margin: 0;
	}
	.board-header p {
		margin: .25rem 0 0;
		opacity: .85;
		font-size: .9rem;
	}
	.board-card {
		border: none;
		border-radius: .75rem;
		box-shadow: 0 .35rem 1.5rem rgba(0,0,0,.08);
		overflow: hidden;
	}
	.table thead th {
		background-color: #224abe;
		color: #fff;
		border: none;
		font-weight: 600;
		white-space: nowrap;
	}
	.table td, .table th {
		vertical-align: middle;
		text-align: center;
	}
	.table td.title-cell {
		text-align: left;
	}
	.table td.title-cell a {
		color: #212529;
		text-decoration: none;
		font-weight: 500;
	}
	.table td.title-cell a:hover {
		color: #224abe;
		text-decoration: underline;
	}
	.deleted-text {
		color: #dc3545;
		font-size: .9rem;
		font-style: italic;
	}
	.depth-arrow {
		color: #adb5bd;
		margin-right: 4px;
	}
	.readcount-badge {
		font-weight: 500;
	}
	.writer-text {
		color: #6c757d;
		font-size: .9rem;
	}
	.empty-row td {
		padding: 3rem 0;
		color: #6c757d;
		font-size: 1rem;
	}
	.toolbar {
		padding: 1.25rem 1.5rem;
		background-color: #fff;
		border-top: 1px solid #eee;
	}
	.pagination .page-link {
		color: #224abe;
	}
	.pagination .page-item.active .page-link {
		background-color: #224abe;
		border-color: #224abe;
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

<div class="page-wrap">

	<div class="board-card">

		<div class="board-header">
			<h1><i class="bi bi-chat-square-text me-2"></i>게시판</h1>
			<p>등록된 글 목록을 확인하고 검색할 수 있습니다.</p>
		</div>

		<div class="table-responsive">
		<table class="table table-hover mb-0">
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
			<tr class="empty-row">
				<td colspan="5"><i class="bi bi-inbox me-1"></i>작성된 글이 없습니다</td>
			</tr>
			<%
		}else{
			for(int i = 0;i < list.size(); i++){	
				BbsDto dto = list.get(i);
				%>
				<tr>
					<td><%=i + 1 + (pageNumber * 10) %></td>
					<td><%=dto.getSeq() %></td>
					<td class="title-cell" title="<%=dto.getTitle() %>">
						<span class="depth-arrow"><%=Util.arrow(dto.getDepth()) %></span>

						<% if(dto.getDel() == 0){ %>			
							<a href="bbs?param=bbsdetail&seq=<%=dto.getSeq() %>">
								<%=Util.dot3(dto.getTitle()) %>
							</a>
						<% }else{ %>
							<span class="deleted-text">
								<i class="bi bi-exclamation-triangle me-1"></i>이 글은 작성자에 의해서 삭제되었습니다
							</span>
						<% } %>	
					</td>
					<td><span class="badge text-bg-light readcount-badge"><i class="bi bi-eye me-1"></i><%=dto.getReadcount() %></span></td>
					<td><span class="writer-text"><%=dto.getId() %></span></td>
				</tr>
				<%
			}
		}
		%>
		</tbody>
		</table>
		</div>

		<div class="d-flex justify-content-center py-3 border-top">
		<nav aria-label="게시판 페이지 이동">
			<ul class="pagination mb-0">
			<%
				// 페이징
				for(int i = 0;i < pageBbs; i++){
					if(pageNumber == i){	// 현재 페이지		[1] [2] 3
						%>
						<li class="page-item active" aria-current="page">
							<span class="page-link"><%=i + 1 %></span>
						</li>
						<%
					}else{					// 그외 페이지
						%>
						<li class="page-item">
							<a class="page-link" href="#none" title="<%=i + 1 %>페이지" onclick="goPage(<%=i %>)"><%=i + 1 %></a>
						</li>
						<%
					}
				}
			%>
			</ul>
		</nav>
		</div>

		<div class="toolbar">
			<div class="row g-2 align-items-center">
				<div class="col-12 col-md-8 mx-md-auto">
					<div class="input-group">
						<select id="category" class="form-select flex-grow-0" style="width:130px;">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="writer">작성자</option>
						</select>

						<input type="text"
						       id="keyword"
						       class="form-control"
						       placeholder="검색어를 입력하세요"
						       value="<%=keyword %>"
						       onkeypress="search_enter(event)">

						<button type="button" class="btn btn-primary" onclick="searchBtn()">
							<i class="bi bi-search me-1"></i>검색
						</button>
					</div>
				</div>
			</div>

			<div class="d-flex justify-content-end mt-3">
				<a href="bbs?param=bbswrite" class="btn btn-success">
					<i class="bi bi-pencil-square me-1"></i>글쓰기
				</a>
			</div>
		</div>

	</div>

</div>

<script type="text/javascript">
// 검색어를 입력하고 enter키를 클릭하면 검색되도록 하는 함수 https://charliecharlie.tistory.com/233
function search_enter(e) {
	if(e.keyCode == 13){	// 13:enter키
		let category = document.getElementById("category").value;
		let keyword = document.getElementById("keyword").value;		
		location.href = "bbs?param=bbslist&category=" + category + "&keyword=" + keyword;
	}
}

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




