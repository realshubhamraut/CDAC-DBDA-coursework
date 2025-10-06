use joinhr;

-- 1) Hello, Employees (staging CTE)
-- Task: Build a CTE that returns EMPLOYEE_ID, full_name, JOB_ID, DEPARTMENT_ID, SALARY.
--  Output: employee_id, full_name, job_id, department_id, salary.
--  Hint: CONCAT(COALESCE(FIRST_NAME,''),' ',LAST_NAME).
with staging as
(
	SELECT EMPLOYEE_ID, CONCAT(COALESCE(FIRST_NAME, ''), ' ', LAST_NAME) AS full_name, 
	JOB_ID, DEPARTMENT_ID, SALARY
    FROM employees
)
select * from staging;

-- 2) Department Headcount (include 0)
-- Task: CTE with employees grouped by DEPARTMENT_ID. Left-join to departments to show all departments.
--  Output: department_id, department_name, headcount.
--  Hint: COALESCE(headcount,0).
with Headcount_temp as
(
	select distinct department_id,count(*) as headcount 
    from employees
    group by DEPARTMENT_ID
)
select d.department_id, d.department_name, COALESCE(headcount,0) as headcount
from departments d
left join Headcount_temp h
on d.DEPARTMENT_ID=h.department_id;

-- 3) Avg Salary by Job
-- Task: CTE aggregates average salary per JOB_ID; join to jobs for titles.
--  Output: job_id, job_title, emp_count, avg_salary.
--  Hint: ROUND(AVG(SALARY),2).
with avg_sal as
(
	select ROUND(AVG(SALARY),2) as avg_salary,job_id,count(*) as emp_count from employees
    group by job_id
)
select j.job_id,j.job_title,a.emp_count,a.avg_salary
from jobs j
join avg_sal a
on j.JOB_ID=a.job_id;

-- 4) Employee → Manager (1 hop)
-- Task: Stage employees in a CTE; self-join to get direct manager name.
--  Output: employee_id, employee_name, manager_id, manager_name.
--  Hint: Left join; top boss may have MANAGER_ID = 0 or NULL.
with EmployeeStage as (
    select employee_id, concat(first_name,' ', last_name) as employee_name, manager_id
    from employees
)
select e.employee_id,e.employee_name,e.manager_id,
coalesce(m.employee_name, 'No Manager') as manager_name
from EmployeeStage e
left join EmployeeStage m on e.manager_id = m.employee_id;

-- 5) Employees Without a Department
-- Task: Use a CTE to list employees where DEPARTMENT_ID IS NULL OR DEPARTMENT_ID=0.
--  Output: employee_id, full_name, job_id, department_id.
with NoDepartment as (
    select employee_id,concat(first_name,' ', last_name) as full_name,
	job_id,department_id
    from employees
    where department_id is null or department_id = 0
)
select * from NoDepartment;

-- 6) Departments Without Employees
-- Task: Distinct DEPARTMENT_ID from employees in a CTE; anti-join to departments.
--  Output: department_id, department_name.
with EmpDept as (
    select distinct department_id
    from employees
    where department_id is not null
)
select d.department_id, d.department_name
from departments d
left join EmpDept ed on d.department_id = ed.department_id
where ed.department_id is null;

-- 7) Map Employees to Region (clean text)
-- Task: CTE joins employees → departments → locations → countries → regions and trims REGION_NAME.
--  Output: employee_id, full_name, department_name, city, country_name, region_name.
--  Hint: TRIM(REPLACE(REGION_NAME,'\r','')).
with EmpRegion as (
    select e.employee_id,concat(e.first_name,' ',e.last_name) as full_name,
	d.department_name,l.city,c.country_name,
	trim(replace(r.region_name,'\r', '')) as region_name
    from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
    join regions r on c.region_id = r.region_id
)
SELECT * FROM EmpRegion;

-- 8) Simple Pay-Band Check
-- Task: CTE joins employees to jobs; return rows where salary < min_salary OR salary > max_salary.
--  Output: employee_id, full_name, job_title, salary, min_salary, max_salary.
with PayBandCheck as (
    select e.employee_id,concat(e.first_name,' ',e.last_name) AS full_name,j.job_title,
	e.salary,j.min_salary,j.max_salary
    from employees e
    join jobs j on e.job_id = j.job_id
)
select *
from PayBandCheck
where salary < min_salary or salary > max_salary;

-- 9) Top Earners (overall)
-- Task: CTE selecting employee_id, full_name, salary, then order and limit to top 5.
--  Output: employee_id, full_name, salary.
--  Hint: Use the CTE just to keep the final SELECT clean.
with EmployeeSalaries as (
    select employee_id,concat(e.first_name,' ',e.last_name) as full_name,salary
    from employees e
)
select *
from EmployeeSalaries
order by salary desc
limit 5;

