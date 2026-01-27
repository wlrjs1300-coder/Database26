CREATE DATABASE DoItSQL; -- 데이터베이스 생성
DROP DATABASE DoItSQL; -- 데이터 베이스 삭제
create database doitsql;
use doitsql; -- 데이터베이스 사용
drop database doitsql;
CREATE DATABASE doitsql;
USE doitsql;
CREATE TABLE doit_create_table (
co1_1 INT, -- 숫자
col_2 VARCHAR(50), -- 문자
col_3 DATETIME -- 날짜, 시간
); -- 테이블 생성
DROP TABLE doit_create_table;
CREATE TABLE doit_dml (
col_1 INT,
col_2 VARCHAR(50),
col_3 DATETIME
);
INSERT INTO doit_dml (col_1,col_2,col_3)VALUES(1,'DoItSQL','2023-01-01'); -- INSERT INTO 테이블명(폴더명,폴더명,폴더명)VALUES(값,값,값)
SELECT * FROM doit_dml; -- SELECT B FROM A = A에 있는 B를 보다 ( * = 모두 )
INSERT INTO doit_dml(col_1)VALUES('문자입력'); -- 폴더명을 지정해서 넣을 수 있음
INSERT INTO doit_dml VALUES(2,'열 이름 생략','2023-01-02'); -- 폴더명은 생략할 수 있음
SELECT * FROM doit_dml;
INSERT INTO doit_dml VALUES(3,'col_3 값 생략');
INSERT INTO doit_dml(col_1,col_2)VALUES(3,'col_3 값 생략');
SELECT * FROM doit_dml;
INSERT INTO doit_dml(col_1,col_3,col_2)VALUES(4,'2023-01-03','열순서 변경'); -- 순서를 바꿔서 넣어도 가능
SELECT * FROM doit_dml;
INSERT INTO doit_dml(col_1,col_2,col_3)VALUES(5,'데이터 입력5','2023-01-03'),(6,'데이터 입력6','2023-01-03'),(7,'데이터 입력7','2023-01-03'); -- 여러개 한번에 넣을 수 있음
SELECT * FROM doit_dml;
USE doitsql;
UPDATE doit_dml SET col_2 = '데이터 수정' WHERE col_1 = 4; -- 안전모드가 걸려 있어서 실행 오류
set SQL_SAFE_UPDATES = 0; -- 안전 모드 해지, set SQL_SAFE_UPDATES = 1; 안전모드 실행
UPDATE doit_dml SET col_2 = '데이터 수정' WHERE col_1 = 4;
SELECT * FROM doit_dml;
UPDATE doit_dml SET col_1 = col_1 + 10;
SELECT * FROM doit_dml;
DELETE FROM doit_dml WHERE col_1 = 14; -- DELETE FROM 테이블명 WHERE 조건  -> 조건 값 삭제 가능
SELECT * FROM doit_dml;
DELETE FROM doit_dml; -- WHERE 조건을 입력하지 않으면 테이블 안에 있는 데이터 전부 삭제
SELECT * FROM doit_dml;