-- Script File for the Live Auction Database

-- creating database
create database auctiondb;
use auctiondb;


-- admins table
create table admins(
	adminID int unsigned not null auto_increment,
    admin_user varchar(10) not null,
    admin_password varchar(20) not null,
    constraint admin_pk primary key(adminID)
    );
alter table admins auto_increment=1000;


-- users table
create table users(
	user_id int unsigned not null auto_increment,
    fname varchar(10) not null,
    lname varchar(10) not null,
    user_password varchar(15) not null,
    phone_no varchar(10) not null unique,
    email_id varchar(30),
    city varchar(20),
    constraint user_pk primary key(user_id)
	);
alter table users auto_increment=2000;

-- product categories table
create table category(
	cat_id int unsigned not null auto_increment primary key,
    prod_category varchar(15) not null
    );
    

-- items table
create table items(
	item_id int unsigned not null auto_increment,
    item_name varchar(30) not null,
    cat_id int unsigned not null,
    item_desc varchar(100),
    reserve_price int unsigned not null,
    starting_price int unsigned,
    end_time datetime not null,
    constraint items_fk foreign key(cat_id) references category(cat_id),
    constraint price_check check(starting_price>reserve_price),
    constraint items_pk primary key(item_id)
	);
alter table items auto_increment=10023;


-- bid table
create table bids(
	bid_id int unsigned not null auto_increment primary key,
    bidder_id int unsigned not null,
    bid_item_id int unsigned not null,
    bid_amt int unsigned not null,
    bid_time datetime not null,
    constraint fk1 foreign key(bidder_id) references users(user_id),
    constraint fk2 foreign key(bid_item_id) references items(item_id)
	);

-- populating admins
INSERT INTO admins (admin_user, admin_password) VALUES
('user1', 'password1'),
('user2', 'password2'),
('user3', 'password3'),
('user4', 'password4'),
('user5', 'password5'),
('user6', 'password6'),
('user7', 'password7'),
('user8', 'password8');



-- populating users
INSERT INTO users (fname, lname, user_password, phone_no, email_id, city)
VALUES 
('John', 'Doe', 'password1', '1234567890', 'johndoe@example.com', 'New York'),
('Jane', 'Doe', 'password2', '0987654321', 'janedoe@example.com', 'Los Angeles'),
('Bob', 'Smith', 'password3', '5555555555', 'bobsmith@example.com', 'Chicago'),
('Samantha', 'Jones', 'password4', '7777777777', 'samanthajones@example.com', 'Houston'),
('Michael', 'Johnson', 'password5', '1111111111', 'michaeljohnson@example.com', 'Philadelphia'),
('Emily', 'Wilson', 'password6', '2222222222', 'emilywilson@example.com', 'Phoenix'),
('Brian', 'Clark', 'password9', '6666666666', 'brianclark@example.com', 'San Francisco'),
('Karen', 'Miller', 'password10', '9999999999', 'karenmiller@example.com', 'Seattle');


-- populating category
INSERT INTO category (prod_category) VALUES 
('Electronics'),
('Books'),
('Fashion'),
('Home & Garden');


-- populating items
INSERT INTO items (item_name, cat_id, item_desc, starting_price, reserve_price, end_time) VALUES 
('MacBook Pro', 1, '3 year old MacBook Pro, no damage',10000, 8000, '2023-03-31 23:59:59'),
('iPhone 13 Pro', 1,'Refurbished. Looks new and works well', 12000, 10000, '2023-04-15 23:59:59'),
('AirPods Pro', 1, 'Silver colored, 5 years old', 15000, 5000, '2023-04-30 23:59:59'),
('Samsung Galaxy Watch', 1,null, 4500, 3000, '2023-05-20 23:59:59'),
('To Kill a Mockingbird', 2," A young girl's coming of-age story about the roots and consequences of racism.", 500, 300, '2023-03-20 23:59:59'),
('The Great Gatsby',2, "Story of Jay Gatsby, and his pursuit of a wealthy young woman." ,100, 50, '2023-04-12 23:59:59'),
("Harry Potter",2,"Harry's journey toward coming to terms with his past and facing his future.", 40, 20, '2023-05-05 23:59:59'),
('Leather Jacket', 3,"Black. The durability and warmth of leather offer broad utility", 200, 150, '2023-04-01 23:59:59'),
('High Heels', 3,"Red in color" ,100, 50, '2023-05-01 23:59:59'),
('Coffee Maker', 4,"2 months old machine. Makes delicious coffee.", 80, 60, '2023-03-15 23:59:59'),
('Water Bottle', 4, "Cello Thermostell Bottle, stainless steel, maintains water temp. for a long time.", 20, 10, '2023-04-01 23:59:59'),
('Throw Pillow', 4,"For fun." ,30, 15, '2023-05-10 23:59:59'),
('Indoor Plant', 4,"Enchances home beauty" ,500, 250, '2023-06-01 23:59:59');


