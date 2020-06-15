-- Create database:
CREATE DATABASE Assignment1_Database_2
GO
USE Assignment1_Database_2
GO 

-- Create tables:
-- Note: + Dia chi: varchar(40)
--	     + Name: varchar(30)
--		 + Others code: char(6) or char(5)

-- 1) Loại mặt hàng:
CREATE TABLE LOAIMATHANG
(
	MaLoaiMatHang	CHAR(5),
	TenLoaiMatHang	VARCHAR(20)
	CONSTRAINT PK_LOAIMATHANG_MaLoaiMatHang
	PRIMARY KEY (MaLoaiMatHang) 
)
GO

-- 2) Khu vực:
CREATE TABLE KHUVUC
(
	MaKhuVuc	CHAR(5),
	TenKhuVuc	VARCHAR(30)
	CONSTRAINT PK_KHUVUC_MaKhuVuc
	PRIMARY KEY (MaKhuVuc)
)
GO 	

-- 3) Khoảng thời gian:
CREATE TABLE KHOANGTHOIGIAN
(
	MaKhoangThoiGianGiaoHang	CHAR(5),
	MoTa	VARCHAR(20),
	CONSTRAINT PK_KHOANGTHOIGIAN_MaKhoangThoiGianGiaoHang
	PRIMARY KEY (MaKhoangThoiGianGiaoHang)
)
GO	

-- 4) Dịch vụ:
CREATE TABLE DICHVU
(
	MaDichVu	CHAR(5),
	TenDichVu	VARCHAR(40)
	CONSTRAINT PK_DICHVU
	PRIMARY KEY (MaDichVu)
)
GO 

-- 5) Thành viên giao hàng:
CREATE TABLE THANHVIENGIAOHANG
(
	MaThanhVienGiaoHang		CHAR(6),
	TenThanhVienGiaoHang	VARCHAR(30),
	NgaySinh				DATE,
	GioiTinh				CHAR(3),
	SoDTThanhVien			VARCHAR(11),
	DiaChiThanhVien			VARCHAR(40)
	CONSTRAINT PK_THANHVIENGIAOHANG_MaThanhVienGiaoHang
	PRIMARY KEY (MaThanhVienGiaoHang)
)
GO 
-- 6) Đăng kí giao hàng:
CREATE TABLE DANGKIGIAOHANG
(
	MaThanhVienGiaoHang		CHAR(6),
	MaKhoangThoiGianDKGiaoHang	CHAR(5)
)
GO 
-- 7) Khách hàng:
CREATE TABLE KHACHHANG
(
	MaKhachHang		CHAR(5),
	MaKhuVuc		CHAR(5),
	TenKhachHang	VARCHAR(30),
	TenCuaHang		VARCHAR(20),
	SoDTKhachHang	VARCHAR(11),
	DiaChiEmail		VARCHAR(30),
	DiaChiNhanHang	VARCHAR(40)
	CONSTRAINT PK_KHACHHANG_MaKhachHang
	PRIMARY KEY (MaKhachHang)
)
GO	
-- 8) Đơn hàng- giao hàng:
CREATE TABLE DONHANG_GIAOHANG
(
	MaDonHangGiaoHang	CHAR(6),
	MaKhachHang			CHAR(5),
	MaNhanVienGiaoHang	CHAR(6),
	MaDichVu			CHAR(5),
	MaKhuVucGiaoHang	CHAR(5),
	TenNguoiNhan		VARCHAR(30),
	DiaChiGiaoHang		VARCHAR(40),
	SoDTNguoiNhan		CHAR(11),
	MaKhoangThoiGianGiaoHang	CHAR(5),
	NgayGiaoHang		DATE,
	PhuongThucThanhToan	VARCHAR(20),	
	TrangThaiPheDuyet VARCHAR(20),
	TrangThaiGiaoHang VARCHAR(20)
	CONSTRAINT PK_DONHANG_GIAOHANG_MaDonHangGiaoHang
	PRIMARY KEY (MaDonHangGiaoHang)
)
GO

-- 9) Chi tiết đơn hàng:
CREATE TABLE CHITIET_DONHANG
(
	MaDonHangGiaoHang	CHAR(6),
	TenSanPhamDuocGiao	VARCHAR(40),
	SoLuong				INT,
	TrongLuong			FLOAT,
	MaLoaiMatHang		CHAR(5),
	TienThuHo			MONEY
	CONSTRAINT PK_CHITIET_DONHANG_MaDonHangGiaoHang_TenSanPhamDuocGiao
	PRIMARY KEY (MaDonHangGiaoHang, TenSanPhamDuocGiao)
)
GO
  
