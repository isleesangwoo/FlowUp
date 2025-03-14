-- ?˜¤?¼?´ ê³„ì • ?ƒ?„±?„ ?œ„?•´?„œ?Š” SYS ?˜?Š” SYSTEM ?œ¼ë¡? ?—°ê²°í•˜?—¬ ?‘?—…?„ ?•´?•¼ ?•©?‹ˆ?‹¤. [SYS ?‹œ?‘] --
show user;
-- USER?´(ê°?) "SYS"?…?‹ˆ?‹¤.

-- ?˜¤?¼?´ ê³„ì • ?ƒ?„±?‹œ ê³„ì •ëª? ?•?— c## ë¶™ì´ì§? ?•Šê³? ?ƒ?„±?•˜?„ë¡? ?•˜ê² ìŠµ?‹ˆ?‹¤.
alter session set "_ORACLE_SCRIPT"=true;
-- Session?´(ê°?) ë³?ê²½ë˜?—ˆ?Šµ?‹ˆ?‹¤.

-- ?˜¤?¼?´ ê³„ì •ëª…ì? FINAL_ORAUSER3 ?´ê³? ?•”?˜¸?Š” gclass ?¸ ?‚¬?š©? ê³„ì •?„ ?ƒ?„±?•©?‹ˆ?‹¤.
create user FINAL_ORAUSER3 identified by gclass default tablespace users; 
-- User FINAL_ORAUSER3?´(ê°?) ?ƒ?„±?˜?—ˆ?Šµ?‹ˆ?‹¤.

-- ?œ„?—?„œ ?ƒ?„±?˜?–´ì§? FINAL_ORAUSER3 ?´?¼?Š” ?˜¤?¼?´ ?¼ë°˜ì‚¬?š©? ê³„ì •?—ê²? ?˜¤?¼?´ ?„œë²„ì— ? ‘?†?´ ?˜?–´ì§?ê³?,
-- ?…Œ?´ë¸? ?ƒ?„± ?“±?“±?„ ?•  ?ˆ˜ ?ˆ?„ë¡? ?—¬?Ÿ¬ê°?ì§? ê¶Œí•œ?„ ë¶??—¬?•´ì£¼ê² ?Šµ?‹ˆ?‹¤.
grant connect, resource, create view, unlimited tablespace to FINAL_ORAUSER3;
-- Grant?„(ë¥?) ?„±ê³µí–ˆ?Šµ?‹ˆ?‹¤.



-------------------------------- ?…Œ?Š¤?Š¸?š© ?…Œ?´ë¸? ?ƒ?„± --------------------------------

CREATE TABLE tbl_test (
    no number not null,
    name NVARCHAR2(5) not null
    ,CONSTRAINT PK_tbl_test_no PRIMARY KEY(no)  
);
-- Table TBL_TEST?´(ê°?) ?ƒ?„±?˜?—ˆ?Šµ?‹ˆ?‹¤.

select *
from tab;

insert into tbl_test(no, name) values(100, '?´?›ˆ');
-- 1 ?–‰ ?´(ê°?) ?‚½?…?˜?—ˆ?Šµ?‹ˆ?‹¤.

commit;
-- ì»¤ë°‹ ?™„ë£?.

select *
from TBL_EMPLOYEE;

drop table tbl_test purge;
-- Table TBL_TEST?´(ê°?) ?‚­? œ?˜?—ˆ?Šµ?‹ˆ?‹¤.

commit;

------------------------------------- ê°•ì´?›ˆ ?…Œ?´ë¸? ë§Œë“¤ê¸? ?‹œ?‘ -------------------------------------



-- ========== ìº˜ë¦°?” ê´?? ¨ ?…Œ?´ë¸? ?ƒ?„± ========== --
-- ìº˜ë¦°?” ?…Œ?´ë¸?
CREATE TABLE tbl_calendar_schedule (
   calendarNo     NUMBER(6)     NOT NULL,         -- ìº˜ë¦°?” ID
   fk_employeeNo  NUMBER(6)     NOT NULL,         -- fk_employeeNo
   calendarTitle  NVARCHAR2(50) NOT NULL,         -- ìº˜ë¦°?” ?¼? • ëª?
   startDate      DATE          NOT NULL,         -- ?¼? • ?‹œ?‘ ?‚ ì§?
   endDate        DATE          NOT NULL,         -- ?¼? • ? ?‚ ì§?
   bgColor        NVARCHAR2(50) DEFAULT  'red',   -- ?¼? • ë°°ê²½ ?ƒ‰?ƒ
   releaseStatus  NUMBER(1)     DEFAULT  0,       -- ê³µê°œ ë¹„ê³µê°? ?—¬ë¶? / ê³µê°œ:0 ë¹„ê³µê°?:1
   registerday    DATE          DEFAULT  sysdate  -- ?¼? • ?“±ë¡? ?‚ ì§?
   ,CONSTRAINT PK_tbl_calendar_calendarNo PRIMARY KEY(calendarNo)                                             -- ìº˜ë¦°?” ID PK ì§?? •
   ,CONSTRAINT FK_tbl_calendar_fk_employeeNo FOREIGN KEY(fk_employeeNo) REFERENCES tbl_employee(employeeNo)   -- ?‚¬?›?…Œ?´ë¸”ì—?„œ FK ê°?? ¸?˜´
   ,CONSTRAINT CK_tbl_calendar_releaseStatus CHECK( releaseStatus In(0, 1))                                -- ê³µê°œ:0 ë¹„ê³µê°?:1
); 


create sequence seq_calendarNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CALENDARNO?´(ê°?) ?ƒ?„±?˜?—ˆ?Šµ?‹ˆ?‹¤.


-- ìº˜ë¦°?” ?¼? • ê³µìœ  ?…Œ?´ë¸?
CREATE TABLE tbl_calendar_share (
   calendarShareNo        NUMBER(6)     NOT NULL,         -- ê³µìœ ?š”ì²? ID
   fk_requestEmployeeNo   NUMBER(6)     NOT NULL,         -- ?¼? • ?š”ì²?? ?‚¬ë²? 
   fk_responseEmployeeNo  NUMBER(6)     NOT NULL,         -- ?¼? • ?‘?‹µ? ?‚¬ë²?
   ShareStatus            NUMBER(1)     DEFAULT  0,       -- ??ê¸?, ?ˆ˜?½, ê±°ì ˆ ?—¬ë¶? / ??ê¸?:0, ?ˆ˜?½:1, ê±°ì ˆ:2
   requestDate            DATE          DEFAULT  sysdate, -- ?š”ì²??¼?
   responseDate           DATE          NOT NULL          -- ?‘?‹µ?¼?
   ,CONSTRAINT PK_calendarShareNo PRIMARY KEY(calendarShareNo)                                             -- ìº˜ë¦°?” ID PK ì§?? •
   ,CONSTRAINT FK_share_fk_requestEmployeeNo FOREIGN KEY(fk_requestEmployeeNo) REFERENCES tbl_employee(employeeNo)     -- ?‚¬?›?…Œ?´ë¸”ì—?„œ FK ê°?? ¸?˜´
   ,CONSTRAINT FK_share_fk_responseEmployeeNo FOREIGN KEY(fk_responseEmployeeNo) REFERENCES tbl_employee(employeeNo)   -- ?‚¬?›?…Œ?´ë¸”ì—?„œ FK ê°?? ¸?˜´
   ,CONSTRAINT CK_share_ShareStatus CHECK( ShareStatus In('0','1','2'))                                          -- ??ê¸?:0, ?ˆ˜?½:1, ê±°ì ˆ:2
); -- ê¸?? ?„ˆë¬? ê¸¸ì–´?„œ ì¤„ì¼ ?•„?š” ?ˆ?Œ


create sequence seq_calendarShareNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CALENDARSHARENO?´(ê°?) ?ƒ?„±?˜?—ˆ?Šµ?‹ˆ?‹¤.

-- ========== ìº˜ë¦°?” ê´?? ¨ ?…Œ?´ë¸? ?ƒ?„± ========== --











