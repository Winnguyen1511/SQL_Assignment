-- Create database:
CREATE DATABASE Assignment2_Database
GO 
USE Assignment2_Database
GO 

-- Note:
-- Name, Address, ...: nvarchar(30)
-- Phone: nvarchar(11)
-- 
-- Create tables:
-- 1) DON_VI_UNG_HO:
CREATE TABLE DON_VI_UNG_HO
(
	MaDVUH	CHAR(5),
	HoTenNguoiDaiDien	NVARCHAR(30),
	DiaChiNguoiDaiDien	NVARCHAR(40),
	SoDienThoaiLienLac	VARCHAR(11),
	SoCMNDNguoiDaiDien	VARCHAR(9),
	SoTaiKhoanNganHang	CHAR(8),
	TenNganHang			NVARCHAR(30),
	ChiNhanhNganHang	NVARCHAR(30),
	TenChuTKNganHang	NVARCHAR(30)
	CONSTRAINT PK_DON_VI_UNG_HO_MaDVUH
	PRIMARY KEY(MaDVUH)
)
GO	

-- 2) DOT_UNG_HO:
CREATE TABLE DOT_UNG_HO
(
	MaDotUngHo	char(5),
	MaDVUH		char(5),
	NgayUngHo	date
	CONSTRAINT PK_DOT_UNG_HO_MaDotUngHo
	PRIMARY KEY(MaDotUngHo)
)
GO 

-- 3) CHI_TIET_UNG_HO:
CREATE TABLE CHI_TIET_UNG_HO
(
	MaDotUngHo		CHAR(5),
	MaHinhThucUH	CHAR(4),
	SoLuongUngHo	MONEY,
	DonViTinh		VARCHAR(5)
	CONSTRAINT PK_CHI_TIET_UNG_HO_MaDotUngHo_MaHinhThucUH
	PRIMARY KEY(MaDotUngHo,MaHinhThucUH)
)
GO
-- 4) HINH_THUC_UH:
CREATE TABLE HINH_THUC_UH
(
	MaHinhThucUH	CHAR(4),
	TenHinhThucUngHo	nvarchar(20)
	CONSTRAINT PK_HINH_THUC_UH_MaHinhThucUH
	PRIMARY KEY(MaHinhThucUH)
)
GO
-- 5) HO_DAN:
CREATE TABLE HO_DAN
(
	MaHoDan		CHAR(5),
	HoTenChuHo	NVARCHAR(30),
	ToDanPho	INT,
	KhoiHoacThon	INT, 
	SoDienThoai		VARCHAR(11),
	DiaChiNha		NVARCHAR(40),
	SoNhanKhau		INT,
	DienGiaDinh		NVARCHAR(40),
	LaHoNgheo		CHAR(4)
	CONSTRAINT PK_HO_DAN_MaHoDan
	PRIMARY KEY(MaHoDan)
)
GO
-- 6) DOT_NHAN_UNG_HO:
CREATE TABLE DOT_NHAN_UNG_HO
(
	MaDotNhanUngHo	CHAR(9),
	MaHoDan			CHAR(5),
	NgayNhanUngHo	DATE
	CONSTRAINT PK_DOT_NHAN_UNG_HO_MaDotNhanUngHo
	PRIMARY KEY (MaDotNhanUngHo)
)
GO 
 
-- 7) CHI_TIET_NHAN_UNG_HO:
CREATE TABLE CHI_TIET_NHAN_UNG_HO
(
	MaDotNhanUngHo	CHAR(9),
	MaHinhThucUH	CHAR(4),
	SoLuongNhanUngHo MONEY,
	DonViTinh		VARCHAR(5)
	CONSTRAINT PK_CHI_TIET_NHAN_UNG_HO_MaDotNhanUngHo_MaHinhThucUH
	PRIMARY KEY(MaDotNhanUngHo,MaHinhThucUH)	
)
GO 

