-- 오라클 계정 생성을 위해서는 SYS 또는 SYSTEM 으로 연결하여 작업을 해야 합니다. [SYS 시작] --
show user;
-- USER이(가) "SYS"입니다.

-- 오라클 계정 생성시 계정명 앞에 c## 붙이지 않고 생성하도록 하겠습니다.
alter session set "_ORACLE_SCRIPT"=true;
-- Session이(가) 변경되었습니다.

-- 오라클 계정명은 FINAL_ORAUSER3 이고 암호는 gclass 인 사용자 계정을 생성합니다.
create user FINAL_ORAUSER3 identified by gclass default tablespace users; 
-- User FINAL_ORAUSER3이(가) 생성되었습니다.

-- 위에서 생성되어진 FINAL_ORAUSER3 이라는 오라클 일반사용자 계정에게 오라클 서버에 접속이 되어지고,
-- 테이블 생성 등등을 할 수 있도록 여러가지 권한을 부여해주겠습니다.
grant connect, resource, create view, unlimited tablespace to FINAL_ORAUSER3;
-- Grant을(를) 성공했습니다.



-------------------------------- 테스트용 테이블 생성 --------------------------------

CREATE TABLE tbl_test (
    no number not null,
    name NVARCHAR2(5) not null
    ,CONSTRAINT PK_tbl_test_no PRIMARY KEY(no)  
);
-- Table TBL_TEST이(가) 생성되었습니다.

select *
from tab;

insert into tbl_test(no, name) values(100, '이훈');
-- 1 행 이(가) 삽입되었습니다.

commit;
-- 커밋 완료.

select *
from TBL_EMPLOYEE;

drop table tbl_test purge;
-- Table TBL_TEST이(가) 삭제되었습니다.

commit;

------------------------------------- 강이훈 테이블 만들기 시작 -------------------------------------



-- ========== 캘린더 관련 테이블 생성 ========== --
-- 캘린더 테이블
CREATE TABLE tbl_calendar_schedule (
   calendarNo     NUMBER(6)     NOT NULL,         -- 캘린더 ID
   fk_employeeNo  NUMBER(6)     NOT NULL,         -- fk_employeeNo
   calendarTitle  NVARCHAR2(50) NOT NULL,         -- 캘린더 일정 명
   startDate      DATE          NOT NULL,         -- 일정 시작 날짜
   endDate        DATE          NOT NULL,         -- 일정 끝 날짜
   bgColor        NVARCHAR2(50) DEFAULT  'red',   -- 일정 배경 색상
   releaseStatus  NUMBER(1)     DEFAULT  0,       -- 공개 비공개 여부 / 공개:0 비공개:1
   registerday    DATE          DEFAULT  sysdate  -- 일정 등록 날짜
   ,CONSTRAINT PK_tbl_calendar_calendarNo PRIMARY KEY(calendarNo)                                             -- 캘린더 ID PK 지정
   ,CONSTRAINT FK_tbl_calendar_fk_employeeNo FOREIGN KEY(fk_employeeNo) REFERENCES tbl_employee(employeeNo)   -- 사원테이블에서 FK 가져옴
   ,CONSTRAINT CK_tbl_calendar_releaseStatus CHECK( releaseStatus In(0, 1))                                -- 공개:0 비공개:1
); 


create sequence seq_calendarNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CALENDARNO이(가) 생성되었습니다.


-- 캘린더 일정 공유 테이블
CREATE TABLE tbl_calendar_share (
   calendarShareNo        NUMBER(6)     NOT NULL,         -- 공유요청 ID
   fk_requestEmployeeNo   NUMBER(6)     NOT NULL,         -- 일정 요청자 사번 
   fk_responseEmployeeNo  NUMBER(6)     NOT NULL,         -- 일정 응답자 사번
   ShareStatus            NUMBER(1)     DEFAULT  0,       -- 대기, 수락, 거절 여부 / 대기:0, 수락:1, 거절:2
   requestDate            DATE          DEFAULT  sysdate, -- 요청일자
   responseDate           DATE          NOT NULL          -- 응답일자
   ,CONSTRAINT PK_calendarShareNo PRIMARY KEY(calendarShareNo)                                             -- 캘린더 ID PK 지정
   ,CONSTRAINT FK_share_fk_requestEmployeeNo FOREIGN KEY(fk_requestEmployeeNo) REFERENCES tbl_employee(employeeNo)     -- 사원테이블에서 FK 가져옴
   ,CONSTRAINT FK_share_fk_responseEmployeeNo FOREIGN KEY(fk_responseEmployeeNo) REFERENCES tbl_employee(employeeNo)   -- 사원테이블에서 FK 가져옴
   ,CONSTRAINT CK_share_ShareStatus CHECK( ShareStatus In('0','1','2'))                                          -- 대기:0, 수락:1, 거절:2
); -- 글자 너무 길어서 줄일 필요 있음


