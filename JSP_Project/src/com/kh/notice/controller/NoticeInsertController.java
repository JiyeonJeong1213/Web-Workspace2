package com.kh.notice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.vo.Member;
import com.kh.notice.model.service.NoticeService;

/**
 * Servlet implementation class NoticeInsertController
 */
@WebServlet("/insert.no")
public class NoticeInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		int result = new NoticeService().insertNotice(title, content, userNo);
		
		if(result>0) {
			HttpSession session = request.getSession();
			session.setAttribute("alertMsg", "공지사항이 작성되었습니다.");
			//response.sendRedirect(request.getContextPath()+"/list.no");
			
			// 글 등록에 성공했을 때 내가 작성한 게시글로 곧바로 이동
			response.sendRedirect(request.getContextPath()+"/detail.no?nno="+ result);
		}else {
			request.setAttribute("errorMsg", "공지사항 작성에 실패했습니다.");
			
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}
}
