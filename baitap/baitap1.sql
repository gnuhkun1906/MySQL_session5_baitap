create database session5_baitap_demo;
create table products (
id varchar(5) primary key ,
productCode int ,
productName varchar(50),
productPrice real,
productAmount int ,
productDescription varchar(50),
productStatus tinyint default(0)
);
-- tạo unique index cho cột productCode
explain select * from products;
create unique index id_productCod
on products(productCode);
alter table products drop index id_composite;
create index id_composite
on products(productName, productPrice);
explain select productName, productPrice from  products;

-- Tạo view lấy thông tin 

create view product_view
as select productCode, productName, productPrice, productStatus  from products;
select * from product_view;
-- cập nhật view 
 create or replace view product_view
 as select productCode, productName, productPrice, productStatus, productAmount from products;

--  xóa view
drop view product_view;

-- tạo store procedure 
delimiter //
create procedure getAllProducts()
begin 
select * from products;
end
// delimiter ;
call getAllProducts;
--  Tạo pro để thêm 1 sản phẩm mới
drop procedure if exists `create_product`;
delimiter //
create procedure create_product(
In idcreate int ,
IN proCode int ,
In proName varchar(50),
In price real,
In proAmount int ,
IN proDes varchar(50),
IN proStatus tinyint
)
begin
insert into products values (idcreate, proCode, proName, price, proAmount, proDes, proStatus);
end //
delimiter ;
call create_product("8",7,"sip rach",900,10,"vẫn sexy",0);
select * from products;

-- tạo pro sửa sản phẩm theo id
delimiter //
create procedure update_product(
IN idc int
)
begin 
update products set productPrice= 200 where id= idc;
end
// delimiter ;
call update_product(2);
 
 -- Tạo pro xóa sản phẩm theo id
 delimiter //
 create procedure delete_pro(IN idDel int)
 begin 
 delete from products where id=idDel;
 end
 // delimiter ;
 call delete_pro(7)










