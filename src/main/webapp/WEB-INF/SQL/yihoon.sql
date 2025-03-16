-- ?ò§?ùº?Å¥ Í≥ÑÏ†ï ?Éù?Ñ±?ùÑ ?úÑ?ï¥?Ñú?äî SYS ?òê?äî SYSTEM ?úºÎ°? ?ó∞Í≤∞Ìïò?ó¨ ?ûë?óÖ?ùÑ ?ï¥?ïº ?ï©?ãà?ã§. [SYS ?ãú?ûë] --
show user;
-- USER?ù¥(Í∞?) "SYS"?ûÖ?ãà?ã§.

-- ?ò§?ùº?Å¥ Í≥ÑÏ†ï ?Éù?Ñ±?ãú Í≥ÑÏ†ïÎ™? ?ïû?óê c## Î∂ôÏù¥Ïß? ?ïäÍ≥? ?Éù?Ñ±?ïò?èÑÎ°? ?ïòÍ≤†Ïäµ?ãà?ã§.
alter session set "_ORACLE_SCRIPT"=true;
-- Session?ù¥(Í∞?) Î≥?Í≤ΩÎêò?óà?äµ?ãà?ã§.

-- ?ò§?ùº?Å¥ Í≥ÑÏ†ïÎ™ÖÏ? FINAL_ORAUSER3 ?ù¥Í≥? ?ïî?ò∏?äî gclass ?ù∏ ?Ç¨?ö©?ûê Í≥ÑÏ†ï?ùÑ ?Éù?Ñ±?ï©?ãà?ã§.
create user FINAL_ORAUSER3 identified by gclass default tablespace users; 
-- User FINAL_ORAUSER3?ù¥(Í∞?) ?Éù?Ñ±?êò?óà?äµ?ãà?ã§.

-- ?úÑ?óê?Ñú ?Éù?Ñ±?êò?ñ¥Ïß? FINAL_ORAUSER3 ?ù¥?ùº?äî ?ò§?ùº?Å¥ ?ùºÎ∞òÏÇ¨?ö©?ûê Í≥ÑÏ†ï?óêÍ≤? ?ò§?ùº?Å¥ ?ÑúÎ≤ÑÏóê ?†ë?Üç?ù¥ ?êò?ñ¥Ïß?Í≥?,
-- ?Öå?ù¥Î∏? ?Éù?Ñ± ?ì±?ì±?ùÑ ?ï† ?àò ?ûà?èÑÎ°? ?ó¨?ü¨Í∞?Ïß? Í∂åÌïú?ùÑ Î∂??ó¨?ï¥Ï£ºÍ≤†?äµ?ãà?ã§.
grant connect, resource, create view, unlimited tablespace to FINAL_ORAUSER3;
-- Grant?ùÑ(Î•?) ?Ñ±Í≥µÌñà?äµ?ãà?ã§.



-------------------------------- ?Öå?ä§?ä∏?ö© ?Öå?ù¥Î∏? ?Éù?Ñ± --------------------------------

CREATE TABLE tbl_test (
    no number not null,
    name NVARCHAR2(5) not null
    ,CONSTRAINT PK_tbl_test_no PRIMARY KEY(no)  
);
-- Table TBL_TEST?ù¥(Í∞?) ?Éù?Ñ±?êò?óà?äµ?ãà?ã§.

select *
from tab;

insert into tbl_test(no, name) values(100, '?ù¥?õà');
-- 1 ?ñâ ?ù¥(Í∞?) ?ÇΩ?ûÖ?êò?óà?äµ?ãà?ã§.

commit;
-- Ïª§Î∞ã ?ôÑÎ£?.

select *
from TBL_EMPLOYEE;

drop table tbl_test purge;
-- Table TBL_TEST?ù¥(Í∞?) ?Ç≠?†ú?êò?óà?äµ?ãà?ã§.

commit;

------------------------------------- Í∞ïÏù¥?õà ?Öå?ù¥Î∏? ÎßåÎì§Í∏? ?ãú?ûë -------------------------------------