create sequence seq_calendarShareNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CALENDARSHARENO이(가) 생성되었습니다.

-- ========== 캘린더 관련 테이블 생성 ========== --











-----------------------------------------------------------------------------------------------
-- ========== 예약 관련 테이블 생성 ========== --
-- 자산 대분류 테이블
CREATE TABLE tbl_asset (
   assetNo           NUMBER(6)     NOT NULL,         -- 회의실 ID
   assetTitle        NVARCHAR2(50) NOT NULL,         -- 회의실 장소 대분류 명 (예: 4층 공용 공간)
   assetInfo         CLOB          NOT NULL,         -- 회의실 장소 정보 (예: 소화기 배치도 및 비상구 위치 사진)
   assetRegisterday  DATE          DEFAULT sysdate,  -- 회의실 등록일자
   assetChangeday    DATE          NULL,             -- 회의실 수정일자
   classification    NUMBER(6)     NOT NULL,         -- 회의실 / 자산 구분 0 : 회의실 1 : 차,빔프로젝트
   CONSTRAINT PK_tbl_asset_assetNo PRIMARY KEY(assetNo)  -- 회의실 ID PK 지정
);

create sequence seq_assetNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ROOMNO이(가) 생성되었습니다.
------------------------------------------------
INSERT INTO tbl_asset (assetNo, assetTitle, assetInfo, assetRegisterday, assetChangeday, classification, asseGroupno, asseDepthno)
VALUES ( seq_assetNo.NEXTVAL, '회의실 1', '소화기 배치도 및 비상구 위치 사진', sysdate, NULL, 1, seq_assetNo.NEXTVAL, 0);

select * from tbl_asset;
------------------------------------------------
-- 자산 대분류 테이블





------------------------------------------------
-- 자산 상세 테이블
CREATE TABLE tbl_assetDetail (
   assetDetailNo           NUMBER(6)     NOT NULL,           -- 회의실 상세 ID
   fk_assetNo              NUMBER(6)     NOT NULL,           -- tbl_asset 회의실 ID pk
   assetName               NVARCHAR2(50) NOT NULL,           -- 회의실 상세 이름
   assetDetailRegisterday  DATE          DEFAULT sysdate,   -- 회의실 상세 등록일자
   assetDetailChangeday    DATE          NULL,              -- 회의실 상세 수정일자
   
   CONSTRAINT PK_tbl_assetDetail_assetDeNo PRIMARY KEY(assetDetailNo),  -- 회의실 상세 ID PK 지정
   CONSTRAINT FK_tbl_assetDetail_fk_assetNo FOREIGN KEY(fk_assetNo) REFERENCES tbl_asset(assetNo) ON DELETE CASCADE  -- 회의실 테이블에서 FK 가져옴
);


create sequence seq_assetDetailNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ASSETDETAILNO이(가) 생성되었습니다.
------------------------------------------------

select *
from tbl_assetDetail;

INSERT INTO tbl_assetDetail (assetDetailNo,fk_assetNo,assetName,assetDetailRegisterday,assetDetailChangeday,asseDeGroupno,asseDeDepthno) 
VALUES (seq_assetDetailNo.nextval, 100029, '행복', sysdate, NULL, 100016, 1);

INSERT INTO tbl_assetDetail (assetDetailNo,fk_assetNo,assetName,assetDetailRegisterday,assetDetailChangeday,asseDeGroupno,asseDeDepthno) 
VALUES (seq_assetDetailNo.nextval, 100029, '사랑', sysdate, NULL, 100016, 1);


INSERT INTO tbl_assetDetail (assetDetailNo,fk_assetNo,assetName,assetDetailRegisterday,assetDetailChangeday,asseDeGroupno,asseDeDepthno) 
VALUES (seq_assetDetailNo.nextval, 100027, '눈물', sysdate, NULL, 100016, 1);

commit;
------------------------------------------------

drop table tbl_assetInformation;

desc tbl_assetDetail;

ALTER TABLE tbl_assetInformation ADD disclosure NUMBER(1) DEFAULT 0 NOT NULL;

-- 비품 정보 테이블
CREATE TABLE tbl_assetInformation (
   assetInformationNo           NUMBER(6)     NOT NULL,            -- 회의실 이용정보 ID
   fk_assetDetailNo             NUMBER(6)     NOT NULL,            -- tbl_assetDetail 자산상세 ID fk
   fk_assetNo                   NUMBER(6)     NOT NULL,            -- tbl_asset 자산 ID fk
   InformationTitle             NVARCHAR2(50) NULL,                 -- 회의실 비품 이름
   InformationContents          CHAR(1)      DEFAULT 'X',          -- 회의실 비품 유무
   CONSTRAINT PK_tbl_assetInfo_assetInfoNo PRIMARY KEY (assetInformationNo),  -- 회의실 ID PK 지정
   CONSTRAINT FK_assetInfo_fk_assetDetailNo FOREIGN KEY (fk_assetDetailNo) REFERENCES tbl_assetDetail(assetDetailNo) ON DELETE CASCADE,  -- 회의실상세테이블에서 FK 가져옴
   CONSTRAINT FK_tbl_assetInfo_fk_assetNo FOREIGN KEY (fk_assetNo) REFERENCES tbl_asset(assetNo) ON DELETE CASCADE  -- 회의실 테이블에서 FK 가져옴
);


