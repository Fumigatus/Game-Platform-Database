use Steam
--OyunID si 14 olan yorumları inaktif hale getirip aciklamasını değiştirdik
UPDATE Yorum
	   SET durum = 0,aciklama = 'Yorum silindi'
	   FROM Yorum
	   WHERE oyunID = 14

GO

--kayıt tarihi 2000 ile 2010 arasında olan kullaniciların cuzdanına 5 dolar ekledik
UPDATE Kullanici
	   SET Cuzdan+=5
	   FROM Kullanici
	   WHERE kayitTarihi BETWEEN '2000-01-01' AND '2010-01-01' 

GO

--09 ile başlayıp 80 ile biten serial numarasını değiştirdik
UPDATE SatinAlma
	   SET serialKey = '1111-1111-1111-1111'
	   FROM SatinAlma
	   WHERE serialKey LIKE '09%80'
GO

--telefon numarası null olan kullanıcının numarasını güncelledik
UPDATE Kullanici
	   SET telNo = '5123627208'
	   FROM Kullanici
	   WHERE telNo IS NULL
GO

--Enderliği 4 olanların enderliğini 1 düşürdük
UPDATE Esya
	   SET enderlik-=1
	   FROM Esya
	   WHERE enderlik IN (4)
GO