-- ========== Ï∫òÎ¶∞?çî Í¥??†® ?Öå?ù¥Î∏? ?Éù?Ñ± ========== --
-- Ï∫òÎ¶∞?çî ?Öå?ù¥Î∏?
CREATE TABLE tbl_calendar_schedule (
   calendarNo     NUMBER(6)     NOT NULL,         -- Ï∫òÎ¶∞?çî ID
   fk_employeeNo  NUMBER(6)     NOT NULL,         -- fk_employeeNo
   calendarTitle  NVARCHAR2(50) NOT NULL,         -- Ï∫òÎ¶∞?çî ?ùº?†ï Î™?
   startDate      DATE          NOT NULL,         -- ?ùº?†ï ?ãú?ûë ?Ç†Ïß?
   endDate        DATE          NOT NULL,         -- ?ùº?†ï ?Åù ?Ç†Ïß?
   bgColor        NVARCHAR2(50) DEFAULT  'red',   -- ?ùº?†ï Î∞∞Í≤Ω ?Éâ?ÉÅ
   releaseStatus  NUMBER(1)     DEFAULT  0,       -- Í≥µÍ∞ú ÎπÑÍ≥µÍ∞? ?ó¨Î∂? / Í≥µÍ∞ú:0 ÎπÑÍ≥µÍ∞?:1
   registerday    DATE          DEFAULT  sysdate  -- ?ùº?†ï ?ì±Î°? ?Ç†Ïß?
   ,CONSTRAINT PK_tbl_calendar_calendarNo PRIMARY KEY(calendarNo)                                             -- Ï∫òÎ¶∞?çî ID PK Ïß??†ï
   ,CONSTRAINT FK_tbl_calendar_fk_employeeNo FOREIGN KEY(fk_employeeNo) REFERENCES tbl_employee(employeeNo)   -- ?Ç¨?õê?Öå?ù¥Î∏îÏóê?Ñú FK Í∞??†∏?ò¥
   ,CONSTRAINT CK_tbl_calendar_releaseStatus CHECK( releaseStatus In(0, 1))                                -- Í≥µÍ∞ú:0 ÎπÑÍ≥µÍ∞?:1
); 


create sequence seq_calendarNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CALENDARNO?ù¥(Í∞?) ?Éù?Ñ±?êò?óà?äµ?ãà?ã§.


-- Ï∫òÎ¶∞?çî ?ùº?†ï Í≥µÏú† ?Öå?ù¥Î∏?
CREATE TABLE tbl_calendar_share (
   calendarShareNo        NUMBER(6)     NOT NULL,         -- Í≥µÏú†?öîÏ≤? ID
   fk_requestEmployeeNo   NUMBER(6)     NOT NULL,         -- ?ùº?†ï ?öîÏ≤??ûê ?Ç¨Î≤? 
   fk_responseEmployeeNo  NUMBER(6)     NOT NULL,         -- ?ùº?†ï ?ùë?ãµ?ûê ?Ç¨Î≤?
   ShareStatus            NUMBER(1)     DEFAULT  0,       -- ??Í∏?, ?àò?ùΩ, Í±∞Ï†à ?ó¨Î∂? / ??Í∏?:0, ?àò?ùΩ:1, Í±∞Ï†à:2
   requestDate            DATE          DEFAULT  sysdate, -- ?öîÏ≤??ùº?ûê
   responseDate           DATE          NOT NULL          -- ?ùë?ãµ?ùº?ûê
   ,CONSTRAINT PK_calendarShareNo PRIMARY KEY(calendarShareNo)                                             -- Ï∫òÎ¶∞?çî ID PK Ïß??†ï
   ,CONSTRAINT FK_share_fk_requestEmployeeNo FOREIGN KEY(fk_requestEmployeeNo) REFERENCES tbl_employee(employeeNo)     -- ?Ç¨?õê?Öå?ù¥Î∏îÏóê?Ñú FK Í∞??†∏?ò¥
   ,CONSTRAINT FK_share_fk_responseEmployeeNo FOREIGN KEY(fk_responseEmployeeNo) REFERENCES tbl_employee(employeeNo)   -- ?Ç¨?õê?Öå?ù¥Î∏îÏóê?Ñú FK Í∞??†∏?ò¥
   ,CONSTRAINT CK_share_ShareStatus CHECK( ShareStatus In('0','1','2'))                                          -- ??Í∏?:0, ?àò?ùΩ:1, Í±∞Ï†à:2
); -- Í∏??ûê ?ÑàÎ¨? Í∏∏Ïñ¥?Ñú Ï§ÑÏùº ?ïÑ?öî ?ûà?ùå


create sequence seq_calendarShareNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CALENDARSHARENO?ù¥(Í∞?) ?Éù?Ñ±?êò?óà?äµ?ãà?ã§.

-- ========== Ï∫òÎ¶∞?çî Í¥??†® ?Öå?ù¥Î∏? ?Éù?Ñ± ========== --