-- Create foreign key:
-- 1) LOAIMATHANG:
-- 2) KHUVUC:
-- 3) KHOANGTHOIGIAN:
-- 4) DICHVU:
-- 5) THANHVIENGIAOHANG: 
-- 6) DANGKYGIAOHANG:
-- FK_DANGKYGIAOHANG_KHOANGTHOIGIAN_MaKhoangThoiGian
ALTER TABLE dbo.DANGKIGIAOHANG
ADD CONSTRAINT FK_DANGKYGIAOHANG_KHOANGTHOIGIAN_MaKhoangThoiGianDKGiaoHang
FOREIGN KEY (MaKhoangThoiGianDKGiaoHang) REFERENCES dbo.KHOANGTHOIGIAN(MaKhoangThoiGianGiaoHang)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 
-- FK_DANGKIGIAOHANG_THANHVIENGIAOHANG_MaThanhVienGiaoHang
ALTER TABLE dbo.DANGKIGIAOHANG
ADD CONSTRAINT FK_DANGKIGIAOHANG_THANHVIENGIAOHANG_MaThanhVienGiaoHang
FOREIGN KEY (MaThanhVienGiaoHang) REFERENCES dbo.THANHVIENGIAOHANG(MaThanhVienGiaoHang)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 
-- 7) KHACHHANG:
-- FK_KHACHHANG_KHUVUC_MaKhuVuc
ALTER TABLE dbo.KHACHHANG
ADD CONSTRAINT FK_KHACHHANG_KHUVUC_MaKhuVuc
FOREIGN KEY (MaKhuVuc) REFERENCES dbo.KHUVUC(MaKhuVuc)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 

-- 8) DONHANG_GIAOHANG:
-- FK_DONHANG_GIAOHANG_KHOANGTHOIGIAN_MaKhoangThoiGianGiaoHang
ALTER TABLE dbo.DONHANG_GIAOHANG
ADD CONSTRAINT FK_DONHANG_GIAOHANG_KHOANGTHOIGIAN_MaKhoangThoiGianGiaoHang
FOREIGN KEY (MaKhoangThoiGianGiaoHang) REFERENCES dbo.KHOANGTHOIGIAN(MaKhoangThoiGianGiaoHang)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 

-- FK_DONHANG_GIAOHANG_DICHVU_MaDichVu
ALTER TABLE dbo.DONHANG_GIAOHANG
ADD CONSTRAINT FK_DONHANG_GIAOHANG_DICHVU_MaDichVu
FOREIGN KEY (MaDichVu) REFERENCES dbo.DICHVU(MaDichVu)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 

-- FK_DONHANG_GIAOHANG_KHACHHANG_MaKhachHang
ALTER TABLE dbo.DONHANG_GIAOHANG
ADD CONSTRAINT FK_DONHANG_GIAOHANG_KHACHHANG_MaKhachHang
FOREIGN KEY (MaKhachHang) REFERENCES dbo.KHACHHANG(MaKhachHang)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 
-- FK_DONHANG_GIAOHANG_KHUVUC_MaKhuVucGiaoHang
ALTER TABLE dbo.DONHANG_GIAOHANG
ADD CONSTRAINT FK_DONHANG_GIAOHANG_KHUVUC_MaKhuVucGiaoHang
FOREIGN KEY (MaKhuVucGiaoHang) REFERENCES dbo.KHUVUC(MaKhuVuc)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 
--ALTER TABLE dbo.DONHANG_GIAOHANG
--DROP CONSTRAINT FK_DONHANG_GIAOHANG_KHUVUC_MaKhuVucGiaoHang 
-- FK_DONHANG_GIAOHANG_THANHVIENGIAOHANG_MaThanhVienGiaoHang
ALTER TABLE dbo.DONHANG_GIAOHANG
ADD CONSTRAINT FK_DONHANG_GIAOHANG_THANHVIENGIAOHANG_MaThanhVienGiaoHang
FOREIGN KEY (MaNhanVienGiaoHang) REFERENCES dbo.THANHVIENGIAOHANG(MaThanhVienGiaoHang)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 



