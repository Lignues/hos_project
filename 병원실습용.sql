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

insert into hos_board(bno, title, content, writer) values (seq_hosboard.nextval, '1�� ���Դϴ�.', '1���̴�', '1�ۼ���');
insert into hos_board(bno, title, content, writer) values (seq_hosboard.nextval, '2�� ���Դϴ�.', '2���̴�', '2�ۼ���');
insert into hos_board(bno, title, content, writer) values (seq_hosboard.nextval, '3�� ���Դϴ�.', '3���̴�', '3�ۼ���');
insert into hos_board(bno, title, content, writer) values (seq_hosboard.nextval, '4�� ���Դϴ�.', '4���̴�', '4�ۼ���');

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
values (seq_hosreply.nextval, 1,'��� �߰� 01','�ۼ���');
insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 1,'��� �߰� 02','�ۼ���');
insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 1,'��� �߰� 03','�ۼ���');
insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 1,'��� �߰� 04','�ۼ���');

insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 2,'��� �߰� 05','�ۼ���');
insert into hos_reply (rno,bno,reply,replyer)
values (seq_hosreply.nextval, 2,'��� �߰� 06','�ۼ���');

-- ȸ��
create table hos_member(
    memberId varchar2(100) primary key, 
    memberPwd varchar2(200) not null, 
    memberName varchar(100) not null, 
    email varchar(200) not null, 
    regDate date default sysdate, 
    updateDate date default sysdate, 
    enabled char(1) default '1'
);

-- ���� 
create table hos_member_auth(
    memberId varchar2(100) not null, 
    auth varchar2(100) not null,
    constraint fk_hosmember_auth foreign key(memberId) references hos_member(memberId)
);

insert into hos_member_auth values('admin','ROLE_ADMIN');
insert into hos_member_auth values('admin','ROLE_MEMBER');

-- �ڵ��α���
create table persistent_logins(
    username varchar2(100) not null, 
    series varchar2(64) primary key, 
    token varchar2(64) not null, 
    last_used timestamp not null
);

commit;

-- ��б�
alter table hos_board add secretContent NUMBER(1) default 0;
-- ��õ
alter table hos_board add likeHit number default 0; 
-- ��ۼ�
alter table hos_board add replyCnt number default 0; 
-- ��� �� ������Ʈ 
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