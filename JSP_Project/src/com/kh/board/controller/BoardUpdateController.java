package com.kh.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardUpdateController
 */
@WebServlet("/update.bo")
public class BoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 필요한 데이터를 담아서 boardUpateForm.jsp로 포워딩 시켜주기
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		ArrayList<Category> list = new BoardService().selectCategoryList();
		Board b = new BoardService().selectBoard(bno);
		Attachment at = new BoardService().selectAttachment(bno);
		
		request.setAttribute("list", list);
		request.setAttribute("b", b);
		request.setAttribute("at", at);
		request.getRequestDispatcher("views/board/boardUpdateForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 필요한 데이터를 전달받고 실제 Board와 Attachment테이블에 UPDATE쿼리문을 실행
		// 1. 전송된 데이터 input file이 포함된 경우 enctype="multipart/form-data"로 전송할 것.
		if(ServletFileUpload.isMultipartContent(request)) {
			// 1-1. 전송파일 용량제한(10mByte)
			int maxSize = 1024*1024*10;
			// 1-2. 전달된 파일을 저장시킬 서버의 폴더의 물리적인 경로 알아내기
			String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/");
			
			// 2. 전달된 파일명 수정작업 후 서버에 업로드
			MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			// 3. 본격적으로 sql문 실행시 필요한 값들 셋팅
			Board b = new Board();
			b.setBoardNo(Integer.parseInt(multi.getParameter("bno")));
			b.setCategory(multi.getParameter("category"));
			b.setBoardTitle(multi.getParameter("title"));
			b.setBoardContent(multi.getParameter("content"));
			// 새롭게 전달된 첨부파일이 있는 경우에만 at변수에 필요한 값을 추가할 것
			Attachment at = null;
			if(multi.getOriginalFileName("upfile") != null) {
				at = new Attachment();
				at.setOriginName(multi.getOriginalFileName("upfile"));
				at.setChangeName(multi.getFilesystemName("upfile"));
				at.setFilePath("resources/board_upfiles/");
				// 첨부파일이 원래 있었을 경우 원본파일의 파일번호, 수정된 이름을 hidden으로 넘겨 받았음
				if(multi.getParameter("originFileNo") != null) { // 기존에 첨부파일이 있었던 경우
					// Attachment테이블의 정보를 UPDATE
					
					// 기존의 파일번호를 저장시키기
					at.setFileNo(Integer.parseInt(multi.getParameter("originFileNo")));
					// 기존의 첨부파일 삭제 
					new File(savePath+at.getChangeName()).delete();
				}else { // 기존에 첨부파일이 없는 경우
					// Attachment테이블에 정보를 INSERT
					
					// REF_BNO에 현재 게시글 번호를 추가시켜줌
					at.setRefBno(Integer.parseInt(multi.getParameter("bno")));
				}
			}
			int result = new BoardService().updateBoard(b,at);
			
			if(result>0) {
				request.getSession().setAttribute("alertMsg", "게시글이 수정되었습니다.");
				response.sendRedirect(request.getContextPath()+"/detail.bo?bno="+multi.getParameter("bno"));
			}else {
				request.setAttribute("errorMsg", "게시글 수정 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
			
			// 하나의 트랜잭션으로 Board의 UPDATE문과 Attachment테이블의 INSERT, UPDATE문 동시에 처리해주기
			
			// 항상 Board테이블에 UPDATE문은 반드시 실행시켜줘야 함
			// case1 : 새로운 첨부파일이 없는 경우 -> INSERT(X), UPDATE(X)
			// case2 : 새로운 첨부파일이 있는 경우, 기존에도 첨부파일이 있던 경우 -> UPDATE(O), INSERT(X)
			// case3 : 새로운 첨부파일이 있는데 기존에는 첨부파일이 없던 경우 -> UPDATE(X), INSERT(O)
			
			// 수정 성공시 : 상세조회페이지로 redirect
			
			// 수정 실패시 : errorPage
		}else {
			request.setAttribute("errorMsg", "전송방식이 잘못되었습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

}