-- 9) CHITIET_DONHANG
-- FK_CHITIET_DONHANG_LOAIMATHANG_MaLoaiMatHang
ALTER TABLE dbo.CHITIET_DONHANG 
ADD CONSTRAINT FK_CHITIET_DONHANG_LOAIMATHANG_MaLoaiMatHang
FOREIGN KEY (MaLoaiMatHang) REFERENCES dbo.LOAIMATHANG(MaLoaiMatHang)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 
--	FK_CHITIET_DONHANG_DONHANG_GIAOHANG_MaDonHangGiaoHang
ALTER TABLE dbo.CHITIET_DONHANG
ADD CONSTRAINT FK_CHITIET_DONHANG_DONHANG_GIAOHANG_MaDonHangGiaoHang
FOREIGN KEY (MaDonHangGiaoHang) REFERENCES dbo.DONHANG_GIAOHANG(MaDonHangGiaoHang)
ON DELETE NO ACTION
ON UPDATE NO ACTION
GO 
----------------------------------------------------------------------------------
-- Simulate data:
-- 1) LOAIMATHANG:
INSERT dbo.LOAIMATHANG
        ( MaLoaiMatHang, TenLoaiMatHang )
VALUES  ( 'MH001', -- MaLoaiMatHang - char(5)
          'Quan ao'  -- TenLoaiMatHang - varchar(20)
          )
GO
INSERT dbo.LOAIMATHANG
        ( MaLoaiMatHang, TenLoaiMatHang )
VALUES  ( 'MH002', -- MaLoaiMatHang - char(5)
          'My Pham'  -- TenLoaiMatHang - varchar(20)
          )
GO
INSERT dbo.LOAIMATHANG
        ( MaLoaiMatHang, TenLoaiMatHang )
VALUES  ( 'MH003', -- MaLoaiMatHang - char(5)
          'Do gia dung'  -- TenLoaiMatHang - varchar(20)
          )
GO
INSERT dbo.LOAIMATHANG
        ( MaLoaiMatHang, TenLoaiMatHang )
VALUES  ( 'MH004', -- MaLoaiMatHang - char(5)
          'Do dien tu'  -- TenLoaiMatHang - varchar(20)
          )
GO 

-- 2) KHUVUC:
INSERT dbo.KHUVUC
        ( MaKhuVuc, TenKhuVuc )
VALUES  ( 'KV001', -- MaKhuVuc - char(5)
          'Son Tra'  -- TenKhuVuc - varchar(30)
          )
GO
INSERT dbo.KHUVUC
        ( MaKhuVuc, TenKhuVuc )
VALUES  ( 'KV002', -- MaKhuVuc - char(5)
          'Lien Chieu'  -- TenKhuVuc - varchar(30)
          )
GO
INSERT dbo.KHUVUC
        ( MaKhuVuc, TenKhuVuc )
VALUES  ( 'KV003', -- MaKhuVuc - char(5)
          'Ngu Hanh Son'  -- TenKhuVuc - varchar(30)
          )
GO
INSERT dbo.KHUVUC
        ( MaKhuVuc, TenKhuVuc )
VALUES  ( 'KV004', -- MaKhuVuc - char(5)
          'Hai Chau'  -- TenKhuVuc - varchar(30)
          )
GO
INSERT dbo.KHUVUC
        ( MaKhuVuc, TenKhuVuc )
VALUES  ( 'KV005', -- MaKhuVuc - char(5)
          'Thanh Khe'  -- TenKhuVuc - varchar(30)
          )
GO

-- 3) KHOANGTHOIGIAN:
INSERT dbo.KHOANGTHOIGIAN
        ( MaKhoangThoiGianGiaoHang, MoTa )
VALUES  ( 'TG001', -- MaKhoangThoiGianGiaoHang - char(5)
          '7h - 9h AM'  -- MoTa - varchar(20)
          )
GO
INSERT dbo.KHOANGTHOIGIAN
        ( MaKhoangThoiGianGiaoHang, MoTa )
VALUES  ( 'TG002', -- MaKhoangThoiGianGiaoHang - char(5)
          '9h - 11h AM'  -- MoTa - varchar(20)
          )
GO
INSERT dbo.KHOANGTHOIGIAN
        ( MaKhoangThoiGianGiaoHang, MoTa )
VALUES  ( 'TG003', -- MaKhoangThoiGianGiaoHang - char(5)
          '1h - 3h PM'  -- MoTa - varchar(20)
          )
GO
INSERT dbo.KHOANGTHOIGIAN
        ( MaKhoangThoiGianGiaoHang, MoTa )
VALUES  ( 'TG004', -- MaKhoangThoiGianGiaoHang - char(5)
          '3h - 5h PM'  -- MoTa - varchar(20)
          )
