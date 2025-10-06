-- 1) Display all the employees whose salary is greater than the average salary of their department.
SELECT * FROM emp e
WHERE sal > (
  SELECT AVG(sal) FROM emp WHERE deptno = e.deptno
);

-- 2) Display employees where length of ename is 5
SELECT * FROM emp WHERE LENGTH(ename) = 5;

-- 3) Display all employees where ename start with J and ends with S
SELECT * FROM emp WHERE ename LIKE 'J%S';

-- 4) Display all employees where employee does not belong to 10,20,40 department_id
SELECT * FROM emp WHERE deptno NOT IN (10, 20, 40);

-- 5) Display all employees where jobs do not belong to the PRESIDENT and MANAGER
SELECT * FROM emp WHERE job NOT IN ('PRESIDENT', 'MANAGER');

-- 6) Display all three figures salary in emp table
SELECT DISTINCT sal FROM emp;

-- 7) Display all records in emp table for employee who does not receive any commission
SELECT * FROM emp WHERE NVL(comm, 0) = 0;

-- 8) Display all ename where first character could be anything, but second character should be L
SELECT * FROM emp WHERE ename LIKE '_L%';

-- 9) Display nth highest and nth lowest salary in emp table
-- Replace :n with desired rank
SELECT * FROM (
  SELECT sal, RANK() OVER (ORDER BY sal DESC) AS rnk FROM emp
) WHERE rnk = :n;

SELECT * FROM (
  SELECT sal, RANK() OVER (ORDER BY sal ASC) AS rnk FROM emp
) WHERE rnk = :n;

-- 10) Display all the departments where the department has 3 employees
SELECT deptno FROM emp GROUP BY deptno HAVING COUNT(*) = 3;

-- 11) Display emp name and corresponding subordinates. Use CONNECT BY clause.
SELECT ename, empno, mgr FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;

-- 12) Display all ename, sal, deptno, dname from emp, dept table including non matching departments
SELECT e.ename, e.sal, e.deptno, d.dname
FROM emp e
RIGHT JOIN dept d ON e.deptno = d.deptno;

-- 13) Display all ename, sal, deptno from emp, dept table including employees without departments
SELECT e.ename, e.sal, e.deptno
FROM emp e
LEFT JOIN dept d ON e.deptno = d.deptno;

-- 14) Display all ename, sal, deptno from emp, dept table including non matching rows on both sides
SELECT e.ename, e.sal, e.deptno, d.dname
FROM emp e
FULL OUTER JOIN dept d ON e.deptno = d.deptno;

-- 15) Display all ename, empno, dname, loc from emp, dept table without joining two tables
SELECT e.ename, e.empno,
  (SELECT dname FROM dept WHERE deptno = e.deptno) AS dname,
  (SELECT loc FROM dept WHERE deptno = e.deptno) AS loc
FROM emp e;

-- 16) Display all the departments where department does not have any employees
SELECT * FROM dept d
WHERE NOT EXISTS (
  SELECT 1 FROM emp e WHERE e.deptno = d.deptno
);

-- 17) Display all the departments where department does have at least one employee
SELECT * FROM dept d
WHERE EXISTS (
  SELECT 1 FROM emp e WHERE e.deptno = d.deptno
);

-- 18) Display all employees who are not managers
SELECT * FROM emp WHERE empno NOT IN (SELECT DISTINCT mgr FROM emp WHERE mgr IS NOT NULL);

-- 19) Display ename, deptno from emp table with format of {ename} belongs to {deptno}
SELECT ename || ' belongs to ' || deptno AS info FROM emp;

-- 20) Display total number of employees hired for 1980,1981,1982. The output should be in one record.
SELECT
  SUM(CASE WHEN TO_CHAR(hiredate, 'YYYY') = '1980' THEN 1 ELSE 0 END) AS hired_1980,
  SUM(CASE WHEN TO_CHAR(hiredate, 'YYYY') = '1981' THEN 1 ELSE 0 END) AS hired_1981,
  SUM(CASE WHEN TO_CHAR(hiredate, 'YYYY') = '1982' THEN 1 ELSE 0 END) AS hired_1982
FROM emp;