-- populating bids with 15 bids
INSERT INTO bids (bidder_id, bid_item_id, bid_amt, bid_time) VALUES 
(2001, 10023, 10000, '2023-03-29 09:00:00'),
(2002, 10023, 12000, '2023-03-30 10:15:00'),
(2001, 10023, 13000, '2023-03-31 08:30:00'),
(2003, 10024, 13000, '2023-04-10 11:00:00'),
(2005, 10024, 15000, '2023-04-11 13:45:00'),
(2006, 10027, 7000, '2023-03-19 09:00:00'),
(2007, 10027, 8000, '2023-03-19 10:15:00'),
(2006, 10027, 10000, '2023-03-20 08:30:00'),
(2001, 10029, 40, '2023-04-07 11:00:00'),
(2005, 10029, 80, '2023-04-11 09:00:00'),
(2003, 10030, 200, '2023-04-01 10:15:00'),
(2001, 10030, 300, '2023-04-01 18:30:00'),
(2003, 10034, 40, '2023-04-03 11:00:00'),
(2007, 10034, 60, '2023-04-08 12:30:00'),
(2006, 10034, 100, '2023-04-09 13:00:00');






-- Queries

-- Query to find the highest bid amount for a specific item in the current auction
select i.item_id as Item_ID, i.item_name as Item, max(b.bid_amt) as Max_Amount
from items i 
join bids b
on i.item_id=b.bid_item_id
where bid_item_id=10034;


-- Query to find the number of bids that have been placed on a specific item so far
select i.item_id as Item_ID, i.item_name as Item, count(*) as No_of_Bids
from items i 
join bids b
on i.item_id=b.bid_item_id
where i.item_id=10034;

-- Query to find the current highest bidder for a specific item
select i.item_id as Item_ID, i.item_name as Item, concat(u.fname,' ',u.lname) as 'Highest Bidder'		
from (items i 
join bids b
on i.item_id=b.bid_item_id
join users u
on b.bidder_id=u.user_id)
where i.item_id=10027
order by b.bid_amt
limit 1;

-- Query to find the no. of items currently available for auction
select count(*) as 'Items Available' from items
where now()<items.end_time;

-- Query for the bidding history of a specific user
select u.user_id,concat(u.fname,' ',u.lname)  as 'Bidder', i.item_name as 'Item', bid_amt as 'Bid', b.bid_time as 'Time'
from (users u 
join bids b
on u.user_id=b.bidder_id  
join items i
on i.item_id=b.bid_item_id)
where u.user_id=2001
order by b.bid_time desc;

-- 6Query to find the number of users that have placed bids on a specific item
select i.item_id as 'Item Id', i.item_name as 'Item', count(distinct b.bidder_id) as 'Number of Bidders'
from items i
join bids b
on  i.item_id=b.bid_item_id  
where i.item_id=10024;


-- Query to find the total amount of all bids placed on a specific item
select i.item_name as "Item", sum(b.bid_amt) as 'Total Bid Value' from
items i join bids b
on i.item_id=b.bid_item_id
where i.item_id=10024;

-- Query to get the status of a specific bid (Losing/Winning)
select b1.bid_id as 'Bid Id', (case
	when b1.bid_amt=(select max(b2.bid_amt)
					from bids b2
                    where b2.bid_item_id=b1.bid_item_id)
	then 'Winning'
    else 'Losing'
    end) as 'Status'
    from bids b1
    where b1.bid_id=10;

-- Query to find the number of items a specific user has bid on in the auction
select u .user_id as 'User Id', concat(u.fname,' ',u.lname)  as 'Selected User', count(distinct b.bid_item_id) as 'Number of Bids'
from users u 
join bids b
on u.user_id=b.bidder_id
where u.user_id=2001;

-- Query to find the total amount of all the bids placed by a specific user
select u .user_id as 'User Id', concat(u.fname,' ',u.lname)  as 'Selected User',sum(b.bid_amt) as 'Total Bid Value'
from users u 
join bids b
on u.user_id=b.bidder_id
where b.bidder_id=2001;