GO
INSERT dbo.KHOANGTHOIGIAN
        ( MaKhoangThoiGianGiaoHang, MoTa )
VALUES  ( 'TG005', -- MaKhoangThoiGianGiaoHang - char(5)
          '7h - 9h30 PM'  -- MoTa - varchar(20)
          )
GO

-- 4) DICHVU:
INSERT dbo.DICHVU
        ( MaDichVu, TenDichVu )
VALUES  ( 'DV001', -- MaDichVu - char(5)
          'Giao hang nguoi nhan tra tien phi'  -- TenDichVu - varchar(40)
          )
GO
INSERT dbo.DICHVU
        ( MaDichVu, TenDichVu )
VALUES  ( 'DV002', -- MaDichVu - char(5)
          'Giao hang nguoi gui tra tien phi'  -- TenDichVu - varchar(40)
          )
GO
INSERT dbo.DICHVU
        ( MaDichVu, TenDichVu )
VALUES  ( 'DV003', -- MaDichVu - char(5)
          'Giao hang cong ich (khong tinh phi)'  -- TenDichVu - varchar(40)
          )
GO 

-- 5) THANHVIENGIAOHANG:
INSERT dbo.THANHVIENGIAOHANG
        ( MaThanhVienGiaoHang ,
          TenThanhVienGiaoHang ,
          NgaySinh ,
          GioiTinh ,
          SoDTThanhVien ,
          DiaChiThanhVien
        )
VALUES  ( 'TV0001' , -- MaThanhVienGiaoHang - char(6)
          'Nguyen Van A' , -- TenThanhVienGiaoHang - varchar(30)
          '19951120' , -- NgaySinh - date
          'Nam' , -- GioiTinh - char(3)
          '0905111111' , -- SoDTThanhVien - varchar(11)
          '23 Ong Ich Khiem'  -- DiaChiThanhVien - varchar(40)
        )
GO 

INSERT dbo.THANHVIENGIAOHANG
        ( MaThanhVienGiaoHang ,
          TenThanhVienGiaoHang ,
          NgaySinh ,
          GioiTinh ,
          SoDTThanhVien ,
          DiaChiThanhVien
        )
VALUES  ( 'TV0002' , -- MaThanhVienGiaoHang - char(6)
          'Nguyen Van B' , -- TenThanhVienGiaoHang - varchar(30)
          '19921226' , -- NgaySinh - date
          'Nu' , -- GioiTinh - char(3)
          '0905111112' , -- SoDTThanhVien - varchar(11)
          '234 Ton Duc Thang'  -- DiaChiThanhVien - varchar(40)
        )
GO

INSERT dbo.THANHVIENGIAOHANG
        ( MaThanhVienGiaoHang ,
          TenThanhVienGiaoHang ,
          NgaySinh ,
          GioiTinh ,
          SoDTThanhVien ,
          DiaChiThanhVien
        )
VALUES  ( 'TV0003' , -- MaThanhVienGiaoHang - char(6)
          'Nguyen Van C' , -- TenThanhVienGiaoHang - varchar(30)
          '19901130' , -- NgaySinh - date
          'Nu' , -- GioiTinh - char(3)
          '0905111113' , -- SoDTThanhVien - varchar(11)
          '45 Hoang Dieu'  -- DiaChiThanhVien - varchar(40)
        )
GO 

INSERT dbo.THANHVIENGIAOHANG
        ( MaThanhVienGiaoHang ,
          TenThanhVienGiaoHang ,
          NgaySinh ,
          GioiTinh ,
          SoDTThanhVien ,
          DiaChiThanhVien
        )
VALUES  ( 'TV0004' , -- MaThanhVienGiaoHang - char(6)
          'Nguyen Van D' , -- TenThanhVienGiaoHang - varchar(30)
          '19950708' , -- NgaySinh - date
          'Nam' , -- GioiTinh - char(3)
          '0905111114' , -- SoDTThanhVien - varchar(11)
          '23/33 Ngu Hanh Son'  -- DiaChiThanhVien - varchar(40)
        )
GO

INSERT dbo.THANHVIENGIAOHANG
        ( MaThanhVienGiaoHang ,
          TenThanhVienGiaoHang ,
          NgaySinh ,
          GioiTinh ,
          SoDTThanhVien ,
          DiaChiThanhVien
        )
VALUES  ( 'TV0005' , -- MaThanhVienGiaoHang - char(6)
          'Nguyen Van E' , -- TenThanhVienGiaoHang - varchar(30)
          '19910204' , -- NgaySinh - date
          'Nam' , -- GioiTinh - char(3)
          '0905111115' , -- SoDTThanhVien - varchar(11)
          '56 Dinh Thi Dieu'  -- DiaChiThanhVien - varchar(40)
        )