-- create foreign key:
-- 1) DON_VI_UNG_HO:
-- 2) DOT_UNG_HO:
-- FK_DOT_UNG_HO_DON_VI_UNG_HO_MaDVUH
ALTER TABLE dbo.DOT_UNG_HO 
ADD CONSTRAINT FK_DOT_UNG_HO_DON_VI_UNG_HO_MaDVUH
FOREIGN KEY(MaDVUH) REFERENCES dbo.DON_VI_UNG_HO(MaDVUH)
-- 3) CHI_TIET_UNG_HO:
-- FK_CHI_TIET_UNG_HO_DOT_UNG_HO_MaDotUngHo
ALTER TABLE dbo.CHI_TIET_UNG_HO
ADD CONSTRAINT FK_CHI_TIET_UNG_HO_DOT_UNG_HO_MaDotUngHo
FOREIGN KEY(MaDotUngHo) REFERENCES dbo.DOT_UNG_HO(MaDotUngHo)

-- FK_CHI_TIET_UNG_HO_HINH_THUC_UH_MaHinhThucUH
ALTER TABLE dbo.CHI_TIET_UNG_HO
ADD CONSTRAINT FK_CHI_TIET_UNG_HO_HINH_THUC_UH_MaHinhThucUH
FOREIGN KEY(MaHinhThucUH) REFERENCES dbo.HINH_THUC_UH(MaHinhThucUH)

-- 4) HINH_THUC_UH:
-- 5) HO_DAN:
-- 6) DOT_NHAN_UNG_HO:
-- FK_DOT_NHAN_UNG_HO_HO_DAN_MaHoDan
ALTER TABLE dbo.DOT_NHAN_UNG_HO
ADD CONSTRAINT FK_DOT_NHAN_UNG_HO_HO_DAN_MaHoDan
FOREIGN KEY(MaHoDan) REFERENCES dbo.HO_DAN(MaHoDan)

-- 7) CHI_TIET_NHAN_UNG_HO:
-- FK_CHI_TIET_NHAN_UNG_HO_HINH_THUC_UH_MaHinhThucUH
ALTER TABLE dbo.CHI_TIET_NHAN_UNG_HO
ADD CONSTRAINT FK_CHI_TIET_NHAN_UNG_HO_HINH_THUC_UH_MaHinhThucUH
FOREIGN KEY(MaHinhThucUH) REFERENCES dbo.HINH_THUC_UH(MaHinhThucUH)

-- FK_CHI_TIET_NHAN_UNG_HO_DOT_NHAN_UNG_HO_MaDotNhanUngHo
ALTER TABLE dbo.CHI_TIET_NHAN_UNG_HO
ADD CONSTRAINT FK_CHI_TIET_NHAN_UNG_HO_DOT_NHAN_UNG_HO_MaDotNhanUngHo
FOREIGN KEY(MaDotNhanUngHo) REFERENCES dbo.DOT_NHAN_UNG_HO(MaDotNhanUngHo)


-- Simulate data: 
-- 1) DON_VI_UNG_HO:
INSERT dbo.DON_VI_UNG_HO
        ( MaDVUH ,
          HoTenNguoiDaiDien ,
          DiaChiNguoiDaiDien ,
          SoDienThoaiLienLac ,
          SoCMNDNguoiDaiDien ,
          SoTaiKhoanNganHang ,
          TenNganHang ,
          ChiNhanhNganHang ,
          TenChuTKNganHang
        )
VALUES  ( 'CN001' , -- MaDVUH - char(5)
          N'Nguyen Van A1' , -- HoTenNguoiDaiDien - nvarchar(30)
          N'Nui Thanh, Quang Nam' , -- DiaChiNguoiDaiDien - nvarchar(40)
          '0905121121' , -- SoDienThoaiLienLac - varchar(11)
          '124898000' , -- SoCMNDNguoiDaiDien - varchar(9)
          '65874000' , -- SoTaiKhoanNganHang - char(8)
          N'TienPhongBank' , -- TenNganHang - nvarchar(30)
          N'Da Nang' , -- ChiNhanhNganHang - nvarchar(30)
          N'Nguyen Van A1'  -- TenChuTKNganHang - nvarchar(30)
        )
GO