-- 10) Jobs Present in Each Department
-- Task: CTE groups employees by DEPARTMENT_ID, JOB_ID and counts. Join jobs for title.
--  Output: department_name, job_title, employees_in_role.
with job_pre_dep as(
	select DEPARTMENT_ID, JOB_ID,count(*) as employees_in_role
    from employees
    group by job_ID,DEPARTMENT_ID
)
select department_name, job_title, employees_in_role
from departments d
join job_pre_dep j
on j.department_id=d.DEPARTMENT_ID
join jobs jj
on jj.JOB_ID=j.job_id;

select *from departments;
select *from jobs;
select *from employees where job_id='AD_PRES';

-- 11) Headcount by Region
-- Task: Reuse the “map to region” idea in a CTE; then group by region.
--  Output: region_name, headcount.
--  Hint: Handle NULL region as “Unknown”.

-- 12) Commission Snapshot
-- Task: In a CTE, compute a flag has_commission = commission_pct > 0. Then count by flag.
--  Output: has_commission, headcount.
--  Optional: Break down by department as well.

-- 13) Employees with Any Job History
-- Task: CTE with distinct EMPLOYEE_ID from job_history (exclude dummy row). Join to employees.
--  Output: employee_id, full_name, history_row_count.
--  Hint: COUNT(*) OVER (PARTITION BY EMPLOYEE_ID) or aggregate before join.

-- 14) Latest History Row (gentle)
-- Task: Clean job_history in a CTE (exclude zero/invalid dates) and pick the latest row per employee using ROW_NUMBER.
--  Output: employee_id, last_hist_job_id, last_hist_department_id, last_hist_end_date.
--  Hint: Order by END_DATE DESC, START_DATE DESC.

-- 15) Locations per Country
-- Task: CTE groups locations by COUNTRY_ID; join to countries.
--  Output: country_id, country_name, location_count.
--  Hint: COALESCE(country_name,'Unknown').


-- Regional Workforce Intelligence Report
-- Problem Statement:
--  Leadership wants a one-page report showing how the workforce is distributed across regions and functions.
-- Tasks/Deliverables:
-- Build a CTE pipeline that maps employees → departments → locations → countries → regions.


-- Produce a final query returning: region_name, department_name, headcount, avg_salary, min_salary, max_salary.


-- Order by region_name, department_name.


-- Provide a second query that shows % share of each department within its region (use window functions).


-- Acceptance Criteria:
-- No duplicate rows.


-- Headcount matches actual counts when cross-checked.


-- % shares per region sum to ~100% (allow rounding).


--  Pay Range Compliance Audit
-- Problem Statement:
--  HR suspects some employees are outside the defined pay bands of their jobs.
-- Tasks/Deliverables:
-- With a CTE, join employees to jobs.


-- Return two result sets:
--  a) Below range: employee rows where salary < min_salary.
--  b) Above range: employee rows where salary > max_salary.


-- Add a computed column deviation_amount.


-- Rank violators by absolute deviation within each job (window function).


-- Acceptance Criteria:
-- Separate lists for below and above.


-- Correct deviation math.


-- Top violators clearly identifiable.


-- Org Chart & Depth Analysis (Recursive)
-- Problem Statement:
--  Build an org chart starting at the President and analyze hierarchy depth.
-- Tasks/Deliverables:
-- Create a recursive CTE starting from the AD_PRES holder.


-- Return level_from_president, manager_id, manager_name, employee_id, employee_name, job_id.


-- Provide a summary table: level_from_president, count_of_employees.


-- Identify the deepest level and list employees at that level.


-- Acceptance Criteria:
-- Levels begin at 0 for the President.


-- No cycles or duplicates.


-- Deepest level computed correctly.


-- Sales Organization Footprint
-- Problem Statement:
--  Sales leadership wants a nested view of all Sales teams (SA_MAN roots and their SA_* trees).
-- Tasks/Deliverables:
-- Use a recursive CTE to traverse only employees with job_id LIKE 'SA_%'.


-- For each SA_MAN, return root_manager_id, root_manager_name, employee_id, name, level_in_sales_tree.


-- Provide a per-manager summary with total_team_size.


-- Acceptance Criteria:
-- Only SA_* roles appear.


-- Each SA_MAN’s totals are correct.


-- Levels restart at 0 for each root.


-- Mobility & Career Progression from Job History
-- Problem Statement:
--  Analyze internal mobility patterns using job_history.
-- Tasks/Deliverables:
-- For each employee, determine number_of_distinct_jobs and number_of_distinct_departments from job_history.


-- Identify employees who moved between departments at least once.


-- Return a list of employees whose latest historical role differs from their current job_id (use window functions to pick latest END_DATE).


-- Acceptance Criteria:
-- Exclude the bogus history row with employee_id=0.


-- The latest role logic is correct.


-- Counts reflect distinct values (not rows).


-- Regional Hiring Vintage & Tenure Bucketing
-- Problem Statement:
--  HR wants tenure distributions by region for workforce planning.
-- Tasks/Deliverables:
-- Compute tenure_years from HIRE_DATE to a fixed anchor date (e.g., 1987-10-01).


-- Bucket employees into [0–1), [1–3), [3–5), 5+.


-- Show region_name, bucket, headcount, avg_salary.


-- Within each region, rank buckets by headcount.


-- Acceptance Criteria:
-- Tenure formula correct.


-- Buckets cover all employees, no overlaps.


-- Rankings stable and sensible.


-- Location & Data Quality Sanity Check
-- Problem Statement:
--  Some locations' rows look malformed (quotes, misplaced columns). Produce a quality audit.
-- Tasks/Deliverables:
-- Create a CTE that cleans strings (trim whitespace/CRLF/quotes) in locations and regions.


-- Flag rows where postal_code, city, or state_province look invalid/empty.


-- Identify countries with no valid locations hosting departments (anti-join logic).


-- Acceptance Criteria:
-- Cleaned outputs are visibly improved.


-- Clear list of suspect rows and reasons.


-- Countries-without-departments list is correct.


-- Department Performance Snapshot
-- Problem Statement:
--  Finance wants a department-level payroll snapshot.
-- Tasks/Deliverables:
-- Build a CTE for department salary stats: dept_id, headcount, total_salary, avg_salary, min_salary, max_salary.


-- Join the department metadata to return department_name, location_id, city, region_name with stats.


-- Provide a windowed rank_by_avg_salary within the region.


-- Acceptance Criteria:
-- Headcount/aggregation correct.


-- Region mapping correct.


-- Ranks restart per region.


-- Commission Utilization Report
-- Problem Statement:
--  Sales ops wants to see where commissions are being used—and where not.
-- Tasks/Deliverables:
-- Map each employee to region_name (CTE).


-- For each region, compute with_commission_count, without_commission_count, pct_with_commission.


-- Return a tidy table sorted by pct_with_commission desc.


-- Acceptance Criteria:
-- commission_pct NULL is treated as no commission.


-- Percentages correct to 2 decimals.


-- Ties handled consistently.


-- Pay Position within Range (Percentile per Employee)
-- Problem Statement:
--  HR needs a normalized indicator of where an employee sits within the job’s pay range.
-- Tasks/Deliverables:
-- Join jobs; compute range_pct = (salary - min_salary) / NULLIF(max_salary - min_salary,0).


-- Return employee_id, name, job_title, salary, range_pct.


-- Rank employees within each job by range_pct (window function), and list top 3 per job.


-- Acceptance Criteria:
-- Division by zero safely handled.


-- range_pct between 0 and 1 for in-range, outside range allowed to be <0 or >1.


-- Exactly top 3 per job (or fewer if fewer employees).


-- Department Staffing Pipeline (Cumulative Salary)
-- Problem Statement:
--  Plan staffing costs by looking at cumulative salary within each department.
-- Tasks/Deliverables:
-- For each department, order employees by salary desc.


-- Compute a running_total of salary (window function).


-- Add a column pct_of_dept_payroll = running_total / total_dept_salary.


-- Identify the minimal set of employees that accounts for ≥ 50% of each department’s payroll.


-- Acceptance Criteria:
-- Running totals correct per department.


-- Percentages accurate.


-- Minimal set logic correct (first point where cumulative ≥ 50%).


-- “What-If” Regional Reorganization (Design + SQL)
-- Problem Statement:
--  The company is considering merging regions “Europe” and “Middle East and Africa” into “EMEA”. Provide impact analysis.
-- Tasks/Deliverables:
-- Without altering base tables, use a CTE to remap region names into EMEA, Americas, Asia (Europe + MEA → EMEA).


-- Recompute headcounts and payroll stats by new_region_name.


-- Show top 5 departments (by headcount) that would reside in EMEA after the merge.


-- Provide a short write-up (3–5 bullets) interpreting the numbers.


-- Acceptance Criteria:
-- Remapping is done only in the query layer (CTE), not via DML.


-- Aggregates reflect the new grouping.


-- Clear, defensible summary points.

