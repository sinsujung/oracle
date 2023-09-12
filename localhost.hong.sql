show user; --sql developer

select * from tabs;


-- insufficient privileges
create table tbldata(
    seq number primary key,
    data varchar2(100) not null
);


CREATE TABLE tblCourseReg (
	courseReg_seq     NUMBER  primary key,
	course_seq        NUMBER NOT NULL, 
	student_seq       NUMBER NOT NULL, 
	completeState_seq NUMBER NOT NULL,
	complete           DATE   NULL ,
    
    constraint course_seq_fk foreign key (course_seq) references tblCourse(course_seq),
    constraint student_seq_fk foreign key (student_seq) references tblStudent(student_seq),
    constraint completeState_seq_fk foreign key (completeState_seq) references tblCompleteState(completeState_seq)

); 

create table tblEmployment (    
employment Number Primary Key,
companyName Varchar(50),
insurance Varchar(50),
hireDate Date,
maintenance_seq Number Not Null
); 



CREATE TABLE tblHopeDuty (
	hopeDuty_seq    NUMBER   PRIMARY KEY, 
	hopeDutyfield   VARCHAR(255) NULL,    
	hopeSalary      NUMBER       NULL,    
	maintenance_seq NUMBER       NOT NULL,
    
    constraint hd_maintenance_seq_fk foreign key (maintenance_seq) references tblEmployment(employment)

);


drop sequence seqmaintenance;
create SEQUENCE seqmaintenance;

create table tblMaintenance(    
maintenance_seq Number Primary Key
);

drop table tblAdmin;
select * from tblmaintenance;








