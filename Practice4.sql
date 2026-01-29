use sakila;
select
a.customer_id, a.store_id, a.first_name, a.last_name, a.email,
a.address_id as a_address_id, b.address_id as b_address_id,
b.address, b.district, b.city_id, b.postal_code, b.phone, b.location
from customer a inner join address b on a.address_id = b.address_id
where a.first_name = 'ROSA';

select
a.customer_id, a.first_name, a.last_name,
b.address_id, b.address, b.district, b.postal_code
from customer a inner join address b on a.address_id = b.address_id and a.create_date = b.last_update
where a.first_name = 'rosa';

select
a.customer_id, a.first_name, a.last_name,
b.address_id, b.address, b.district, b.postal_code,
c.city_id, c.city
from customer a inner join address b on a.address_id = b.address_id inner join city c on b.city_id = c.city_id
where a.first_name = 'rosa';

select
a.address, a.address_id as a_address_id,
b.address_id as b_address_id, b.store_id
from address a left join store b on a.address_id = b.address_id;

select
a.address, a.address_id as a_address_id,
b.address_id as b_address_id, b.store_id
from address a left join store b on a.address_id = b.address_id;

select
a.address, a.address_id as a_address_id,
b.address_id as b_address_id, b.store_id
from address a right join store b on a.address_id = b.address_id;

select
a.address_id as a_address_id, a.store_id,
b.address, b.address_id as b_address_id
from store a left join address b on a.address_id = b.address_id
union
select
a.address_id as a_address_id, a.store_id,
b.address, b.address_id as b_address_id
from store a right join address b on a.address_id = b.address_id;

create table doit_cross1(num int);
create table doit_cross2(name varchar(10));
insert into doit_cross1 values (1),(2),(3);
insert into doit_cross2 values ('do'),('it'),('sql');

