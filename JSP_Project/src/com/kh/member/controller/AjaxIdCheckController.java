package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class AjaxIdCheckController
 */
@WebServlet("/idCheck.me")
public class AjaxIdCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxIdCheckController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 사용자가 전달한 데이터 변수화
		String id = request.getParameter("id");
		// 2. db에 현재 전달된 데이터가 존재하는지 확인
		String userId = new MemberService().checkId(id);
		// 3. 중복된 아이디가 존재하는 케이스, 존재하지 않는 케이스별로 데이터 전달
		if(userId != null) { // 중복된 아이디가 존재하는 경우 --> 사용불가
			response.getWriter().print("NNNNN");
		}else { // 중복된 아이디가 없는 경우 --> 사용가능
			response.getWriter().print("NNNNY");
		}
		// response.setContentType("text/html; charset=UTF-8"); 영어만 있어서 안 써도 됨
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
