if OBJECT_ID('dbo.vAlp') is not null
	begin 
		drop view dbo.vAlp
	end
go

--Kullanýcýnýn hesabýyla ilgili temel verileri (id'si, adý, cüzdan bakiyesinin büyüklüðü, sattýðý en karlý eþyanýn ismi,
--eþyayý aldýðý tarih, eþyayý sattýðý tarih, eþyanýn satýþýndan elde ettiði kar) getiren view
create view vAlp
as
	select	k.ID, k.kullaniciAdi as [Kullanýcý Adý],
		case when k.Cuzdan>=1990 then 'Ortalama üstü bakiye'
			 when k.Cuzdan between 1500 and 1990 then 'Ortalama bakiye'
			 else 'Ortalama altý bakiye'
		end as [Bakiye Miktarý], e.isim as [Eþya Ýsmi], 
		convert(varchar,ek.alisTarihi,5) as [Alýþ Tarihi], 
		convert(varchar,ek.satisTarihi,5) as [Satýþ Tarihi], 
		round(max(satisFiyati-alisFiyati),2) as [Max Kar]
	from Kullanici k 
		inner join EnvanterKaydi ek on ek.kullaniciID=k.ID 
		inner join Esya e on e.ID=ek.esyaID
		where ek.ID=dbo.maxKar(k.ID)
		group by k.ID, k.kullaniciAdi,k.Cuzdan,e.isim,ek.alisTarihi,ek.satisTarihi
go

--View'e ek olarak sepetindeki oyunlarýn sayýsý, sepetteki oyunlarýn toplam fiyatý
select valp.ID,[Kullanýcý Adý], [Bakiye Miktarý], vAlp.[Eþya Ýsmi], [Alýþ Tarihi], [Satýþ Tarihi],[Max Kar], 
	count(se.kullaniciID) as [Sepetteki Ürün Sayýsý], round(sum(o.fiyat),2) as [Sepet Tutarý]
	from vAlp 
	inner join SepeteEkle se on se.kullaniciID=vAlp.ID
	inner join Oyun o on se.oyunID=o.ID
	group by vAlp.ID,[Bakiye Miktarý],vAlp.[Eþya Ýsmi],[Alýþ Tarihi],[Satýþ Tarihi],[Kullanýcý Adý],[Max Kar]
	order by vAlp.ID
	