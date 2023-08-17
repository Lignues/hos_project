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

alter table hos_board add constraint pk_hosboard
primary key(bno); 
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
    enabled char(1) default '1'
);

-- 권한 
create table hos_member_auth(
    memberId varchar2(100) not null, 
    auth varchar2(100) not null,
    constraint fk_hosmember_auth foreign key(memberId) references hos_member(memberId)
);

insert into hos_member_auth values('admin','ROLE_ADMIN');
insert into hos_member_auth values('admin','ROLE_MEMBER');

-- 자동로그인
create table persistent_logins(
    username varchar2(100) not null, 
    series varchar2(64) primary key, 
    token varchar2(64) not null, 
    last_used timestamp not null
);

commit;

-- 비밀글
alter table hos_board add secretContent NUMBER(1) default 0;
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

delete from hos_member where memberid = '';
delete from hos_member_auth where memberid = 'test';

select * from article_like;
select * from hos_board;
select * from hos_reply;
select * from hos_member;
select * from hos_member_auth;
select * from persistent_logins;