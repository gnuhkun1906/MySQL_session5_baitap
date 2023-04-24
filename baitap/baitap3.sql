create database session5_baitap_studentTest;
use session5_baitap_studenttest;

create table student(
rn int primary key,
`name` varchar(20),
age tinyint 
);

 create table test(
 testId int primary key,
 `name` varchar(20)
 );
 
 create table studenTest(
 rn int,
 foreign key(rn) references student(rn),
 testId int ,
 foreign key(testId) references test(testid),
 `date` date,
 mark float
 );
 
 insert into studenTest values
 (1,1,"2006-07-17",8),
 (1,2,"2006-07-18",5),
 (1,3,"2006-07-19",7),
 (2,1,"2006-07-17",7),
 (2,2,"2006-07-18",4),
 (2,3,"2006-07-19",2),
 (3,1,"2006-07-17",10),
 (3,3,"2006-07-18",1);
 
 -- 2. Sửa đổi
 alter table student 
 add constraint age check(age>15 and age<55);
 
 alter table studenTest 
 modify mark float default(0);
 
 alter table studenTest 
 add primary key (rn,testId);
 
 alter table test
 modify `name` varchar(50) unique;

alter table  test drop constraint name_UNIQUE;
 
-- 3.Hiển thị danh sách  các học viên tham gia thi
select (select @stt:=@stt +1) as `stt`, s.`name`, t.`name`, st.mark, st.`date`
from  (select @stt:= 0) r,studentest st join student s on st.rn=s.rn
join test t on st.testId=t.testId ;
 
 -- 4. Hiển thi danh sách các học sinh chưa thi môn nào
 select * from student where rn not in 
 (select s.rn from student s join studenTest st on s.rn=st.rn);
 
 -- 5. Hiện thị danh sách học viên phải thi lại, tên môn học và( điểm thi lại thì phải nhỏ hơn 5)
 select s.`name`, t.`name`, st.mark, st.`date`
from studentest st join student s on st.rn=s.rn
join test t on st.testId=t.testId where st.mark<5;
 
 -- 6. Hiển thị danh sách học viên và điểm trung bình của các môn thi và sắp xêp theo thứ tự giảm dần
 select s.`name`, avg(st.mark) as `avg` from 
 student s join studentest st on s.rn =st.rn
 group by st.rn order by `avg` desc ;
 
 -- 8. Hiển thị tên học viên có điểm trung bình lớn nhất
 select s.`name`, max(avg(st.mark)) as `avg` from 
 student s join studentest st on s.rn =st.rn
group by st.rn;

-- 9. Hiển thị điểm cao nhất của từng môn học,danh sách phải đc sắp xếp theo môn học asc
select t.`name` as `testname`, max(st.mark)
from test t join studentest st on t.testId=st.testId
group by st.testId order by t.`name`;

-- 10.Hiển thị danh sách tất cả học viên và môn học mà học viên đó đã thi nếu chưa thi thì thì tên môn học đó là null
select s.`name`,t.`name` as `Test Name` from 
student s left join studentest st on s.rn=st.rn
left join test t on st.testId=t.testId;
-- 11. update  tuổi của học viên mỗi người lên 1 tuổi
update student 
set age=age+1;
-- 12. Thêm trường status có kiểu dữ liệu là varchar(10) vào bảng student
alter table student 
add column `status` varchar(10);
-- 13.cập nhật status  cho những học viên nhỏ hơn 30 tuổi;
update student
set `status` = case when age<30
then concat("young",`status`)
else concat("old", `status`)
end;
-- 14. Hiển thị danh sách học viên và điểm thi sắp xếp theo ngày thi tăng dần
select s.`name` as `Student Name`, t.`name` as `TestName`, st.mark , st.`date`
from student s join studentest st on s.rn = st.rn 
join test t on st.testId=t.testId
order by st.`date`;

-- 15. Hiển thị thông tin sinh viên có tên bắt đầu bẳng "T"  và điểm thi trung bình >4.5
select  s.`name` as `Student Name`,s.age,avg(st.mark) as `Điểm trung bình`
from student s join studentest st on s.rn=st.rn 
group by st.rn 
having s.`name` like "T%" and avg(mark)>4.5;

-- 16. Hiển thị thông tin sinh viên và xếp hạng theo điểm trung bình cao nhất thì xếp thứ 1
select s.*, avg(mark), rank() over(order by avg(mark) desc)
from student s join studentest st on s.rn=st.rn 
group by st.rn;

-- 17. Sửa đổi kiểu dữ liệu cột name trong bảng student;
alter table student 
modify `name` nvarchar(255);

-- 18. update chuỗi 
update student 
set `name`= case when age>20 
then concat("old ",`name`) 
else concat("young", `name`) 
end;
 
 -- 19. Xóa tất cả các môn học chưa có sinh viên nào thi
 delete from test where testId not in 
 (select st.testId from studenTest st);
-- 20.Xóa thông tin học viên có điểm thi < 5
delete from student where rn not in 
(select st.rn from studentest st where st.mark>5); 
 
 
 
 
 
 
 
 
 