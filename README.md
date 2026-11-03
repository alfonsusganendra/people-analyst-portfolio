# HR Analytics Dashboard: Employee Retention & Compensation 

## Latar Belakang
*Project* ini mensimulasikan peran **People Analyst** dalam menganalisis data terkait Human Resources. 
Tujuan utama: 
- Identifikasi resignasi (*attrition*),
- Analisis struktur gaji,
- Identifikasi karyawan yang beresiko tinggi untuk *resign* (*flight risk*),
- Membantu tim HR mengambil keputusan berbasis data.

## Tools & Teknologi
- **SQL (PostgreSQL via DBeaver):** Untuk ekstraksi, transformasi dan agregasi data mentah (dengan menggunakan antara lain 'JOIN', 'GROUP BY', 'CASE WHEN' dan agregasi). 
- **Microsoft Excel:** Untuk pembuatan Pivot Table dan *dashboard* yang interaktif. 

## Sumber Data
*Dataset* yang digunakan adalah **IBM HR Analytics Employee Attrition & Performance** (sumber dari Kaggle). 

Catatan: *dataset* asli menggunakan mata uang dollar (USD). Untuk relevansi konteks bisnis di Indonesia, dilakukan konversi ke mata uang rupiah (IDR) dengan asumsi kurs 1 USD = Rp. 18.000,-. Konversi ini hanya bertujuan untuk simulasi di *project* ini. 

## Proses Analisis
1. **Data Preparation:** memecah *dataset* tunggal menjadi dua tabel ('employees' dan 'departments_info') untuk mempraktekkan relasi antar *database*. 
2. **SQL Querying:** menjalankan 3 *query* utama untuk hitung *attrition rate*, rata-rata gaji per divisi dan per *role* serta identifikasi *flight risk*. 
3. **Visualisasi:** mengekspor hasil *query* ke Microsoft Excel, membuat garis *benchmark* rata-rata perusahaan dan membuat *dashboard* interaktif.

## Contoh Query SQL (Average Salary by Department and Job Role)
```
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
```


## Key Insights & Rekomendasi
1. **Sales Department (20.63% attrition rate)**
- Memiliki tingkat resignasi tertinggi, **4.5% di atas rata-rata perusahaan (16.12%)**
- Rekomendasi: perlu lakukan survei kepuasan internal, evaluasi beban kerja dan tinjau ulang jenjang karir dan gaji untuk Sales Department.

2. **Human Resources Department (19.05% attrition rate)**
- Memiliki tingkat resignasi tertinggi kedua setelah Sales Department, **2.9% di atas rata-rata perusahaan (16.12%)**
- Rekomendasi: perlu lakukan survey kepuasan internal dan evaluasi beban kerja untuk Human Resources Department. 

3. **Research & Development (67% of *flight risk*)**
- Meskipun memiliki tingkat resignasi terendah (13.84%), department ini memiliki **67% (304 karyawan)** dari total karyawan yang beresiko tinggi untuk *resign* (performa tinggi, kepuasan kerja rendah). 
- Rekomendasi: lakukan *stay interview* dan tinjau ulang program apresiasi untuk top performer di Research & Development Department.

## Tantangan dan Pembelajaran
- **Case Sensitivity di PostgreSQL:** Saat membuat tabel 'departments_info', awalnya saya menulis "human resources" (huruf kecil). Namun, karena PostgreSQL bersifat *case-sensitive*, proses 'JOIN' dengan tabel 'employees' (yang menggunakan "Human Resources") gagal menampilkan data. Saya kemudian memperbaikinya dengan standarisasi format data. Hal tersebut mengajarkan saya pentingnya **validasi data** sebelum proses JOIN. 

- **Istilah hirarki/struktur:** pada *query* awal, istilah "manajer_departemen" bisa membingungkan ketika berhadapan dengan jabatan fungsional seperti "Research Director". Saya kemudian memperbaikinya dengan mengganti nama kolom menjadi "dept_head" sebagai istilah netral untuk menghindari salah pemahaman. 

## Tampilan Dashboard
<img width="1131" height="677" alt="dashboard_preview" src="https://github.com/user-attachments/assets/bf3b16fb-ba4c-4a29-866a-85d3e6e1f138" />

## Struktur File Repository
- 'README.md': Dokumentasi lengkap *project* ini. 
- 'dashboard_preview.png': *Screenshot* tampilan *dashboard* Excel.
- 'HR_Analytics_Dashboard.xlsx': File Excel yang berisi data hasil olahan, Pivot Table dan *dashboard*. 
- 'sql_queries_analysis.sql': Script SQL lengkap (PostgreSQL) yang digunakan untuk pengolahan data di DBeaver. 


--------
Dibuat oleh saya, **Alfonsus Ganendra W. G. K.** sebagai bagian dari portfolio untuk *role* People Analyst. 

[LinkedIn: https://linkedin.com/in/alfonsusganendra/]


