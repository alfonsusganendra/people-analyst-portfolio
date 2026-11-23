# HR Analytics Dashboard: Employee Retention & Compensation 

## Latar Belakang
*Project* ini menganalisis data Human Resources untuk menjawab 4 pertanyaan bisnis, yaitu:
- Seberapa tinggi tingkat *attrition* (*resignation*) per departemen?
- Bagaimana struktur gaji per departemen dan per jabatan (*job role*)?
- Siapa saja *top performer* yang berisiko tinggi untuk *resign* (*flight risk*)?
- Rekomendasi apa yang dapat diberikan kepada tim HR (berdasarkan data)?

## Tools & Teknologi
- **SQL (PostgreSQL via DBeaver):** Untuk ekstraksi, transformasi dan agregasi data mentah (dengan menggunakan antara lain 'JOIN', 'GROUP BY', 'CASE WHEN' dan agregasi). 
- **Microsoft Excel:** Untuk pembuatan Pivot Table dan *dashboard* yang interaktif. 

## Sumber Data
*Dataset* yang digunakan adalah **IBM HR Analytics Employee Attrition & Performance** (sumber: Kaggle), berisi 1.470 karyawan.

Catatan: angka gaji/*salary* ditampilkan dalam **USD** (sesuai *dataset* asli). 

## Proses Analisis
1. **Data Preparation:** memecah *dataset* tunggal menjadi dua tabel ('employees' dan 'departments_info') untuk mempraktekkan relasi antar tabel.
Catatan: Tabel 'departments_info' adalah tabel yang dibuat untuk keperluan 'JOIN'. 
3. **SQL Querying:** menjalankan 3 *query* utama untuk menghitung *attrition rate* (per departemen), rata-rata gaji (per departemen dan per *role*) dan identifikasi *flight risk*. 
4. **Visualisasi:** mengekspor hasil *query* ke Microsoft Excel dan membangun *dashboard* interaktif dengan *slicer* per departemen.

## Definisi "*flight risk*" dalam *project* ini
Adalah karyawan yang **masih aktif** (Attrition = 'No"), namun memenuhi kriteria berikut:
- 'PerformanceRating = 4' (performa tertinggi) **dan**
- 'JobSatisfaction <= 2' (kepuasan kerja rendah).
Total: **67 karyawan** beresiko tinggi untuk *resign*. 

## Contoh Query SQL (Average Salary by Department and Job Role)
```
SELECT 
    d.department AS nama_departemen,
    d.dept_head AS kepala_departemen,
    e."JobRole" AS posisi, 
    COUNT(e."EmployeeNumber") AS jumlah_karyawan,
    ROUND(AVG(e."MonthlyIncome"), 0) AS rata_rata_gaji
FROM employees e
JOIN departments_info d ON e."Department" = d.department
GROUP BY d.department, d.dept_head, e."JobRole"
ORDER BY d.department, rata_rata_gaji desc;
```

## Key Insights & Rekomendasi
1. **Sales Department - attrition rate tertinggi (20,63%)**
- Rekomendasi: survei kepuasan internal, evaluasi beban kerja dan tinjau ulang jenjang karir dan gaji.
  
2. **Human Resources Department - attrition rate tertinggi kedua (19,05%)**
- Rekomendasi: survei kepuasan internal dan evaluasi beban kerja. 

3. **Research & Development - 73% dari *flight risk* (49 dari 67 karyawan)**
- Meskipun memiliki *attrition rate* terendah (13.84%), department ini memiliki **73% dari total karyawan yang beresiko tinggi untuk *resign*** (performa tinggi, kepuasan kerja rendah). 
- Rekomendasi: *stay interview* dan tinjau ulang program apresiasi untuk *top performer*.

4. **kaitan antara *salary* dan *attrition* di Sales Department**
- *Job Role "Sales Representative"* memiliki rata-rata gaji terendah (USD 2.626) dengan kondisi Sales Department memiliki *attrition rate* tertinggi (20,63%).
- Rekomendasi: tinjau ulang nominal *salary* untuk posisi *entry-level* di Sales Department.  
  
## Tantangan dan Pembelajaran
- **Case Sensitivity di PostgreSQL:** Saat membuat tabel 'departments_info', awalnya saya menulis "human resources" (huruf kecil). Namun, karena PostgreSQL bersifat *case-sensitive*, proses 'JOIN' dengan tabel 'employees' (yang menggunakan "Human Resources") gagal menampilkan data. Saya kemudian memperbaikinya dengan standarisasi format data. Pelajarannya: pentingnya **validasi data** sebelum proses JOIN. 

- **Istilah hirarki/struktur:** pada *query* awal, istilah "manajer_departemen" bisa membingungkan ketika berhadapan dengan jabatan fungsional seperti "Research Director". Saya kemudian memperbaikinya dengan mengganti nama kolom menjadi "dept_head" sebagai istilah netral untuk menghindari kesalahpahaman.

- **Definisi bisnis vs. hasil *query*:** Di awal, *flight risk* didefinisikan dengan 'PerformanceRating >= 3' (kurang lebih 300 karyawan, terlalu luas). Saya kemudian memperbaikinya dengan merubah definisi *flight risk* menjadi 'PerformanceRating = 4' agar fokus pada *top performer* dan sejalan dengan konteks bisnis. Pelajarannya: filter harus konsisten antara SQL yang dibuat dengan konteks bisnis.

## Tampilan Dashboard
<img width="1537" height="725" alt="dashboard_preview" src="https://github.com/user-attachments/assets/24208107-1caa-4855-bf85-551412e609f5" />


## Struktur File Repository
- 'README.md': Dokumentasi lengkap *project* ini. 
- 'dashboard_preview.png': *Screenshot* tampilan *dashboard* Excel.
- 'HR_Analytics_Dashboard.xlsx': File Excel yang berisi data hasil olahan, Pivot Table dan *dashboard*. 
- 'sql_queries_analysis.sql': Script SQL lengkap (PostgreSQL) yang digunakan untuk pengolahan data di DBeaver. 


--------
Dibuat oleh saya, **Alfonsus Ganendra W. G. K.** sebagai bagian dari portfolio untuk *role* Data Analyst dan sejenisnya.  

[LinkedIn: https://linkedin.com/in/alfonsusganendra/]