create sequence seq_assetInformationNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ASSETINFORMATIONNO이(가) 생성되었습니다.
------------------------------------------------
INSERT INTO tbl_assetInformation (assetInformationNo, fk_assetDetailNo, fk_assetNo, InformationTitle, InformationContents)
VALUES ( seq_assetInformationNo.NEXTVAL, 100014, 100029, '빔프로젝트', DEFAULT);


select assetInformationNo, fk_assetDetailNo, fk_assetNo, InformationTitle, InformationContents
from tbl_assetInformation
where fk_assetNo = 100029;

commit;

select * from tbl_asset;
------------------------------------------------
select *
from tbl_employee;

select *
from tbl_post;

25/02/15 
25/02/19
insert into tbl_assetReservation(assetReservationNo, fk_assetDetailNo, fk_employeeNo, reservationStart, reservationEnd, reservationDay)
values(seq_roomReservationNo.nextval, 100009, 100012, to_date('2025/02/19 09:00:00', 'yyyy/mm/dd HH24:mi:ss'), to_date('2025/02/19 13:00:00', 'yyyy/mm/dd HH24:mi:ss'), sysdate);

commit;

select *
from tbl_assetDetail;


assetname

select assetNo, assetTitle, assetInfo, assetRegisterday, assetChangeday, classification
		from tbl_asset
        
select * 
from tbl_assetReservation Re join tbl_assetDetail De
on Re.fk_assetdetailno = De.assetdetailno
left join tbl_asset_class ass
on De.fk_assetno = ass.assetno
where Re.fk_employeeno = 100012;



-- 상세 예약 테이블
CREATE TABLE tbl_assetReservation (
   assetReservationNo           NUMBER(6)     NOT NULL,          -- 회의실 이용정보 ID
   fk_assetDetailNo             NUMBER(6)     NOT NULL,          -- tbl_roomDetail 회의실 상세 ID fk
   fk_employeeNo               NUMBER(6)     NOT NULL,          -- tbl_employee 사원 ID fk
   reservationStart            DATE          NULL,              -- 이용시작시간
   reservationEnd              DATE          NULL,              -- 이용끝시간
   reservationDay              DATE          NULL,              -- 예약한 날짜
   reservationContents         NVARCHAR2(50) NULL               -- 예약한 이유
   ,CONSTRAINT PK_Reservation_ReservaNo PRIMARY KEY(assetReservationNo)                           -- 회의실 ID PK 지정
   ,CONSTRAINT FK_assetInfo_fk_assetDeNo FOREIGN KEY(fk_assetDetailNo) REFERENCES tbl_assetDetail(assetDetailNo) ON DELETE CASCADE    -- 회의실상세테이블에서 FK 가져옴
   ,CONSTRAINT FK_Reservation_fk_employeeNo FOREIGN KEY(fk_employeeNo) REFERENCES tbl_employee(employeeNo)   -- 사원테이블에서 FK 가져옴
); 

drop table tbl_assetReservation purge;

select assetReservationNo, fk_assetDetailNo, fk_employeeNo, 
       to_char(reservationStart, 'yyyy.mm.dd hh24:mi') as reservationStart, 
       to_char(reservationEnd, 'yyyy.mm.dd hh24:mi') as reservationEnd, 
       to_char(reservationDay, 'yyyy.mm.dd hh24:mi'), 
       reservationContents
from tbl_assetReservation
where to_char(reservationEnd, 'yyyy.mm.dd') between '2025.02.24' and '2025.02.28'
order by assetReservationNo;


12:00
14:30



2:30

5

(reservationStart * 60) - (reservationEnd * 60) / 30 = 30분 단위로 끊은 것의 개수


create sequence seq_roomReservationNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- 
-- ============= 회의실 예약 생성 ============= --

-- ========== 예약 관련 테이블 생성 ========== --



insert into tbl_assetReservation(assetReservationNo, fk_assetDetailNo, fk_employeeNo, reservationStart, reservationEnd, reservationContents, reservationDay)
values(seq_roomReservationNo.nextval, 100014, 100012, to_date('2025-02-25 12:00', 'yyyy-mm-dd hh24:mi'), to_date('2025-02-25 14:30', 'yyyy-mm-dd hh24:mi'), '그냥~',  sysdate);


commit;