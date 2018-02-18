## MYSQL ALL THE TABLE SCHEMA 

create table tbl_login ( 
l_id int NOT NULL AUTO_INCREMENT,
l_email varchar(30) NOT NULL,
l_pass varchar(30) NOT NULL,
l_type varchar(30) NOT NULL,
primary key(l_id));

-----------------------------------------------------

create table tbl_user_detail ( 
u_id int NOT NULL AUTO_INCREMENT,
l_id int NOT NULL,
u_fname varchar(20) ,
u_lname varchar(20) ,
u_gender varchar(20),
u_contact varchar(20),
u_add varchar(50) ,
u_city int  ,
u_state int ,
u_country int ,
u_pincode int ,
u_join_date varchar(20) NOT NULL,
u_laste_date varchar(20) NOT NULL,
primary key(u_id),
foreign key(l_id) references tbl_login(l_id));


-------------------------------------------------------

create table tbl_category(
c_id int not null AUTO_INCREMENT,
c_name varchar(30) NOT NULL,
primary key(c_id));




----------------------------------------------------------------




create table tbl_sub_cat(
sub_id int NOT NULL AUTO_INCREMENT,
c_id int NOT NULL,
sub_name varchar(30) NOT NULL,
primary key(sub_id),
foreign key(c_id) references tbl_category(c_id));

-------------------------------------------------------------------------


create table tbl_product(
p_id int NOT NULL AUTO_INCREMENT,
sub_id int NOT NULL,
p_name varchar(30) NOT NULL,
p_desc varchar(30) NOT NULL,
p_price int NOT NULL,
p_qty int NOT NULL,
p_img varchar(30) NOT NULL,
p_company varchar(30) NOT NULL,
primary key(p_id),
foreign key(sub_id) references tbl_sub_cat(sub_id));


insert into tbl_product values(null,1,'Nataraj Erasers','Best Product',30,10,'images/productImages/e3.jpg','Nataraj','special');
insert into tbl_product values(null,28,'Pen Cello Benz','Easy to Write',30,10,'images/productImages/Cello Benz Rectractable.jpg','Cello','normal');
insert into tbl_product values(null,28,'Pen Cello Gripp','Easy to Write',40,10,'images/productImages/Cello Gripp.png','Cello','normal');


---------------------------------------------------------------------------


create table tbl_order(
o_id int NOT NULL AUTO_INCREMENT,
l_id int NOT NULL,
order_date varchar(30) NOT NULL,
order_status varchar(30) NOT NULL,
grand_total int NOT NULL,
primary key(o_id),
foreign key(l_id) references tbl_login(l_id));


------------------------------------------------------------------------------

create table tbl_order_detail(
o_detail_id int NOT NULL AUTO_INCREMENT,
o_id int NOT NULL,
p_id int NOT NULL,
user_qty int NOT NULL,
total int NOT NULL,
primary key(o_detail_id),
foreign key(o_id) references tbl_order(o_id),
foreign key(p_id) references tbl_product(p_id));

------------------------------------------------------------------------------

create procedure user_buy_item1(o_id int,pid int,user_qty int,total int)
begin
DECLARE total_products INT DEFAULT 0;
DECLARE new_total INT DEFAULT 0;
insert into tbl_order_detail values(null,o_id,pid,user_qty,total);
select p_qty into total_products from tbl_product where p_id = pid;
set new_total = total_products - user_qty;
update tbl_product set p_qty = new_total where p_id = pid;
end 

------------------------------------------------------------------------------------
DECLARE total_products INT DEFAULT 0;
 
SELECT COUNT(*) INTO total_products
FROM products

------------------------------------------------------------------------------------

select p_id,p_name,p_price,p_desc,p_img,sub_name,c_name from tbl_product,tbl_sub_cat,tbl_category where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and p_id = 1;


----------------------------------------------------------------------------------------

create table tbl_display_img(
d_img_id int NOT NULL AUTO_INCREMENT,
p_id int NOT NULL,
d_img_name varchar(30) NOT NULL,
primary key(d_img_id),
foreign key(p_id) references tbl_product(p_id));


-------------------------------------------------------------------------------

