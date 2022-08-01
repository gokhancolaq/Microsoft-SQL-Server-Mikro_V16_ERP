SELECT w.sth_stok_kod AS StokKod,w.depo AS Depo,SUM(w.sth_miktar) AS Miktar FROM (
SELECT
	sth_stok_kod
	   ,sth_giris_depo_no depo
   ,sth_miktar
 FROM STOK_HAREKETLERI
WHERE sth_tip IN (0, 2)
AND sth_cins NOT IN (9)
UNION ALL
SELECT
	sth_stok_kod
	   ,sth_cikis_depo_no depo
   ,-1 * sth_miktar
 FROM STOK_HAREKETLERI
WHERE sth_tip IN (1, 2)
AND sth_cins NOT IN (9)
) AS w
GROUP BY w.sth_stok_kod,w.depo
ORDER BY 1
