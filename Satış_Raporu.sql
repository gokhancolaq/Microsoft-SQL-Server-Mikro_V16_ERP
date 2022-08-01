
SELECT
sth_Guid,
case
when dbo.fn_AyIsimBul(month(sth_tarih))='Ocak' then '01-Ocak'
when dbo.fn_AyIsimBul(month(sth_tarih))='Þubat' then '02-Þubat'
when dbo.fn_AyIsimBul(month(sth_tarih))='Mart' then '03-Mart'
when dbo.fn_AyIsimBul(month(sth_tarih))='Nisan' then '04-Nisan'
when dbo.fn_AyIsimBul(month(sth_tarih))='Mayýs' then '05-Mayýs'
when dbo.fn_AyIsimBul(month(sth_tarih))='Haziran' then '06-Haziran'
when dbo.fn_AyIsimBul(month(sth_tarih))='Temmuz' then '07-Temmuz'
when dbo.fn_AyIsimBul(month(sth_tarih))='Aðustos' then '08-Aðustos'
when dbo.fn_AyIsimBul(month(sth_tarih))='Eylül' then '09-Eylül'
when dbo.fn_AyIsimBul(month(sth_tarih))='Ekim' then '10-Ekim'
when dbo.fn_AyIsimBul(month(sth_tarih))='Kasým' then '11-Kasým'
when dbo.fn_AyIsimBul(month(sth_tarih))='Aralýk' then '12-Aralýk'
end as Ay,
CAST(dbo.fn_HaftaBul(sth_tarih) AS NVARCHAR(100)) + '.Hafta' AS [Hafta],
convert(nvarchar,sth_tarih,104) as Tarih,
sto_kod as [Stok Kodu],
dbo.fn_StokIsmi(sto_kod) as [Stok Adý],
sto_altgrup_kod AS [ALT GRUP],
sth_cari_kodu as [Cari Kod],
dbo.fn_CarininIsminiBul(0,sth_cari_kodu) AS [Cari Ad],
sth_plasiyer_kodu as [Plasiyer Kodu],
dbo.fn_CarininIsminiBul(1,sth_plasiyer_kodu) as [Plasiyer Adý],
sto_model_kodu AS [ModelID],
sto_kategori_kodu as [Kategori Kod],
dbo.fn_KategoriIsmi(sto_kategori_kodu) as [Kategori Ad],
dbo.fn_CarininIsminiBul(0,sth_cari_kodu) AS [Cari Adý],
UPPER(dbo.fn_GD_CariIl(sth_cari_kodu)) AS [Cari Ýl],


sth_miktar * 
CASE WHEN (sth_normal_iade=0 or (sth_normal_iade=1 and sth_evraktip=4)) and (STH_DEGERFARKI_MI=0) THEN 1.0
WHEN (sth_normal_iade=1) and (STH_DEGERFARKI_MI=0) THEN -1.0
ELSE 0.0 END AS [NET MIKTAR],

round(STH_BRUT_DEGER_ANA * CASE WHEN sth_normal_iade=0 THEN 1.0 ELSE -1.0 END ,0)AS [BRUT TUTAR],
round(STH_NET_DEGER_ANA * CASE WHEN (sth_normal_iade=0 or (sth_normal_iade=1 and sth_evraktip=4) ) THEN 1.0 ELSE -1.0 END,0) AS [NET TUTAR],
round(STH_TOPLAM_ISKONTO_ANA * CASE WHEN sth_normal_iade=0 THEN 1.0 ELSE -1.0 END,0) AS [ISKONTO TUTAR]

FROM dbo.STOK_HAREKETLERI_VIEW_WITH_INDEX_02 WITH (NOLOCK)
LEFT JOIN dbo.STOKLAR WITH (NOLOCK) ON sto_kod =sth_stok_kod
left JOIN dbo.CARI_HESAPLAR S WITH(NOLOCK) ON S.cari_kod=sth_cari_kodu
left JOIN dbo.CARI_HESAPLAR_USER CU WITH(NOLOCK) ON  S.cari_Guid=CU.Record_uid
LEFT JOIN STOK_HAREKETLERI_EK WITH (NOLOCK) on sth_Guid=sthek_related_uid
LEFT JOIN BAKIM_HAREKETLERI WITH (NOLOCK) on bkm_Guid=sth_bkm_uid
WHERE
(sth_cins in (0,1,9,12)) AND
sth_fat_uid<> '00000000-0000-0000-0000-000000000000' And
(((sth_tip=1 and sth_normal_iade=0) or (sth_tip=1 and sth_normal_iade=1))or
((sth_tip=0 and sth_normal_iade=1)))
AND sth_tarih>='20220101' AND sth_tarih<=GETDATE()