-----------------------------------------------------------------------------------------------
-- ========== ?˜ˆ?•½ ê´?? ¨ ?…Œ?´ë¸? ?ƒ?„± ========== --
-- ??‚° ??ë¶„ë¥˜ ?…Œ?´ë¸?
CREATE TABLE tbl_asset (
   assetNo           NUMBER(6)     NOT NULL,         -- ?šŒ?˜?‹¤ ID
   assetTitle        NVARCHAR2(50) NOT NULL,         -- ?šŒ?˜?‹¤ ?¥?†Œ ??ë¶„ë¥˜ ëª? (?˜ˆ: 4ì¸? ê³µìš© ê³µê°„)
   assetInfo         CLOB          NOT NULL,         -- ?šŒ?˜?‹¤ ?¥?†Œ ? •ë³? (?˜ˆ: ?†Œ?™”ê¸? ë°°ì¹˜?„ ë°? ë¹„ìƒêµ? ?œ„ì¹? ?‚¬ì§?)
   assetRegisterday  DATE          DEFAULT sysdate,  -- ?šŒ?˜?‹¤ ?“±ë¡ì¼?
   assetChangeday    DATE          NULL,             -- ?šŒ?˜?‹¤ ?ˆ˜? •?¼?
   classification    NUMBER(6)     NOT NULL,         -- ?šŒ?˜?‹¤ / ??‚° êµ¬ë¶„ 0 : ?šŒ?˜?‹¤ 1 : ì°?,ë¹”í”„ë¡œì ?Š¸
   CONSTRAINT PK_tbl_asset_assetNo PRIMARY KEY(assetNo)  -- ?šŒ?˜?‹¤ ID PK ì§?? •
);

create sequence seq_assetNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ROOMNO?´(ê°?) ?ƒ?„±?˜?—ˆ?Šµ?‹ˆ?‹¤.
------------------------------------------------
INSERT INTO tbl_asset (assetNo, assetTitle, assetInfo, assetRegisterday, assetChangeday, classification, asseGroupno, asseDepthno)
VALUES ( seq_assetNo.NEXTVAL, '?šŒ?˜?‹¤ 1', '?†Œ?™”ê¸? ë°°ì¹˜?„ ë°? ë¹„ìƒêµ? ?œ„ì¹? ?‚¬ì§?', sysdate, NULL, 1, seq_assetNo.NEXTVAL, 0);

select * from tbl_asset;
------------------------------------------------
-- ??‚° ??ë¶„ë¥˜ ?…Œ?´ë¸?





------------------------------------------------
-- ??‚° ?ƒ?„¸ ?…Œ?´ë¸?
CREATE TABLE tbl_assetDetail (
   assetDetailNo           NUMBER(6)     NOT NULL,           -- ?šŒ?˜?‹¤ ?ƒ?„¸ ID
   fk_assetNo              NUMBER(6)     NOT NULL,           -- tbl_asset ?šŒ?˜?‹¤ ID pk
   assetName               NVARCHAR2(50) NOT NULL,           -- ?šŒ?˜?‹¤ ?ƒ?„¸ ?´ë¦?
   assetDetailRegisterday  DATE          DEFAULT sysdate,   -- ?šŒ?˜?‹¤ ?ƒ?„¸ ?“±ë¡ì¼?
   assetDetailChangeday    DATE          NULL,              -- ?šŒ?˜?‹¤ ?ƒ?„¸ ?ˆ˜? •?¼?
   
   CONSTRAINT PK_tbl_assetDetail_assetDeNo PRIMARY KEY(assetDetailNo),  -- ?šŒ?˜?‹¤ ?ƒ?„¸ ID PK ì§?? •
   CONSTRAINT FK_tbl_assetDetail_fk_assetNo FOREIGN KEY(fk_assetNo) REFERENCES tbl_asset(assetNo) ON DELETE CASCADE  -- ?šŒ?˜?‹¤ ?…Œ?´ë¸”ì—?„œ FK ê°?? ¸?˜´
);


create sequence seq_assetDetailNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ASSETDETAILNO?´(ê°?) ?ƒ?„±?˜?—ˆ?Šµ?‹ˆ?‹¤.
------------------------------------------------

select *
from tbl_assetDetail;

INSERT INTO tbl_assetDetail (assetDetailNo,fk_assetNo,assetName,assetDetailRegisterday,assetDetailChangeday,asseDeGroupno,asseDeDepthno) 
VALUES (seq_assetDetailNo.nextval, 100029, '?–‰ë³?', sysdate, NULL, 100016, 1);

INSERT INTO tbl_assetDetail (assetDetailNo,fk_assetNo,assetName,assetDetailRegisterday,assetDetailChangeday,asseDeGroupno,asseDeDepthno) 
VALUES (seq_assetDetailNo.nextval, 100029, '?‚¬?‘', sysdate, NULL, 100016, 1);


