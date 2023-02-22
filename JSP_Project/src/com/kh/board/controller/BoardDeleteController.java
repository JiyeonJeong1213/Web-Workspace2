package com.kh.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class BoardDeleteController
 */
@WebServlet(urlPatterns = "/delete.bo", name = "boardDeleteServlet")
public class BoardDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		int userNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
		Attachment at = new BoardService().selectAttachment(bno);
		
		int result = new BoardService().deleteBoard(bno, userNo, at);
		
		if(result>0) {
			if(at != null) {
				String savePath = request.getSession().getServletContext().getRealPath(at.getFilePath());
				new File(savePath+at.getChangeName()).delete();
			}
			
			request.getSession().setAttribute("alertMsg", "게시글이 삭제되었습니다.");
			response.sendRedirect(request.getContextPath()+"/list.bo");
		}else {
			request.setAttribute("errorMsg", "게시글 삭제 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
