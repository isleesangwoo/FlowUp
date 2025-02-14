//package com.spring.app.board.domain;
//
//public class CommentVO {
//
//	private commentNo          NUMBER                not null          -- 
//	private fk_postNo          NUMBER                not null          -- 해당 댓글이 속한 게시글 번호
//	private fk_employeeNo      number(6)             not null          -- 댓글 작성자
//	private name               NVARCHAR2(50)         not null          --
//	content            CLOB                  not null          -- 
//	regDate            DATE default SYSDATE  not null          -- 
//	status             NUMBER(1) default 1   not null          -- 삭제여부 1 활성화 0 삭제
//	groupNo            NUMBER                not null          -- 댓글 그룹 번호 (원댓글/대댓글을 묶는 값)
//	fk_commentNo       NUMBER default 0      not null          -- 부모 댓글 번호 (대댓글일 경우 부모 댓글 번호, 댓글이면 0)
//	depthNo            NUMBER default 0      not null          -- CHECK (depthNo IN (0,1)) / 댓글: 0, 대댓글: 1 (들여쓰기를 위한 컬럼)
//	
//}