GO

-- 6) DANGKYGIAOHANG:
INSERT dbo.DANGKIGIAOHANG
        ( MaThanhVienGiaoHang ,
          MaKhoangThoiGianDKGiaoHang
        )
VALUES  ( 'TV0001' , -- MaThanhVienGiaoHang - char(6)
          'TG004'  -- MaKhoangThoiGianDKGiaoHang - char(5)
        )
INSERT dbo.DANGKIGIAOHANG
        ( MaThanhVienGiaoHang ,
          MaKhoangThoiGianDKGiaoHang
        )
VALUES  ( 'TV0002' , -- MaThanhVienGiaoHang - char(6)
          'TG005'  -- MaKhoangThoiGianDKGiaoHang - char(5)
        )
INSERT dbo.DANGKIGIAOHANG
        ( MaThanhVienGiaoHang ,
          MaKhoangThoiGianDKGiaoHang
        )
VALUES  ( 'TV0003' , -- MaThanhVienGiaoHang - char(6)
          'TG001'  -- MaKhoangThoiGianDKGiaoHang - char(5)
        )
INSERT dbo.DANGKIGIAOHANG
        ( MaThanhVienGiaoHang ,
          MaKhoangThoiGianDKGiaoHang
        )
VALUES  ( 'TV0003' , -- MaThanhVienGiaoHang - char(6)
          'TG002'  -- MaKhoangThoiGianDKGiaoHang - char(5)
        )
GO
INSERT dbo.DANGKIGIAOHANG
        ( MaThanhVienGiaoHang ,
          MaKhoangThoiGianDKGiaoHang
        )
VALUES  ( 'TV0003' , -- MaThanhVienGiaoHang - char(6)
          'TG003'  -- MaKhoangThoiGianDKGiaoHang - char(5)
        )
GO
--
--

-- 7) KHACHHANG:
INSERT dbo.KHACHHANG
        ( MaKhachHang ,
          MaKhuVuc ,
          TenKhachHang ,
          TenCuaHang ,
          SoDTKhachHang ,
          DiaChiEmail ,
          DiaChiNhanHang
        )
VALUES  ( 'KH001' , -- MaKhachHang - char(5)
          'KV001' , -- MaKhuVuc - char(5)
          'Le Thi A' , -- TenKhachHang - varchar(30)
          'Cua hang 1' , -- TenCuaHang - varchar(20)
          '0905111111' , -- SoDTKhachHang - varchar(11)
          'alethi@gmail.com' , -- DiaChiEmail - varchar(30)
          '80 Pham Phu Thai'  -- DiaChiNhanHang - varchar(40)
        )
INSERT dbo.KHACHHANG
        ( MaKhachHang ,
          MaKhuVuc ,
          TenKhachHang ,
          TenCuaHang ,
          SoDTKhachHang ,
          DiaChiEmail ,
          DiaChiNhanHang
        )
VALUES  ( 'KH002' , -- MaKhachHang - char(5)
          'KV001' , -- MaKhuVuc - char(5)
          'Nguyen Van B' , -- TenKhachHang - varchar(30)
          'Cua hang 2' , -- TenCuaHang - varchar(20)
          '0905111112' , -- SoDTKhachHang - varchar(11)
          'bnguyenvan@gmail.com' , -- DiaChiEmail - varchar(30)
          '100 Phan Tu'  -- DiaChiNhanHang - varchar(40)
        )
INSERT dbo.KHACHHANG
        ( MaKhachHang ,
          MaKhuVuc ,
          TenKhachHang ,
          TenCuaHang ,
          SoDTKhachHang ,
          DiaChiEmail ,
          DiaChiNhanHang
        )
VALUES  ( 'KH003' , -- MaKhachHang - char(5)
          'KV002' , -- MaKhuVuc - char(5)
          'Le Thi B' , -- TenKhachHang - varchar(30)
          'Cua hang 3' , -- TenCuaHang - varchar(20)
          '0905111113' , -- SoDTKhachHang - varchar(11)
          'blethi@gmail.com' , -- DiaChiEmail - varchar(30)
          '23 An Thuong 18'  -- DiaChiNhanHang - varchar(40)
        )
INSERT dbo.KHACHHANG
        ( MaKhachHang ,
          MaKhuVuc ,
          TenKhachHang ,
          TenCuaHang ,
          SoDTKhachHang ,
          DiaChiEmail ,
          DiaChiNhanHang
        )
