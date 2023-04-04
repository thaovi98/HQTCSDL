--VIEW1
GO
CREATE VIEW View1 AS
SELECT*FROM Hangsx;
SELECT*FROM Nhanvien;
SELECT*FROM Sanpham;
SELECT*FROM Nhap;
SELECT*FROM Xuat;
GO 
SELECT*FROM View1
--VIEW2
GO
CREATE VIEW View2 AS
SELECT*FROM Sanpham ORDER BY giaban DESC;
GO 
SELECT*FROM View2
--VIEW3
GO
CREATE VIEW View3 AS
SELECT tensp FROM Sanpham,Hangsx WHERE Sanpham.mahangsx=Hangsx.Mahangsx;
GO
SELECT*FROM View3
--VIEW4
GO
CREATE VIEW View4 AS
SELECT*FROM Nhanvien WHERE(Gioitinh='Nữ') AND (Phong='Kế toán');
GO
SELECT*FROM View4
--VIEW5
GO
CREATE VIEW View5 AS
SELECT Sohdn, Sanpham.masp, tensp, Tenhang, soluongN, dongiaN, tiennhap=soluongN*dongiaN,mausac,donvitinh,Ngaynhap,Tennv,Phong
FROM Sanpham inner join Hangsx 
ON Sanpham.mahangsx = Hangsx.mahangsx, Nhanvien inner join Nhap  ON Nhanvien.manv = Nhap.manv
ORDER BY dongiaN ASC;
GO
SELECT*FROM View5
--VIEW6
GO
CREATE VIEW View6 AS
SELECT Sohdx,Sanpham.masp, tensp, Tenhang, soluongX, giaban, tienxuat=soluongX*giaban,mausac,donvitinh,Ngayxuat,Tennv,Phong
FROM Sanpham inner join Hangsx 
ON Sanpham.mahangsx = Hangsx.mahangsx, Nhanvien inner join Xuat  ON Nhanvien.manv = Xuat.manv 
WHERE (NgayXuat>='2018/10/1') AND (NgayXuat<='2018/10/31')
ORDER BY sohdx ASC;
GO
SELECT*FROM View6
--VIEW7
GO
CREATE VIEW View7 AS
SELECT Sohdn,Sanpham.masp,tensp,soluongN,dongiaN, Ngaynhap,Tennv,Phong
FROM Nhap
JOIN Sanpham ON Nhap.Masp =Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.Mahangsx
JOIN Nhanvien ON.Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND YEAR(Ngaynhap)=2017
GO
SELECT*FROM View7
--VIEW9
GO
CREATE VIEW View9 AS
SELECT TOP(10) tenSP, giaBan FROM SanPham ORDER BY giaBan DESC;
GO
SELECT*FROM View9
--VIEW10
GO
CREATE VIEW View10 AS
SELECT * FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000
GO
SELECT*FROM View10
--VIEW11
GO
CREATE VIEW View11 AS
SELECT SUM(SoluongN * DongiaN) AS TongTien FROM Nhap
JOIN Sanpham ON Nhap.Masp=Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx=Hangsx.Mahangsx
WHERE Hangsx.Tenhang= 'Samsung' AND YEAR(Ngaynhap) = 2018
GO
SELECT*FROM View11
--VIEW12
GO
CREATE VIEW View12 AS
SELECT SUM(Xuat.SoluongX * Sanpham.Giaban) AS TongTien FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp = Sanpham.Masp
WHERE Xuat.Ngayxuat = '2018-09-02'
GO
SELECT*FROM View12
--VIEW13
GO
CREATE VIEW View13 AS
SELECT TOP 1 Sohdn, Ngaynhap, DongiaN FROM Nhap ORDER BY DongiaN DESC
GO
SELECT*FROM View13
--VIEW14
GO
CREATE VIEW View14 AS
SELECT TOP 10 Sanpham.Tensp, SUM(Nhap.SoluongN) AS TongSoLuongN FROM Sanpham 
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp 
WHERE YEAR(Nhap.Ngaynhap) = 2019 
GROUP BY Sanpham.Tensp 
ORDER BY TongSoLuongN DESC
GO
SELECT*FROM View14
--VIEW15
GO
CREATE VIEW View15 AS
SELECT Sanpham.Masp, Sanpham.Tensp FROM Sanpham
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp
INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND Nhanvien.Manv = 'NV01';
GO
SELECT*FROM View15
--VIEW16
GO
CREATE VIEW View16 AS
SELECT Sohdn, Masp, SoluongN, Ngaynhap FROM Nhap WHERE Masp = 'SP02' AND Manv = 'NV02'
GO
SELECT*FROM View16
--VIEW17
GO
CREATE VIEW View17 AS
SELECT Nhanvien.manv, Nhanvien.tennv FROM Nhanvien
JOIN Xuat ON Nhanvien.Manv = Xuat.Manv
WHERE Xuat.Masp = 'SP02' AND Xuat.Ngayxuat = '2020-03-02'
GO
SELECT*FROM View17
--VIEW18
GO
CREATE VIEW View18 AS
SELECT COUNT(*) as N'loaisanpham' FROM Hangsx GROUP BY Hangsx.Tenhang
GO
SELECT*FROM View18
--VIEW19
GO
CREATE VIEW View19 AS
SELECT COUNT(*) as N'tongtiennhap' FROM Nhap WHERE YEAR( Ngaynhap )=2018 GROUP BY Masp
GO
SELECT*FROM View19
--VIEW20
GO
CREATE VIEW View20 AS
SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) as tong_soluong_xuat
FROM Sanpham
JOIN Xuat ON Sanpham.masp = Xuat.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Ngayxuat) = 2018 AND Hangsx.tenhang = 'Samsung'
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000
GO
SELECT*FROM View20
--VIEW21
GO
CREATE VIEW View21 AS
SELECT COUNT(*) as N'soluongnhanvien' FROM Nhanvien WHERE Gioitinh = 'Nam' GROUP BY Phong
GO
SELECT*FROM View21
--VIEW22
GO
CREATE VIEW View22 AS
SELECT COUNT(*) as N'tongsoluongnhap' FROM Nhap 
JOIN Sanpham ON Nhap.Masp = Sanpham.masp 
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.Mahangsx 
WHERE YEAR( Ngaynhap )=2018 GROUP BY Hangsx.Tenhang
GO
SELECT*FROM View22
--VIEW23
GO
CREATE VIEW View23 AS
SELECT COUNT(*) as N'tongluongtienxuat' FROM Xuat WHERE YEAR( Ngayxuat )=2018 GROUP BY Manv
GO
SELECT*FROM View23
--VIEW24
GO
CREATE VIEW View24 AS
SELECT manv, SUM(soluongN * dongiaN) AS tong_tien_nhap FROM Nhap 
WHERE MONTH(ngaynhap) = 8 AND YEAR(ngaynhap) = 2018
GROUP BY manv
HAVING SUM(soluongN * dongiaN) > 100000;
GO
SELECT*FROM View24
--VIEW25
GO
CREATE VIEW View25 AS
SELECT SanPham.masp, SanPham.tensp FROM SanPham WHERE SanPham.masp NOT IN (SELECT masp FROM Xuat)
GO
SELECT*FROM View25
--VIEW26
GO
CREATE VIEW View26 AS
SELECT DISTINCT SanPham.masp, SanPham.tensp
FROM Nhap inner join SanPham on Nhap.Masp=SanPham.masp inner join Xuat on SanPham.masp=Xuat.Masp
WHERE YEAR(Nhap.NgayNhap) = '2018' and YEAR(Xuat.NgayXuat) = '2018'
GO
SELECT*FROM View26
--VIEW27
GO
CREATE VIEW View27 AS
SELECT DISTINCT NhanVien.Manv, NhanVien.Tennv
FROM Nhap inner join Nhanvien on Nhap.Manv=Nhanvien.Manv inner join Xuat on Nhanvien.Manv=Xuat.Manv
GO
SELECT*FROM View27
--VIEW28
GO
CREATE VIEW View28 AS
SELECT Nhanvien.Manv, Nhanvien.Tennv, Nhanvien.Sodt, Nhanvien.Diachi, Nhanvien.email, Nhanvien.Gioitinh, Nhanvien.Phong
FROM Nhap inner join Nhanvien on Nhap.Manv=Nhanvien.Manv inner join Xuat on Nhanvien.Manv=Xuat.Manv
WHERE Nhap.Manv is null and Xuat.Manv is null
GO
SELECT*FROM View28