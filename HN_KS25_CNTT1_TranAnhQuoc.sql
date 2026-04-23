create database book_store_DB;
use book_store_DB;

create table category (
	category_id int primary key auto_increment not null,
    category_name varchar(100) not null,
    description varchar(255)
);

create table book (
	book_id int primary key auto_increment not null,
	title varchar(150) not null,
    status int default 1,
    publish_date date,
    price decimal(10,2),
    category_id int,
    foreign key (category_id) references category (category_id)
);

create table book_order (
	order_id int primary key auto_increment not null,
    customer_name varchar(100) not null,
    book_id int,
	foreign key (book_id) references book (book_id) on delete cascade,
    order_date date default (current_date()),
    delivery_date date
);

-- them cot
alter table book
add column author_name varchar(100) not null;

-- sua kieu du lieu 
alter table book_order
modify column customer_name varchar(200);

-- them rang buoc
alter table book_order
add constraint check_delivery_date 
check (delivery_date >= order_date);


insert into category (category_name, description)
values 
	('IT & Tech', 'Sách lập trình'),
	('Business', 'Sách kinh doanh'),
	('Novel', 'Tiểu thuyết');
    
insert into book (title, status, publish_date, price, category_id, author_name)
values 
	('CleanCode', 1, '2020-05-10', 500000, 1, 'Robert C.Martin'),
	('Đắc Nhân Tâm', 0, '2018-08-20', 150000, 2, 'Dale Carnegie'),
	('JavaScript Nâng cao', 1, '2023-01-15', 350000, 1, 'Kyle Simpson'),
	('Nhà Giả Kim', 0, '2015-11-25', 120000, 3, 'Paulo Coelho');
    
insert into book_order (order_id, customer_name, book_id, order_date, delivery_date) 
values
	(101, 'Nguyen Hai Nam', 1, '2025-01-10', '2025-02-10'),
	(102, 'Tran Bao Ngoc', 3, '2025-02-05', '2025-02-10'),
	(103, 'Le Hoang Yen', 4, '2025-03-12', null);
    
update book
set price = 50000
where category_id = 1;

update book_order
set delivery_date = '2025-12-31'
where delivery_date is null;

delete from book_order
where order_date < '2025-02-01';

select *
from book 
order by price desc
limit 2;

select title, price, category_name
from book as b
inner join category as c
on b.category_id = c.category_id;

select title, author_name,
	case
		when status = 1 then 'Còn hàng'
        when status = 0 then 'Hết hàng'
	end as status_name
from book;

select title, category_id
from book 
group by title, category_id
having category_id > 2;
	