VALUES  ( 'KH004' , -- MaKhachHang - char(5)
          'KV002' , -- MaKhuVuc - char(5)
          'Nguyen Van C' , -- TenKhachHang - varchar(30)
          'Cua hang 4' , -- TenCuaHang - varchar(20)
          '0905111114' , -- SoDTKhachHang - varchar(11)
          'cnguyenvan@gmail.com' , -- DiaChiEmail - varchar(30)
          '67 Ngo The Thai'  -- DiaChiNhanHang - varchar(40)
        )
INSERT dbo.KHACHHANG
        ( MaKhachHang ,
          MaKhuVuc ,
          TenKhachHang ,
          TenCuaHang ,
          SoDTKhachHang ,
          DiaChiEmail ,
          DiaChiNhanHang
        )
VALUES  ( 'KH005' , -- MaKhachHang - char(5)
          'KV001' , -- MaKhuVuc - char(5)
          'Le Thi D' , -- TenKhachHang - varchar(30)
          'Cua hang 5' , -- TenCuaHang - varchar(20)
          '0905111115' , -- SoDTKhachHang - varchar(11)
          'dlethi@gmail.com' , -- DiaChiEmail - varchar(30)
          '100 Chau Thi Vinh Te'  -- DiaChiNhanHang - varchar(40)
        )

-- 8) DONHANG_GIAOHANG:
INSERT dbo.DONHANG_GIAOHANG
        ( MaDonHangGiaoHang ,
          MaKhachHang ,
          MaNhanVienGiaoHang ,
          MaDichVu ,
          MaKhuVucGiaoHang ,
          TenNguoiNhan ,
          DiaChiGiaoHang ,
          SoDTNguoiNhan ,
          MaKhoangThoiGianGiaoHang ,
          NgayGiaoHang ,
          PhuongThucThanhToan,
		  TrangThaiPheDuyet,
		  TrangThaiGiaoHang
        )
VALUES  ( 'DH0001' , -- MaDonHangGiaoHang - char(6)
          'KH001' , -- MaKhachHang - char(5)
          'TV0001' , -- MaNhanVienGiaoHang - char(5)
          'DV001' , -- MaDichVu - char(5)
          'KV001' , -- MaKhuVucGiaoHang - char(5)
          'Pham Van A' , -- TenNguoiNhan - varchar(30)
          '30 Hoang Van Thu' , -- DiaChiGiaoHang - varchar(40)
          '0905111111' , -- SoDTNguoiNhan - char(11)
          'TG001' , -- MaKhoangThoiGianGiaoHang - char(5)
          '20161010' , -- NgayGiaoHang - date
          'Tien mat',  -- PhuongThucThanhToan - varchar(20)
		  'Da phe duyet',
		  'Da giao hang'
		)
INSERT dbo.DONHANG_GIAOHANG
        ( MaDonHangGiaoHang ,
          MaKhachHang ,
          MaNhanVienGiaoHang ,
          MaDichVu ,
          MaKhuVucGiaoHang ,
          TenNguoiNhan ,
          DiaChiGiaoHang ,
          SoDTNguoiNhan ,
          MaKhoangThoiGianGiaoHang ,
          NgayGiaoHang ,
          PhuongThucThanhToan,
		  TrangThaiPheDuyet,
		  TrangThaiGiaoHang
        )
VALUES  ( 'DH0002' , -- MaDonHangGiaoHang - char(6)
          'KH001' , -- MaKhachHang - char(5)
          'TV0002' , -- MaNhanVienGiaoHang - char(5)
          'DV001' , -- MaDichVu - char(5)
          'KV005' , -- MaKhuVucGiaoHang - char(5)
          'Pham Van B' , -- TenNguoiNhan - varchar(30)
          '15 Le Dinh Ly' , -- DiaChiGiaoHang - varchar(40)
          '0905111112' , -- SoDTNguoiNhan - char(11)
          'TG005' , -- MaKhoangThoiGianGiaoHang - char(5)
          '20161223' , -- NgayGiaoHang - date
          'Tien mat',  -- PhuongThucThanhToan - varchar(20)
		  'Da phe duyet',
		  'Chua giao hang'
		)
