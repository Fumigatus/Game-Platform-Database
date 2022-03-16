use Steam
--Telefon numarasi 512 ile baþlayan kullanici bilgilerini sildik
DELETE FROM Kullanici
	   WHERE telNo LIKE '111%'
	   
GO
--'J-RPG' türünü sildik
DELETE FROM Tur
	   WHERE turIsmi = 'J-RPG'
GO
--yas sýnýrý 3 ten kücük eþit ve ücretsiz olan oyunlarý sildik
DELETE FROM Oyun
	   WHERE yasSiniri <= 3 AND fiyat = 0
GO
--'Teneke' metni içeren geliþtiricileri sildik
DELETE FROM Gelistirici
       WHERE isim IN ('Teneke Kafalar Studios')
GO

--2000 ile 2019 arasýnda gerçekleþtirilen sepete ekleme iþlemlerini sildik
DELETE FROM SepeteEkle
	   WHERE tarih BETWEEN '2000-01-01' AND '2019-01-01'
GO
