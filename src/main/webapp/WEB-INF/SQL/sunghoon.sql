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

drop sequence seq_document;


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
