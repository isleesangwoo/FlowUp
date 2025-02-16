-- CREATE table tbl_documentType
-- (documentCode   number          not null
-- ,documentType   NVARCHAR2(20)   not null
-- ,constraint PK_docType_documentCode primary key(documentCode)
-- );
-- Table TBL_DOCUMENTTYPE이(가) 생성되었습니다.
-- Table TBL_DOCUMENTTYPE이(가) 삭제되었습니다.

insert into tbl_documentType(documentCode, documentType) values (1, '휴가신청');
insert into tbl_documentType(documentCode, documentType) values (2, '업무기안');
insert into tbl_documentType(documentCode, documentType) values (3, '지출품의');
insert into tbl_documentType(documentCode, documentType) values (4, '연장근무신청');

commit;

CREATE table tbl_document
(documentNo         number                  not null
,fk_emloyeeNo       number                  not null
,fk_documentCode    number
,subject            NVARCHAR2(200)          not null
,draftDate          date    default sysdate not null
,status             number  default 0       not null
,securityLevel      number 
,constraint     PK_tbl_document primary key(documentNo)
,constraint     fk_tbl_document_employeeNo foreign key(fk_emloyeeNo) references tbl_employee(employeeNo) on delete cascade
,constraint     fk_tbl_document_documentCode foreign key(fk_documentCode) references tbl_documentType(documentCode) on delete set null
);

create sequence seq_document
start with 100001
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Table TBL_DOCUMENT이(가) 생성되었습니다.

-- CREATE table tbl_document_temp
-- (documentTempNo number      not null
-- ,fk_documentNo  number      not null
-- ,writeDate      Date        not null
-- ,constraint     PK_document_temp_docTempNo primary key(documentTempNo)
-- ,constraint     fk_doc_temp_documentNo foreign key(fk_documentNo) references tbl_document(documentNo) on delete cascade
-- );
-- Table TBL_DOCUMENT_TEMP이(가) 생성되었습니다.
-- Table TBL_DOCUMENT_TEMP이(가) 삭제되었습니다.

CREATE table tbl_document_attach
(documentAttachNo   number          not null
,fk_documentNo      number          not null
,fileName           Nvarchar2(200)  not null
,orgFilename        Nvarchar2(200)  not null
,fileSize           number          not null
,constraint PK_tbl_document_attach primary key(documentAttachNo)
,constraint fk_doc_attach_documentNo foreign key(fk_documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DOCUMENT_ATTACH이(가) 생성되었습니다.

CREATE table tbl_approval
(approvalNo     number      not null
,fk_documentNo  number      not null
,fk_approver    number      not null
,approvalOrder  number      not null
,approvalStatus number      not null
,executionDate  date        default sysdate
,constraint PK_tbl_approval_approvalNo primary key(approvalNo)
,constraint fk_tbl_approval_documentNo foreign key(fk_documentNo) references tbl_document(documentNo) on delete cascade
,constraint fk_tbl_approval_approver foreign key(fk_approver) references tbl_employee(employeeNo) on delete cascade
);
-- Table TBL_APPROVAL이(가) 생성되었습니다.

CREATE table tbl_draft_annual
(documentNo     number          not null
,useAmount      number          not null
,reason         NVARCHAR2(200)  not null
,startDate      Date            not null
,endDate        Date            not null
,type           number          not null
,constraint PK_tbl_draft_annual_documentNo primary key(documentNo)
,constraint FK_tbl_draft_annual_documentNo foreign key(documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DRAFT_ANNUAL이(가) 생성되었습니다.

CREATE table tbl_draft_business
(documentNo     number          not null
,doDate         Date            not null
,content        NVARCHAR2(200)  not null   
,coDepartment   NVARCHAR2(20)
,constraint PK_draft_business_documentNo primary key(documentNo)
,constraint FK_draft_business_documentNo foreign key(documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DRAFT_BUSINESS이(가) 생성되었습니다.

CREATE table tbl_draft_expense
(documentNo     number          not null
,writeDate      Date            not null
,reason         NVARCHAR2(200)  not null   
,totalAmount    number          not null
,department     NVARCHAR2(20)   not null
,constraint PK_draft_expense_documentNo primary key(documentNo)
,constraint FK_draft_expense_documentNo foreign key(documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DRAFT_EXPENSE이(가) 생성되었습니다.

CREATE table tbl_draft_overtime
(documentNo     number          not null
,reason         NVARCHAR2(200)  not null   
,constraint PK_draft_overtime_documentNo primary key(documentNo)
,constraint FK_draft_overtime_documentNo foreign key(documentNo) references tbl_document(documentNo) on delete cascade
);
-- Table TBL_DRAFT_OVERTIME이(가) 생성되었습니다.

CREATE table tbl_expense_detail
(expenseDetailNo    number          not null
,fk_documentNo      number          not null
,amount             number          not null
,useDate            date            not null
,type               Nvarchar2(20)   not null
,content            Nvarchar2(100)  not null
,note               Nvarchar2(200)
,constraint PK_expense_detail_detailNo primary key(expenseDetailNo)
,constraint FK_expense_detail_documentNo foreign key(fk_documentNo) references tbl_draft_expense(documentNo) on delete cascade
);
-- Table TBL_EXPENSE_DETAIL이(가) 생성되었습니다.

drop table tbl_document_temp purge;
select * from tab;

select (Endtime - starttime)*24
from tbl_commute;

select *
from tbl_commute;