package com.mbc.project.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mbc.project.dao.MemberDao;
import com.mbc.project.dto.MemberDto;

import net.sf.json.JSONObject;

public class MemberController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}
	
	public void doProc(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		//System.out.println("MemberController doProc");
		
		String param = request.getParameter("param");
		
		MemberDao dao = MemberDao.getInstance();
		
		if(param.equals("login")) {
			response.sendRedirect("loginB.jsp");
		}
		else if(param.equals("regi")) {
			response.sendRedirect("regiB.jsp");
		}
		else if(param.equals("idcheck")) {
			String id = request.getParameter("id");
						
			int count = dao.idcheck(id);
			
			String str = "YES";
			if(count > 0) {
				str = "NO";
			}
			
			JSONObject obj = new JSONObject();
			obj.put("str", str);	// <- 짐싸!
			
			response.setContentType("application/x-json; charset=utf-8");
			response.getWriter().print(obj);	// <- 잘가~ 			
		}
		else if(param.equals("regiAf")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			boolean isS = dao.addMember(new MemberDto(id, pw, name, email, 0));
			
			String message = "MEMBER_OK";
			if(!isS) {
				message = "MEMBER_NG";
			}
			
			// 짐싸!
			request.setAttribute("message", message);
			
			// 잘가~
		//	request.getRequestDispatcher("message.jsp").forward(request, response);
			forward("message.jsp", request, response);
		}
		else if(param.equals("loginAf")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDto login = dao.login(new MemberDto(id, pw, null, null, 0));
			
			String loginMsg = "LOGIN_SUCCESS";
			if(login == null || login.getId().equals("")) {
				loginMsg = "LOGIN_FAIL";				
			}else {	// login 성공!
				//request.getSession().setMaxInactiveInterval(2 * 60 * 60);
				request.getSession().setAttribute("login", login);
			}
			
			// 짐싸!
			request.setAttribute("loginMsg", loginMsg);
			
			// 이동!
			forward("message.jsp", request, response);			
		}			
	}
	
	public void forward(String url, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
		

}
