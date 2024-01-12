/*
=========================================================
Graded Challenge 2

Nama : Jeni Kasturi
Batch : BSD-002

Program ini dibuat untuk menambah barang, menghapus barang, 
menampilkan barang di keranjang, serta menjumlahkan seluruh harga barang belanjaan 
yang terdapat pada keranjang belanja
========================================================
*/

--CREATE DATABASE GC2

BEGIN;
-- bikin Table Product
CREATE TABLE Product(
	Product_id int PRIMARY KEY,
	Product varchar(50),
	"Manufacturing Price" float);


-- bikin Table Country 
CREATE TABLE Country(
	Country_id int PRIMARY KEY,
	Country VARCHAR(50));

-- bikin table Segment 
CREATE TABLE Segment(
	Segment_id int PRIMARY KEY,
	Segment VARCHAR(50));

-- bikin table discount_band 
CREATE TABLE Discount_Band(
	Discount_Band_id int PRIMARY KEY,
	Discount_Band VARCHAR(50));

-- bikin table Main(sesuaikan typedatanya) 
CREATE TABLE main(
	id SERIAL PRIMARY KEY,
	Segment_id int,
	Country_id int,
	Product_id int,
	Discount_Band_id int,
	Units_Sold FLOAT,
	Sale_Price FLOAT,
	Gross_Sales FLOAT,
	Discounts FLOAT,
	Sales FLOAT,
	COGS FLOAT,
	Profit FLOAT,
	Date DATE);

-- bikin savepoint1(untuk menyimpan value/isi dari tabel diatas)
SAVEPOINT table_savepoint1;

-----------------------------------------------------------------------

-- masukan nilai ke tabel product(sesuai ketentuan soal)
COPY Product(Product_id, Product, "Manufacturing Price")
FROM 'C:\tmp\Product.csv'
DELIMITER ','
CSV HEADER;

-- masukan nilai ke tabel country
COPY Country(Country_id, Country)
FROM 'C:\tmp\Country.csv'
DELIMITER ','
CSV HEADER;

-- masukan nilai ke tabel segment
COPY Segment(Segment_id, Segment)
FROM 'C:\tmp\Segment.csv'
DELIMITER ','
CSV HEADER;

-- masukan nilai ke tabel discount_band 
COPY Discount_Band(Discount_Band_id, Discount_Band)
FROM 'C:\tmp\Discount_Band.csv'
DELIMITER ','
CSV HEADER;

-- masukan nilai ke tabel main 
COPY main(Segment_id, Country_id, 
		  Product_id, Discount_Band_id, Units_Sold,
		  Sale_Price, Gross_Sales, Discounts, 
		  Sales, COGS, Profit, Date)
FROM 'C:\tmp\main.csv'
DELIMITER ','
CSV HEADER;

-----------------------------------------------------------------------------------------------------

-- bikin savepoint2
SAVEPOINT table_savepoint2;

-- hapus/hilangkan savepoint1
RELEASE SAVEPOINT table_savepoint1;

-- bikin user menggunakan create
CREATE USER asep WITH PASSWORD '1234';
CREATE USER dadang WITH PASSWORD '1234';

-- Berikan hak istimewa SELECT ke user1 pada skema publik
GRANT SELECT ON ALL TABLES IN SCHEMA public TO asep;

-- Berikan hak istimewa SELECT ke user2 pada skema publik
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA PUBLIC TO dadang;

-- Cabut hak istimewa tertentu dari user1 pada skema publik
REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA public FROM asep;

-- Finish TCL
COMMIT;	

--ROLLBACK;