INSERT dbo.DONHANG_GIAOHANG
        ( MaDonHangGiaoHang ,
          MaKhachHang ,
          MaNhanVienGiaoHang ,
          MaDichVu ,
          MaKhuVucGiaoHang ,
          TenNguoiNhan ,
          DiaChiGiaoHang ,
          SoDTNguoiNhan ,
          MaKhoangThoiGianGiaoHang ,
          NgayGiaoHang ,
          PhuongThucThanhToan,
		  TrangThaiPheDuyet,
		  TrangThaiGiaoHang
        )
VALUES  ( 'DH0003' , -- MaDonHangGiaoHang - char(6)
          'KH002' , -- MaKhachHang - char(5)
          'TV0002' , -- MaNhanVienGiaoHang - char(5)
          'DV001' , -- MaDichVu - char(5)
          'KV005' , -- MaKhuVucGiaoHang - char(5)
          'Pham Van C' , -- TenNguoiNhan - varchar(30)
          '23 Le Dinh Ly' , -- DiaChiGiaoHang - varchar(40)
          '0905111113' , -- SoDTNguoiNhan - char(11)
          'TG001' , -- MaKhoangThoiGianGiaoHang - char(5)
          '20170408' , -- NgayGiaoHang - date
          'Tien mat',  -- PhuongThucThanhToan - varchar(20)
		  'Da phe duyet',
		  'Da giao hang'
		)
INSERT dbo.DONHANG_GIAOHANG
        ( MaDonHangGiaoHang ,
          MaKhachHang ,
          MaNhanVienGiaoHang ,
          MaDichVu ,
          MaKhuVucGiaoHang ,
          TenNguoiNhan ,
          DiaChiGiaoHang ,
          SoDTNguoiNhan ,
          MaKhoangThoiGianGiaoHang ,
          NgayGiaoHang ,
          PhuongThucThanhToan,
		  TrangThaiPheDuyet,
		  TrangThaiGiaoHang
        )
VALUES  ( 'DH0004' , -- MaDonHangGiaoHang - char(6)
          'KH003' , -- MaKhachHang - char(5)
          'TV0001' , -- MaNhanVienGiaoHang - char(5)
          'DV003' , -- MaDichVu - char(5)
          'KV002' , -- MaKhuVucGiaoHang - char(5)
          'Pham Van D' , -- TenNguoiNhan - varchar(30)
          '45 Pham Phu Thai' , -- DiaChiGiaoHang - varchar(40)
          '0905111114' , -- SoDTNguoiNhan - char(11)
          'TG002' , -- MaKhoangThoiGianGiaoHang - char(5)
          '20151011' , -- NgayGiaoHang - date
          'Chuyen khoang',  -- PhuongThucThanhToan - varchar(20)
		  'Da phe duyet',
		  'Da giao hang'
		)
INSERT dbo.DONHANG_GIAOHANG
        ( MaDonHangGiaoHang ,
          MaKhachHang ,
          MaNhanVienGiaoHang ,
          MaDichVu ,
          MaKhuVucGiaoHang ,
          TenNguoiNhan ,
          DiaChiGiaoHang ,
          SoDTNguoiNhan ,
          MaKhoangThoiGianGiaoHang ,
          NgayGiaoHang ,
          PhuongThucThanhToan,
		  TrangThaiPheDuyet,
		  TrangThaiGiaoHang
        )
VALUES  ( 'DH0005' , -- MaDonHangGiaoHang - char(6)
          'KH003' , -- MaKhachHang - char(5)
          'TV0005' , -- MaNhanVienGiaoHang - char(5)
          'DV003' , -- MaDichVu - char(5)
          'KV003' , -- MaKhuVucGiaoHang - char(5)
          'Pham Van E' , -- TenNguoiNhan - varchar(30)
          '78 Hoang Dieu' , -- DiaChiGiaoHang - varchar(40)
          '0905111115' , -- SoDTNguoiNhan - char(11)
          'TG003' , -- MaKhoangThoiGianGiaoHang - char(5)
          '20170404' , -- NgayGiaoHang - date
          'Chuyen khoang',  -- PhuongThucThanhToan - varchar(20)
		  'Chua phe duyet',
		  NULL
		)
GO 
-- 9) CHITIET_DONHANG:
INSERT dbo.CHITIET_DONHANG
        ( MaDonHangGiaoHang ,
          TenSanPhamDuocGiao ,
          SoLuong ,
          TrongLuong ,
          MaLoaiMatHang ,
          TienThuHo
        )
VALUES  ( 'DH0001' , -- MaDonHangGiaoHang - char(6)
          'Ao len' , -- TenSanPhamDuocGiao - varchar(40)
          2 , -- SoLuong - int
          0.5 , -- TrongLuong - float
          'MH001' , -- MaLoaiMatHang - varchar(20)
          200000  -- TienThuHo - money
        )
