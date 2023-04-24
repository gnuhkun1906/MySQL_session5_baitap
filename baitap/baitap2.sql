create database session5_baitap_quanlisinhvien;
use session5_baitap_quanlisinhvien;
-- Tạo bảng student
create table student(
studentId int primary key auto_increment,
studentName varchar(50),
age int,
email varchar(50)
);
-- Tạo bảng classes
create table classes(
classId int primary key auto_Increment,
className varchar(50)
);
 -- Tạo bảng classStudent
create table classstudent(
studentId int,
foreign key(studentId) references student(studentId),
classId int ,
 foreign key(classId) references classes(classId)
); 

insert into classstudent values
(1,1),
(2,1),
(3,2),
(4,2),
(5,2);
 -- Tạo bảng subjects
 create table subjects(
 subjectId int primary key auto_increment,
 subName varchar(50)
 );
 -- Tạo bảng mark
 create table mark(
 mark int ,
 subId int,
 foreign key(subId) references subjects(subjectId),
 stuId int,
 foreign key(stuId) references student(studentId)
 );

insert into mark values 
(8,1,1),
(4,2,1),
(9,1,1),
(7,1,3),
(3,1,4),
(5,2,5),
(8,3,3),
(1,3,5),
(3,2,4);

-- 1. Hiển thị danh sách tất cả học viên 
select * from student;
-- 2. Hiện thị danh sách tát cả các môn học
select * from subjects;
-- 3. Tính điểm trung bình
select avg(mark) as `Điểm trung bình` from mark;
-- 4. Hiện thị môn học có học sinh điểm cao nhất
select sb.subName , max(mark) from subjects sb join mark m on sb.subjectId=m.subId group by subId;
-- 5. Đánh số thứ tự của điểm theo chiều giảm
create index idx_mark on mark(markstudent) ;
-- 6. Thay đổi kiểu dữ  liệu của cột subjectname  thành nvarchar
alter table subjects 
modify column subName nvarchar(50);
-- 7. Cập nhật thêm dòng chữ 
update subjects 
set subName=concat("Đây là môn học ",subName);
-- 8. Viết check constraint  kiểm tra độ tuổi  nhập vào trong bảng studnet student
alter table student
add constraint age check(age>15 and age<50);
-- 9. Loại bỏ tất cả các quan hệ giữa bảng
alter table mark 
drop foreign key subId;
-- 10. Xóa học viên có studentId là 1

delete from student where studentId=1;
-- 11. Thêm cột status vào bảng student kiểu dữ liệu là bit và giá trị mặc định lầ 1
alter table student 
add column `status` bit default(1);
-- 12. Cập nhật giá trị status trong bảng  student giá trị là 0
update student
set `status`=0;



 
