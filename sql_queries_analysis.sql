/*
 * HR Analytics Portfolio - SQL Queries
 * Role Target: People Analyst
 * Tools: PostgreSQL via DBeaver
 * Dataset: IBM HR Analytics Employee Attrition & Performance

 * Queries included:
 * 1. Attrition Rate per Department
 * 2. Average Salary by Department and Job Role 
 * 3. Flight Risk Analysis 
 */

=========================================
-- Query Awal
=========================================

-- cek semua kolom yang ada di dataset
select *
from employees
limit 10;

-- cek jenis department yang ada di dataset 
select 
distinct "Department"
from employees;

-- Buat tabel departments_info
create table departments_info (
	department VARCHAR(50) primary key,
	office_location VARCHAR(100),
	dept_manager VARCHAR(100),
	total_budget INT,
	established_year INT
);

-- Input data untuk 3 departemen yang ada di dataset
insert into departments_info (department, office_location, dept_head, total_budget, established_year) VALUES
('Sales', 'Gedung A, Lantai 2, Jakarta', 'Hendra Sulistyo', 5000000, 2010),
('Research & Development', 'Gedung B, Lantai 5, Jakarta', 'Kevin Wibisono', 8000000, 2008),
('Human Resources', 'Gedung A, Lantai 1, Jakarta', 'Clara Putri', 2000000, 2012);

-- Verifikasi data sudah masuk
select *
from departments_info; 

=========================================
-- Query 1: Attrition Rate per Department
=========================================
select 
	"Department",
	COUNT("EmployeeNumber") as total_karyawan,
	SUM(case when "Attrition" = 'Yes' then 1 else 0 end) as jumlah_resign,
	ROUND((SUM(case when "Attrition" = 'Yes' then 1 else 0 end) * 100.0 / COUNT("EmployeeNumber")), 2) as attrition_rate_percentage
from employees 
group by "Department"
order by attrition_rate_percentage desc;

=========================================
-- Query 2: Average Salary by Department and Job Role
=========================================
select
	d.department as nama_departemen,
	d.dept_head as kepala_departemen,
	e."JobRole" as posisi, 
	COUNT(e."EmployeeNumber") as jumlah_karyawan,
	ROUND(AVG(e."MonthlyIncome"), 0) as rata_rata_gaji
from employees e
join departments_info d on e."Department" = d.department
group by d.department, d.dept_head, e."JobRole"
order by d.department, rata_rata_gaji desc;

=========================================
-- Query 3: Flight Risk Analysis
=========================================
select
	e."EmployeeNumber" as id_karyawan,
	e."Age" as usia, 
	e."Department" as departemen, 
	e."JobRole" as posisi,
	e."MonthlyIncome" as gaji_bulanan,
	e."PerformanceRating" as rating_performa,
	e."JobSatisfaction" as kepuasan_kerja,
	e."YearsAtCompany" as masa_kerja_tahun,
	d.dept_head as kepala_departemen
from employees e
join departments_info d on e."Department" = d.department
where e."PerformanceRating" >= 3
	and e."JobSatisfaction" <= 2
	and e."Attrition" = 'No'
order by e."PerformanceRating" desc, e."JobSatisfaction" asc;
