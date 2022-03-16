use Steam
--Telefon numarasi 512 ile ba�layan kullanici bilgilerini sildik
DELETE FROM Kullanici
	   WHERE telNo LIKE '111%'
	   
GO
--'J-RPG' t�r�n� sildik
DELETE FROM Tur
	   WHERE turIsmi = 'J-RPG'
GO
--yas s�n�r� 3 ten k�c�k e�it ve �cretsiz olan oyunlar� sildik
DELETE FROM Oyun
	   WHERE yasSiniri <= 3 AND fiyat = 0
GO
--'Teneke' metni i�eren geli�tiricileri sildik
DELETE FROM Gelistirici
       WHERE isim IN ('Teneke Kafalar Studios')
GO

--2000 ile 2019 aras�nda ger�ekle�tirilen sepete ekleme i�lemlerini sildik
DELETE FROM SepeteEkle
	   WHERE tarih BETWEEN '2000-01-01' AND '2019-01-01'
GO
