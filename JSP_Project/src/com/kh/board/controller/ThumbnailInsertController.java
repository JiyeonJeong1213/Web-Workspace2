package com.kh.board.controller;

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
import com.kh.common.MyFileRenamePolicy;
import com.kh.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class ThumbnailInsertController
 */
@WebServlet("/insert.th")
public class ThumbnailInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThumbnailInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("views/board/thumbnailEnrollForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(ServletFileUpload.isMultipartContent(request)) {
			
			// 1-1. 전송용량제한
			int maxSize = 10*1024*1024;
			
			// 1-2. 저장할 폴더의 물리적 경로
			String savePath = request.getSession().getServletContext().getRealPath("/resources/thumb_upfiles/");
			
			// 2. 전달된 파일명 수정작업 후 서버에 업로드
			MultipartRequest multi =  new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			// 3. db에 값 저장
			// BOARD테이블에 들어갈 데이터 뽑아오기
			Board b = new Board();
			b.setBoardTitle(multi.getParameter("title"));
			b.setBoardContent(multi.getParameter("content"));
			b.setBoardWriter(((Member)request.getSession().getAttribute("loginUser")).getUserNo()+"");
			
			// ATTACHMENT테이블에 여러번 INSERT할 데이터를 뽑기
			// 단, 여러개의 첨부파일이 있을 것이기 때문에 attachment들을 ArrayList에 담을 예정 => 반드시 1개 이상은 담김(대표이미지)
			ArrayList<Attachment> list = new ArrayList<>();
			
			for(int i=1; i <= 4; i++) { // 파일의 개수는 최대 4개이기 때문에 4번 반복시킴
				
				String key = "file"+i; // file1, file2, file3, file4
				
				if(multi.getOriginalFileName(key) != null) { // 넘어온 첨부파일이 있는 경우
					// Attachment객체 생성해서 원본명,수정명,저장경로, 파일레벨 담기
					// 그다음 list에 추가하기
					Attachment at = new Attachment();
					at.setOriginName(multi.getOriginalFileName(key));
					at.setChangeName(multi.getFilesystemName(key));
					at.setFilePath("/resources/thumb_upfiles/");
					at.setFileLevel(i);
					
					list.add(at);
				}
			}
			
			int result = new BoardService().insertThumbnailBoard(b, list);
			
			if(result>0) { // 성공시 -> list.th를 요청
				request.getSession().setAttribute("alarmMsg", "성공적으로 업로드 되었습니다.");
				response.sendRedirect(request.getContextPath()+"/list.th");
			}else {
				request.setAttribute("errorMsg", "사진게시판 업로드 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
		}
	}

}
