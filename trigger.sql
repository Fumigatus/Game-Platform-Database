if object_id('trgYorumSil') is not null
	begin
	drop trigger dbo.trgYorumSil
	end
go

create trigger trgYorumSil on yorum after delete as
insert into silinenYorum select * , GETDATE() from deleted
go

exec dbo.spYorumTarihiVeAktifligi 1,0
--select * from Yorum
select * from silinenYorum