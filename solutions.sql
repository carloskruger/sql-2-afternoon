-- Practice joins

select * from invoice join invoice_line
on invoice.invoice_id = invoice_line.invoice_id
where invoice_line.unit_price > 0.99;


select i.invoice_date, c.first_name, c.last_name, i.total
from invoice as i join customer as c on i.customer_id = c.customer_id;

select c.first_name, c.last_name, e.first_name, e.last_name from customer as c
join employee as e on  c.support_rep_id = e.employee_id;

select a.title, b.name from album as a 
join artist as b on a.artist_id = b.artist_id;

select plt.track_id from playlist_track as plt join
playlist as pl on pl.name = 'Music';

select distinct pl.name from playlist as pl join playlist_track as plt
on pl.playlist_id = 5;

select * from playlist where playlist_id = 5;
select t.name, pl.name from track as t 
join playlist_track as plt on t.track_id = plt.track_id
join playlist as pl on plt.playlist_id = pl.playlist_id; 

select a.title, t.name from album as a 
join track as t on t.album_id = a.album_id
join genre as g on  g.name = 'Alternative & Punk';

-- Practice nested queries

select * from invoice where invoice_id 
in (select invoice_id from invoice_line where 
    unit_price > 0.99);

select * from playlist_track where playlist_id in 
(select playlist_id from playlist where name = 'Music');

select name from track where track_id 
in (select track_id from playlist_track where playlist_id = 5);

select * from track where genre_id in 
(select genre_id from genre where name = 'Comedy')

select * from track where album_id in 
(select album_id from album where artist_id in 
 (select artist_id from artist where name = 'Queen')
)

-- Practice updating Rows

update customer 
set fax =  null where fax is not null

update customer set company = 'Self'
where company is null;

update customer set last_name = 'Thompson'
where first_name =  'Julia' and last_name = 'Barnett';

update customer set support_rep_id = 4
where email = 'luisrojas@yahoo.es';

update track 
set composer = 'The Darkness around us'
where composer is null and genre_id in
(select genre_id from genre where name = 'Metal')

-- Group by

select count(*), genre.name from track
join genre on track.genre_id = genre.genre_id group by genre.name;

select count(*), genre.name from track
join genre on track.genre_id = genre.genre_id group by genre.name
having genre.name = 'Rock' or genre.name = 'Pop';

select artist.name, count(title) from artist 
join album on album.artist_id = artist.artist_id
group by artist.name 

-- Use Distinct

select distinct composer from track;

select distinct billing_postal_code from invoice;

select distinct company from customer;

-- Delete Rows

delete from practice_delete 
where type = 'bronze';

delete from practice_delete 
where type = 'silver';

delete from practice_delete 
where value = 150

-- eCommerce Simulation

create table users (
  user_id serial primary key,
  name varchar(100),
  email varchar(100)
  );


create table products (
  product_id serial primary key,
  name varchar(100),
  price integer
  );

  create table orders (
  orders_id serial primary key,
  product_id integer references products(product_id),
  quantity integer

  );

insert into users (name, email)
    values ('user 1', 'email1@gmail.com'),
    ('user 2', 'email2@gmail.com'),
    ('user 3', 'email3@gmail.com');

insert into products (name, price)
values ('product 1', 45),
('product 2', 22),
('product 3', 34);

insert into orders (product_id, quantity)
values (1, 10),
(2, 5),
(3 , 8);

select products.name, orders.quantity from orders join products
on orders.product_id = products.product_id

select * from orders;

select orders.quantity * products.price as total from orders  
join products on orders.product_id = products.product_id
where orders_id = 1

ALTER TABLE orders
 ADD COLUMN user_id INTEGER REFERENCES users(user_id);

 update orders
set user_id = 1
where user_id is null

select * from orders
where user_id = 1;

select count(*) from orders
where user_id = 1;


select sum(orders.quantity * products.price) as total
from orders 
join products on orders.product_id = products.product_id 
where orders.user_id = 1;










