<%@page import="com.mbc.project.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDto login = (MemberDto)session.getAttribute("login");
	if(login == null){
		%>
		<script>
		alert('login해 주십시오');
		location.href = "login.jsp";
		</script>		
		<%
	}
%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
	body {
		background: linear-gradient(160deg, #eef2ff 0%, #f8fafc 45%, #ffffff 100%);
		min-height: 100vh;
	}

	.write-wrapper {
		max-width: 760px;
		margin: 60px auto;
	}

	.write-card {
		border: none;
		border-radius: 1rem;
		box-shadow: 0 1rem 3rem rgba(30, 41, 59, 0.08);
		overflow: hidden;
	}

	.write-card-header {
		background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
		color: #fff;
		padding: 2rem 2.25rem;
	}

	.write-card-header h1 {
		font-size: 1.6rem;
		font-weight: 700;
		margin-bottom: 0.35rem;
	}

	.write-card-header p {
		margin: 0;
		font-size: 0.9rem;
		opacity: 0.85;
	}

	.write-card-body {
		padding: 2.25rem;
		background: #fff;
	}

	.form-label {
		font-weight: 600;
		color: #334155;
		font-size: 0.9rem;
	}

	.form-control {
		border-radius: 0.6rem;
		border: 1px solid #e2e8f0;
		padding: 0.65rem 0.9rem;
	}

	.form-control:focus {
		border-color: #6366f1;
		box-shadow: 0 0 0 0.2rem rgba(99, 102, 241, 0.15);
	}

	.form-control[readonly] {
		background-color: #f1f5f9;
		color: #64748b;
	}

	textarea.form-control {
		resize: vertical;
		min-height: 280px;
	}

	.input-group-text {
		background-color: #f8fafc;
		border-radius: 0.6rem 0 0 0.6rem;
		border: 1px solid #e2e8f0;
		color: #6366f1;
	}

	.btn-submit {
		background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
		border: none;
		border-radius: 0.6rem;
		padding: 0.7rem 2rem;
		font-weight: 600;
		box-shadow: 0 0.5rem 1.2rem rgba(79, 70, 229, 0.25);
		transition: transform 0.15s ease, box-shadow 0.15s ease;
	}

	.btn-submit:hover {
		transform: translateY(-1px);
		box-shadow: 0 0.7rem 1.5rem rgba(79, 70, 229, 0.32);
		color: #fff;
	}

	.btn-cancel {
		border-radius: 0.6rem;
		padding: 0.7rem 1.6rem;
		font-weight: 600;
		color: #64748b;
		border: 1px solid #e2e8f0;
	}

	.btn-cancel:hover {
		background-color: #f1f5f9;
		color: #334155;
	}
</style>

</head>
<body>

<div class="write-wrapper">

	<div class="card write-card">

		<div class="write-card-header">
			<h1><i class="bi bi-pencil-square me-2"></i>글쓰기</h1>
			<p>새로운 게시글을 작성해 주세요.</p>
		</div>

		<div class="write-card-body">

			<form action="bbs" method="post">
				<input type="hidden" name="param" value="bbswriteAf"/>

				<div class="mb-3">
					<label class="form-label"><i class="bi bi-person-fill me-1"></i>작성자 ID</label>
					<input type="text" name="id" class="form-control" value="<%=login.getId() %>" readonly="readonly"/>
				</div>

				<div class="mb-3">
					<label class="form-label"><i class="bi bi-card-heading me-1"></i>제목</label>
					<input type="text" name="title" class="form-control" placeholder="제목을 입력하세요" required/>
				</div>

				<div class="mb-4">
					<label class="form-label"><i class="bi bi-file-text me-1"></i>내용</label>
					<textarea rows="12" name="content" class="form-control" placeholder="내용을 기입해 주세요" required></textarea>
				</div>

				<div class="d-flex justify-content-end gap-2">
					<a href="bbs" class="btn btn-cancel">
						<i class="bi bi-x-lg me-1"></i>취소
					</a>
					<button type="submit" class="btn btn-submit text-white">
						<i class="bi bi-check2-circle me-1"></i>작성완료
					</button>
				</div>

			</form>

		</div>

	</div>

</div>

</body>
</html>





