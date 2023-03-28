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