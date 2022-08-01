--Mikro V16'da Çalýþmaktadýr.

Select 
dbo.fn_StokHarEvrTip(sth_evraktip) AS EvrakTip,
sth_evrakno_seri AS EvrakSeri,
sth_evrakno_sira  AS EvrakSira,
ChHar_SeriNo AS SeriNo
From STOK_HAREKETLERI WITH (NOLOCK)
Join CIHAZ_HAREKETLERI on sth_Guid=ChHar_master_uid
JOIN STOKLAR on sto_kod= sth_stok_kod

