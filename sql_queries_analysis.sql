/*
 * HR Analytics Portfolio - SQL Queries
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
    dept_head VARCHAR(100),
    total_budget INT,
    established_year INT
);

-- Input data untuk 3 departemen yang ada di dataset
insert into departments_info (department, office_location, dept_head, total_budget, established_year) values
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
    "Department" AS nama_departemen,
    COUNT("EmployeeNumber") AS total_karyawan,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS jumlah_resign,
    ROUND((SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT("EmployeeNumber")), 2) AS persentase_attrition
from employees 
group by "Department"
order by persentase_attrition desc;

=========================================
-- Query 2: Average Salary by Department and Job Role
=========================================
select 
    d.department AS nama_departemen,
    d.dept_head AS kepala_departemen,
    e."JobRole" AS posisi, 
    COUNT(e."EmployeeNumber") AS jumlah_karyawan,
    ROUND(AVG(e."MonthlyIncome"), 0) AS rata_rata_gaji
from employees e
join departments_info d ON e."Department" = d.department
group by d.department, d.dept_head, e."JobRole"
order by d.department, rata_rata_gaji desc;

=========================================
-- Query 3: Flight Risk Analysis
=========================================
select
    e."EmployeeNumber" AS id_karyawan,
    e."Age" AS usia,
    e."Department" AS nama_departemen,
    e."JobRole" AS posisi,
    e."MonthlyIncome" AS gaji_bulanan,
    e."PerformanceRating" AS rating_performa,
    e."JobSatisfaction" AS kepuasan_kerja,
    e."YearsAtCompany" AS masa_kerja_tahun,
    d.dept_head AS kepala_departemen
from employees e
join departments_info d ON e."Department" = d.department
where e."PerformanceRating" = 4     
  and e."JobSatisfaction" <= 2       
  and e."Attrition" = 'No'           
order by  
    e."PerformanceRating" desc, 
    e."JobSatisfaction" asc;