INSERT dbo.DON_VI_UNG_HO
        ( MaDVUH ,
          HoTenNguoiDaiDien ,
          DiaChiNguoiDaiDien ,
          SoDienThoaiLienLac ,
          SoCMNDNguoiDaiDien ,
          SoTaiKhoanNganHang ,
          TenNganHang ,
          ChiNhanhNganHang ,
          TenChuTKNganHang
        )
VALUES  ( 'CN002' , -- MaDVUH - char(5)
          N'Nguyen Van A2' , -- HoTenNguoiDaiDien - nvarchar(30)
          N'Phong Dien, Thua' , -- DiaChiNguoiDaiDien - nvarchar(40)
          '0905121122' , -- SoDienThoaiLienLac - varchar(11)
          '124898001' , -- SoCMNDNguoiDaiDien - varchar(9)
          '65874001' , -- SoTaiKhoanNganHang - char(8)
          N'Vietcom' , -- TenNganHang - nvarchar(30)
          N'Quang Nam' , -- ChiNhanhNganHang - nvarchar(30)
          N'Nguyen Van A2'  -- TenChuTKNganHang - nvarchar(30)
        )
GO 

INSERT dbo.DON_VI_UNG_HO
        ( MaDVUH ,
          HoTenNguoiDaiDien ,
          DiaChiNguoiDaiDien ,
          SoDienThoaiLienLac ,
          SoCMNDNguoiDaiDien ,
          SoTaiKhoanNganHang ,
          TenNganHang ,
          ChiNhanhNganHang ,
          TenChuTKNganHang
        )
VALUES  ( 'CTY01' , -- MaDVUH - char(5)
          N'Nguyen Van A3' , -- HoTenNguoiDaiDien - nvarchar(30)
          N'Tam Dao, Vinh Phuc' , -- DiaChiNguoiDaiDien - nvarchar(40)
          '0905121123' , -- SoDienThoaiLienLac - varchar(11)
          '124898002' , -- SoCMNDNguoiDaiDien - varchar(9)
          '65874002' , -- SoTaiKhoanNganHang - char(8)
          N'DongA' , -- TenNganHang - nvarchar(30)
          N'Thua Thien Hue' , -- ChiNhanhNganHang - nvarchar(30)
          N'Nguyen Van A3'  -- TenChuTKNganHang - nvarchar(30)
        )
GO

INSERT dbo.DON_VI_UNG_HO
        ( MaDVUH ,
          HoTenNguoiDaiDien ,
          DiaChiNguoiDaiDien ,
          SoDienThoaiLienLac ,
          SoCMNDNguoiDaiDien ,
          SoTaiKhoanNganHang ,
          TenNganHang ,
          ChiNhanhNganHang ,
          TenChuTKNganHang
        )
VALUES  ( 'CTY02' , -- MaDVUH - char(5)
          N'Nguyen Van A4' , -- HoTenNguoiDaiDien - nvarchar(30)
          N'Ba To, Quang Ngai' , -- DiaChiNguoiDaiDien - nvarchar(40)
          '0905121124' , -- SoDienThoaiLienLac - varchar(11)
          '124898003' , -- SoCMNDNguoiDaiDien - varchar(9)
          '65874003' , -- SoTaiKhoanNganHang - char(8)
          N'MBank' , -- TenNganHang - nvarchar(30)
          N'Gia Lai' , -- ChiNhanhNganHang - nvarchar(30)
          N'Nguyen Van A4'  -- TenChuTKNganHang - nvarchar(30)
        )
GO

-- 2) DOT_UNG_HO:
INSERT dbo.DOT_UNG_HO
        ( MaDotUngHo, MaDVUH, NgayUngHo )
VALUES  ( 'UH001', -- MaDotUngHo - char(5)
          'CN002', -- MaDVUH - char(5)
          '20161118'  -- NgayUngHo - date
          )
GO 

INSERT dbo.DOT_UNG_HO
        ( MaDotUngHo, MaDVUH, NgayUngHo )
VALUES  ( 'UH002', -- MaDotUngHo - char(5)
          'CTY01', -- MaDVUH - char(5)
          '20151119'  -- NgayUngHo - date
          )
GO 

INSERT dbo.DOT_UNG_HO
        ( MaDotUngHo, MaDVUH, NgayUngHo )
