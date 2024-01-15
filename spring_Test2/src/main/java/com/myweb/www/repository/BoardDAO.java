package com.myweb.www.repository;

import java.util.List;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	//List<BoardVO> getList();
	List<BoardVO> getList(PagingVO pgvo);

	int readCount(long bno);

	BoardVO getDetail(long bno);

	int update(BoardVO bvo);
//	int update(BoardVO bvo);
	
	int delete(long bno);

	int getTotalCount(PagingVO pgvo);

	long selectOneBno();

	void updateCommentqty();

	void updateFileqty();






}
