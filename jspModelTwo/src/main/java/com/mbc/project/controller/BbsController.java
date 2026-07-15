package com.mbc.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mbc.project.dao.BbsDao;
import com.mbc.project.dto.BbsDto;

@WebServlet("/bbs")
public class BbsController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}
	
	public void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		
		System.out.println("BbsController doProc");
		BbsDao dao = BbsDao.getInstance();
		
		String param = request.getParameter("param");
		
		if(param.equals("bbslist")) {
			
			// 카테고리 & 검색어
			String category = request.getParameter("category");
			String keyword = request.getParameter("keyword");
			if(category == null) {
				category = "title";
			}
			if(keyword == null) {
				keyword = "";
			}
			
			// page number
			String sPageNumber = request.getParameter("pageNumber");
			int pageNumber = 0;			
			// parameter로 넘어 온 값이 있을 때
			if(sPageNumber != null && !sPageNumber.equals("")) {
				pageNumber = Integer.parseInt(sPageNumber);
			}
			
			// 글목록
			List<BbsDto> list = dao.getBbsList(category, keyword, pageNumber);
			
			// 글의 총수
			int count = dao.getAllBbs(category, keyword);
			
			// 페이지 계산
			int pageBbs = count / 10;
			if((count % 10) > 0) {
				pageBbs += 1;
			}
			
			// 짐싸!
			request.setAttribute("list", list);			// 글목록
			request.setAttribute("pageBbs", pageBbs);	// 페이지의 총수
			request.setAttribute("pageNumber", pageNumber); //현재 페이지
			request.setAttribute("category", category);	
			request.setAttribute("keyword", keyword);
	
			// 잘가~
			forward("bbslist.jsp", request, response);
		}
		else if(param.equals("bbswrite")) {
			response.sendRedirect("bbswrite.jsp");
		}
		else if(param.equals("bbswriteAf")) {
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			boolean isS = dao.bbswrite(new BbsDto(id, title, content));
			
			String bbsWriteMsg = "BBSWRITE_SUCCESS";
			if(!isS) {
				bbsWriteMsg = "BBSWRITE_FAIL";
			}
			
			request.setAttribute("bbsWriteMsg", bbsWriteMsg);
			forward("message.jsp", request, response);
		}
		else if(param.equals("bbsdetail")) {			
			int seq = Integer.parseInt(request.getParameter("seq"));
			
			// 조회수 증가
			dao.readcount(seq);
			
			// object
			BbsDto dto = dao.getBbs(seq);
			
			// 짐싸!
			request.setAttribute("dto", dto);
			
			// 잘가~
			forward("bbsdetail.jsp", request, response);
		}
		else if(param.equals("bbsanswer")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
						
			// 짐싸!
			request.setAttribute("dto", dao.getBbs(seq));
			// 잘가
			forward("bbsanswer.jsp", request, response);
		}
		else if(param.equals("bbsanswerAf")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			dao.answerUpdate(seq);
			boolean isS = dao.answerInsert(seq, new BbsDto(id, title, content));
			
			String answerMsg = "ANSWER_SUCCESS";
			if(!isS) {
				answerMsg = "ANSWER_FAIL";
			}
			
			request.setAttribute("answerMsg", answerMsg);
			request.setAttribute("seq", seq);
			
			forward("message.jsp", request, response);			
		}
	}	
	
	public void forward(String url, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
	
}
