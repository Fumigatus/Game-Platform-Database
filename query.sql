USE Steam
--Kullanicilar�n c�zdan�ndaki miktar�n uygunlu�u, yas s�n�r�na uymalar� ve �yeliklerin, oyunlar�n aktif olmas� ko�ullar�yla alabilecekleri oyunlari listeledik(sadece 1 adet)
SELECT Kullanici.kullaniciAdi,Oyun.isim
FROM Kullanici
INNER JOIN Oyun ON Kullanici.Cuzdan >= Oyun.fiyat AND Kullanici.Durum = 1 AND Oyun.durum = 1 AND Kullanici.Yas >= Oyun.yasSiniri
GO
--Seri olan oyunlar� isimlerine g�re s�ralad�k
SELECT Gelistirici.isim AS GelistiriciIsmi,Oyun.isim AS OyunIsmi
From Gelistirici
INNER JOIN Oyun ON Gelistirici.ID = Oyun.gelistiriciID AND (Oyun.isim LIKE('%[0-9]') OR Oyun.isim LIKE('%XV'))
ORDER BY OyunIsmi
GO
--�ye olunan gruplar� s�ralad�k(kurucular da �ye olarak say�ld� ve inaktif gruplar liste d��� edildi)
SELECT Kullanici.kullaniciAdi,Grup.isim
FROM Kullanici
INNER JOIN (SELECT UyeOlma.kullaniciID AS KID , UyeOlma.grupID AS GID FROM UyeOlma UNION ALL SELECT Grup.kullaniciID AS KID ,Grup.ID AS GID FROM Grup WHERE Grup.durum = 1) AS GRUPLAR
ON GRUPLAR.KID = Kullanici.ID
INNER JOIN Grup ON Grup.ID = GRUPLAR.GID 
ORDER BY Kullanici.kullaniciAdi 
GO		   

		 