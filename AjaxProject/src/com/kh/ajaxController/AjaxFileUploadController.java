package com.kh.ajaxController;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.common.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class AjaxFileUploadController
 */
@WebServlet("/fileUpload.do")
public class AjaxFileUploadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxFileUploadController() {
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
		String filePath = request.getServletContext().getRealPath("/upload/");
		
		MultipartRequest multi = new MultipartRequest(request, filePath, 1024*1024*100, "UTF-8", new MyFileRenamePolicy());
		
		System.out.println(multi.getOriginalFileName("upfile0"));
		
		// 전달된 파일들의 key값만 뽑아오기
		Enumeration e = multi.getFileNames();
		while(e.hasMoreElements()) {
			String filename = (String)e.nextElement();
			String originName = multi.getOriginalFileName(filename); // 넘어온 파일의 원본명
			String changeName = multi.getFilesystemName(filename); // 넘어온 파일의 수정명
			System.out.println(originName+"|||"+changeName);
		}
		
	}

}
