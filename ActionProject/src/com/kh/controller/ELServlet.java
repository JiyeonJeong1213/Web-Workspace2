package com.kh.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.model.vo.Person;

/**
 * Servlet implementation class ELServlet
 */
@WebServlet("/el.do")
public class ELServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ELServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 데이터들을 담을 수 있는 객체(scope == 영역)
		 * 
		 * 1. ServletContext(application scope)
		 * 	  한 애플리케이션 당 1개만 존재하는 객체
		 *    이 영역에 데이터를 담으면 애플리케이션 전역에서 사용 가능
		 *    => 공유범위가 가장 큼
		 *    
		 * 2. HttpSesseion(session scope)
		 * 	  한 브라우저 당 한개만 존재하는 객체
		 * 	  이 영역에 데이터를 담으면 jsp/servlet안에서 사용 가능
		 * 	  값이 한번 담기면 서버가 멈추거나 브라우저가 종료되기 전까지 사용 가능
		 * 	  => 공유범위가 제한적
		 * 
		 * 3. HttpServletRequest (request scope)
		 *    요청 및 응답시 매번 생성되는 객체
		 *    이 영역에 데이터를 담으면 해당 request객체로 포워딩 받는 응답 jsp에서만 사용 가능
		 *    => 공유범위가 해당 요청에 대한 응답 jsp까지
		 *    
		 * 4. PageContext(page scope)
		 * 	  현재 jsp페이지에서만 사용 가능
		 *    => 공유범위가 가장 적음
		 *    
		 * 위 객체들에 값을 담을 때는 객체.setAttribute("키", 담고자하는 데이터);
		 * 				꺼낼 때는 객체.getAttribute("키");
		 * 				삭제  		removeAttribute("키");
		 * 위 객체들은 모두 jsp페이지에서 별도의 임포트나 변수선언 없이 사용할 수 있도록 기본적으로 내장되어 있음
		 */
		
		// requestScope에 데이터 담기
		request.setAttribute("classroom", "C강의장");
		request.setAttribute("student", new Person("지연","여자","학생"));
		
		// sessionScope에 데이터 담기
		HttpSession session = request.getSession();
		session.setAttribute("academy", "KH정보교육원");
		session.setAttribute("teacher", new Person("홍길동","남자","선생"));
		
		// 동일한 키 값으로 데이터 추가하기
		request.setAttribute("scope", "request scope");
		session.setAttribute("scope", "session scope");
		
		// applicationScope에 데이터 담기
		ServletContext application = request.getServletContext();
		application.setAttribute("scope", "application scope");
		
		request.getRequestDispatcher("views/1_EL/01_el.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