VALUES  ( 'UH003', -- MaDotUngHo - char(5)
          'CN002', -- MaDVUH - char(5)
          '20150810'  -- NgayUngHo - date
          )
GO 

INSERT dbo.DOT_UNG_HO
        ( MaDotUngHo, MaDVUH, NgayUngHo )
VALUES  ( 'UH004', -- MaDotUngHo - char(5)
          'CTY02', -- MaDVUH - char(5)
          '20151020'  -- NgayUngHo - date
          )
GO 

INSERT dbo.DOT_UNG_HO
        ( MaDotUngHo, MaDVUH, NgayUngHo )
VALUES  ( 'UH005', -- MaDotUngHo - char(5)
          'CTY02', -- MaDVUH - char(5)
          '20161111'  -- NgayUngHo - date
          )
GO 

-- SELECT * FROM dbo.DOT_UNG_HO
-- SELECT * FROM dbo.DON_VI_UNG_HO

-- 3) CHI_TIET_UNG_HO:
INSERT dbo.CHI_TIET_UNG_HO
        ( MaDotUngHo ,
          MaHinhThucUH ,
          SoLuongUngHo ,
          DonViTinh
        )
VALUES  ( 'UH001' , -- MaDotUngHo - char(5)
          'HT01' , -- MaHinhThucUH - char(4)
          6000 , -- SoLuongUngHo - money
          'USD'  -- DonViTinh - varchar(5)
        )
GO

INSERT dbo.CHI_TIET_UNG_HO
        ( MaDotUngHo ,
          MaHinhThucUH ,
          SoLuongUngHo ,
          DonViTinh
        )
VALUES  ( 'UH002' , -- MaDotUngHo - char(5)
          'HT02' , -- MaHinhThucUH - char(4)
          50 , -- SoLuongUngHo - money
          'Thung'  -- DonViTinh - varchar(5)
        )
GO 

INSERT dbo.CHI_TIET_UNG_HO
        ( MaDotUngHo ,
          MaHinhThucUH ,
          SoLuongUngHo ,
          DonViTinh
        )
VALUES  ( 'UH003' , -- MaDotUngHo - char(5)
          'HT03' , -- MaHinhThucUH - char(4)
          200 , -- SoLuongUngHo - money
          'Bo'  -- DonViTinh - varchar(5)
        )
GO

INSERT dbo.CHI_TIET_UNG_HO
        ( MaDotUngHo ,
          MaHinhThucUH ,
          SoLuongUngHo ,
          DonViTinh
        )
VALUES  ( 'UH003' , -- MaDotUngHo - char(5)
          'HT01' , -- MaHinhThucUH - char(4)
          100000 , -- SoLuongUngHo - money
          'JPY'  -- DonViTinh - varchar(5)
        )
GO

INSERT dbo.CHI_TIET_UNG_HO
        ( MaDotUngHo ,
          MaHinhThucUH ,
          SoLuongUngHo ,
          DonViTinh
        )
VALUES  ( 'UH004' , -- MaDotUngHo - char(5)
          'HT01' , -- MaHinhThucUH - char(4)
          100000 , -- SoLuongUngHo - money
          'USD'  -- DonViTinh - varchar(5)
        )
GO

INSERT dbo.CHI_TIET_UNG_HO
        ( MaDotUngHo ,
          MaHinhThucUH ,
          SoLuongUngHo ,
          DonViTinh
        )
VALUES  ( 'UH005' , -- MaDotUngHo - char(5)
          'HT03' , -- MaHinhThucUH - char(4)
          100 , -- SoLuongUngHo - money
          'Bo'  -- DonViTinh - varchar(5)
        )
GO

-- 4) HINH_THUC_UH:
INSERT dbo.HINH_THUC_UH
        ( MaHinhThucUH, TenHinhThucUngHo )
VALUES  ( 'HT01', -- MaHinhThucUH - char(4)
          N'Tien mat'  -- TenHinhThucUngHo - nvarchar(20)
          )
GO

INSERT dbo.HINH_THUC_UH
        ( MaHinhThucUH, TenHinhThucUngHo )
