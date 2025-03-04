CREATE table tbl_document
(documentNo         NVARCHAR2(20)           not null
,fk_employeeNo       number                  not null
,subject            NVARCHAR2(200)          not null
,draftDate          date    default sysdate not null
,status             number  default 0       not null
,securityLevel      number  default 0
,temp               number  default 0
,documentType       NVARCHAR2(20)           not null
,constraint     PK_tbl_document primary key(documentNo)
,constraint     fk_tbl_document_employeeNo foreign key(fk_employeeNo) references tbl_employee(employeeNo) on delete cascade
);

create sequence seq_document
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- drop sequence seq_document;


CREATE table tbl_document_attach
(documentAttachNo   number          not null
,fk_documentNo      NVARCHAR2(20)   not null
,fileName           Nvarchar2(200)  not null
,orgFilename        Nvarchar2(200)  not null
,fileSize           number          not null
,constraint PK_tbl_document_attach primary key(documentAttachNo)
,constraint fk_doc_attach_documentNo foreign key(fk_documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DOCUMENT_ATTACH이(가) 생성되었습니다.

CREATE table tbl_approval
(approvalNo     number          not null
,fk_documentNo  NVARCHAR2(20)   not null
,fk_approver    number          not null
,approvalOrder  number          not null
,approvalStatus number          not null
,executionDate  date            default sysdate
,constraint PK_tbl_approval_approvalNo primary key(approvalNo)
,constraint fk_tbl_approval_documentNo foreign key(fk_documentNo) references tbl_document(documentNo) on delete cascade
,constraint fk_tbl_approval_approver foreign key(fk_approver) references tbl_employee(employeeNo) on delete cascade
);
-- Table TBL_APPROVAL이(가) 생성되었습니다.

create sequence seq_approval
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

CREATE table tbl_draft_annual
(documentNo     NVARCHAR2(20)   not null
,useAmount      number          not null
,reason         NVARCHAR2(200)  not null
,startDate      Date            not null
,endDate        Date            not null
,annualtype     number          not null
,constraint PK_tbl_draft_annual_documentNo primary key(documentNo)
,constraint FK_tbl_draft_annual_documentNo foreign key(documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DRAFT_ANNUAL이(가) 생성되었습니다.

CREATE table tbl_draft_business
(documentNo     NVARCHAR2(20)   not null
,doDate         Date            not null
,content        NVARCHAR2(200)  not null   
,coDepartment   NVARCHAR2(20)
,constraint PK_draft_business_documentNo primary key(documentNo)
,constraint FK_draft_business_documentNo foreign key(documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DRAFT_BUSINESS이(가) 생성되었습니다.

CREATE table tbl_draft_expense
(documentNo     NVARCHAR2(20)   not null
,writeDate      Date            not null
,reason         NVARCHAR2(200)  not null   
,totalAmount    number          not null
,department     NVARCHAR2(20)   not null
,constraint PK_draft_expense_documentNo primary key(documentNo)
,constraint FK_draft_expense_documentNo foreign key(documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DRAFT_EXPENSE이(가) 생성되었습니다.

CREATE table tbl_draft_overtime
(documentNo     NVARCHAR2(20)   not null
,reason         NVARCHAR2(200)  not null   
,constraint PK_draft_overtime_documentNo primary key(documentNo)
,constraint FK_draft_overtime_documentNo foreign key(documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DRAFT_OVERTIME이(가) 생성되었습니다.

CREATE table tbl_expense_detail
(expenseDetailNo    number          not null
,fk_documentNo      NVARCHAR2(20)   not null
,amount             number          not null
,useDate            date            not null
,type               Nvarchar2(20)   not null
,content            Nvarchar2(100)  not null
,note               Nvarchar2(200)
,constraint PK_expense_detail_detailNo primary key(expenseDetailNo)
,constraint FK_expense_detail_documentNo foreign key(fk_documentNo) references tbl_draft_expense(documentNo) on delete cascade
);
-- Table TBL_EXPENSE_DETAIL이(가) 생성되었습니다.


select * from tab;

select (Endtime - starttime)*24
from tbl_commute;

select *
from tbl_commute
where commuteno != 100010;

select employeeNo.nextval
from dual;

SELECT seq_document.nextval FROM DUAL;

insert into tbl_draft_annual(DOCUMENTNO, USEAMOUNT, REASON, STARTDATE, ENDDATE, ANNUALTYPE)
values(seq_document.currval, 1, 'dd', to_date('2025-02-17', 'yyyy-MM-dd'), to_date('2025-02-18', 'yyyy-MM-dd' ), '연차');

select * from tbl_document;
select * from tbl_draft_annual;

select *
from tbl_document;

select documentNo, subject, documentType, draftDate
		from tbl_document
		where fk_employeeNo = 100014 and temp = 1;
    
    
    
    
select documentNo, subject, documentType, draftDate, status
from tbl_document;

select documentNo, subject, documentType, draftDate, status, name
from
(
    select employeeNo, name
    from
        (
            select fk_departmentno
            from tbl_employee
            where employeeNo = '100014'
        ) E1 JOIN tbl_employee E2
    ON E1.fk_departmentNo = E2.fk_departmentno
) E JOIN tbl_document D
ON E.employeeNO = D.fk_employeeNo;



select *
from tbl_document
where fk_employeeno = '100014';

SELECT *
  FROM all_sequences;


select *
from tbl_document D JOIN tbl_draft_annual A
ON d.documentNo = A.documentNo;

select d.documentNo, d.fk_employeeNo, subject, draftDate, status, securityLevel, temp, documentType, approvalDate
     , useAmount, reason, startDate, endDate, annualType
from tbl_document D JOIN tbl_draft_annual A
ON d.documentNo = A.documentNo JOIN tbl_employee E
ON d.fk_employeeNo = E.employeeNo
where d.documentNo = '2025-100002';

select d.documentNo, fk_employeeNo, subject, to_char(draftDate, 'yyyy-mm-dd') as draftDate, status, securityLevel, temp, documentType, to_char(approvalDate, 'yyyy-mm-dd') as approvalDate
     , useAmount, reason, to_char(startDate, 'yyyy-mm-dd') as startDate, to_char(endDate, 'yyyy-mm-dd') as endDate, annualType
from tbl_document D JOIN tbl_draft_annual A
ON d.documentNo = A.documentNo
where d.documentNo = '2025-100002';

select approvalNo, fk_documentNo, fk_approver, approvalOrder, approvalStatus
     , to_char(executionDate, 'yyyy-mm-dd') as executionDate, positionname, name
from tbl_approval JOIN tbl_employee
ON fk_approver = employeeNo JOIN tbl_position
ON fk_positionno = positionno
where fk_documentNo = '2025-100032'
order by approvalOrder desc;


select *
from tbl_document D JOIN tbl_draft_annual A
ON d.documentNo = A.documentNo;

select d.documentNo, d.fk_employeeNo, subject, draftDate, d.status, e.securityLevel, temp, documentType, approvalDate
     , useAmount, reason, startDate, endDate, annualType, name, teamname
from tbl_document D JOIN tbl_draft_annual A
ON d.documentNo = A.documentNo JOIN tbl_employee E
ON d.fk_employeeNo = E.employeeNo JOIN tbl_team T
ON E.fk_teamNo = T.teamno
where d.documentNo = '2025-100002';



select *
from tbl_document JOIN tbl_approval
ON documentNo = fk_documentNo
where fk_employeeNo = '100014' and (select 
order by draftDate desc;

select *
from tbl_approval
where fk_approver = '100014';


select approvalNo, fk_approver, fk_documentNo, approvalOrder, fk_employeeNo, subject, draftDate, documentType, name, documentNo
from
(
    select approvalNo, fk_approver, fk_documentNo, approvalOrder, ROW_NUMBER() OVER(PARTITION BY fk_documentNo ORDER BY approvalOrder DESC) AS rn
    from tbl_approval
    where APPROVALSTATUS = 0
) A JOIN tbl_document
ON fk_documentNo = documentNo
JOIN tbl_employee
ON fk_employeeNo = employeeNo
where rn = 1 and fk_approver = '100014' and temp = 0;


select approvalNo, fk_approver, fk_documentNo, approvalOrder, FK_EMPLOYEENO, SUBJECT, DRAFTDATE, TEMP
from
(
    select approvalNo, fk_approver, fk_documentNo, approvalOrder, ROW_NUMBER() OVER(PARTITION BY fk_documentNo ORDER BY approvalOrder DESC) AS rn
    from tbl_approval
    where APPROVALSTATUS = 0
) A JOIN tbl_document
ON fk_documentNo = documentNo
where rn != 1 and fk_approver = '100014' and temp = 0;


select approvalNo, fk_approver, fk_documentNo, approvalOrder, fk_employeeNo, subject, draftDate, documentType, name, documentNo
from
(
    select approvalNo, fk_approver, fk_documentNo, approvalOrder, ROW_NUMBER() OVER(PARTITION BY fk_documentNo ORDER BY approvalOrder DESC) AS rn
    from tbl_approval
    where APPROVALSTATUS = 0
) A JOIN tbl_document
ON fk_documentNo = documentNo
JOIN tbl_employee
ON fk_employeeNo = employeeNo
where rn != 1 and fk_approver = '100014' and temp = 0;


select approvalNo, fk_approver, fk_documentNo, approvalOrder, fk_employeeNo, subject, draftDate, documentType, name, documentNo, approvalDate ,D.status
from
(
    select approvalNo, fk_approver, fk_documentNo, approvalOrder
    from tbl_approval
    where APPROVALSTATUS != 0 and fk_approver = '100014'
) A JOIN tbl_document D
ON fk_documentNo = documentNo
JOIN tbl_employee
ON fk_employeeNo = employeeNo
where temp = 0;
