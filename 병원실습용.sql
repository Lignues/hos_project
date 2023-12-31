drop table hos_attach;
drop table persistent_logins;
drop table hos_reply;
drop table article_like;
drop table hos_board;
drop table hos_member_auth;
drop table hos_member;

create table hos_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(4000) not null,
    writer varchar2(12) not null,
    regDate date default sysdate,
    updateDate date default sysdate
)

drop sequence seq_hosboard;
create sequence seq_hosboard;

insert into hos_board(bno, title, content, writer) values (seq_hosboard.nextval, '1번 글입니다.', '1번이다', '1작성자');
insert into hos_board(bno, title, content, writer) values (seq_hosboard.nextval, '2번 글입니다.', '2번이다', '2작성자');
insert into hos_board(bno, title, content, writer) values (seq_hosboard.nextval, '3번 글입니다.', '3번이다', '3작성자');
insert into hos_board(bno, title, content, writer) values (seq_hosboard.nextval, '4번 글입니다.', '4번이다', '4작성자');

commit;

select * from hos_board;

create table hos_reply(
    rno number(10,0),
    bno number(10,0),
    reply varchar2(200) not null,
    replyer varchar2(12) not null,
    replyRegDate date default sysdate,
    ReplyUpdateDate date default sysdate
);

alter table hos_board add constraint pk_hosboard primary key(bno); 
alter table hos_reply add constraint pk_hosreply primary key(rno);
alter table hos_reply add constraint fk_hosreply
foreign key(bno) references hos_board(bno);

drop sequence seq_hosreply;
create sequence seq_hosreply;

insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 1,'댓글 추가 01','작성자');
insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 1,'댓글 추가 02','작성자');
insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 1,'댓글 추가 03','작성자');
insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 1,'댓글 추가 04','작성자');

insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 2,'댓글 추가 05','작성자');
insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 2,'댓글 추가 06','작성자');

-- 회원
create table hos_member(
    memberId varchar2(100) primary key, 
    memberPwd varchar2(200) not null, 
    memberName varchar(100) not null, 
    email varchar(200) not null,
    regDate date default sysdate,
    updateDate date default sysdate, 
    enabled char(1) default '1',
    ban number(2) default 0
);

-- 권한 
create table hos_member_auth(
    memberId varchar2(100) not null, 
    auth varchar2(100) not null,
    constraint fk_hosmember_auth foreign key(memberId) references hos_member(memberId)
);

insert into hos_member_auth values('admin','ROLE_ADMIN');
insert into hos_member_auth values('admin','ROLE_MEMBER');

-- 중복권한 방지
ALTER TABLE hos_member_auth
ADD CONSTRAINT uk_member_auth UNIQUE (memberId, auth);

-- 자동로그인
create table persistent_logins(
    username varchar2(100) not null, 
    series varchar2(64) primary key, 
    token varchar2(64) not null, 
    last_used timestamp not null
);

commit;

-- 이용정지
alter table hos_member add ban number(2) default 0;
-- 비밀글
alter table hos_board add secretContent NUMBER(1) default 0;
-- 조회수
alter table hos_board add views NUMBER default 0;
-- 추천
alter table hos_board add likeHit number default 0; 
-- 댓글수
alter table hos_board add replyCnt number default 0; 
-- 댓글 수 업데이트 
update hos_board B 
set  replyCnt = (select count(rno) 
    from hos_reply R where R.bno = B.bno);

create table article_like(
    bno number(10,0),
    memberId  varchar2(100), 
    FOREIGN KEY (memberId) REFERENCES hos_member(memberId) ON DELETE CASCADE,
    FOREIGN KEY (BNO) REFERENCES hos_board(BNO) ON DELETE CASCADE 
);

create table article_viewed(
    bno number(10,0),
    memberId  varchar2(100), 
    FOREIGN KEY (memberId) REFERENCES hos_member(memberId) ON DELETE CASCADE,
    FOREIGN KEY (BNO) REFERENCES hos_board(BNO) ON DELETE CASCADE 
);

-- 첨부파일
create table hos_attach(
    uuid varchar2(100) not null, 
    uploadPath varchar2(200) not null, 
    fileName varchar2(100) not null, 
    fileType char(1) default 'I', 
    bno number(10,0)
);

alter table hos_attach add constraint pk_attach primary key(uuid);
alter table hos_attach add constraint fk_hos_attach 
foreign key(bno) references hos_board(bno);

delete from hos_member where memberid = '';
delete from hos_member_auth where memberid = 'admin';

select * from hos_attach;
select * from article_like;
select * from hos_board;
select * from hos_reply;
select * from hos_member;
select * from hos_member_auth;
select * from persistent_logins;
select * from article_viewed;
select * from hos_board_report;  

-- ########신규기능########

-- 신고게시판
drop table hos_board_report;

create table hos_board_report(
    rnum number(10,0),
    bno number(10,0) not null, 
    reportContent varchar2(50) not null,
    reporter varchar2(12) not null,
    handle number(1,0) default 0,
    
    --constraint fk_hosboard_reportBno foreign key(bno) references hos_board(bno),
    constraint fk_hosboard_reporter foreign key(reporter) references hos_member(memberId)
);

-- pk설정
alter table hos_board_report add constraint pk_hosReport primary key(rnum);

-- 중복신고 방지(같은 글 같은 제보자가 불가) 안하는게 맞는거같다
ALTER TABLE hos_board_report
ADD CONSTRAINT uk_reporter_bno UNIQUE (bno, reporter);

drop sequence seq_hosreport;
create sequence seq_hosreport;

insert into hos_board_report(rnum, bno, reportContent, reporter) values (seq_hosreport.nextval, 26, '1신고번이다', 'scott');
insert into hos_board_report(rnum, bno, reportContent, reporter) values (seq_hosreport.nextval, 26, '1신고번이다', 'test');
insert into hos_board_report(rnum, bno, reportContent, reporter) values (seq_hosreport.nextval, 26, '1신고번이다', 'admin');
insert into hos_board_report(rnum, bno, reportContent, reporter) values (seq_hosreport.nextval, 26, '1신고번이다', '4작성자');

insert into hos_board_report(rnum, bno, reportContent, reporter) values (seq_hosreport.nextval, 27, '2신고번이다', 'admin');
insert into hos_board_report(rnum, bno, reportContent, reporter) values (seq_hosreport.nextval, 27, '2신고번이다', 'scott');

commit;

  
-- group by 활용으로 권한 통일
select * from  
    (select rownum as rn, c.* from      
        (SELECT h.memberId, memberPwd, memberName, email, enabled, regDate, updateDate, COUNT(a.memberId) AS authCount
        FROM hos_member h
        LEFT OUTER JOIN hos_member_auth a ON h.memberId = a.memberId
        GROUP BY h.memberId, memberPwd, memberName, email, enabled, regDate, updateDate
        order by authCount desc) c where rownum <= 10
        ) where rn > 0;
        
-- 예약기능

create table hos_book(
    bookDate date not null,
    bookTime number(2) not null,
    memberId varchar2(12) not null,
    bookReason varchar2(100) not null,
    
    --constraint fk_hosboard_reportBno foreign key(bno) references hos_board(bno),
    constraint fk_hosbook_memberId foreign key(memberId) references hos_member(memberId)
);

-- 중복예약 방지
ALTER TABLE hos_book
ADD CONSTRAINT uk_hosBooking UNIQUE (bookDate, bookTime);
drop table hos_book;

select * from hos_book;
