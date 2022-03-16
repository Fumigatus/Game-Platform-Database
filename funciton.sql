use Steam

if OBJECT_ID('dbo.maxKar') is not null
	begin 
		drop function dbo.maxKar
	end
go

--verilen kullan�c� id'nin en karl� i�leminin id'sini d�nen fonksiyon
create function maxKar(@user_id int)
returns float
as 
	begin
	declare @maxKazanc float
	select @maxKazanc= max(satisFiyati-alisFiyati) from EnvanterKaydi where kullaniciID=@user_id
	declare @eid int
	select @eid = ID from EnvanterKaydi where kullaniciID=@user_id and (satisFiyati-alisFiyati)=@maxKazanc
	return @eid
	end
go

--id'si 20 olan kullan�c�n�n i�lem id'si d�nd�r�ld�
select dbo.maxKar(40) as [Max Karl� ��lemin ID'si]