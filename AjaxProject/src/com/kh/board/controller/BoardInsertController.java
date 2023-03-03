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
import com.kh.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardInsertController
 */
@WebServlet("/insert.bo")
public class BoardInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 카테고리 조회
		ArrayList<Category> list = new BoardService().selectCategoryList();
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("views/board/boardEnrollForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파일 업로드 하려면 cos.jar 라이브러리를 추가해야 함 (메이븐레파지토리에서 다운)
		
		request.setCharacterEncoding("UTF-8");
		
//		String category = request.getParameter("category"); // null
//		String title = request.getParameter("title"); // null
		
		//System.out.println(category+title);
		
		/*
		 * 폼 전송시 일반 방식이 아니라 multipart/form-data로 전송하는 경우
		 * request로부터 값을 뽑아낼 수 없음
		 * 
		 * multipart라는 객체에 값을 이과시켜서 다뤄줘야 함
		 */
		
		// enctype이 multipart/form-data로 전송되었는지 확인
		if(ServletFileUpload.isMultipartContent(request)) {
			// 파일 업로드를 위한 라이브러리 cos.jar가 필요함
			
			// 1. 전송되는 파일을 처리할 작업 내용(전송되는 파일의 용량제한, 전달된 파일을 저장할 경로)
			// 1-1. 전송파일 용량제한(int maxSize => byte단위로 값을 기술해야 함) 여기선 10Mbyte로 제한할 예정
			/*
			 * 단위 정리
			 * byte -> kbyte -> mbyte -> gbyte -> tbyte
			 * 1 kbyte = 1024byte (2의 10승)
			 * 1 mbyte = 1024kbyte -> 1024 * 1024 byte -> (2의 20승)
			 */
			int maxSize = 1024 * 1024 * 10;
			// 1-2. 전달된 파일을 저장할 서버의 폴더경로 알아내기(String savePath)
			/*
			 * 세션객체에서 제공하는 getRealPath메소드를 통해 알아낼 예정
			 * 다만 WebContent 폴더로부터 board_upfiles폴더까지의 경로는 매개변수로 제시해줘야 함
			 * 그리고 결론적으로는 board_upfiles폴더 내부에 파일들이 저장될 것이기 때문에 /를 마지막에 붙여줘야 함
			 */
			String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/");
			// C:\Web-Workspace2\JSP_Project\WebContent\resources\board_upfiles\
			
			// 2. 전달된 파일명 수정 및 서버에 업로드 작업
			/*
			 * - HttpSevletRequest request => MultipartRequest multi로 변환
			 * 
			 * 매개변수 생성자로 생성(cos.jar에서 제공하는 객체)
			 * MultipartRequest multi = new MultipartRequest(request객체, 저장할 폴더 경로, 용량제한, 인코딩값, 파일명을 수정시켜주는 객체);
			 * 
			 * 위 구문 한 줄 실행만으로 넘어온 첨부파일들이 해당 폴더에 업로드 됨
			 * 그리고 사용자가 올린 파일명은 그대로 해당폴더에 업로드 하지 않는 게 관례
			 * - 같은 파일명이 있을 경우 덮어씌워지거나 에러가 날 수 있고, 한글/특수문자/띄어쓰기가 포함된 파일명일 경우 
			 * 사용하는 서버에 따라 에러가 발생할 수 있기 때문에 파일명은 반드시 변환시켜서 업로드
			 * 
			 * 기본적으로 파일명 수정작업을 해주는 객체
			 * - DefaultFilenamePolicy객체 (cos.jar에서 제공하는 객체)
			 * - 내부적으로 rename()이라는 메소드가 실행되면서 파일명이 수정됨
			 * - 동일한 파일명이 존재할 경우 파일명 뒤에 카운팅된 숫자를 붙여서 유니크한 파일명을 만듦
			 * 	 ex) aaa.jpg, aaa1.jpg, aaa2.jpg...
			 * 
			 * - 절대 파일명이 안 겹치게끔 rename할 예정
			 * - 즉, DefaultFilenamePolicy객체 사용 안함
			 * 내 입맛대로 나만의 파일명 생성 규칙을 만들어서 파일이름을 바꿔주는 객체 만들어보기
			 */
			MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			// 3. DB에 기록할 데이터들을 뽑아서 Attachment객체에 담기, Board객체에 담기
			// - 카테고리번호, 제목, 내용, 작성자번호를 뽑아서 Board에 Insert
			// - 넘어온 첨부파일이 있다면 원본명, 수정명, 폴더경로를 뽑아서 Attachment테이블에 Insert
			String category = multi.getParameter("category");
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
			String boardWriter = ((Member)request.getSession().getAttribute("loginUser")).getUserNo()+""; 
			
			Board b = new Board();
			b.setCategory(category);
			b.setBoardTitle(title);
			b.setBoardContent(content);
			b.setBoardWriter(boardWriter);
			
			Attachment at = null; // 처음에는 null값으로 초기화시키고, 실제로 사용자가 첨부파일을 업로드 했을 때만 객체 생성
			
			// 첨부파일이 있을 경우 원본명을 반환해주고, 없을 경우 null을 반환해줌
			if(multi.getOriginalFileName("upfile")!=null) {
				 at = new Attachment();
				 at.setOriginName(multi.getOriginalFileName("upfile")); // 원본명
				 at.setChangeName(multi.getFilesystemName("upfile")); // 수정명(실제 서버에 업로드 되어 있는 파일명)
				 at.setFilePath("resources/board_upfiles/");
			}
			
			// 4. 서비스 요청
			int result = new BoardService().insertBoard(b, at);
			
			if(result>0) { // 작성 성공 -> 최신 글 목록으로 이동
				request.getSession().setAttribute("alertMsg", "게시글 작성 성공");
				response.sendRedirect(request.getContextPath()+"/list.bo?currentPage=1");
			}else { // 작성 실패 -> 첨부파일이 있었을 경우 이미 업로드 된 첨부파일을 삭제해주기(용량만 차지함)
				if(at != null) {
					// 삭제 시키고자 하는 파일객체 생성 후 delete메소드 호출시 파일이 삭제 됨
					new File(savePath+at.getChangeName()).delete();
				}
				request.setAttribute("errorMsg", "게시글 작성 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
		}else {
			request.setAttribute("errorMsg", "전송방식이 잘못되었습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
		
	}

}
