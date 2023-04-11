--Câu 1--
CREATE FUNCTION fn_DanhSachSanPhamTheoHang(@tenHang nvarchar(50))
RETURNS TABLE
AS
RETURN
SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Hangsx hs ON Sanpham.mahangsx = Hangsx.Mahangsx
WHERE Hangsx.Tenhang = @tenHang

SELECT * FROM DBO.fn_DanhSachSanPhamTheoHang(N'F1 Plus')
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
    SELECT mahangsx,Tenhang,Diachi
    FROM Hangsx
    WHERE Diachi LIKE '%' + @dia_chi + '%';
--kt
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
CREATE FUNCTION DANHSACHSANPHAM1 (@MAHANGSX NCHAR(10), @LUACHON INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT Sanpham.masp, Sanpham.tensp, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh,
        CASE 
            WHEN @LUACHON = 0 THEN Nhap.Ngaynhap
            WHEN @LUACHON = 1 THEN Xuat.Ngayxuat
        END AS 'NGAYNHAPXUAT'
    FROM SANPHAM SP
    LEFT JOIN Nhap BN ON Sanpham.masp = Nhap.Masp
    LEFT JOIN Xuat BX ON Sanpham.masp = Xuat.Masp
    WHERE SP.MAHANGSX = @MAHANGSX AND (@LUACHON = 0 OR @LUACHON = 1)
)
select * from DANHSACHSANPHAM1(N'H01',1)
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
SELECT sp.masp, sp.tensp, sp.giaban, hs.tenhang
FROM Sanpham sp
INNER JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
WHERE sp.giaban >= @x AND sp.giaban <= @y AND hs.tenhang LIKE '%' + @z + '%'
SELECT * FROM DanhSachSanPham(1500000, 8000000, 'SamSung')
--Câu 10--
SELECT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang 
FROM Sanpham 
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx;