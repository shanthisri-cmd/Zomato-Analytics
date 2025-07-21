create database Zomato_analysis;
use zomato_analysis;

select * from main;
select * from country;
select * from currency;

## (1) Number of Resturent---
select count('Resturent Name') as Resturents from main;

##  (2) Numbre of restorent based on  country ---

select c.countryname,count( 'Resturent name') as Resturent from main as m
join country as c  on
m. countrycode=c.countryid group by 1 order by 2 desc;

## (3) Number of restorent based on city ---

select city ,count('Resturent name') as Resturent from main 
group by 1 order by 2 desc;

## (4) Namber of restorent open by year,quater,month

select count('Resturent name') as Resturent ,
extract(year from str_to_date(datekey_opening ,"%Y-%m-%d"))
 as year from main group by 2 order by 1 desc;

select count('Resturent name')as Resturent,
 concat("Q-",extract(quarter from str_to_date( datekey_opening,"%Y-%m-%d")))
as  Quarter from main group by 2 order by 1 desc;

select count('resturent name') as Resturent,
monthname (str_to_date(datekey_opening ,"%Y-%m-%d"))
 as month from main group by 2 order by 1 desc;

### (5) Count of Resturent  above and below average Rating
select count('Resturent name') as Resturent from main 
where Rating >(select avg(Rating) from main) ;

select count('Resturent name') as Resturent from main 
where Rating < (select avg(Rating) from main);


## (6) Resturent falls in each bucket
select price,count('Resturent name') as Resturent from
(select case when Average_cost_for_two between 0 and 300 then "0-300"
when Average_cost_for_two between 301 and 600 then "301-600"
when Average_cost_for_two between 601 and 1000 then "601-1000"
when Average_cost_for_two between 1001 and 430000 then "1001-430000"
else ">430000 "
end as Price from main)ab group by price order by count("Resturent name") desc;

### (7) Resturent based on table booking
select concat(round(count("Resturent name")/
(select count("resturent name")from main)*100,2),"%") as 'Table booking '  
from main where Has_table_booking="Yes" ;

## (8) Resturent based on online delivery
select concat(round(count("Resturent name")/
(select count("Resturent name") from main)*100,2),"%") as 'Online delivery'
from main where Has_online_delivery="Yes";

### (9) Resturent fall on different ratings, cuisines and city
select count(*) as Resturent ,Rating,cuisines,city from main
 group by  Rating,cuisines,city ;