-----------------------------------------------------------------------------------------------
-- ========== ?òà?ïΩ Í¥??†® ?Öå?ù¥Î∏? ?Éù?Ñ± ========== --
-- ?ûê?Ç∞ ??Î∂ÑÎ•ò ?Öå?ù¥Î∏?
CREATE TABLE tbl_asset (
   assetNo           NUMBER(6)     NOT NULL,         -- ?öå?ùò?ã§ ID
   assetTitle        NVARCHAR2(50) NOT NULL,         -- ?öå?ùò?ã§ ?û•?Üå ??Î∂ÑÎ•ò Î™? (?òà: 4Ï∏? Í≥µÏö© Í≥µÍ∞Ñ)
   assetInfo         CLOB          NOT NULL,         -- ?öå?ùò?ã§ ?û•?Üå ?†ïÎ≥? (?òà: ?Üå?ôîÍ∏? Î∞∞Ïπò?èÑ Î∞? ÎπÑÏÉÅÍµ? ?úÑÏπ? ?Ç¨Ïß?)
   assetRegisterday  DATE          DEFAULT sysdate,  -- ?öå?ùò?ã§ ?ì±Î°ùÏùº?ûê
   assetChangeday    DATE          NULL,             -- ?öå?ùò?ã§ ?àò?†ï?ùº?ûê
   classification    NUMBER(6)     NOT NULL,         -- ?öå?ùò?ã§ / ?ûê?Ç∞ Íµ¨Î∂Ñ 0 : ?öå?ùò?ã§ 1 : Ï∞?,ÎπîÌîÑÎ°úÏ†ù?ä∏
   CONSTRAINT PK_tbl_asset_assetNo PRIMARY KEY(assetNo)  -- ?öå?ùò?ã§ ID PK Ïß??†ï
);

create sequence seq_assetNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ROOMNO?ù¥(Í∞?) ?Éù?Ñ±?êò?óà?äµ?ãà?ã§.
------------------------------------------------
INSERT INTO tbl_asset (assetNo, assetTitle, assetInfo, assetRegisterday, assetChangeday, classification, asseGroupno, asseDepthno)
VALUES ( seq_assetNo.NEXTVAL, '?öå?ùò?ã§ 1', '?Üå?ôîÍ∏? Î∞∞Ïπò?èÑ Î∞? ÎπÑÏÉÅÍµ? ?úÑÏπ? ?Ç¨Ïß?', sysdate, NULL, 1, seq_assetNo.NEXTVAL, 0);

select * from tbl_asset;
------------------------------------------------
-- ?ûê?Ç∞ ??Î∂ÑÎ•ò ?Öå?ù¥Î∏?





------------------------------------------------
-- ?ûê?Ç∞ ?ÉÅ?Ñ∏ ?Öå?ù¥Î∏?
CREATE TABLE tbl_assetDetail (
   assetDetailNo           NUMBER(6)     NOT NULL,           -- ?öå?ùò?ã§ ?ÉÅ?Ñ∏ ID
   fk_assetNo              NUMBER(6)     NOT NULL,           -- tbl_asset ?öå?ùò?ã§ ID pk
   assetName               NVARCHAR2(50) NOT NULL,           -- ?öå?ùò?ã§ ?ÉÅ?Ñ∏ ?ù¥Î¶?
   assetDetailRegisterday  DATE          DEFAULT sysdate,   -- ?öå?ùò?ã§ ?ÉÅ?Ñ∏ ?ì±Î°ùÏùº?ûê
   assetDetailChangeday    DATE          NULL,              -- ?öå?ùò?ã§ ?ÉÅ?Ñ∏ ?àò?†ï?ùº?ûê
   
   CONSTRAINT PK_tbl_assetDetail_assetDeNo PRIMARY KEY(assetDetailNo),  -- ?öå?ùò?ã§ ?ÉÅ?Ñ∏ ID PK Ïß??†ï
   CONSTRAINT FK_tbl_assetDetail_fk_assetNo FOREIGN KEY(fk_assetNo) REFERENCES tbl_asset(assetNo) ON DELETE CASCADE  -- ?öå?ùò?ã§ ?Öå?ù¥Î∏îÏóê?Ñú FK Í∞??†∏?ò¥
);


create sequence seq_assetDetailNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ASSETDETAILNO?ù¥(Í∞?) ?Éù?Ñ±?êò?óà?äµ?ãà?ã§.
------------------------------------------------

