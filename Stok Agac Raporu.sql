Select 
sto_kod as [Stok Kodu],
MikroDB_V16_SES2020.dbo.fn_StokIsmi(sto_kod) as [Stok Adý],
sto_anagrup_kod AS [ANA GRUP],
sto_altgrup_kod AS [ALT GRUP],
sto_reyon_kodu as [Stok Kategori],
sto_model_kodu AS [MARKA ID],
MikroDB_V16_SES2020.dbo.fn_KategoriIsmi(sto_kategori_kodu) as [KATEGORÝ],
ssfl.sfiyat_fiyati AS Fiyat
From STOKLAR
LEFT OUTER JOIN STOK_SATIS_FIYAT_LISTELERI ssfl ON sto_kod=ssfl.sfiyat_stokkod AND ssfl.sfiyat_listesirano=1