INSERT dbo.CHITIET_DONHANG
        ( MaDonHangGiaoHang ,
          TenSanPhamDuocGiao ,
          SoLuong ,
          TrongLuong ,
          MaLoaiMatHang ,
          TienThuHo
        )
VALUES  ( 'DH0001' , -- MaDonHangGiaoHang - char(6)
          'Quan au' , -- TenSanPhamDuocGiao - varchar(40)
          1 , -- SoLuong - int
          0.25 , -- TrongLuong - float
          'MH001' , -- MaLoaiMatHang - varchar(20)
          350000  -- TienThuHo - money
        )
INSERT dbo.CHITIET_DONHANG
        ( MaDonHangGiaoHang ,
          TenSanPhamDuocGiao ,
          SoLuong ,
          TrongLuong ,
          MaLoaiMatHang ,
          TienThuHo
        )
VALUES  ( 'DH0002' , -- MaDonHangGiaoHang - char(6)
          'Ao thun' , -- TenSanPhamDuocGiao - varchar(40)
          1 , -- SoLuong - int
          0.25 , -- TrongLuong - float
          'MH001' , -- MaLoaiMatHang - varchar(20)
          1000000  -- TienThuHo - money
        )
INSERT dbo.CHITIET_DONHANG
        ( MaDonHangGiaoHang ,
          TenSanPhamDuocGiao ,
          SoLuong ,
          TrongLuong ,
          MaLoaiMatHang ,
          TienThuHo
        )
VALUES  ( 'DH0002' , -- MaDonHangGiaoHang - char(6)
          'Ao khoac' , -- TenSanPhamDuocGiao - varchar(40)
          3 , -- SoLuong - int
          0.25 , -- TrongLuong - float
          'MH001' , -- MaLoaiMatHang - varchar(20)
          2000000  -- TienThuHo - money
        )
INSERT dbo.CHITIET_DONHANG
        ( MaDonHangGiaoHang ,
          TenSanPhamDuocGiao ,
          SoLuong ,
          TrongLuong ,
          MaLoaiMatHang ,
          TienThuHo
        )
VALUES  ( 'DH0003' , -- MaDonHangGiaoHang - char(6)
          'Sua duong the' , -- TenSanPhamDuocGiao - varchar(40)
          2 , -- SoLuong - int
          0.25 , -- TrongLuong - float
          'MH002' , -- MaLoaiMatHang - varchar(20)
          780000  -- TienThuHo - money
        )
INSERT dbo.CHITIET_DONHANG
        ( MaDonHangGiaoHang ,
          TenSanPhamDuocGiao ,
          SoLuong ,
          TrongLuong ,
          MaLoaiMatHang ,
          TienThuHo
        )
VALUES  ( 'DH0003' , -- MaDonHangGiaoHang - char(6)
          'Kem tay da chet' , -- TenSanPhamDuocGiao - varchar(40)
          3 , -- SoLuong - int
          0.5 , -- TrongLuong - float
          'MH002' , -- MaLoaiMatHang - varchar(20)
          150000  -- TienThuHo - money
        )
INSERT dbo.CHITIET_DONHANG
        ( MaDonHangGiaoHang ,
          TenSanPhamDuocGiao ,
          SoLuong ,
          TrongLuong ,
          MaLoaiMatHang ,
          TienThuHo
        )
VALUES  ( 'DH0003' , -- MaDonHangGiaoHang - char(6)
          'Kem duong ban dem' , -- TenSanPhamDuocGiao - varchar(40)
          4 , -- SoLuong - int
          0.25 , -- TrongLuong - float
          'MH002' , -- MaLoaiMatHang - varchar(20)
          900000  -- TienThuHo - money
        )
--
GO 
-------------------------------------------------------------------
-- View all tables:
SELECT * FROM dbo.LOAIMATHANG
SELECT * FROM dbo.KHUVUC
SELECT * FROM dbo.KHOANGTHOIGIAN
SELECT * FROM dbo.DICHVU
SELECT * FROM dbo.THANHVIENGIAOHANG
SELECT * FROM dbo.DANGKIGIAOHANG
SELECT * FROM dbo.KHACHHANG
SELECT * FROM dbo.DONHANG_GIAOHANG
SELECT * FROM dbo.CHITIET_DONHANG

DELETE FROM dbo.KHACHHANG 
WHERE TenKhachHang = 'Le Thi A'
