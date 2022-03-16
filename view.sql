if OBJECT_ID('dbo.vAlp') is not null
	begin 
		drop view dbo.vAlp
	end
go

--Kullan�c�n�n hesab�yla ilgili temel verileri (id'si, ad�, c�zdan bakiyesinin b�y�kl���, satt��� en karl� e�yan�n ismi,
--e�yay� ald��� tarih, e�yay� satt��� tarih, e�yan�n sat���ndan elde etti�i kar) getiren view
create view vAlp
as
	select	k.ID, k.kullaniciAdi as [Kullan�c� Ad�],
		case when k.Cuzdan>=1990 then 'Ortalama �st� bakiye'
			 when k.Cuzdan between 1500 and 1990 then 'Ortalama bakiye'
			 else 'Ortalama alt� bakiye'
		end as [Bakiye Miktar�], e.isim as [E�ya �smi], 
		convert(varchar,ek.alisTarihi,5) as [Al�� Tarihi], 
		convert(varchar,ek.satisTarihi,5) as [Sat�� Tarihi], 
		round(max(satisFiyati-alisFiyati),2) as [Max Kar]
	from Kullanici k 
		inner join EnvanterKaydi ek on ek.kullaniciID=k.ID 
		inner join Esya e on e.ID=ek.esyaID
		where ek.ID=dbo.maxKar(k.ID)
		group by k.ID, k.kullaniciAdi,k.Cuzdan,e.isim,ek.alisTarihi,ek.satisTarihi
go

--View'e ek olarak sepetindeki oyunlar�n say�s�, sepetteki oyunlar�n toplam fiyat�
select valp.ID,[Kullan�c� Ad�], [Bakiye Miktar�], vAlp.[E�ya �smi], [Al�� Tarihi], [Sat�� Tarihi],[Max Kar], 
	count(se.kullaniciID) as [Sepetteki �r�n Say�s�], round(sum(o.fiyat),2) as [Sepet Tutar�]
	from vAlp 
	inner join SepeteEkle se on se.kullaniciID=vAlp.ID
	inner join Oyun o on se.oyunID=o.ID
	group by vAlp.ID,[Bakiye Miktar�],vAlp.[E�ya �smi],[Al�� Tarihi],[Sat�� Tarihi],[Kullan�c� Ad�],[Max Kar]
	order by vAlp.ID
	