-- 21) Display ename, deptno with label for deptno
SELECT ename, deptno,
  CASE deptno
    WHEN 10 THEN 'ten'
    WHEN 20 THEN 'twenty'
    WHEN 30 THEN 'thirty'
    WHEN 40 THEN 'fourty'
    ELSE 'other'
  END AS dept_label
FROM emp;

-- 22) Display ename lowercase, job with first letter uppercase
SELECT LOWER(ename) AS ename,
  INITCAP(job) AS job
FROM emp;

-- 23) Display all employees who joined in the first week of the month
SELECT * FROM emp
WHERE TO_CHAR(hiredate, 'WW') = TO_CHAR(TRUNC(hiredate, 'MM'), 'WW');

-- 24) Display all employees who joined in the 49th week of the year
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'WW') = '49';

-- 25) Display empno, deptno, salary, salary difference with previous record
SELECT empno, deptno, sal,
  sal - LAG(sal) OVER (PARTITION BY deptno ORDER BY sal DESC) AS sal_diff
FROM emp
ORDER BY deptno DESC;

-- 26) Create table emp1 and copy the emp table for deptno 10 while creating the table
CREATE TABLE emp1 AS SELECT * FROM emp WHERE deptno = 10;

-- 27) Create table emp2 with the same structure of emp table. Do not copy the data
CREATE TABLE emp2 AS SELECT * FROM emp WHERE 1=0;

-- 28) Insert new record in emp1, merge emp1 on emp
INSERT INTO emp1 VALUES (9999, 'OM', 'CLERK', 7788, SYSDATE, 3000, NULL, 10);

MERGE INTO emp e
USING emp1 e1 ON (e.empno = e1.empno)
WHEN MATCHED THEN UPDATE SET e.sal = e1.sal
WHEN NOT MATCHED THEN INSERT VALUES (e1.empno, e1.ename, e1.job, e1.mgr, e1.hiredate, e1.sal, e1.comm, e1.deptno);

-- 29) Display all records for deptno which belongs to employee name JAMES
SELECT * FROM emp WHERE deptno = (
  SELECT deptno FROM emp WHERE ename = 'JAMES'
);

-- 30) Display all records where salary <= ADAMS salary
SELECT * FROM emp WHERE sal <= (
  SELECT sal FROM emp WHERE ename = 'ADAMS'
);

-- 31) Display all employees joined before WARD
SELECT * FROM emp WHERE hiredate < (
  SELECT hiredate FROM emp WHERE ename = 'WARD'
);

-- 32) Display all subordinates working under BLAKE
SELECT * FROM emp WHERE mgr = (
  SELECT empno FROM emp WHERE ename = 'BLAKE'
);

-- 33) Display all subordinates (all levels) for employee BLAKE
SELECT * FROM emp
START WITH empno = (SELECT empno FROM emp WHERE ename = 'BLAKE')
CONNECT BY PRIOR empno = mgr;

-- 34) Display all records for deptno which belongs to KING's Job
SELECT * FROM emp WHERE deptno IN (
  SELECT deptno FROM emp WHERE job = (
    SELECT job FROM emp WHERE ename = 'KING'
  )
);

-- 35) Update salary based on department rules
UPDATE emp
SET sal = CASE
  WHEN deptno = 40 THEN sal * 1.25
  WHEN deptno = 90 THEN sal * 1.15
  WHEN deptno = 110 THEN sal * 1.10
  ELSE sal
END;

-- 36) Display ename joined in Year 81 as MANAGER
SELECT ename FROM emp
WHERE job = 'MANAGER' AND TO_CHAR(hiredate, 'YY') = '81';

-- 37) Display who is making the highest commission
SELECT * FROM emp
WHERE comm = (SELECT MAX(comm) FROM emp WHERE comm IS NOT NULL);

-- 38) Display senior most employee and tenure
SELECT ename, ROUND(MONTHS_BETWEEN(SYSDATE, hiredate)/12, 2) AS years_worked
FROM emp
WHERE hiredate = (SELECT MIN(hiredate) FROM emp);

-- 39) Most and least experienced employee
SELECT * FROM emp
WHERE hiredate = (SELECT MIN(hiredate) FROM emp)
   OR hiredate = (SELECT MAX(hiredate) FROM emp);