create procedure st_cancle_order1(oid int,pid int)
begin
DECLARE u_qty INT DEFAULT 0;
DECLARE now_qty INT DEFAULT 0;
DECLARE cur_qty INT DEFAULT 0;
select user_qty into u_qty from tbl_order_detail where o_id = oid and p_id = pid;
select p_qty into now_qty from tbl_product where p_id = pid;
set cur_qty = u_qty + now_qty;
update tbl_product set p_qty = cur_qty where p_id = pid;
delete from tbl_order_detail where o_id = oid and p_id = pid;
end

------------------------------------------------------------------------------------------

select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.p_id = 1; 

-------------------------------------------------------------------------

create procedure st_change_product_info(pid int,pname varchar(30),pdesc varchar(30),pprice int,user_qty int,pimg varchar(30),pcom varchar(30),ptype varchar(20))
begin
DECLARE now_qty INT DEFAULT 0;
DECLARE cur_qty INT DEFAULT 0;
select p_qty into now_qty from tbl_product where p_id = pid;
set cur_qty = now_qty + user_qty;
update tbl_product set p_name = pname,p_desc = pdesc,p_price = pprice,p_qty = cur_qty,p_img = pimg,p_company = pcom,p_type = ptype where p_id = pid;
end

--------------------------------------------------------------------------------
insert into date_example values(null,CURDATE());

insert into date_example values(null,'2016-03-09');

select * from date_example where j_date between '2016-03-01' and '2016-03-31';

-----------------------------------------------------------------------------------


select sum(user_qty) from tbl_order_detail,tbl_sub_cat,tbl_category,tbl_product where tbl_order_detail.p_id = tbl_product.p_id and tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_category.c_id = 6;

-------------------------------------------------------------------------------------
date wise category display

select sum(user_qty) from tbl_order_detail,tbl_sub_cat,tbl_category,tbl_product,tbl_order where tbl_order_detail.p_id = tbl_product.p_id and  tbl_order_detail.o_id = tbl_order.o_id and tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_category.c_id = 6 and tbl_order.order_date between '2016-04-04' and '2016-04-06';

-----------------------------------------------------------------------------------------------------------

delete product

create procedure st_delete_product(pid int)
begin
delete from tbl_display_img where p_id = pid;
delete from tbl_order_detail where p_id = pid;
delete from tbl_dealer where p_id = pid;
delete from tbl_product where p_id  = pid;
end

--------------------------------------------------------------------------------------------------------------------

select l_id,p_name from tbl_order,tbl_order_detail,tbl_product where tbl_order.o_id = tbl_order_detail.o_id and tbl_order_detail.p_id = tbl_product.p_id and tbl_order.order_status = 'pending' and tbl_order_detail.p_id = 7;


--------------------------------------------------------------------------------------------------------------

select p_id from tbl_product,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.sub_name = 'Erasers' and tbl_sub_cat.c_id = 6;


------------------------------------------------------------------------------------------------------------------------------------


select p_id from tbl_product,tbl_sub_cat,tbl_category where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_category.c_id = 6;


-----------------------------------------------------------------------------------------------------------------------------------


create table tbl_product_dealer_info(
d_id int NOT NULL AUTO_INCREMENT,
d_name varchar(30) not null,
d_contact varchar(20) not null,
d_address varchar(50) not null,
d_email varchar(20) not null,
primary key(d_id));

-------------------------------------------------------------------------

create table tbl_dealer(
d_id int NOT NULL AUTO_INCREMENT,
l_id int NOT NULL,
p_id int NOT NULL,
d_price int NOT NULL,
d_last_date varchar(30) NOT NULL,
primary key(d_id),
foreign key(l_id) references tbl_login(l_id),
foreign key(p_id) references tbl_product(p_id));


----------------------------------------------------------------------------------------

select u_fname,u_contact,l_email,d_last_date,d_price from tbl_user_detail,tbl_login,tbl_dealer where 
tbl_login.l_id = tbl_dealer.l_id and 
tbl_user_detail.l_id = tbl_dealer.l_id and 
tbl_dealer.p_id = 85 order by d_price;

--------------------------------------------------------------------------------------------


create procedure st_delete_student(sid int)
begin
delete from student where id  = sid;
end










