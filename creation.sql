CREATE DATABASE Steam
	ON PRIMARY (
				NAME = 'Steam',
				FILENAME = 'D:\veritabaný\steam.mdf',--d:\ de veritabaný adýnda bir klasor olmasý lazým yoksa hata alýrsýn o dosyanýn içine steam.mdf oluþturur
				SIZE = 5MB,
				MAXSIZE = 200MB,
				FILEGROWTH = 5MB
				)
GO

USE Steam

CREATE TABLE Kullanici
(

SonGiris DATE NOT NULL,

Email VARCHAR(50)
	  CONSTRAINT notnullblUyeMail NOT NULL
	  CONSTRAINT unqKullaniciMail UNIQUE
	  CONSTRAINT chckKullaniciMail CHECK (Email LIKE '%@%.com'),--Girilecek email formatýný ==> "bir_þeyler@bir_þeyler.com" olarak belirledik

kayitTarihi DATE  DEFAULT GETDATE() NOT NULL, --Kayit tarihini varsayýlan olarak bugünün tarihi alýyoruz GETDATE() ile

kullaniciAdi VARCHAR(50) NOT NULL,

Cuzdan FLOAT DEFAULT 0 NOT NULL,

Parola VARCHAR(24) NOT NULL,

telNo char(10)
	  CONSTRAINT uniqueTelNo UNIQUE
	  CONSTRAINT chkTel CHECK(telNo LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), --telefon numarasýnýn her bir karakteri 0 ile 9 arasýnda olsun

dogumTarihi DATE NOT NULL,

Durum SMALLINT DEFAULT 1, --Uyelik kapanýrsa burasý 0 yapýlýr

ID INT IDENTITY(1,1) PRIMARY KEY,--ID degeri 1 den baþlayýp biz insert ettikce 1 er 1 er artacak(identity anlamý) ve primary key olacak

Yas AS DATEDIFF(yy,dogumTarihi,GETDATE()), --Günün tarihinden dogum tarihini cikartýp yas degiskeni olusturduk

)	  

GO

CREATE TABLE Tur
(

ID INT IDENTITY(1,1) PRIMARY KEY,

turIsmi VARCHAR(20)

)

GO

CREATE TABLE Yayinci
(

ID INT IDENTITY(1,1) PRIMARY KEY,

isim VARCHAR(30)

)

GO

CREATE TABLE Gelistirici
(

ID INT IDENTITY(1,1) PRIMARY KEY,

isim VARCHAR(30)

)

GO

CREATE TABLE Oyun
(

ID INT IDENTITY(1,1) PRIMARY KEY,

yasSiniri INT DEFAULT 0 NOT NULL,

fiyat FLOAT,

cikisTarihi DATE NOT NULL,

durum SMALLINT DEFAULT 1,

isim VARCHAR(50),

gelistiriciID INT FOREIGN KEY REFERENCES Gelistirici(ID),--Gelistirici tablosunun id primary key i burada foreign key oldu
			  
yayinciID INT FOREIGN KEY REFERENCES Yayinci(ID)

)

GO

CREATE TABLE Esya
(

ID INT IDENTITY(1,1) PRIMARY KEY,

isim VARCHAR(25) UNIQUE,

enderlik CHAR(1)
		 CONSTRAINT enderlikChck CHECK (enderlik LIKE ('[0-5]')),--1'den 5'e kadar enderlik numarasý tutuyor
		
oyunID INT FOREIGN KEY REFERENCES Oyun(ID)

)

GO

CREATE TABLE EnvanterKaydi
(

alisFiyati FLOAT NOT NULL,

satisFiyati FLOAT,

satisTarihi DATE,

alisTarihi DATE NOT NULL,

satistaMi SMALLINT DEFAULT 0,

ID INT IDENTITY(1,1) PRIMARY KEY,

kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID),

esyaID INT FOREIGN KEY REFERENCES Esya(ID)

)

GO

CREATE TABLE TeklifVerme
(

durum SMALLINT DEFAULT 0,--Teklif durumu ?

tarih DATE,

tutar float,--Teklif verilmediði zaman tutar da olmaz o yüzden not null yok ? maybe

teklifID INT IDENTITY(1,1) PRIMARY KEY,

envanterID INT FOREIGN KEY REFERENCES EnvanterKaydi(ID),

kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID)

)

GO

CREATE TABLE ArkadasEkleme
(

tarih DATE NOT NULL,--EKlenme tarihi

durum SMALLINT DEFAULT 0,--Arkadaþlýk durumu

EkleyenID INT FOREIGN KEY REFERENCES Kullanici(ID),

EklenenID INT FOREIGN KEY REFERENCES Kullanici(ID)

)

GO

CREATE TABLE Grup
(

ID INT IDENTITY(1,1) PRIMARY KEY,

isim VARCHAR(30) NOT NULL,

olusturulmaTarihi DATE DEFAULT GETDATE() NOT NULL,

kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID),

durum SMALLINT DEFAULT 0


)

GO

CREATE TABLE UyeOlma
(


uyeOlmaTarihi DATE DEFAULT GETDATE() NOT NULL,

ayrilmaTarihi DATE DEFAULT NULL,

kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID),

grupID INT FOREIGN KEY REFERENCES Grup(ID)


)

GO

CREATE TABLE Yorum
(
ID INT IDENTITY(1,1) PRIMARY KEY,

durum SMALLINT default 1 NOT NULL,--Yorum mevcut mu(1) degil mi(0)

aciklama VARCHAR(200),

tarih DATE DEFAULT GETDATE() NOT NULL,--yorumun yapýlma tarihi

kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID),

oyunID INT FOREIGN KEY REFERENCES Oyun(ID)
)

GO

CREATE TABLE Begenme
(

yorumID INT FOREIGN KEY REFERENCES Yorum(ID),

kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID)

)

GO

CREATE TABLE TurOlur
(

oyunID INT FOREIGN KEY REFERENCES Oyun(ID),

turID INT FOREIGN KEY REFERENCES Tur(ID)

)

GO

CREATE TABLE Basarim
(

ID INT IDENTITY(1,1) PRIMARY KEY,

oyunID INT FOREIGN KEY REFERENCES Oyun(ID)

)

GO

CREATE TABLE BasarimAcilir
(

tarih DATE DEFAULT GETDATE() NOT NULL,--Basarim acildiysa bir acilma tarihine sahiptir ? acaba

kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID),

basarimID INT FOREIGN KEY REFERENCES Basarim(ID)

)

GO

CREATE TABLE SepeteEkle
(

tarih DATE DEFAULT NULL,

kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID),

oyunID INT FOREIGN KEY REFERENCES Oyun(ID)

)

GO

CREATE TABLE IstekListesineEkle
(

tarih DATE DEFAULT GETDATE(),

siraNumarasi INT NOT NULL,
			 

kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID),

oyunID INT FOREIGN KEY REFERENCES Oyun(ID)

)

GO

CREATE TABLE SatinAlma
(

tarih DATE DEFAULT NULL,


kullaniciID INT FOREIGN KEY REFERENCES Kullanici(ID),

oyunID INT FOREIGN KEY REFERENCES Oyun(ID)

)

GO
