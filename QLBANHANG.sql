use master
create database QLBANHANG
use QLBANHANG
drop database QLBANHANG

create table Sanpham
(
masp nchar(10)primary key,
mahangsx nchar(10) not null,
tensp nvarchar(20) not null,
soluong int not null,
mausac nvarchar(20) not null,
giaban money not null,
donvitinh nchar(10) not null,
mota nvarchar(max) not null
)
create table Hangsx
(
Mahangsx nchar(10) primary key,
Tenhang nvarchar(20) not null,
Diachi nvarchar(30) not null,
Sodt nvarchar(20) not null,
Email nvarchar(30) not null
)
create table Nhanvien
(
Manv nchar(10) primary key,
Tennv nvarchar(20) not null,
Gioitinh nchar(10) not null,
Diachi nvarchar(30) not null,
Sodt nvarchar(20) not null,
Email nvarchar(30) not null,
Phong nvarchar(30) not null
)
create table Nhap
(
Sohdn nchar(10) primary key,
Masp nchar(10) not null,
Manv nchar(10) not null,
Ngaynhap date not null,
soluongN int not null,
dongiaN money not null
)
create table Xuat
(
Sohdx nchar(10) not null, 
Masp nchar(10) not null,
Manv nchar(10) not null,
Ngayxuat date not null,
soluongX int not null,
CONSTRAINT Pk_Xuat PRIMARY KEY (Sohdx,Manv) 
)

Alter table Sanpham
Add
constraint fk_1 foreign key(mahangsx) references Hangsx(mahangsx)
on delete cascade
on update cascade
Alter table Nhap
Add
constraint fk_2 foreign key(masp) references Sanpham(masp)
on delete cascade
on update cascade
Alter table Nhap
Add
constraint fk_3 foreign key(manv) references Nhanvien(manv)
on delete cascade
on update cascade
Alter table Xuat
Add
constraint fk_4 foreign key(masp) references Sanpham(masp)
on delete cascade
on update cascade
Alter table Xuat
Add
constraint fk_5 foreign key(manv) references Nhanvien(manv)
on delete cascade
on update cascade

SELECT*FROM Hangsx
INSERT INTO Hangsx
VALUES('H01','Samsung','Korea','011-08271717','ss@gmail.com.kr')
INSERT INTO Hangsx
VALUES('H02','OPPO','China','081-08626262','oppo@gmail.com.cn')
INSERT INTO Hangsx
VALUES('H03','Vinfone','Việt Nam','084-098262626','vf@gmail.com.vn')

SELECT*FROM Nhanvien
INSERT INTO Nhanvien
VALUES('NV01','Nguyễn Thị Thu','Nữ','Hà Nội','0982626521','thu@gmail.com','Kế toán')
INSERT INTO Nhanvien
VALUES('NV02','Lê Văn Nam','Nam','Bắc Ninh','0972525252','nam@gmail.com','Vật tư')
INSERT INTO Nhanvien
VALUES('NV03','Trần Hoà Bình','Nữ','Hà Nội','0328388388','hb@gmail.com','Kế toán')

SELECT*FROM Sanpham
INSERT INTO Sanpham
VALUES('SP01','H02','F1 Plus','100','Xám','7000000','Chiếc','Hàng cận cao cấp')
INSERT INTO Sanpham
VALUES('SP02','H01','Galaxy Note 11','50','Đỏ','19000000','Chiếc','Hàng cao cấp')
INSERT INTO Sanpham
VALUES('SP03','H02','F3 lite','200','Nâu','3000000','Chiếc','Hàng phổ thông')
INSERT INTO Sanpham
VALUES('SP04','H03','Vjoy 3','200','Xám','15000000','Chiếc','Hàng phổ thông')
INSERT INTO Sanpham
VALUES('SP05','H01','Galaxy V21','500','Nâu','8000000','Chiếc','Hàng cận cao cấp')

SELECT*FROM Nhap
INSERT INTO Nhap
VALUES('N01','SP02','NV01','02/05/2019','10','17000000')
INSERT INTO Nhap
VALUES('N02','SP01','NV02','04/07/2020','30','6000000')
INSERT INTO Nhap
VALUES('N03','SP04','NV02','05/17/2020','20','12000000')
INSERT INTO Nhap
VALUES('N04','SP01','NV03','03/22/2020','10','62000000')
INSERT INTO Nhap
VALUES('N05','SP05','NV01','07/07/2020','20','7000000')

SELECT*FROM Xuat
INSERT INTO Xuat
VALUES('X01','SP03','NV02','06/14/2020','5')
INSERT INTO Xuat
VALUES('X02','SP01','NV03','03/05/2019','3')
INSERT INTO Xuat
VALUES('X03','SP02','NV01','12/12/2020','1')
INSERT INTO Xuat
VALUES('X04','SP03','NV02','06/02/2020','2')
INSERT INTO Xuat
VALUES('X05','SP05','NV01','05/18/2020','1')

