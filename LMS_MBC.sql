# LMS에 대한 테이블을 생성, 더미데이터 입력(CRUD)

SHOW DATABASES; # LMS만 보임

# DROP TABLE members; # 잘못 만들었을 경우 실행

USE LMS; # LMS 데이터베이스를 사용
CREATE TABLE members ( # members 테이블 생성
# 필드명 타입 옵션
   id  INT AUTO_INCREMENT PRIMARY KEY, 
#      정수 자동번호생성기      기본키 (다른테이블과 연결용)
  uid VARCHAR(50) NOT NULL UNIQUE,
#   가변문자(50자) 공백 비허용 유일한값
password VARCHAR(255) NOT NULL,
name VARCHAR(50) NOT NULL,
role ENUM('admin','manager','user') DEFAULT 'user',
#    열거타입(관호안에 글자만 허용)         기본값 = user
active BOOLEAN DEFAULT TRUE,
#      불린타입       기본값     TRUE = 1, FALSE = 0으로 저장
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
# 생성일     날짜시간타입     기본값 = 시스템시간
);

# 더미데이터 입력
INSERT INTO members(uid,password,name,role,active)
VALUES('kkw','1234','김기원','admin',TRUE),
('lhj','1234','임효정','manager',TRUE),
('ljj','1234','이재정','user',TRUE),
('ljk','1234','이지건','user',TRUE),
('kdg','1234','김도균','user',TRUE);

# 더미데이터 수정
SELECT * FROM members; # 전체 출력
SELECT * FROM members WHERE uid = 'kkw' and password = '1234' and active = true; # 로그인 할 때

UPDATE members SET password = '1111' WHERE uid = 'kkw';

# 회원삭제
DELETE FROM members WHERE uid = 'kkw';
UPDATE members SET active = false WHERE uid = 'kkw'; # 회원 비활성화

drop table scores;
create table scores(
id INT AUTO_INCREMENT PRIMARY KEY,
member_id int not null,
korean int not null,
english int not null,
math int not null,
total int not null,
average int not null,
grade char(1) not null,
created_at datetime default current_timestamp,
foreign key (member_id) references members(id)
# 외래키 생성     필드        연결      테이블   필드
);

# 후보키 : 공백이 없고, 유일해야 되는 필드 (학번, 주민번호, ID, Email...)
# PRIMARY KEY : 기본키, 공백이 없고, 유일해야하며, 인덱싱이 되어 있어야하는 옵션
# 인덱싱 : db에서 빠른 찾기를 위한 옵션
# 외래키 : 다른 테이블과 연결이 되는 키
# 외래키는 자식, 기본키는 부모
# members가 부모, scores가 자식, members에 값이 있어야 scores에 값을 넣을 수 있음
# members테이블의 id와 scores테이블의 member_id의 타입은 일치해야함

insert into scores (member_id,korean,english,math,total,average,grade)values(2,99,99,99,297,99,"A"),(3,88,88,88,264,88,"B"),(4,77,77,77,231,77,"C"),(5,66,66,66,198,66,"F"),(6,80,80,80,240,80,"B");
select * from scores;

# 기본 정보 조회 (INNER JOIN)
# 성적 데이터가 존재하는 회원만 조회, 이름, 과목 점수, 평균, 등급을 가져옴
SELECT
m.name as 이름,
m.uid as 아이디,
s.korean as 국어,
s.english as 영어,
s.math as 수학,
s.total as 총점,
s.average as 평균,
s.grade as 등급
from members m join scores s on m.id = s.member_id;
# Aliasing (별칭) : members m 처럼 테이블 이름 뒤에 한 글자 별칭을 줘서 사용 가능
# on : 조건 (m.id = s.member_id 와 같이 두 테이블을 연결하는 핵심 키 지정)

delete from scores where member_id = 2;
# 성적이 없는 회원도 포함 조회 (LEFT JOIN)
# 성적표가 아직 작성되지 않은 회원까지 모두 포함하여 명단을 만들 때 사용, 성적이 없으면 NULL 표시

SELECT
m.name as 이름,
m.role as 역할,
s.average as 평균,
s.grade as 등급,
IFNULL(s.grade,'미산출') as 상태 # 성적이 없으면 '미산출' 표시
FROM members m LEFT JOIN scores s ON m.id = s.member_id;

drop table boards;
create table boards(
id int auto_increment primary key,
member_id int not null,
title varchar(200) not null,
content text not null,
created_at datetime default current_timestamp,
foreign key (member_id) references members(id));

insert into boards (member_id, title, content) values (3,'제목1','내용1'),(4,'제목4','내용4'),(4,'제목5','내용5'),(5,'제목6','내용6');
select * from boards;

# 게시글 목록 조회 (INNTER JOIN)
select
b.id as 글번호,
b.title as 제목,
m.name as 작성자, -- members 테이블에서 가져옴
b.created_at as 작성일
from boards b inner join members m on b.member_id = m.id order by b.created_at desc; -- 최신글 순으로 정렬

# 특정 사용자의 글만 조회 ( WHERE 절 조합)
SELECT
b.title,
b.content,
m.name as 작성자, -- members 테이블에서 가져옴
b.created_at
from boards b join members m on b.member_id = m.id where m.uid = 'lhj'; -- 특정 아이디를 가진 유저의 글만 필터링

# 관리자용 : 통계 조회 (GROUP BY 조합)
SELECT
m.name,
m.uid,
count(b.id) as 작성글수 # GROUP BY와 세트
from members m left join boards b on m.id = b.member_id group by m.id;

# 작성자 이름으로 검색 (LIKE 활용)
SELECT
b.id as 글번호,
b.title as 제목,
m.name as 작성자,
b.created_at as 작성일
from boards b inner join members m on b.member_id = m.id where m.name like '%지건%' order by b.created_at desc;
# WHERE m.name LIKE '%검색어%' or b.title like '%검색어%'