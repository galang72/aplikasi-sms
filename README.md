# Aplikasi Student Management System

## Latar Belakang

Dalam dunia pendidikan modern, pengelolaan data mahasiswa secara efisien dan terorganisir menjadi sangat penting. Banyak institusi pendidikan masih menggunakan metode manual atau sistem yang tidak terintegrasi, yang menyebabkan pengolahan data menjadi lambat dan rentan terhadap kesalahan.

Untuk itu, dikembangkanlah *Student Management System* – sebuah aplikasi berbasis desktop yang ditujukan untuk mempermudah manajemen data mahasiswa, dosen, dan staf akademik. Aplikasi ini memungkinkan setiap pengguna sesuai perannya (superadmin, admin, dosen, mahasiswa) untuk berinteraksi dengan data secara aman dan efisien, dilengkapi fitur login, pengelolaan data pengguna, serta sistem pemulihan akun yang terintegrasi.

## Fitur Aplikasi

- *Login Aman* dengan enkripsi password menggunakan SHA
- *Manajemen Role*:
  - *Superadmin*: Akses penuh terhadap seluruh sistem
  - *Admin*: Mengelola data pengguna dan mahasiswa
  - *Dosen*: Melihat dan mencatat data akademik mahasiswa
  - *Mahasiswa*: Mengakses data pribadi dan akademik
- *Fitur Lupa Password/Username* dengan verifikasi ID dan tanggal lahir
- *Tampilan GUI Interaktif* menggunakan Tkinter
- *Pemilihan Tanggal* yang praktis menggunakan tkcalendar.DateEntry
- Struktur kode modular per peran pengguna

## Teknologi yang Digunakan

- *Python 3*
- *MySQL* (sebagai basis data)
- *Tkinter* (untuk GUI)
- *tkcalendar* (untuk input tanggal)
- *mysql-connector-python* (untuk koneksi ke database)

## Cara Instalasi dan Menjalankan Aplikasi

### 1. Clone repositori ini

```bash
git clone https://https://github.com/galang72/aplikasi-sms.git
cd aplikasi-sms
```

2. Install library Python yang dibutuhkan
```bash
pip install mysql-connector-python tkcalendar
```
3. Setup database MySQL


Masuk ke terminal/command prompt dan login ke MySQL:


mysql -u root -p

Buat database dan tabel awal:


CREATE DATABASE student_ms;
USE student_ms;

CREATE TABLE login_details (
  id VARCHAR(10) PRIMARY KEY,
  uname VARCHAR(50) NOT NULL,
  password VARCHAR(100) NOT NULL,
  typeofuser VARCHAR(20) NOT NULL
);

Tambahkan akun superadmin awal:


INSERT INTO login_details (id, uname, password, typeofuser)
VALUES ('SA001', 'superadmin', SHA('admin123'), 'superadmin');

> 💡 Anda dapat menyesuaikan data awal sesuai kebutuhan proyek.



4. Jalankan aplikasi

python main.py

Struktur Folder

student-ms/
├── backend.py
├── login.py
├── main.py
├── windows/
│   ├── admin.py
│   ├── faculty.py
│   ├── student.py
│   ├── superadmin.py
├── assets/
│   └── (gambar/ikon yang digunakan)
└── README.md

Username & Password Default

Username: superadmin

Password: admin123


Pengembang

Proyek ini dibuat oleh: 
[Galang lian kagura] – 2025
Sebagai bagian dari pembelajaran/pengembangan aplikasi berbasis GUI dengan Python dan integrasi database MySQL.


---

Lisensi: Bebas digunakan untuk tujuan pendidikan.


