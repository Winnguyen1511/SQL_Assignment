USE Assignment2_Database
GO 

-- 1) Xóa những đơn vị ủng hộ có tài khoản ngân hàng được mở ở ngân hàng "DongA"
DECLARE @BankName NVARCHAR(30) = 'DongA'

BEGIN TRANSACTION

DELETE FROM dbo.CHI_TIET_UNG_HO
FROM dbo.CHI_TIET_UNG_HO
INNER JOIN dbo.DOT_UNG_HO ON DOT_UNG_HO.MaDotUngHo = CHI_TIET_UNG_HO.MaDotUngHo
INNER JOIN dbo.DON_VI_UNG_HO ON DON_VI_UNG_HO.MaDVUH = DOT_UNG_HO.MaDVUH
WHERE TenNganHang = @BankName

DELETE FROM dbo.DOT_UNG_HO
FROM dbo.DOT_UNG_HO
INNER JOIN dbo.DON_VI_UNG_HO
ON DON_VI_UNG_HO.MaDVUH = DOT_UNG_HO.MaDVUH
WHERE TenNganHang = @BankName

DELETE FROM dbo.DON_VI_UNG_HO
WHERE TenNganHang = @BankName

ROLLBACK

-- check the result: should not has DongA
-- SELECT * FROM dbo.DON_VI_UNG_HO

-- 2) Cập nhật hình thức ủng hộ có tên là "Mi tom" thành "Mi an lien"
BEGIN TRANSACTION
UPDATE dbo.HINH_THUC_UH
SET TenHinhThucUngHo = N'Mi an lien'
WHERE TenHinhThucUngHo = N'Mi tom'
ROLLBACK
-- check the result:
-- SELECT * FROM dbo.HINH_THUC_UH

-- 3)  Liệt kê những chủ hộ có họ tên bắt đầu là ký tự 'Ph' và có độ dài nhiều nhất là 30
-- ký tự (kể cả ký tự trắng)

SELECT HoTenChuHo FROM dbo.HO_DAN
WHERE HoTenChuHo LIKE N'Ph%'
AND len(HoTenChuHo) <= 30

-- 4) Liệt kê những đợt nhận ủng hộ có NgayNhanUngHo nằm trong năm 2015 và có
-- MaHoDan kết thúc bằng ký tự '1' (ký tự số 1)
SELECT * FROM dbo.DOT_NHAN_UNG_HO
WHERE YEAR(NgayNhanUngHo) = 2015
AND MaHoDan LIKE '%1'

-- 5)  Liệt kê MaDVUH, HoTenNguoiDaiDien, MaDotUngHo, NgayUngHo của những
-- đợt ủng hộ diễn ra trước ngày 30/04/2016. Kết quả hiển thị cần được sắp xếp giảm dần
-- theo NgayUngHo và tăng dần theo HoTenNguoiDaiDien

SELECT DUH.MaDVUH, DVUH.HoTenNguoiDaiDien, DUH.MaDotUngHo, DUH.NgayUngHo 
FROM dbo.DOT_UNG_HO AS DUH, dbo.DON_VI_UNG_HO AS DVUH
WHERE DUH.MaDVUH = DVUH.MaDVUH
AND DUH.NgayUngHo < '20160430'
ORDER BY DUH.NgayUngHo DESC


SELECT DUH.MaDVUH, DVUH.HoTenNguoiDaiDien, DUH.MaDotUngHo, DUH.NgayUngHo 
FROM dbo.DOT_UNG_HO AS DUH, dbo.DON_VI_UNG_HO AS DVUH
WHERE DUH.MaDVUH = DVUH.MaDVUH
AND DUH.NgayUngHo < '20160430'
ORDER BY DVUH.HoTenNguoiDaiDien

-- 6) Liệt kê những hộ dân là hộ nghèo và chưa từng được nhận ủng hộ lần nào

SELECT * FROM dbo.HO_DAN
WHERE LaHoNgheo = 'Dung'
EXCEPT
SELECT dbo.HO_DAN.* FROM dbo.HO_DAN
INNER JOIN dbo.DOT_NHAN_UNG_HO
ON DOT_NHAN_UNG_HO.MaHoDan = HO_DAN.MaHoDan

-- 7) Liệt kê họ tên của những chủ hộ đang có trong hệ thống. Nếu họ tên trùng nhau
-- thì chỉ hiển thị 1 lần. Học viên cần thực hiện yêu cầu này bằng 2 cách khác nhau (mỗi
-- cách được tính 0.5 điểm)

SELECT DISTINCT * FROM dbo.HO_DAN

-- 8) Liệt kê MaHoDan, HoTenChuHo, ToDanPho, KhoiHoacThon,
-- MaDotNhanUngHo, NgayNhanUngHo, MaHinhThucUH, SoLuongNhanUngHo,
-- DonViTinh của tất cả hộ dân đang có trong hệ thống

SELECT HD.MaHoDan, Hd.HoTenChuHo, HD.ToDanPho, HD.KhoiHoacThon,
		DNUH.MaDotNhanUngHo, DNUH.NgayNhanUngHo, HTUH.MaHinhThucUH, CTNUH.SoLuongNhanUngHo, CTNUH.DonViTinh 
FROM dbo.HO_DAN AS HD, dbo.DOT_NHAN_UNG_HO AS DNUH, dbo.HINH_THUC_UH AS HTUH, dbo.CHI_TIET_NHAN_UNG_HO AS CTNUH
WHERE DNUH.MaHoDan = HD.MaHoDan
AND CTNUH.MaHinhThucUH = HTUH.MaHinhThucUH
AND DNUH.MaDotNhanUngHo = CTNUH.MaDotNhanUngHo

-- 9)  Liệt kê những đơn vị ủng hộ có tài khoản ngân hàng ở ngân hàng "DongA", từng
-- ít nhất 5 lần hỗ trợ cho người dân với TenHinhThucUngHo là "Mi an lien" trong năm
-- 2016

SELECT TenHinhThucUngHo FROM dbo.DON_VI_UNG_HO
INNER JOIN dbo.DOT_UNG_HO ON DOT_UNG_HO.MaDVUH = DON_VI_UNG_HO.MaDVUH
INNER JOIN dbo.CHI_TIET_UNG_HO ON CHI_TIET_UNG_HO.MaDotUngHo = DOT_UNG_HO.MaDotUngHo
INNER JOIN dbo.HINH_THUC_UH ON HINH_THUC_UH.MaHinhThucUH = CHI_TIET_UNG_HO.MaHinhThucUH
WHERE TenNganHang = N'DongA' AND TenHinhThucUngHo = N'Mi tom'
AND YEAR(NgayUngHo) = 2016
GROUP BY TenHinhThucUngHo
HAVING COUNT(SoCMNDNguoiDaiDien) >= 5

-- 10)  Liệt kê những hộ dân đã từng được nhận ủng hộ với TenHinhThucUngHo là
-- "Mi an lien" và chưa từng được nhận ủng hộ với TenHinhThucUngHo là "Gao

SELECT * FROM dbo.HO_DAN 
INNER JOIN dbo.DOT_NHAN_UNG_HO ON DOT_NHAN_UNG_HO.MaHoDan = HO_DAN.MaHoDan
INNER JOIN dbo.CHI_TIET_NHAN_UNG_HO ON CHI_TIET_NHAN_UNG_HO.MaDotNhanUngHo = DOT_NHAN_UNG_HO.MaDotNhanUngHo
INNER JOIN dbo.HINH_THUC_UH ON HINH_THUC_UH.MaHinhThucUH = CHI_TIET_NHAN_UNG_HO.MaHinhThucUH
WHERE TenHinhThucUngHo = N'Mi tom' AND NOT TenHinhThucUngHo = N'Gao'
