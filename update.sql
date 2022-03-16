use Steam
--OyunID si 14 olan yorumlar� inaktif hale getirip aciklamas�n� de�i�tirdik
UPDATE Yorum
	   SET durum = 0,aciklama = 'Yorum silindi'
	   FROM Yorum
	   WHERE oyunID = 14

GO

--kay�t tarihi 2000 ile 2010 aras�nda olan kullanicilar�n cuzdan�na 5 dolar ekledik
UPDATE Kullanici
	   SET Cuzdan+=5
	   FROM Kullanici
	   WHERE kayitTarihi BETWEEN '2000-01-01' AND '2010-01-01' 

GO

--09 ile ba�lay�p 80 ile biten serial numaras�n� de�i�tirdik
UPDATE SatinAlma
	   SET serialKey = '1111-1111-1111-1111'
	   FROM SatinAlma
	   WHERE serialKey LIKE '09%80'
GO

--telefon numaras� null olan kullan�c�n�n numaras�n� g�ncelledik
UPDATE Kullanici
	   SET telNo = '5123627208'
	   FROM Kullanici
	   WHERE telNo IS NULL
GO

--Enderli�i 4 olanlar�n enderli�ini 1 d���rd�k
UPDATE Esya
	   SET enderlik-=1
	   FROM Esya
	   WHERE enderlik IN (4)
GO
