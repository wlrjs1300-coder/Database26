# 파이썬과 mysql 병합 작업을 위한 sql 페이지

# 일반적으로 system(root) 계정은 개발용으로 허용하지 않는다
# mysql에 사용할 id와 pw와 권한을 부여하고 db를 생성

CREATE USER 'mbc'@'localhost'IDENTIFIED BY '1234';
# 사용자계정생성 ID     접속PC                   암호
#           'lhj'@192.168.0.154             '5678'
#           'lhj'@192.168.0.% -> 192.168.0.1~192.168.0.255
#           'lhj'@'%'         -> 전체ip(외부에서도 접속가능->보안이 좋지 않음)
# 사용자 계정 생성은 ID가 중복되어도 됨 - 대신 접속 pc를 다중 처리 할 수 있음
# CREATE USER 'mbc'@'192.168.0.%'IDENTIFIED BY '5678';
# CREATE USER 'mbc'@'%'IDENTIFIED BY 'Mbc320!!';

DROP USER 'mbc'@'localhost'; # 사용자 삭제

# mbc사용자에게 lms권한 부여
# 1. db 생성 -> 계정 권한 부여
CREATE DATABASE lms DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
# lms db 생성                              한국어지원
# COLLATE : 문자 집합에 포함된 문자들을 어떻게 비교하고 정렬할지 정의하는 키워드
# 데이터 비교 시, 대소문자 구분, 문자 간의 정렬 순서, 언어별 특수문자 처리 방식 지원
# utf8mb4 : 문자집합
# general : 비교규칙(간단한 일반 비교)
# ci : Case Insensitive(대소문자 구분하지 않음)
# COLLATE utf8m4_bin = 대소문자 구분함

# mbc라는 계정이 lms를 사용할 수 있게 권한 부여
GRANT ALL PRIVILEGES ON LMS.* TO 'mbc'@'localhost';
#                   db명.테이블     ID     접속PC
# ALL PRIVILEGES = 모든 권한 부여
# GRANT SELECT, INSERT ON LMS.* TO '알바'@'%';
#        READ   CREATE     = 읽고 생성하는 권한만 부여
# 권한 즉시 반영
FLUSH PRIVILEGES;

USE mysql; # mysql 최고(최상위) db접속
SELECT * FROM user; # mysql의 사용자 목록을 볼 수 있음