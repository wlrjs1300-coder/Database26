select @@hostname;

-- 이 창은 메모장처럼 사용됨
-- 스크립트를 1줄 씩 실행하는 것이 기본 (crtl + enger)
-- 만약 더미 데이터를 여러개 입력할 때는 블럭설정 후 (ctrl + shift + enter)actoraddresscategory

use sakila; -- sakila 데이터베이스 사용
select * from actor; -- actor 테이블에 있는 모든 값

use world; -- world 데이터베이스 사용
select * from city; -- city 테이블에 있는 모든 값