VALUES  ( 'HT02', -- MaHinhThucUH - char(4)
          N'Mi tom'  -- TenHinhThucUngHo - nvarchar(20)
          )
GO 

INSERT dbo.HINH_THUC_UH
        ( MaHinhThucUH, TenHinhThucUngHo )
VALUES  ( 'HT03', -- MaHinhThucUH - char(4)
          N'Quan ao'  -- TenHinhThucUngHo - nvarchar(20)
          )
GO

-- 5) HO_DAN:
INSERT dbo.HO_DAN
        ( MaHoDan ,
          HoTenChuHo ,
          ToDanPho ,
          KhoiHoacThon ,
          SoDienThoai ,
          DiaChiNha ,
          SoNhanKhau ,
          DienGiaDinh ,
          LaHoNgheo
        )
VALUES  ( 'HD001' , -- MaHoDan - char(5)
          N'Tran Van B1' , -- HoTenChuHo - nvarchar(30)
          10 , -- ToDanPho - int
          5 , -- KhoiHoacThon - int
          '0915222000' , -- SoDienThoai - varchar(11)
          N'12 Tran Van On' , -- DiaChiNha - nvarchar(40)
          5 , -- SoNhanKhau - int
          N'Cong nhan vien chuc' , -- DienGiaDinh - nvarchar(40)
          'Dung'  -- LaHoNgheo - char(4)
        )
GO

INSERT dbo.HO_DAN
        ( MaHoDan ,
          HoTenChuHo ,
          ToDanPho ,
          KhoiHoacThon ,
          SoDienThoai ,
          DiaChiNha ,
          SoNhanKhau ,
          DienGiaDinh ,
          LaHoNgheo
        )
VALUES  ( 'HD002' , -- MaHoDan - char(5)
          N'Tran Van B2' , -- HoTenChuHo - nvarchar(30)
          11 , -- ToDanPho - int
          6 , -- KhoiHoacThon - int
          '0915222001' , -- SoDienThoai - varchar(11)
          N'13 Nguyen Huu Tho' , -- DiaChiNha - nvarchar(40)
          6 , -- SoNhanKhau - int
          N'Cong nhan vien chuc' , -- DienGiaDinh - nvarchar(40)
          'Sai'  -- LaHoNgheo - char(4)
        )
GO 

INSERT dbo.HO_DAN
        ( MaHoDan ,
          HoTenChuHo ,
          ToDanPho ,
          KhoiHoacThon ,
          SoDienThoai ,
          DiaChiNha ,
          SoNhanKhau ,
          DienGiaDinh ,
          LaHoNgheo
        )
VALUES  ( 'HD003' , -- MaHoDan - char(5)
          N'Tran Van B3' , -- HoTenChuHo - nvarchar(30)
          12 , -- ToDanPho - int
          7 , -- KhoiHoacThon - int
          '0915222002' , -- SoDienThoai - varchar(11)
          N'14 Phan Chu Trinh' , -- DiaChiNha - nvarchar(40)
          6 , -- SoNhanKhau - int
          N'Thuong Binh' , -- DienGiaDinh - nvarchar(40)
          'Dung'  -- LaHoNgheo - char(4)
        )
GO

INSERT dbo.HO_DAN
        ( MaHoDan ,
          HoTenChuHo ,
          ToDanPho ,
          KhoiHoacThon ,
          SoDienThoai ,
          DiaChiNha ,
          SoNhanKhau ,
          DienGiaDinh ,
          LaHoNgheo
        )
VALUES  ( 'HD004' , -- MaHoDan - char(5)
          N'Tran Van B4' , -- HoTenChuHo - nvarchar(30)
          13 , -- ToDanPho - int
          7 , -- KhoiHoacThon - int
          '0915222003' , -- SoDienThoai - varchar(11)
          N'12 Phan Chu Trinh' , -- DiaChiNha - nvarchar(40)
          1 , -- SoNhanKhau - int
          N'Me VNAH' , -- DienGiaDinh - nvarchar(40)
          'Dung'  -- LaHoNgheo - char(4)
        )
GO