select *
from tbl_assetDetail;

INSERT INTO tbl_assetDetail (assetDetailNo,fk_assetNo,assetName,assetDetailRegisterday,assetDetailChangeday,asseDeGroupno,asseDeDepthno) 
VALUES (seq_assetDetailNo.nextval, 100029, '?ñâÎ≥?', sysdate, NULL, 100016, 1);

INSERT INTO tbl_assetDetail (assetDetailNo,fk_assetNo,assetName,assetDetailRegisterday,assetDetailChangeday,asseDeGroupno,asseDeDepthno) 
VALUES (seq_assetDetailNo.nextval, 100029, '?Ç¨?ûë', sysdate, NULL, 100016, 1);


INSERT INTO tbl_assetDetail (assetDetailNo,fk_assetNo,assetName,assetDetailRegisterday,assetDetailChangeday,asseDeGroupno,asseDeDepthno) 
VALUES (seq_assetDetailNo.nextval, 100027, '?ààÎ¨?', sysdate, NULL, 100016, 1);

commit;
------------------------------------------------

drop table tbl_assetInformation;

desc tbl_assetDetail;

ALTER TABLE tbl_assetInformation ADD release NUMBER(1) DEFAULT 0 NOT NULL;
desc tbl_assetInformation;


select *
from tbl_assetInformation;

-- ÎπÑÌíà ?†ïÎ≥? ?Öå?ù¥Î∏?
CREATE TABLE tbl_assetInformation (
   assetInformationNo           NUMBER(6)     NOT NULL,            -- ?öå?ùò?ã§ ?ù¥?ö©?†ïÎ≥? ID
   fk_assetDetailNo             NUMBER(6)     NOT NULL,            -- tbl_assetDetail ?ûê?Ç∞?ÉÅ?Ñ∏ ID fk
   fk_assetNo                   NUMBER(6)     NOT NULL,            -- tbl_asset ?ûê?Ç∞ ID fk
   InformationTitle             NVARCHAR2(50) NULL,                 -- ?öå?ùò?ã§ ÎπÑÌíà ?ù¥Î¶?
   InformationContents          CHAR(1)      DEFAULT 'X',          -- ?öå?ùò?ã§ ÎπÑÌíà ?ú†Î¨?
   CONSTRAINT PK_tbl_assetInfo_assetInfoNo PRIMARY KEY (assetInformationNo),  -- ?öå?ùò?ã§ ID PK Ïß??†ï
   release                      NUMBER(1)    DEFAULT 0    NOT NULL, -- Í≥µÍ∞ú?ó¨Î∂?
   CONSTRAINT FK_assetInfo_fk_assetDetailNo FOREIGN KEY (fk_assetDetailNo) REFERENCES tbl_assetDetail(assetDetailNo) ON DELETE CASCADE,  -- ?öå?ùò?ã§?ÉÅ?Ñ∏?Öå?ù¥Î∏îÏóê?Ñú FK Í∞??†∏?ò¥
   CONSTRAINT FK_tbl_assetInfo_fk_assetNo FOREIGN KEY (fk_assetNo) REFERENCES tbl_asset(assetNo) ON DELETE CASCADE  -- ?öå?ùò?ã§ ?Öå?ù¥Î∏îÏóê?Ñú FK Í∞??†∏?ò¥
);


create sequence seq_assetInformationNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ASSETINFORMATIONNO?ù¥(Í∞?) ?Éù?Ñ±?êò?óà?äµ?ãà?ã§.
------------------------------------------------
INSERT INTO tbl_assetInformation (assetInformationNo, fk_assetDetailNo, fk_assetNo, InformationTitle, InformationContents)
VALUES ( seq_assetInformationNo.NEXTVAL, 100014, 100029, 'ÎπîÌîÑÎ°úÏ†ù?ä∏', DEFAULT);


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



