use doitsql;

create table doit_increment (
col_1  int auto_increment primary key, # auto_increment 자동번호생성기, primary key = 절대값
col_2  varchar(50),
col_3 int
);

insert into doit_increment (col_2,col_3) values ('1 자동입력',1),('2 자동입력',2); # col_1에 값을 입력하지 않아도 1부터 시작하여 자동으로 번호가 입력됨

select * from doit_increment;
select last_insert_id(); # 마지막으로 입력된 insert 값 확인

alter table doit_increment auto_increment=100; # auto_increment = A를 설정하면 A부터 시작하여 자동번호 생성 시작
insert into doit_increment (col_2,col_3) values ('시작값이 변했을까?',0);

set @@auto_increment_increment = 5; # @@auto_increment_increment = A를 설정하면 A씩 올라가며 자동번호 생성 시작
insert into doit_increment (col_2,col_3) values ('5씩 증가하나?(1)',0);
insert into doit_increment (col_2,col_3) values ('5씩 증가하나?(2)',0);

delete from doit_increment;
set sql_safe_updates=0; # delete 하기 전 안전모드 해제
set sql_safe_updates=1;

drop table doit_insert_select_from;
select * from doit_insert_select_from;

create table doit_insert_select_from(
col_1 int,
col_2 varchar(10)
);
create table doit_insert_select_to(
col_1 int,
col_2 varchar(10)
);

insert into doit_insert_select_from values (1,'DO');
insert into doit_insert_select_from values (2,'IT');
insert into doit_insert_select_from values (3,'SQL');

insert into doit_insert_select_to select * from doit_insert_select_from; # 다른 테이블에 들어있는 값을 그대로 넣을 수도 있음
select * from doit_insert_select_to;

create table doit_select_new as (select * from doit_insert_select_from); # 다른 테이블에 들어있는 값 그대로 새로운 테이블을 만들 수도 있음
select * from doit_select_new;

create table doit_parent (col_1 int primary key);
create table doit_child (col_1 int);

alter table doit_child add foreign key (col_1) references doit_parent (col_1); # 다른 테이블에 적용된 값을 참조하여 다른 테이블에서 사용 가능

insert into doit_parent values(1);
insert into doit_child values(1); # child에는 먼저 값을 넣을 수 없음, parent에 먼저 값을 넣어야만 가능
select * from doit_child;
delete from doit_child where col_1 = 1;
delete from doit_parent where col_1 = 1; # 삭제하는 것 또한 child 값을 먼저 삭제할 수 없음
select * from doit_parent;
drop table doit_child;
drop table doit_parent; # 테이블 삭제는 child를 먼저 삭제해야 parent을 삭제할 수 있음

create table doit_parent (col_1 int primary key);
create table doit_child(col_1 int);
alter table doit_child add foreign key (col_1) references doit_parent(col_1);

show create table doit_child;

alter table doit_child drop constraint doit_child_ibfk_1; # 외래키 적용 해지하는 방법 but 적혀 있는 constraint보단 foreign key가 더 권장됨, primary key 경우 생략 가능하며, unique 경우 index로 대체
drop table doit_parent;

use doitsql;
create table doit_float(col_1 float);
insert into doit_float values (0.7);
select * from doit_float where col_1 = 0.7; # float = 소수점

select 10/3;

create table doit_char_varchar(
col_1 char(5),
col_2 varchar(5)
);

insert into doit_char_varchar values ('12345','12345'),('67890','67890'),('abcde','abcde'),('가나다라마','가나다라마'),('hello','안녕하세요');

select
col_1, char_length(col_1) as char_length, length(col_1) as char_byte,
col_2, char_length(col_2) as char_length, length(col_2) as char_byte
from doit_char_varchar;

create table doit_collation(
col_latin1_general_ci varchar(10) collate latin1_general_ci,
col_latin1_general_cs varchar(10) collate latin1_general_cs,
col_latin1_bin varchar(10) collate latin1_bin,
col1_latin7_general_ci varchar(10) collate latin7_general_ci
);
insert into doit_collation values ('a','a','a','a'),('b','b','b','b'),('A','A','A','A'),('B','B','B','B'),('*','*','*','*'),('_','_','_','_'),('!','!','!','!'),('1','1','1','1'),('2','2','2','2');
select col_latin1_general_ci from doit_collation order by col_latin1_general_ci;
select col_latin1_general_cs from doit_collation order by col_latin1_general_cs;
select col_latin1_bin from doit_collation order by col_latin1_bin;
select col1_latin7_general_ci from doit_collation order by col1_latin7_general_ci;

create table date_table (
justdate DATE,
justtime TIME,
justdatetime DATETIME,
justtimestamp TIMESTAMP);