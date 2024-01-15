package com.myweb.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.repository.BoardDAO;
import com.myweb.www.repository.FileDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class BoardServiceImple implements BoardService{
	
	private final BoardDAO bdao;
	
	private final FileDAO fdao;
	

//	@Override
//	public int insert(BoardVO bvo) {
//		log.info("insert service impl");
//		return bdao.insert(bvo);
//	}
	
	@Override
	public int insert(BoardDTO bdto) {
		log.info("insert service impl");
		//기존 보드 내용을 DB에 저장
		int isOk = bdao.insert(bdto.getBvo());
		
		// flist를 db에 저장
		if(bdto.getFlist() == null) {
			// 파일의 값이 없다면....
			return isOk;	// 그냥 성공한 걸로 처리
		} else {
			// 파일 저장
			if(isOk >0 && bdto.getFlist().size()>0) {
				// fvo는 bno는 아직 설정되기 전.
				// 현재 bdto 시점에서는 아직 bno가 생성되지 않음
				// insert를 통해 자동생성=> DB에서 검색해서 가져오기 (어디서?->bno에서 값이 가장 큰것)
				long bno = bdao.selectOneBno();
				for(FileVO fvo : bdto.getFlist()) {
					fvo.setBno(bno);
					// 파일 (실제) 저장
					isOk *= fdao.insertFile(fvo);
				}	
			}
		}
		return isOk;
	}
	
	/*
	@Override
	public List<BoardVO> getList() {
		log.info("getList service impl");
		return bdao.getList();
	}
	*/
	
	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		bdao.updateCommentqty();
		bdao.updateFileqty();
		
		log.info("getList service impl");
		return bdao.getList(pgvo);
	}

	@Override
	public BoardDTO getDetail(long bno) {
		// readCount
//		bdao.readCount(bno,1);	// bno,1
		
		int isOk = bdao.readCount(bno);
		BoardVO bvo = bdao.getDetail(bno);
		List<FileVO> flist = fdao.getFileList(bno);
		BoardDTO bdto = new BoardDTO(bvo, flist);
		return bdto;
	}

//	@Override
//	public int modify(BoardVO bvo) {
//		log.info("Modify service impl");		
//		return bdao.update(bvo);
//	}
	
	@Override
	public int modify(BoardDTO bdto) {
		log.info("modify service impl");
		//기존 보드 내용을 DB에 저장
		int isOk = bdao.update(bdto.getBvo());
		
		// flist를 db에 저장
		if(bdto.getFlist() == null) {
			// 파일의 값이 없다면(파일이 존재 x다면)....
			return isOk;	// 그냥 성공한 걸로 처리
		} else {
			// 파일 저장
			if(isOk >0 && bdto.getFlist().size()>0) {
				// 수정전 정보는 아래 bno로 그대로 가져오면 되지만
				// 수정하여 추가하는 정보(수정 가능하려는 title,content와 추가 하려는 file)의 경우
				// 아래와같이 title,.....의 정보는 그대로 가져옴
				long bno = bdto.getBvo().getBno();
//				long bno = bdao.selectOneBno();	// 셋팅된 bvo 정보들
				// file의 경우 기존의 파일은 그대로, 추가되는 파일들은 아래와 같이 for(복수의 파일경우)을 통해 흩뿌리기로 나열 
				for(FileVO fvo : bdto.getFlist()) {
					fvo.setBno(bno);
//					fvo.setBno(bdto.getBvo().getBno());
					// 파일 (실제) 저장
					isOk *= fdao.insertFile(fvo);
				}
			}
		}
		return isOk;
	}
	

	@Override
	public int delete(long bno) {
		log.info("delete service impl");	
		return bdao.delete(bno);
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		log.info("getTotalCount service impl");
		return bdao.getTotalCount(pgvo);
	}

	@Override
	public int removeFile(String uuid) {
		// TODO Auto-generated method stub
		return fdao.removeFile(uuid);
	}




	
}