INSERT INTO tbl_assetDetail (assetDetailNo,fk_assetNo,assetName,assetDetailRegisterday,assetDetailChangeday,asseDeGroupno,asseDeDepthno) 
VALUES (seq_assetDetailNo.nextval, 100027, '?ˆˆë¬?', sysdate, NULL, 100016, 1);

commit;
------------------------------------------------

drop table tbl_assetInformation;

desc tbl_assetDetail;

ALTER TABLE tbl_assetInformation ADD release NUMBER(1) DEFAULT 0 NOT NULL;
desc tbl_assetInformation;


select *
from tbl_assetInformation;

-- ë¹„í’ˆ ? •ë³? ?…Œ?´ë¸?
CREATE TABLE tbl_assetInformation (
   assetInformationNo           NUMBER(6)     NOT NULL,            -- ?šŒ?˜?‹¤ ?´?š©? •ë³? ID
   fk_assetDetailNo             NUMBER(6)     NOT NULL,            -- tbl_assetDetail ??‚°?ƒ?„¸ ID fk
   fk_assetNo                   NUMBER(6)     NOT NULL,            -- tbl_asset ??‚° ID fk
   InformationTitle             NVARCHAR2(50) NULL,                 -- ?šŒ?˜?‹¤ ë¹„í’ˆ ?´ë¦?
   InformationContents          CHAR(1)      DEFAULT 'X',          -- ?šŒ?˜?‹¤ ë¹„í’ˆ ?œ ë¬?
   CONSTRAINT PK_tbl_assetInfo_assetInfoNo PRIMARY KEY (assetInformationNo),  -- ?šŒ?˜?‹¤ ID PK ì§?? •
   release                      NUMBER(1)    DEFAULT 0    NOT NULL, -- ê³µê°œ?—¬ë¶?
   CONSTRAINT FK_assetInfo_fk_assetDetailNo FOREIGN KEY (fk_assetDetailNo) REFERENCES tbl_assetDetail(assetDetailNo) ON DELETE CASCADE,  -- ?šŒ?˜?‹¤?ƒ?„¸?…Œ?´ë¸”ì—?„œ FK ê°?? ¸?˜´
   CONSTRAINT FK_tbl_assetInfo_fk_assetNo FOREIGN KEY (fk_assetNo) REFERENCES tbl_asset(assetNo) ON DELETE CASCADE  -- ?šŒ?˜?‹¤ ?…Œ?´ë¸”ì—?„œ FK ê°?? ¸?˜´
);


create sequence seq_assetInformationNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ASSETINFORMATIONNO?´(ê°?) ?ƒ?„±?˜?—ˆ?Šµ?‹ˆ?‹¤.
------------------------------------------------
INSERT INTO tbl_assetInformation (assetInformationNo, fk_assetDetailNo, fk_assetNo, InformationTitle, InformationContents)
VALUES ( seq_assetInformationNo.NEXTVAL, 100014, 100029, 'ë¹”í”„ë¡œì ?Š¸', DEFAULT);


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



