drop table hos_reply;
drop table hos_board;
create table hos_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(4000) not null,
    writer CHAR(10) not null,
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
    replyer CHAR(10) not null,
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

commit;

alter table hos_reply modify column replyer varchar(20) not null;

select * from hos_board;
select * from hos_reply;