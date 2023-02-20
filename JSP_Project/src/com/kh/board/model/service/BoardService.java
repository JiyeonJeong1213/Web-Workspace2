package com.kh.board.model.service;

import static com.kh.common.JDBCTemplate.close;
import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BoardDao;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.model.vo.PageInfo;

public class BoardService {
	
	public int selectListCount() {
		Connection conn = getConnection();
		
		int listCount = new BoardDao().selectListCount(conn);
		
		close(conn);
		
		return listCount;
	}
	
	public ArrayList<Board> selectList(PageInfo pi) {
		Connection conn = getConnection();
		
		ArrayList<Board> list = new BoardDao().selectList(conn, pi);
		
		close(conn);
		
		return list;
	}
	
	public ArrayList<Category> selectCategoryList(){
		Connection conn = getConnection();
		ArrayList<Category> list = new BoardDao().selectCategoryList(conn);
		close(conn);
		return list;
	}
	
	public int insertBoard(Board b, Attachment at) {
		Connection conn = getConnection();
		
		int result1 = new BoardDao().insertBoard(conn, b);
		
		// Attachment테이블에 등록여부를 판단할 변수
		int result2 = 1; // 1로 미리 선언과 동시에 초기화시켜주는 이유는 Attachment테이블에 Insert문이 실행되지 않을 수 있으므로(첨부파일 없는 경우) 
		if(at != null) {
			result2 = new BoardDao().insertAttachment(conn, at);
		}
		
		// 트랜잭션 처리
		if(result1>0 && result2>0) {
			// 첨부파일 없는 경우 insert가 성공했을 때도 result2는 0이기 때문에 rollback처리 될 수 있음
			// 그래서 애초에 result2의 값을 1로 초기화 시켜줘야 함
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result1*result2; // 혹시 하나라도 실패해서 0이 반환될 경우 아예 실패값을 반환하기 위해 곱셈 결과를 반환
	}
	
	public int increaseCount(int bno) {
		Connection conn = getConnection();
		
		int result = new BoardDao().increaseCount(conn, bno);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public Board selectBoard(int bno) {
		Connection conn = getConnection();
		Board b = new BoardDao().selectBoard(conn, bno);
		close(conn);
		return b;
	}
	public Attachment selectAttachment(int bno) {
		Connection conn = getConnection();
		Attachment at = new BoardDao().selectAttachment(conn, bno);
		close(conn);
		return at;
	}
	
}
