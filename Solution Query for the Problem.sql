select * from salary;
select * from deduction;
select * from income;
select * from emp_transaction;

insert into emp_transaction
select emp_id, emp_name, trns_type 
, case when trns_type = 'Insurance' then round(base_salary* (percentage/100),2)
	   when trns_type = 'House'     then round(base_salary* (percentage/100),2)
	   when trns_type = 'Health'    then round(base_salary* (percentage/100),2)
	   when trns_type = 'Basic'     then round(base_salary* (percentage/100),2)
	   when trns_type = 'Allowance' then round(base_salary* (percentage/100),2)
	   when trns_type = 'Others'    then round(base_salary* (percentage/100),2)
	   end as Amount
from salary
cross join
		(select income as trns_type, cast(percentage as decimal) as percentage from income
		union
		select deduction as trns_type, cast(percentage as decimal) as percentage from deduction) x


------ Building Salary Report
create extension tablefunc;

select employee
, basic, allowance, others
, (basic + allowance + others) as gross
, insurance, health, house
, (insurance + health + house) as total_deduction
, ((basic + allowance + others) - (insurance + health + house)) as net_pay
from crosstab('select emp_name, trns_type, amount
			   from emp_transaction
			   order by emp_name, trns_type'
			 , 'select distinct trns_type from emp_transaction order by trns_type')
	 as result(employee varchar, allowance numeric, basic numeric, health numeric
			   , house numeric, insurance numeric, others numeric)






