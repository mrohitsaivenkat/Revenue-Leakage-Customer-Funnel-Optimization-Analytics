select * from events;

select * from customer_analytics;

-- 1. Funnel stage counts.

select event_type ,
count(*) as total_events
from events 
group by event_type 
order by total_events desc;


-- 2. Traffic source performance.

select traffic_source,
count(*) as purchased 
from events
where event_type = "purchase"
group by traffic_source 
order by purchased desc;


-- 3.Device wise purchase

select device_type, 
count(*) as purchases 
from events
where event_type = "purchase"
group by device_type
order by purchases desc;


-- 4. Bounce rate by device type

select device_type,
round(count(case when event_type = "bounce" then 1 end )*100.0/count(*),2)
as bounce_rate
from events 
group by device_type 
order by bounce_rate desc;


-- 5. Top 10 purchased products 

select product_id,
count(*) as purchase_count
from events 
where event_type = "purchase"
group by product_id 
order by purchase_count desc 
limit 10 ;


-- 6. Most viewed products 

select product_id,
count(*) as viewed_products
from events 
where event_type = "view"
group by events.product_id
order by viewed_products desc ;


-- 7.Campaign performance 

select 
campaign_id ,
count(*) as purchases
from events 
where event_type = "purchase"
group by campaign_id 
order by purchases desc ;


-- 8. Monthly purchase trend 

select 
datetime(timestamp) as month,
count(*) as purchases 
from events 
where  event_type = "purchase"
group by month
order by purchases ;


-- 9. Page category performance

select
    page_category,
    count(*) AS purchases
from events
where event_type="purchase"
group by page_category
order by purchases desc;


-- X. Average Session Duration by Device

select 
device_type ,
round(avg(session_duration_sec),2) as  avg_duration
from events 
group by  device_type;

select 
device_type ,
round(avg(session_duration_sec),2) as  avg_duration
from events 
where event_type = "purchase"
group by  device_type;


--  11. A/B Test Results.

select 
experiment_group ,
count(*) as purchases
from events 
where event_type = "purchase"
group by experiment_group 
order by purchases ;


--12 . Customers with multiple purchases 

select
    customer_id,
    COUNT(*) AS purchase_count
from events
where event_type='purchase'
group by customer_id
having COUNT(*) > 1
order by purchase_count desc;


-- 13.Customer Segment Distribution

select customer_segment ,
count(*) as customer
from customer_analytics 
group by  customer_segment 
order by customer desc ;


-- 14.Purchase Rate by Segment

select customer_segment ,
round(avg(purchased)*100,2) as purchase_rate 
from customer_analytics 
group  by  customer_segment 
order by purchase_rate desc;


-- 15.Average Behavior by Segment

select  customer_segment ,
round(avg(view_count),2) as avg_views ,
round(avg(click_count),2) as avg_clicks , 
round(avg(cart_count),2) as avg_cart ,
round(avg(purchase_count),2) as avg_purchase 
from customer_analytics 
group by customer_segment ;


-- 16. Top 10 Most Engaged Customers

select
customer_id,
total_sessions,
view_count,
click_count
from customer_analytics
order by total_sessions desc
limit 10;


-- 17. Customers with Highest Bounce Rate

select 
customer_id ,
bounce_rate 
from customer_analytics
group by customer_id
order by bounce_rate desc 
limit 15;


-- 18.Average Bounce Rate by Purchase Status

select 
purchased ,
round(avg(bounce_rate),4) as avg_bounce_rate
from customer_analytics 
group by purchased ;


-- 19. Cart Abandonment Analysis

select
count(*) as abounded_customers 
from customer_analytics 
where abounded_cart = 1;


-- 20.High Value Buyers

select 
customer_id,
purchase_count,
total_sessions
from customer_analytics
where customer_segment = "High value buyer"
order by purchase_count desc;



































































































































































































