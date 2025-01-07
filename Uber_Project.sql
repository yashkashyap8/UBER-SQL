show databases;
create database Uber;
use Uber;

select * from rides;
select * from passangers;
select * from drivers;

#Q1 What are & how many unique pickup locations are there in the dataset?
select distinct(r.pickup_location) from rides r ;
select count(distinct(r.pickup_location)) from rides r;

#Q2 What is the total number of rides in the dataset?
select count(r.ride_id) from rides r ;

#Q3 Calculate the average ride duration.
select avg(ride_duration) from rides r; 

#Q4 List the top 5 drivers based on their total earnings.
select r.driver_id, sum(r.fare_amount) from rides r
group by r.driver_id
order by sum(r.fare_amount)
limit 5;

#Q5 Calculate the total number of rides for each payment method.
select r.payment_method, count(r.ride_id) from rides r
group by r.payment_method;

#Q6 Retrieve rides with a fare amount greater than 20.
select r.ride_id,r.fare_amount from rides r where r.fare_amount > 20;

#Q7 Identify the most common pickup location.
select r.pickup_location ,count(r.pickup_location) from rides r
group by r.pickup_location 
order by count(r.pickup_location)
limit 1;

#Q8 Calculate the average fare amount.
select avg(r.fare_amount) from rides r;

#Q9 List the top 10 drivers with the highest average ratings.
select r.driver_id,avg(p.rating) from 
rides r inner join passangers p 
on r.ride_id = p.passenger_id 
group by r.driver_id
order by avg(p.rating)
limit 10;

#Q10 Calculate the total earnings for all drivers.
select d.driver_name, sum(d.earnings) from drivers d 
group by d.driver_name
order by sum(d.earnings);

#Q11 How many rides were paid using the "Cash" payment method?
select r.payment_method ,count(r.ride_id) from rides r 
group by r.payment_method;

#Q12 Calculate the number of rides & average ride distance for rides originating 
#from the 'Dhanbad' pickup location.
select r.pickup_location,count(r.ride_id), avg(r.ride_distance) from rides r
where pickup_location = 'Dhanbad'
group by r.pickup_location;

#Q13 Retrieve rides with a ride duration less than 10 minutes.
select r.ride_id, r.ride_duration from rides r where r.ride_duration<10; 

#Q14 List the passengers who have taken the most number of rides.
select p.passenger_name,p.total_rides from passangers p 
order by p.total_rides desc;

#Q15 Calculate the total number of rides for each driver in descending order.
select d.driver_name,sum(d.total_rides) from drivers d
group by d.driver_name 
order by sum(d.total_rides) desc;

#Q16 Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.
select r.payment_method, r.passenger_id from rides r where pickup_location='Gandhinagar'; 

#Q17 Calculate the average fare amount for rides with a ride distance greater than 10.
select avg(r.fare_amount) from rides r where ride_distance > 10;

#Q18 List the drivers in descending order accordinh to their total number of rides.
select d.driver_name,sum(d.total_rides) from drivers d
group by d.driver_name 
order by sum(d.total_rides) desc;  

#Q19 Calculate the percentage distribution of rides for each pickup location.
select pickup_location, count(*) as Ride_count round(count(*)*100 / (SELECT COUNT(*) FROM Rides),2) as percentage
from rides
group by r.pickup_location
order by percentage;

#Q20 Retrieve rides where both pickup and dropoff locations are the same.
select r.ride_id from rides r where pickup_location=dropoff_location; 



#Intermediate Level:     

                 
#Q1 List the passengers who have taken rides from at least 300 different pickup locations.
select r.passenger_id, count(distinct(r.pickup_location)) from rides r
group by r.passenger_id
having  count(distinct(r.pickup_location)) >= 300;

#Q2 Calculate the average fare amount for rides taken on weekdays.
select avg(r.fare_amount) from rides r
where dayofweek(str_to_date(ride_timestamp, '%m/%d/%Y %H:%i')) > 1 and 
dayofweek(str_to_date(ride_timestamp, '%m/%d/%Y %H:%i')) < 7;

#Q3 Identify the drivers who have taken rides with distances greater than 19.
select distinct r.driver_id from rides r where ride_distance > 19; 

#Q4 Calculate the total earnings for drivers who have completed more than 100 rides.
select d.driver_id ,sum(d.earnings) from drivers d 
where d.total_rides > 100
group by d.driver_id;

#Q5 Retrieve rides where the fare amount is less than the average fare amount.
select * from rides r
where r.fare_amount < (select avg(r.fare_amount)from rides r);

#Q6 Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.
select d.driver_id, avg(d.rating) from drivers d 
where d.driver_id in (select r.driver_id from rides r where payment_method in ('credit card' and 'cash')group by r.driver_id having count(distinct payment_method)=2)
group by d.driver_id;

#Q7 List the top 3 passengers with the highest total spending.
select p.passenger_name from passangers p 
order by p.total_spent desc 
limit 3;

