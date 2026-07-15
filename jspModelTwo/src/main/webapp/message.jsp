<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 회원가입
String message = (String)request.getAttribute("message");
if(message != null && message.equals("")== false){
	if(message.equals("MEMBER_OK")){
		%>
		<script type="text/javascript">
		alert('회원가입에 성공했습니다');
		location.href = "./member?param=login";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
		alert('다시 가입해 주십시오');
		location.href = "./member?param=regi";
		</script>
		<%		
	}
}
// login
String loginMsg = (String)request.getAttribute("loginMsg");
if(loginMsg != null && loginMsg.equals("") == false){
	if(loginMsg.equals("LOGIN_SUCCESS")){
		%>
		<script type="text/javascript">
		alert('로그인에 성공했습니다');
		location.href = "./bbs?param=bbslist";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
		alert('아이디나 패스워드를 확인해 주십시오');
		location.href = "./member?param=login";
		</script>
		<%
	}
}
// bbswrite
String bbsWriteMsg = (String)request.getAttribute("bbsWriteMsg");
if(bbsWriteMsg != null && !bbsWriteMsg.equals("")){
	if(bbsWriteMsg.equals("BBSWRITE_SUCCESS")){
		%>
		<script type="text/javascript">
		alert('글작성완료');
		location.href = "./bbs?param=bbslist";
		</script>
		<%		
	}else{
		%>
		<script type="text/javascript">
		alert('다시 작성해 주십시오');
		location.href = "./bbs?param=bbswrite";
		</script>
		<%			
	}	
}

// answerMsg
String answerMsg = (String)request.getAttribute("answerMsg");
Integer seq = (Integer)request.getAttribute("seq");
if(answerMsg != null && !answerMsg.equals("")){
	if(answerMsg.equals("ANSWER_SUCCESS")){
		%>
		<script type="text/javascript">
		alert('답글작성에 성공했습니다');
		location.href = "bbs?param=bbslist";
		</script>
		<%		
	}else{		
		%>
		<script type="text/javascript">
		alert('답글작성을 다시 해 주십시오');
		location.href = "bbs?param=bbsanswer&seq=" + <%=seq %>;
		</script>
		<%			
	}	
	
	
}
%>	


