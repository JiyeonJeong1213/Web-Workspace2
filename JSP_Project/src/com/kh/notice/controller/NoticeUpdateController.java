package com.kh.notice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.notice.model.service.NoticeService;
import com.kh.notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeUpdateController
 */
@WebServlet("/update.no")
public class NoticeUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeUpdateController() {
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
		
		int nno = Integer.parseInt(request.getParameter("nno"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		int result = new NoticeService().updateNotice(nno, title, content);
		
		if(result <= 0) {
			request.setAttribute("errorMsg", "공지사항 수정에 실패했습니다.");
			request.getRequestDispatcher("views/common/errorPage").forward(request, response);
		}else {
			HttpSession session = request.getSession();
			session.setAttribute("alertMsg", "공지사항이 수정되었습니다.");
			
			response.sendRedirect(request.getContextPath()+"/detail.no?nno="+ nno);
		}
	}

}
