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