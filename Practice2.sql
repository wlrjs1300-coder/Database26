use sakila;
select first_name from customer;
select first_name, last_name from customer;
select * from customer;
show columns from sakila.customer;
select * from customer where first_name='maria'; -- customer폴더 안에 있는 모든 데이터에서 first_name을 'maria'로 갖고 있는 데이터를 갖고옴
select * from customer where address_id = 200;
select * from customer where address_id < 200;
select * from customer where first_name = 'MARIA';
select * from customer where first_name < 'MARIA';
select * from payment where payment_date = '2005-07-09 13:24:07';
select * from payment where payment_date < '2005-07-09 13:24:07';
select * from customer where address_id between 5 and 10;
select * from payment where payment_date between '2005-06-17' and '2005-07-19';
select * from payment where payment_date = '2005-07-08 07:33:56';
select * from customer
where first_name between 'm' and 'o';
select * from customer
where first_name not between 'm' and 'o';
select * from city where city = 'sunnyvale' and country_id = 103;
select * from payment where payment_date >= '2005-06-01' and payment_date <= '2005-07-05';
select * from customer where first_name = 'maria' or first_name = 'linda';
select * from customer where first_name in ('maria','linda','nancy');
select * from city where country_id = 86 or country_id = 103 and city in ('cheju','sunnyvale','dallas');
select * from city where (country_id = 86 or country_id = 103) and city in ('cheju','sunnyvale','dallas');
select * from city where country_id in (86, 103) and city in ('cheju','sunnyvale','dallas');
select * from address;
select * from address where address2 = null;
select * from address where address2 is null;
select * from address where address2 is not null;
select * from address where address2 = '';
select * from customer;
select * from customer order by first_name; -- order by A : A 열로 오름차순 정렬
select * from customer order by last_name;
select * from customer order by store_id, first_name;
select * from customer order by first_name, store_id; -- order by A, B 진행 시, A 조건에 먼저 맞추고 그에 맞는 결과 값 중 B와도 맞는 걸 정렬
select * from customer order by first_name asc; -- asc : 오름차순
select * from customer order by first_name desc; -- desc : 내림차순
select * from customer order by store_id desc, first_name asc; -- 두개를 같이 사용 가능
select * from customer order by store_id desc, first_name asc limit 10; -- limit A = 상위 A개만 정렬
select * from customer order by customer_id asc limit 100, 10; -- limit A, B = A행 부터 B개 정렬
select * from customer order by customer_id asc limit 10 offset 100; -- limt A offset B = B만큼 띄고 A개만큼 정렬 (offset은 limit이 있을 때만 사용되고 limit이 사용 될 때는 항상 order by가 따라 와야함)
select * from customer where first_name like 'a%'; -- like 'a%' = a로 시작하는 first_name을 정렬
select * from customer where first_name like '%a'; -- like '%a' = a로 끝나는 first_name을 정렬
select * from customer where first_name like '%a%'; -- like '%a%" = a를 포함하는 first_name을 정렬
select * from customer where first-name not like '%a'; -- not like = 부정
with CTE (col_1) as (
select 'a%bc' union all
select 'a_bc' union all
select 'abc'
)
select * from CTE;
with CTE (col_1) as (
select 'a%bc' union all
select 'a_bc' union all
select 'abc'
)
select * from CTE where col_1 like '%';
with CTE (col_1) as (
select 'a%bc' union all
select 'a_bc' union all
select 'abc'
)
select * from CTE where col_1 like '%#%%' escape '#'; -- escape A = A뒤에 있는 거는 무조건 문자로 보겠다 (% 혹은 _가 들어가있는 문자를 찾고 싶을 때 사용될 수 있는게 escape)
select * from customer where first_name like 'a_'; -- 'a_' = a로 시작하는 2글자 (_ 숫자 만큼 늘어남)
select * from customer where first_name like 'a__';
select * from customer where first_name like '_____'; -- '_____' = _ 숫자 길이의 문자 정렬
select * from customer where first_name like 'A_R%'; -- A_R로 시작하는 문자열 조회
select * from customer where first_name regexp 'k[l-n]'; -- k뒤에 l에서 n 사이의 문자로 조합되어 있는 문자 정렬
select * from customer where first_name regexp 'k[^l-n]'; -- [^..] = 부정
select * from film;
select special_features from film group by special_features; -- special_features열의 데이터를 그룹화
select rating from film group by rating; -- rating 그룹화 (2개의 이상의 것들도 하나로 그룹화) 
select special_features, rating from film group by special_features, rating; -- 같이 그룹화 가능 ( select 뒤에 값을 무조건 group by 뒤에도 입력해 줘야함)
select rating, special_features from film group by rating, special_features; -- 순서 바꿔서 가능
select special_features, count(*)as cnt from film group by special_features; -- count(*) = 숫자를 세는 함수, 함수 as A 는 A로서 함수의 결과값을 정렬
select special_features, rating, count(*)as cnt from film group by special_features, rating order by special_features, rating, cnt desc;
select special_features, rating from film group by special_features, rating having rating='g'; -- having 조건 = 조건에 맞는 것들을 필터링 (그룹화한 것들에만 사용 가능)
select special_features, count(*)as cnt from film group by special_features having cnt > 70;
select special_features, rating, count(*)as cnt from film group by special_features, rating having rating = 'r' and cnt > 8;
select distinct special_features, rating from film; -- select distinct = 중복된 것들 제거하고 정렬