#Q8 Calculate the average fare amount for rides taken during different months of the year.
select month(STR_TO_DATE(r.ride_timestamp '%m/%d/%Y %H:%i')) as Month_name, avg(r.fare_amount) from rides r
group by Month_name;

#Q9 Identify the most common pair of pickup and dropoff locations.
select r.pickup_location, r.dropoff_location, count(*) as ride_count from rides r
group by r.pickup_location, r.dropoff_location
order by ride_count desc
limit 1;

#Q10 Calculate the total earnings for each driver and order them by earnings in descending order.
select distinct d.driver_name, sum(d.earnings) from drivers d 
group by d.driver_name
order by sum(d.earnings) desc;

#Q11 List the passengers who have taken rides on their signup date.
select p.passenger_id, p.passenger_name from 
passangers p join rides r
on p.passenger_id = r.passenger_id 
where date(p.signup_date)=date(r.ride_timestamp);

#Q12 Calculate the average earnings for each driver and order them by earnings in descending order.
select distinct d.driver_name, avg(d.earnings) from drivers d 
group by d.driver_name
order by avg(d.earnings) desc;

#Q13 Retrieve rides with distances less than the average ride distance.
select * from rides r
where r.ride_distance < (select avg(r.ride_distance) from rides r);

#Q14 List the drivers who have completed the least number of rides.
select d.driver_id,d.driver_name from drivers d
where d.total_rides = (select min(d.total_rides)from drivers d);

#Q15 Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.
select avg(r.fare_amount) from rides r
where r.passenger_id in (select passenger_id from passangers where total_rides >= 20);

#Q16 Identify the pickup location with the highest average fare amount.
select r.pickup_location, avg(r.fare_amount) from rides r
group by r.pickup_location 
order by avg(r.fare_amount) desc
limit 1;

#Q17 Calculate the average rating of drivers who completed at least 100 rides.
select d.driver_id, avg(d.rating) from drivers d
where d.total_rides >= 100
group by d.driver_id;

select avg(rating) from drivers
where driver_id in (select driver_id  from rides r
					group by driver_id
					having count(*) >= 100);

#Q18 List the passengers who have taken rides from at least 5 different pickup locations.
select r.passenger_id, count(distinct r.pickup_location) from rides r
group by r.passenger_id
having count(r.pickup_location) >= 5;

#Q19 Calculate the average fare amount for rides taken by passengers with ratings above 4.
select avg(r.fare_amount) from rides r 
where r.passenger_id in (select passenger_id from passangers where rating > 4);

#Q20 Retrieve rides with the shortest ride duration in each pickup location.
select r1.* from 
rides r1 join (select pickup_location,min(ride_duration) as min_duration from rides group by pickup_location) r2
on r1.pickup_location = r2.pickup_location and r1.ride_duration = r2.min_duration;


#Advanced Level:

#Q1 List the drivers who have driven rides in all pickup locations.
select d.driver_id from drivers d 
where d.driver_id not in (select distinct driver_id from rides
							where pickup_location not in 
									(select distinct pickup_location from rides)
						);
					

#Q2 Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.
select avg(r.fare_amount) from rides r 
where r.passenger_id in (select passenger_id from passangers where total_spent > 300);

#Q3 List the bottom 5 drivers based on their average earnings.
select d.driver_id, d.driver_name ,avg(earnings) from drivers d
group by d.driver_id ,d.driver_name 
order by avg(earnings)
limit 5;

#Q4 Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.
select  sum(r.fare_amount) from rides r 
where passenger_id in (select passenger_id from rides 
						group by passenger_id having 
						count(distinct payment_method)>1);

#Q5 Retrieve rides where the fare amount is significantly above the average fare amount.
select * from rides 
where fare_amount > (select avg(fare_amount)*1.5 from rides);

#Q6 List the drivers who have completed rides on the same day they joined.
select r.driver_id from 
rides r join drivers d
on r.driver_id = d.driver_id 
where 


select * from rides r ;
DATE(2024-07-06 12:33);


#Q7 Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.
select  avg(r.fare_amount) from rides r 
where passenger_id in (select passenger_id from rides 
						group by passenger_id having 
						count(distinct payment_method)>1);

#Q8 Identify the pickup location with the highest percentage increase in average fare amount compared to 
#the overall average fare.
select pickup_location, avg(fare_amount),
((select avg(fare_amount) from rides)- avg(fare_amount)) *100/(select avg(fare_amount) from rides) as percentage  
from rides					
group by pickup_location
order by percentage desc;

#Q9 Retrieve rides where the dropoff location is the same as the pickup location.
select * from rides r 
where r.pickup_location =r.dropoff_location;

#Q10 Calculate the average rating of drivers who have driven rides with varying pickup locations.
select d.driver_id from drivers d
where d.driver_id in (select distinct driver_id from rides 
					group by driver_id 
					having count(distinct pickup_location)>1);