-- 6) DOT_NHAN_UNG_HO:
INSERT dbo.DOT_NHAN_UNG_HO
        ( MaDotNhanUngHo ,
          MaHoDan ,
          NgayNhanUngHo
        )
VALUES  ( 'NhanUH001' , -- MaDotNhanUngHo - char(9)
          'HD003' , -- MaHoDan - char(5)
          '20161111'  -- NgayNhanUngHo - date
        )
GO 

INSERT dbo.DOT_NHAN_UNG_HO
        ( MaDotNhanUngHo ,
          MaHoDan ,
          NgayNhanUngHo
        )
VALUES  ( 'NhanUH002' , -- MaDotNhanUngHo - char(9)
          'HD001' , -- MaHoDan - char(5)
          '20161118'  -- NgayNhanUngHo - date
        )
GO

INSERT dbo.DOT_NHAN_UNG_HO
        ( MaDotNhanUngHo ,
          MaHoDan ,
          NgayNhanUngHo
        )
VALUES  ( 'NhanUH003' , -- MaDotNhanUngHo - char(9)
          'HD003' , -- MaHoDan - char(5)
          '20161120'  -- NgayNhanUngHo - date
        )
GO

-- 7) CHI_TIET_NHAN_UNG_HO:
INSERT dbo.CHI_TIET_NHAN_UNG_HO
        ( MaDotNhanUngHo ,
          MaHinhThucUH ,
          SoLuongNhanUngHo ,
          DonViTinh
        )
VALUES  ( 'NhanUH001' , -- MaDotNhanUngHo - char(9)
          'HT01' , -- MaHinhThucUH - char(4)
          5000 , -- SoLuongNhanUngHo - money
          'USD'  -- DonViTinh - varchar(5)
        )
GO

INSERT dbo.CHI_TIET_NHAN_UNG_HO
        ( MaDotNhanUngHo ,
          MaHinhThucUH ,
          SoLuongNhanUngHo ,
          DonViTinh
        )
VALUES  ( 'NhanUH001' , -- MaDotNhanUngHo - char(9)
          'HT02' , -- MaHinhThucUH - char(4)
          50 , -- SoLuongNhanUngHo - money
          'Thung'  -- DonViTinh - varchar(5)
        )
GO 

INSERT dbo.CHI_TIET_NHAN_UNG_HO
        ( MaDotNhanUngHo ,
          MaHinhThucUH ,
          SoLuongNhanUngHo ,
          DonViTinh
        )
VALUES  ( 'NhanUH002' , -- MaDotNhanUngHo - char(9)
          'HT03' , -- MaHinhThucUH - char(4)
          100 , -- SoLuongNhanUngHo - money
          'Bo'  -- DonViTinh - varchar(5)
        )
GO

INSERT dbo.CHI_TIET_NHAN_UNG_HO
        ( MaDotNhanUngHo ,
          MaHinhThucUH ,
          SoLuongNhanUngHo ,
          DonViTinh
        )
VALUES  ( 'NhanUH003' , -- MaDotNhanUngHo - char(9)
          'HT01' , -- MaHinhThucUH - char(4)
          10000000 , -- SoLuongNhanUngHo - money
          'VND'  -- DonViTinh - varchar(5)
        )
GO

INSERT dbo.CHI_TIET_NHAN_UNG_HO
        ( MaDotNhanUngHo ,
          MaHinhThucUH ,
          SoLuongNhanUngHo ,
          DonViTinh
        )
VALUES  ( 'NhanUH003' , -- MaDotNhanUngHo - char(9)
          'HT02' , -- MaHinhThucUH - char(4)
          25 , -- SoLuongNhanUngHo - money
          'Thung'  -- DonViTinh - varchar(5)
        )
GO

INSERT dbo.CHI_TIET_NHAN_UNG_HO
        ( MaDotNhanUngHo ,
          MaHinhThucUH ,
          SoLuongNhanUngHo ,
          DonViTinh
        )
VALUES  ( 'NhanUH003' , -- MaDotNhanUngHo - char(9)
          'HT03' , -- MaHinhThucUH - char(4)
          70 , -- SoLuongNhanUngHo - money
          'Bo'  -- DonViTinh - varchar(5)
        )
GO