-- ?ƒ?„¸ ?˜ˆ?•½ ?…Œ?´ë¸?
CREATE TABLE tbl_assetReservation (
   assetReservationNo           NUMBER(6)     NOT NULL,          -- ?šŒ?˜?‹¤ ?´?š©? •ë³? ID
   fk_assetDetailNo             NUMBER(6)     NOT NULL,          -- tbl_roomDetail ?šŒ?˜?‹¤ ?ƒ?„¸ ID fk
   fk_employeeNo               NUMBER(6)     NOT NULL,          -- tbl_employee ?‚¬?› ID fk
   reservationStart            DATE          NULL,              -- ?´?š©?‹œ?‘?‹œê°?
   reservationEnd              DATE          NULL,              -- ?´?š©??‹œê°?
   reservationDay              DATE          NULL,              -- ?˜ˆ?•½?•œ ?‚ ì§?
   reservationContents         NVARCHAR2(50) NULL               -- ?˜ˆ?•½?•œ ?´?œ 
   ,CONSTRAINT PK_Reservation_ReservaNo PRIMARY KEY(assetReservationNo)                           -- ?šŒ?˜?‹¤ ID PK ì§?? •
   ,CONSTRAINT FK_assetInfo_fk_assetDeNo FOREIGN KEY(fk_assetDetailNo) REFERENCES tbl_assetDetail(assetDetailNo) ON DELETE CASCADE    -- ?šŒ?˜?‹¤?ƒ?„¸?…Œ?´ë¸”ì—?„œ FK ê°?? ¸?˜´
   ,CONSTRAINT FK_Reservation_fk_employeeNo FOREIGN KEY(fk_employeeNo) REFERENCES tbl_employee(employeeNo)   -- ?‚¬?›?…Œ?´ë¸”ì—?„œ FK ê°?? ¸?˜´
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

(reservationStart * 60) - (reservationEnd * 60) / 30 = 30ë¶? ?‹¨?œ„ë¡? ?Š?? ê²ƒì˜ ê°œìˆ˜


create sequence seq_roomReservationNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- 
-- ============= ?šŒ?˜?‹¤ ?˜ˆ?•½ ?ƒ?„± ============= --

-- ========== ?˜ˆ?•½ ê´?? ¨ ?…Œ?´ë¸? ?ƒ?„± ========== --



insert into tbl_assetReservation(assetReservationNo, fk_assetDetailNo, fk_employeeNo, reservationStart, reservationEnd, reservationContents, reservationDay)
values(seq_roomReservationNo.nextval, 100014, 100012, to_date('2025-02-25 12:00', 'yyyy-mm-dd hh24:mi'), to_date('2025-02-25 14:30', 'yyyy-mm-dd hh24:mi'), 'ê·¸ëƒ¥~',  sysdate);


commit;





desc tbl_assetInformation;



select ASSETINFORMATIONNO, FK_ASSETDETAILNO, INFORMATIONTITLE, INFORMATIONCONTENTS, RELEASE
from tbl_assetInformation
where FK_ASSETDETAILNO = 100030;

insert into tbl_assetInformation(ASSETINFORMATIONNO, FK_ASSETDETAILNO, INFORMATIONTITLE, INFORMATIONCONTENTS, RELEASE)
values(seq_assetInformationNo.nextval, 100030, '?™”?´?Š¸ë³´ë“œ', 'O', 0);


insert into tbl_assetInformation(ASSETINFORMATIONNO, FK_ASSETDETAILNO, INFORMATIONTITLE, INFORMATIONCONTENTS, RELEASE)
values(seq_assetInformationNo.nextval, 100030, 'ë¹”í”„ë¡œì ?Š¸', 'X', 1);

commit;







desc tbl_calendar_schedule;


select FK_EMPLOYEENO, SUBJECT, to_char(STARTDATE, 'yyyyMMdd HH24mi') as STARTDATE, to_char(ENDDATE, 'yyyyMMdd HH24mi') as ENDDATE
from tbl_calendar_schedule;





select fk_employeeno, subject, 
       to_char(startdate, 'YYYYMMDD HH24MI') as startdate, 
       to_char(enddate, 'YYYYMMDD HH24MI') as enddate
from tbl_calendar_schedule
where fk_employeeno = 100012
and (
    (startdate between to_date('20250312 0900', 'YYYY-MM-DD HH24:MI') 
                   and to_date('20250312 2130', 'YYYY-MM-DD HH24:MI'))
    or 
    (enddate between to_date('20250312 0900', 'YYYY-MM-DD HH24:MI') 
                 and to_date('20250312 2130', 'YYYY-MM-DD HH24:MI'))
    or 
    (startdate <= to_date('20250312 0900', 'YYYY-MM-DD HH24:MI') 
     and enddate >= to_date('20250312 2130', 'YYYY-MM-DD HH24:MI'))
);



select distinct name, fk_employeeno, subject, 
       to_char(startdate, 'YYYY-MM-DD HH24:MI') as startdate, 
       to_char(enddate, 'YYYY-MM-DD HH24:MI') as enddate
from tbl_calendar_schedule cs join tbl_employee em
on cs.fk_employeeno = em.employeeno
where 
    (startdate <= to_date('20250312 235959', 'YYYY-MM-DD HH24:MI:SS') 
     and enddate >= to_date('20250312 000000', 'YYYY-MM-DD HH24:MI:SS'));
