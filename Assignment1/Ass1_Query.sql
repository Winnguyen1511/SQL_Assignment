USE Assignment1_Database
GO 

-- 1) Delete 'Le Thi A' in KHACHHANG
-- KHACHHANG TenKhachHang = 'Le Thi A'
--			 MaKhachHang = 'KH001'
-- DONHANG_GIAOHANG	MaDonHangGiaoHang DH0001, DH0002
-- CHITIET_DONHANG DH0001 2records, DH0002 2record
BEGIN TRANSACTION
SAVE TRANSACTION Tran1
DELETE FROM dbo.CHITIET_DONHANG
WHERE MaDonHangGiaoHang = 'DH0001'
GO 

DELETE FROM dbo.CHITIET_DONHANG
WHERE MaDonHangGiaoHang = 'DH0002'
GO 
SAVE TRANSACTION Tran2
DELETE FROM dbo.DONHANG_GIAOHANG
WHERE MaKhachHang = 'KH001'
GO 
SAVE TRANSACTION Tran3
DELETE FROM dbo.KHACHHANG
WHERE TenKhachHang = 'Le Thi A'
GO 

ROLLBACK TRANSACTION Tran1

-- 
DECLARE @CustomerName VARCHAR(30) = 'Le Thi A'
if object_id('tempdb..#tmpMaKhachHang', 'U') IS NOT NULL
	DROP TABLE #tmpMaKhachHang 
SELECT MaKhachHang INTO #tmpMaKhachHang FROM dbo.KHACHHANG
WHERE TenKhachHang = @CustomerName
--check the result: should be 1 record
--SELECT * FROM #tmpMaKhachHang

if object_id('tempdb..#tmpMaDonHang', 'U') IS NOT NULL
	DROP TABLE #tmpMaDonHang
SELECT DHGH.MaDonHangGiaoHang INTO #tmpMaDonHang
FROM dbo.DONHANG_GIAOHANG AS DHGH
WHERE DHGH.MaKhachHang = ANY(SELECT * FROM #tmpMaKhachHang)
-- check the result: should be 2 records
-- SELECT * FROM #tmpMaDonHang

-- Delete routine:
-- Delete from the lowest level: CHITIET_DONHANG
BEGIN TRANSACTION
DELETE FROM dbo.CHITIET_DONHANG
WHERE MaDonHangGiaoHang = ANY(SELECT * FROM #tmpMaDonHang)
-- delete from DONHANG_GIAOHANG:
DELETE FROM dbo.DONHANG_GIAOHANG
WHERE MaKhachHang = ANY(SELECT * FROM #tmpMaKhachHang)

-- delete top level: KHACHHANG:
DELETE FROM dbo.KHACHHANG
WHERE TenKhachHang = @CustomerName

-- SELECT * FROM dbo.KHACHHANG
ROLLBACK 

-- 2) Update KHACHHANG live in 'Son Tra' to 'Ngu Hanh Son'
-- Get MaKhuVuc of 'Ngu Hanh Son' and 'Son Tra'
-- Update corresponding in KHACHHANG:
BEGIN TRANSACTION
DECLARE @LocationNameFrom VARCHAR(30) = 'Son Tra'
DECLARE @LocationNameTo VARCHAR(30) = 'Ngu Hanh Son'

DECLARE @LocationIDFrom	CHAR(5)
DECLARE @LocationIDTo CHAR(5)

SELECT TOP 1 @LocationIDFrom = MaKhuVuc FROM dbo.KHUVUC
WHERE TenKhuVuc = @LocationNameFrom
SELECT TOP 1 @LocationIDTo = MaKhuVuc FROM dbo.KHUVUC
WHERE TenKhuVuc = @LocationNameTo

UPDATE dbo.KHACHHANG
SET MaKhuVuc = @LocationIDTo
WHERE MaKhuVuc = @LocationIDFrom
GO 
--SELECT * FROM dbo.KHACHHANG
ROLLBACK 

-- 3) Liệt kê shipper có tên bắt đầu bằng 'Tr' và có độ dài ít nhất là 25 kí tự
SELECT TenThanhVienGiaoHang FROM dbo.THANHVIENGIAOHANG
WHERE TenThanhVienGiaoHang LIKE 'Tr%'
AND LEN(TenThanhVienGiaoHang) >= 25

-- 4) Liệt kê đơn hàng có năm 2017 và khu vự Hải Châu.
SELECT * FROM dbo.DONHANG_GIAOHANG AS DHGH, dbo.KHUVUC AS KV
WHERE YEAR(DHGH.NgayGiaoHang) = 2017 
AND KV.TenKhuVuc = 'Hai Chau'
AND DHGH.MaKhuVucGiaoHang = KV.MaKhuVuc