-- ?ÉÅ?Ñ∏ ?òà?ïΩ ?Öå?ù¥Î∏?
CREATE TABLE tbl_assetReservation (
   assetReservationNo           NUMBER(6)     NOT NULL,          -- ?öå?ùò?ã§ ?ù¥?ö©?†ïÎ≥? ID
   fk_assetDetailNo             NUMBER(6)     NOT NULL,          -- tbl_roomDetail ?öå?ùò?ã§ ?ÉÅ?Ñ∏ ID fk
   fk_employeeNo               NUMBER(6)     NOT NULL,          -- tbl_employee ?Ç¨?õê ID fk
   reservationStart            DATE          NULL,              -- ?ù¥?ö©?ãú?ûë?ãúÍ∞?
   reservationEnd              DATE          NULL,              -- ?ù¥?ö©?Åù?ãúÍ∞?
   reservationDay              DATE          NULL,              -- ?òà?ïΩ?ïú ?Ç†Ïß?
   reservationContents         NVARCHAR2(50) NULL               -- ?òà?ïΩ?ïú ?ù¥?ú†
   ,CONSTRAINT PK_Reservation_ReservaNo PRIMARY KEY(assetReservationNo)                           -- ?öå?ùò?ã§ ID PK Ïß??†ï
   ,CONSTRAINT FK_assetInfo_fk_assetDeNo FOREIGN KEY(fk_assetDetailNo) REFERENCES tbl_assetDetail(assetDetailNo) ON DELETE CASCADE    -- ?öå?ùò?ã§?ÉÅ?Ñ∏?Öå?ù¥Î∏îÏóê?Ñú FK Í∞??†∏?ò¥
   ,CONSTRAINT FK_Reservation_fk_employeeNo FOREIGN KEY(fk_employeeNo) REFERENCES tbl_employee(employeeNo)   -- ?Ç¨?õê?Öå?ù¥Î∏îÏóê?Ñú FK Í∞??†∏?ò¥
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

(reservationStart * 60) - (reservationEnd * 60) / 30 = 30Î∂? ?ã®?úÑÎ°? ?Åä?? Í≤ÉÏùò Í∞úÏàò


create sequence seq_roomReservationNo
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- 
-- ============= ?öå?ùò?ã§ ?òà?ïΩ ?Éù?Ñ± ============= --

-- ========== ?òà?ïΩ Í¥??†® ?Öå?ù¥Î∏? ?Éù?Ñ± ========== --



insert into tbl_assetReservation(assetReservationNo, fk_assetDetailNo, fk_employeeNo, reservationStart, reservationEnd, reservationContents, reservationDay)
values(seq_roomReservationNo.nextval, 100014, 100012, to_date('2025-02-25 12:00', 'yyyy-mm-dd hh24:mi'), to_date('2025-02-25 14:30', 'yyyy-mm-dd hh24:mi'), 'Í∑∏ÎÉ•~',  sysdate);


commit;





desc tbl_assetInformation;



select ASSETINFORMATIONNO, FK_ASSETDETAILNO, INFORMATIONTITLE, INFORMATIONCONTENTS, RELEASE
from tbl_assetInformation
where FK_ASSETDETAILNO = 100030;

insert into tbl_assetInformation(ASSETINFORMATIONNO, FK_ASSETDETAILNO, INFORMATIONTITLE, INFORMATIONCONTENTS, RELEASE)
values(seq_assetInformationNo.nextval, 100030, '?ôî?ù¥?ä∏Î≥¥Îìú', 'O', 0);


insert into tbl_assetInformation(ASSETINFORMATIONNO, FK_ASSETDETAILNO, INFORMATIONTITLE, INFORMATIONCONTENTS, RELEASE)
values(seq_assetInformationNo.nextval, 100030, 'ÎπîÌîÑÎ°úÏ†ù?ä∏', 'X', 1);

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













--------------------------------------------------------
--  DDL for Table TBL_LOGINHISTORY
--------------------------------------------------------
drop table TBL_LOGINHISTORY purge;

select HISTORYNO, FK_EMPLOYEENO, to_char(LOGINDATE, 'yyyy-MM-dd HH24:mi:ss') as LOGINDATE, CLIENTIP
from TBL_LOGINHISTORY
where fk_employeeno = 100012
order by LOGINDATE desc;

CREATE TABLE TBL_LOGINHISTORY
("HISTORYNO" NUMBER NOT NULL, 
 "FK_EMPLOYEENO" NUMBER(6) NOT NULL, 
 "LOGINDATE" DATE DEFAULT sysdate, 
 "CLIENTIP" VARCHAR2(20),
 CONSTRAINT PK_TBL_LOGINHISTORY_HISTORYNO PRIMARY KEY(HISTORYNO),
 CONSTRAINT FK_TBL_LOGINHISTORY_EMPLOYEENO FOREIGN KEY (FK_EMPLOYEENO) REFERENCES TBL_EMPLOYEE(EMPLOYEENO) ON DELETE CASCADE
)

CREATE SEQUENCE historyno;

commit;

--------------------------------------------------------
--  DDL for Index PK_TBL_LOGINHISTORY
--------------------------------------------------------

  CREATE UNIQUE INDEX "MYMVC_USER"."PK_TBL_LOGINHISTORY" ON "MYMVC_USER"."TBL_LOGINHISTORY" ("HISTORYNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table TBL_LOGINHISTORY
--------------------------------------------------------

  ALTER TABLE "MYMVC_USER"."TBL_LOGINHISTORY" MODIFY ("FK_USERID" NOT NULL ENABLE);
  ALTER TABLE "MYMVC_USER"."TBL_LOGINHISTORY" MODIFY ("LOGINDATE" NOT NULL ENABLE);
  ALTER TABLE "MYMVC_USER"."TBL_LOGINHISTORY" MODIFY ("CLIENTIP" NOT NULL ENABLE);
  ALTER TABLE "MYMVC_USER"."TBL_LOGINHISTORY" ADD CONSTRAINT "PK_TBL_LOGINHISTORY" PRIMARY KEY ("HISTORYNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table TBL_LOGINHISTORY
--------------------------------------------------------

  ALTER TABLE "MYMVC_USER"."TBL_LOGINHISTORY" ADD CONSTRAINT "FK_TBL_LOGINHISTORY_FK_USERID" FOREIGN KEY ("FK_USERID")
	  REFERENCES "MYMVC_USER"."TBL_MEMBER" ("USERID") ENABLE;


select BOARDNO, BOARDNAME, BOARDDESC, ISPUBLIC, CREATEDBY, CREATEDAT, STATUS
from tbl_board
order by CREATEDBY desc;

desc tbl_board;







select V.postNo, V.fk_boardNo, V.fk_employeeNo, V.name, V.subject,V.content, 

            V.readCount, V.regDate, V.commentCount, V.allowComments,
            V.isNotice, V.noticeEndDate, V.likeCount,
            b.boardNo, b.boardName,B.createdBy,sysdate AS currentDate,
            ps.positionName
from
(
    SELECT  V.postNo, V.fk_boardNo, V.fk_employeeNo, V.name, V.subject,V.content, 
            V.readCount, V.regDate, V.commentCount, V.allowComments,
            V.isNotice, V.noticeEndDate, V.likeCount,
            b.boardNo, b.boardName,B.createdBy,sysdate AS currentDate ,
            ps.positionName,
            row_number() over(order by postNo desc) AS rno
    FROM tbl_post V
    JOIN tbl_board b 
    ON V.fk_boardNo = b.boardNo
    join tbl_employee E 
    on v.fk_employeeNo = E.employeeNo
    JOIN tbl_position ps 
    on e.FK_positionNo = ps.positionNo
    order by V.postNo;
) V
where rno Between 1 and 5;







SELECT 
    V.postNo, V.fk_boardNo, V.fk_employeeNo, V.name, V.subject, V.content, 
    V.readCount, V.regDate, V.commentCount, V.allowComments,
    V.isNotice, V.noticeEndDate, V.likeCount,
    V.boardNo, V.boardName, V.createdBy, V.currentDate,
    V.positionName
FROM (
    SELECT  
        P.postNo, P.fk_boardNo, P.fk_employeeNo, P.name, P.subject, P.content, 
        P.readCount, P.regDate, P.commentCount, P.allowComments,
        P.isNotice, P.noticeEndDate, P.likeCount,
        B.boardNo, B.boardName, B.createdBy, 
        SYSDATE AS currentDate,
        PS.positionName,
        ROW_NUMBER() OVER (ORDER BY P.postNo DESC) AS rno
    FROM tbl_post P
    JOIN tbl_board B ON P.fk_boardNo = B.boardNo
    JOIN tbl_employee E ON P.fk_employeeNo = E.employeeNo
    JOIN tbl_position PS ON E.FK_positionNo = PS.positionNo
) V
WHERE V.rno BETWEEN 1 AND 5;





select seq, fk_userid, name, content, regdate, fileName, orgFilename, fileSize
from
(
    select seq, fk_userid, name, content, to_char(regdate, 'yyyy-mm-dd hh24:mi:ss') AS regdate
         , row_number() over(order by seq desc) AS rno
         , nvl(fileName, ' ') AS fileName, nvl(orgFilename, ' ') AS orgFilename, nvl(to_char(fileSize), ' ') AS fileSize
    from tbl_comment
    where parentSeq = to_number(#{parentSeq})
) V
where rno Between #{startRno} and #{endRno}
        
        
        
        