--1. Hiển thị thông tin các bảng dữ liệu
SELECT*FROM Hangsx;
SELECT*FROM Nhanvien;
SELECT*FROM Sanpham;
SELECT*FROM Nhap;
SELECT*FROM Xuat;
--2. Đưa ra thông tin masp,tensp,tenhang,soluong,mausac,giaban,donvitinh,mota của các sản phẩm sắp xếp theo chiều giảm dần giá bán
SELECT*FROM Sanpham ORDER BY giaban DESC;
--3. Đưa ra thông tin các sản phẩm có trong cửa hàng do công ty có tên hãng là samsung sản xuất
SELECT tensp FROM Sanpham,Hangsx WHERE Sanpham.mahangsx=Hangsx.Mahangsx;
--4. Đưa ra thông tin các nhân viên Nữ ở phòng 'Kế toán'
SELECT*FROM Nhanvien WHERE(Gioitinh='Nữ') AND (Phong='Kế toán');
--5. Đưa ra thông tin phiếu nhập gồm: sohdn, masp, tensp, tenhang, soluongN, dongiaN, tiennhap=soluongN*dongiaN, mausac, donvitinh, ngaynhap, tennv, phong. Sắp xếp theo chiều tăng dần của hóa đơn nhập.
SELECT Sohdn, Sanpham.masp, tensp, Tenhang, soluongN, dongiaN, tiennhap=soluongN*dongiaN,mausac,donvitinh,Ngaynhap,Tennv,Phong
FROM Sanpham inner join Hangsx 
ON Sanpham.mahangsx = Hangsx.mahangsx, Nhanvien inner join Nhap  ON Nhanvien.manv = Nhap.manv
ORDER BY dongiaN ASC;
--6. Đưa ra thông tin phiếu xuất gồm: sohdx, masp, tensp, tenhang, soluongX, giaban, tienxuat=soluongX*giaban, mausac, donvitinh, ngayxuat, tennv, phong trong tháng 10 năm 2018, sắp xếp theo chiều tăng dần của sohdx.
SELECT Sohdx,Sanpham.masp, tensp, Tenhang, soluongX, giaban, tienxuat=soluongX*giaban,mausac,donvitinh,Ngayxuat,Tennv,Phong
FROM Sanpham inner join Hangsx 
ON Sanpham.mahangsx = Hangsx.mahangsx, Nhanvien inner join Xuat  ON Nhanvien.manv = Xuat.manv 
WHERE (NgayXuat>='2018/10/1') AND (NgayXuat<='2018/10/31')
ORDER BY sohdx ASC;
--7. Đưa ra các thông tin về các hóa đơn mà hãng samsung đã nhập trong năm 2017, gồm: sohdn, masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong.
SELECT Sohdn,Sanpham.masp,tensp,soluongN,dongiaN, Ngaynhap,Tennv,Phong
FROM Nhap
JOIN Sanpham ON Nhap.Masp =Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.Mahangsx
JOIN Nhanvien ON.Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND YEAR(Ngaynhap)=2017
--9. Đưa ra thông tin 10 sản phẩm có giá bán cao nhất trong cửa hàng, theo chiều giảm dần giá bán.
SELECT TOP(10) tenSP, giaBan FROM SanPham ORDER BY giaBan DESC;
--10. Đưa ra các thông tin sản phẩm có giá bán từ 100.000 đến 500.000 của hãng samsung.
SELECT * FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000
--11. Tính tổng tiền đã nhập trong năm 2018 của hãng samsung.
SELECT SUM(SoluongN * DongiaN) AS TongTien FROM Nhap
JOIN Sanpham ON Nhap.Masp=Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx=Hangsx.Mahangsx
WHERE Hangsx.Tenhang= 'Samsung' AND YEAR(Ngaynhap) = 2018
--12. Thống kê tổng tiền đã xuất trong ngày 2/9/2018
SELECT SUM(Xuat.SoluongX * Sanpham.Giaban) AS TongTien FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp = Sanpham.Masp
WHERE Xuat.Ngayxuat = '2018-09-02'
--13. Đưa ra sohdn, ngaynhap có tiền nhập phải trả cao nhất trong năm 2018
SELECT TOP 1 Sohdn, Ngaynhap, DongiaN FROM Nhap ORDER BY DongiaN DESC
--14. Đưa ra 10 mặt hàng có soluongN nhiều nhất trong năm 2019.
SELECT TOP 10 Sanpham.Tensp, SUM(Nhap.SoluongN) AS TongSoLuongN FROM Sanpham 
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp 
WHERE YEAR(Nhap.Ngaynhap) = 2019 
GROUP BY Sanpham.Tensp 
ORDER BY TongSoLuongN DESC
--15. Đưa ra masp,tensp của các sản phẩm do công ty ‘Samsung’ sản xuất do nhân viên có mã ‘NV01’ nhập.
SELECT Sanpham.Masp, Sanpham.Tensp FROM Sanpham
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp
INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND Nhanvien.Manv = 'NV01';
--16. Đưa ra sohdn,masp,soluongN,ngayN của mặt hàng có masp là ‘SP02’, được nhân viên ‘NV02′ xuất.
SELECT Sohdn, Masp, SoluongN, Ngaynhap FROM Nhap WHERE Masp = 'SP02' AND Manv = 'NV02'
--17. Đưa ra manv,tennv đã xuất mặt hàng có mã ‘SPO2′ ngày 03-02-2020.
SELECT Nhanvien.manv, Nhanvien.tennv FROM Nhanvien
JOIN Xuat ON Nhanvien.Manv = Xuat.Manv
WHERE Xuat.Masp = 'SP02' AND Xuat.Ngayxuat = '2020-03-02'