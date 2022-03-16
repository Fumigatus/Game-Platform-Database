use Steam

if OBJECT_ID('dbo.spYorumTarihiVeAktifligi') is not null
	begin 
		drop procedure dbo.spYorumTarihiVeAktifligi
	end
go

--Sorgu 1: Pasif yorumlarý siler.
--Sorgu 2: Belirtilen tarihten önceki yorumlarýn durumunu pasif yapar.
create procedure spYorumTarihiVeAktifligi
(@sorguTuru int,@yorumAktifligi int = null,@minTarih date = NULL)
as
declare @hata int
if(@sorguTuru = 1)
    begin
        select Kullanici.kullaniciAdi,Yorum.aciklama
        from Yorum
        inner join Oyun On Yorum.oyunID = Oyun.ID
        inner join Kullanici On Yorum.kullaniciID = Kullanici.ID

        Where
        Yorum.durum = @yorumAktifligi
        if(@yorumAktifligi = 0)
        begin
        begin try
        delete Begenme from Yorum where Begenme.yorumID = Yorum.ID and Yorum.durum = @yorumAktifligi
        delete from Yorum where Yorum.durum = @yorumAktifligi
        end try
        begin catch
        select ERROR_NUMBER()  as errNumber,
               ERROR_LINE() as errLine,
               ERROR_MESSAGE() as errMsg
        end catch
        end

    end
else if(@sorguTuru = 2)
    begin
        select Kullanici.kullaniciAdi,Yorum.aciklama
        from Yorum
        inner join Oyun On Yorum.oyunID = Oyun.ID
        inner join Kullanici On Yorum.kullaniciID = Kullanici.ID
        Where
        datediff(day,Yorum.tarih,@minTarih) > 0
        begin transaction
        Update Yorum set durum = 0 where Yorum.tarih < @minTarih
        set @hata = @@ERROR
        if(@hata != 0) begin rollback transaction end
        else if(@hata = 0) begin commit transaction end

    end
go