-- 5) Liệt kê MaDonHangGiaoHang, MaThanhVienGiaoHang,
-- NgayGiaoHang, PhuongThucThanhToan của tất cả những đơn hàng có trạng thái là "Da giao hang". Kết
-- quả hiển thị được sắp xếp tăng dần theo NgayGiaoHang và giảm dần theo PhuongThucThanhToan.

SELECT MaDonHangGiaoHang, MaNhanVienGiaoHang, NgayGiaoHang, PhuongThucThanhToan  FROM dbo.DONHANG_GIAOHANG
WHERE TrangThaiGiaoHang = 'Da Giao Hang'
ORDER BY NgayGiaoHang
--ORDER BY PhuongThucThanhToan DESC 

-- 6) Liệt kê những thành viên có giới tính là "Nam" và chưa từng được giao hàng lần nào.

SELECT * FROM dbo.THANHVIENGIAOHANG
WHERE GioiTinh = 'Nam'
AND MaThanhVienGiaoHang NOT IN
(
	SELECT MaThanhVienGiaoHang FROM dbo.DANGKIGIAOHANG
)
GO 

-- 7) Liệt kê họ tên của những khách hàng đang có trong hệ thống. Nếu họ tên trùng nhau thì chỉ hiển
-- thị 1 lần. Học viên cần thực hiện yêu cầu này bằng 2 cách khác nhau (mỗi cách được tính 0.5 điểm)
SELECT DISTINCT TenKhachHang FROM dbo.KHACHHANG

SELECT TenKhachHang FROM dbo.KHACHHANG
GROUP BY TenKhachHang

-- 8) Liệt kê MaKhachHang, TenKhachHang, DiaChiNhanHang, MaDonHangGiaoHang,
-- PhuongThucThanhToan, TrangThaiGiaoHang của tất cả các khách hàng đang có trong hệ thống
SELECT DHGH.MaKhachHang, KH.TenKhachHang, KH.DiaChiNhanHang, DHGH.MaDonHangGiaoHang,
	DHGH.PhuongThucThanhToan, DHGH.TrangThaiGiaoHang 
FROM dbo.DONHANG_GIAOHANG AS DHGH, dbo.KHACHHANG AS KH
WHERE DHGH.MaKhachHang = KH.MaKhachHang

-- 9)  Liệt kê những thành viên giao hàng có giới tính là "Nu" và từng giao hàng cho 10 khách hàng
-- khác nhau ở khu vực giao hàng là "Hai Chau" 

SELECT MaThanhVienGiaoHang FROM dbo.THANHVIENGIAOHANG
INNER JOIN dbo.DONHANG_GIAOHANG ON DONHANG_GIAOHANG.MaNhanVienGiaoHang = THANHVIENGIAOHANG.MaThanhVienGiaoHang
INNER JOIN dbo.KHUVUC ON KHUVUC.MaKhuVuc = DONHANG_GIAOHANG.MaKhuVucGiaoHang
WHERE TenKhuVuc = 'Hai Chau' AND GioiTinh = 'Nu'
GROUP BY MaThanhVienGiaoHang
HAVING COUNT(MaKhachHang) = 10

-- 10)  Liệt kê những khách hàng đã từng yêu cầu giao hàng tại khu vực "Lien Chieu" và chưa từng
-- được một thành viên giao hàng nào có giới tính là "Nam" nhận giao hàng. 

DECLARE @LocalName VARCHAR(30) = 'Lien Chieu'
DECLARE @ShipperGender	 CHAR(3) = 'Nam'
DECLARE @DeliverStatus	VARCHAR(20) = 'Chua giao hang'
SELECT * FROM dbo.DONHANG_GIAOHANG
INNER JOIN dbo.KHUVUC ON KHUVUC.MaKhuVuc = DONHANG_GIAOHANG.MaKhuVucGiaoHang
INNER JOIN dbo.THANHVIENGIAOHANG ON THANHVIENGIAOHANG.MaThanhVienGiaoHang = DONHANG_GIAOHANG.MaNhanVienGiaoHang
WHERE TenKhuVuc = @LocalName AND GioiTinh = @ShipperGender
	AND TrangThaiGiaoHang = @DeliverStatus


  