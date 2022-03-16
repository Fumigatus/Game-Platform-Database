use Steam
--OyunID si 14 olan yorumlarý inaktif hale getirip aciklamasýný deðiþtirdik
UPDATE Yorum
	   SET durum = 0,aciklama = 'Yorum silindi'
	   FROM Yorum
	   WHERE oyunID = 14

GO

--kayýt tarihi 2000 ile 2010 arasýnda olan kullanicilarýn cuzdanýna 5 dolar ekledik
UPDATE Kullanici
	   SET Cuzdan+=5
	   FROM Kullanici
	   WHERE kayitTarihi BETWEEN '2000-01-01' AND '2010-01-01' 

GO

--09 ile baþlayýp 80 ile biten serial numarasýný deðiþtirdik
UPDATE SatinAlma
	   SET serialKey = '1111-1111-1111-1111'
	   FROM SatinAlma
	   WHERE serialKey LIKE '09%80'
GO

--telefon numarasý null olan kullanýcýnýn numarasýný güncelledik
UPDATE Kullanici
	   SET telNo = '5123627208'
	   FROM Kullanici
	   WHERE telNo IS NULL
GO

--Enderliði 4 olanlarýn enderliðini 1 düþürdük
UPDATE Esya
	   SET enderlik-=1
	   FROM Esya
	   WHERE enderlik IN (4)
GO
