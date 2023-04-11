--Câu 1--
CREATE FUNCTION DanhSachSanPhamTheoHangSX (@tenHangSX varchar(50))
RETURNS TABLE
AS
RETURN
    SELECT SanPham.MaSP, SanPham.TenSP, SanPham.SoLuong, SanPham.MauSac, SanPham.GiaBan, SanPham.DonViTinh, SanPham.MoTa, HangSX.TenHang
    FROM SanPham
    INNER JOIN HangSX ON SanPham.MaHangSX = HangSX.MaHangSX
    WHERE HangSX.TenHang = @tenHangSX
SELECT * FROM DanhSachSanPhamTheoHangSX('SamSung')
--Câu 2--
CREATE FUNCTION DanhSachSanPhamNhap(@ngayX date, @ngayY date)
RETURNS TABLE
AS
RETURN
    SELECT sp.tensp, hs.tenhang, n.ngaynhap
    FROM Sanpham sp
    JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
    JOIN Nhap n ON sp.masp = n.masp
    WHERE n.ngaynhap >= @ngayX AND n.ngaynhap <= @ngayY
GO
SELECT * FROM DanhSachSanPhamNhap('2019-05-02', '2020-07-04')
--Câu 3--
CREATE FUNCTION LuaChon(@luachon int)
RETURNS @bang TABLE (tensp nvarchar(20), masp nvarchar(10),tenhang nvarchar(20), Soluong int)
AS
BEGIN
	IF @luachon = 0
	BEGIN
		INSERT INTO @bang 
			SELECT tensp, Sanpham.masp, tenhang, Soluong FROM Sanpham INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
			WHERE soluong < 0
	END
	IF @luachon = 1
	BEGIN
		INSERT INTO @bang
			SELECT tensp, Sanpham.masp, tenhang, Soluong FROM Sanpham INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
			WHERE soluong > 0
	END
	RETURN
END
--Câu 4--
CREATE FUNCTION ThongTinNV (@Phong nvarchar(30))
RETURNS TABLE RETURN
SELECT Tennv FROM Nhanvien
WHERE Nhanvien.Phong = @Phong
GO
SELECT *FROM ThongTinNV ('Vat tu')
--Câu 5--
CREATE FUNCTION dbo.fn_DanhSachHangSXTheoDiaChi
    (@dia_chi NVARCHAR(30))
RETURNS TABLE
AS
RETURN
    SELECT MAHANGSX, TENHANG, DIACHI, SDT, EMAIL
    FROM HANGSX
    WHERE DIACHI LIKE '%' + @dia_chi + '%';
SELECT*FROM fn_DanhSachHangSXTheoDiaChi (N'KOREA')
--Câu 6--
CREATE FUNCTION DSXuat (@x int, @y int)
RETURNS TABLE RETURN
SELECT Tenhang, tensp, soluongX
FROM Xuat INNER JOIN Sanpham ON Xuat.Masp = Sanpham.masp INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.Mahangsx
WHERE YEAR(Ngayxuat) BETWEEN @x AND @y
GO
SELECT * FROM DSXuat(2019, 2020)
--Câu 7--
CREATE FUNCTION dbo.fn_DanhSachHangSXTheoDiaChi
    (@dia_chi NVARCHAR(30))
RETURNS TABLE
AS
RETURN
    SELECT mahangsx,Tenhang,Diachi
    FROM Hangsx
    WHERE Diachi LIKE '%' + @dia_chi + '%';
--kt
SELECT*FROM fn_DanhSachHangSXTheoDiaChi (N'KOREA')
--Câu 8--
CREATE FUNCTION NVNhap (@x int)
RETURNS TABLE RETURN
SELECT Nhanvien.Manv, Tennv, Phong
FROM Nhanvien INNER JOIN Nhap ON Nhanvien.Manv = Nhap.Manv
WHERE DAY(Ngaynhap) = @x
GO
SELECT * FROM NVNhap (22)
--Câu 9--
CREATE FUNCTION DanhSachSanPham(
    @x FLOAT,
    @y FLOAT,
    @z NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN
SELECT Sanpham.masp, Sanpham.tensp, Sanpham.giaban, Hangsx.Tenhang,
FROM Sanpham
INNER JOIN Hangsx hs ON Sanpham.mahangsx = Hangsx.Mahangsx
WHERE Sanpham.giaban >= @x AND Sanpham.giaban <= @y AND Hangsx.Tenhang LIKE '%' + @z + '%'
SELECT * FROM DanhSachSanPham(1500000, 8000000, 'SamSung')
--Câu 10--
SELECT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang 
FROM Sanpham 
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx;