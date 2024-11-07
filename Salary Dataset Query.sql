drop table if exists salary;
create table salary(
	emp_id int not null,
	emp_name varchar(50) not null,
	base_salary int not null
);

insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);

drop table if exists income;
create table income(
	id int not null,
	income varchar(50) not null,
	percentage int not null
);

insert into income values(1, 'Basic', 100); 
insert into income values(2, 'Allowance', 4); 
insert into income values(3, 'Others', 6);


drop table if exists deduction;
create table deduction(
	id int not null,
	deduction varchar(50) not null,
	percentage int not null
);

insert into deduction values(1, 'Insurance', 5); 
insert into deduction values(2, 'Health', 6);
insert into deduction values(3, 'House', 4);


create table emp_transaction(
	emp_id int not null,
	emp_name varchar(50) not null,
	trns_type varchar(50) not null,
	amount int not null
);


select * from income;
select * from salary;
select * from deduction;
select * from emp_transaction;
truncate table emp_transaction;



insert into emp_transaction 
select emp_id, emp_name, trns_type
, case when trns_type = 'Basic' then round(base_salary * (percentage/100), 2) 
	 when trns_type = 'Allowance' then round(base_salary * (percentage/100), 2) 
	 when trns_type = 'Others' then round(base_salary * (percentage/100), 2) 
 	 when trns_type = 'Insurance' then round(base_salary * (percentage/100), 2) 
	 when trns_type = 'Health' then round(base_salary * (percentage/100), 2) 
 	 when trns_type = 'House' then round(base_salary * (percentage/100), 2) 
  end as amount
from salary
cross join (select income as trns_type,  cast(percentage as decimal) as percentage from income
			union
			select deduction as trns_type, cast(percentage as decimal) as percentage from deduction)
