--1. Viết thủ tục thêm mới nhân viên bao gồm các tham số: manv, tennv, gioitinh, diachi, sodt, email, phong và 1 biển Flag, Nếu Flag=0 thì nhập mới, ngược lại thì cập nhật thông tin nhân viên theo mã. 
--Hãy kiểm tra:- gioitinh nhập vào có phải là Nam hoặc Nữ không, nếu không trả về mã lỗi 1. - Ngược lại nếu thỏa mãn thì cho phép nhập và trả về mã lỗi 0..
CREATE PROCEDURE sp_ThemMoiNhanVien
    @manv nchar(10),
    @tennv nvarchar(20),
    @gioitinh nchar(10),
    @diachi nvarchar(30),
    @sodt nvarchar(20),
    @email nvarchar(30),
    @phong nvarchar(30),
    @Flag nvarchar
AS
BEGIN
    SET NOCOUNT ON;
    IF (@gioitinh <> N'Nam' AND @gioitinh <> N'Nữ')
    BEGIN
        SELECT 1 AS 'Lỗi' 
        RETURN
    END
    IF (@Flag = 0)
    BEGIN
        INSERT INTO Nhanvien (Manv, Tennv, Gioitinh, Diachi, Sodt, Email, Phong)
        VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)

        SELECT 0 AS 'Lỗi'
        RETURN
    END
    ELSE 
    BEGIN
        UPDATE Nhanvien
        SET Tennv = @tennv,
            Gioitinh = @gioitinh,
            Diachi = @diachi,
            Sodt = @sodt,
            Email = @email,
            Phong = @phong
        WHERE Manv = @manv
        IF (@@ROWCOUNT > 0)
        BEGIN
            SELECT 0 AS 'Lỗi' 
            RETURN
        END
        ELSE
        BEGIN
            SELECT 2 AS 'Lỗi' 
            RETURN
        END
    END
END
--Lệnh thực thi
EXEC sp_ThemMoiNhanVien 'NV03','Trần Hoà Bình','Nữ','Hà Nội','0328388388','hb@gmail.com','Kế toán',1
--2. Viết thủ tục thêm mới sản phẩm với các tham biến masp, tenhang, tensp, soluong, mausac, giaban, donvitinh, mota và 1 biến Flag. Nếu Flag=0 thì thêm mới sản phẩm, ngược lại cập nhật sản phẩm. 
--Hãy kiểm tra:- Nếu tenhang không có trong bảng hangsx thì trả về mã lỗi 1 - Nếu soluong <0 thì trả về mã lỗi 2 - Ngược lại trả về mã lỗi 0.
CREATE PROCEDURE sp_ThemMoiSanPham
    @masp nchar(10),
	@tenhang nvarchar(20),
    @tensp nvarchar(20),
    @soluong nvarchar(30),
    @mausac nvarchar(20),
    @giaban money,
    @donvitinh nchar(10),
	@mota nvarchar(max),
    @Flag nvarchar
	AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra tên hãng sản xuất
    IF NOT EXISTS(SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        SELECT 1 AS 'MaLoi', 'Không tìm thấy hãng sản xuất' AS 'MoTaLoi'
        RETURN
    END

    -- Kiểm tra số lượng sản phẩm
    IF @soluong < 0
    BEGIN
        SELECT 2 AS 'MaLoi', 'Số lượng sản phẩm phải lớn hơn hoặc bằng 0' AS 'MoTaLoi'
        RETURN
    END

    -- Nếu chỉ là thêm mới sản phẩm
    IF @Flag = 0
    BEGIN
        INSERT INTO Sanpham (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES (@masp, (SELECT mahangsx FROM Hangsx WHERE tenhang = @tenhang), @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)

        SELECT 0 AS 'MaLoi', 'Thêm mới sản phẩm thành công' AS 'MoTaLoi'
    END
    ELSE -- Nếu chỉ là cập nhật sản phẩm
    BEGIN
        UPDATE Sanpham
        SET mahangsx = (SELECT mahangsx FROM Hangsx WHERE tenhang = @tenhang), 
            tensp = @tensp, 
            soluong = @soluong, 
            mausac = @mausac, 
            giaban = @giaban, 
            donvitinh = @donvitinh, 
            mota = @mota
        WHERE masp = @masp

        SELECT 0 AS 'MaLoi', 'Cập nhật sản phẩm thành công' AS 'MoTaLoi'
    END
END
--Lệnh thực thi
EXEC sp_ThemMoiSanPham 'H02','F1 Plus','100','Xám','7000000','Chiếc','Hàng cận cao cấp',1
--3. Viết thủ tục xóa dữ liệu bảng nhanvien với tham biến là many. Nếu many chưa có thì trả về 1, ngược lại xóa nhanvien với nhanvien bị xóa là many và trả về 0. (Lưu ý: xóa nhanvien thì phải xóa các bảng Nhập, Xuất mà nhân viên này tham gia). 
CREATE PROCEDURE usp_XoaNhanVien
    @manv nchar(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT * FROM Nhanvien WHERE Manv = @manv)
    BEGIN
        RETURN 1; 
    END

    DELETE FROM Nhap WHERE Manv = @manv;
    DELETE FROM Xuat WHERE Manv = @manv;


    DELETE FROM Nhanvien WHERE Manv = @manv;

    RETURN 0; 
END;
--Lệnh thực thi
EXEC usp_XoaNhanVien 'NV02';
--4. Viết thủ tục xóa dữ liệu bảng sanpham với tham biến là masp. Nếu masp chưa có thì trả về 1, ngược lại xóa sanpham với sanpham bị xóa là masp và trả về 0. (Lưu ý: xóa sanpham thì phải xóa các bảng Nhap, Xuat mà sanpham này cung ứng). 
CREATE PROCEDURE usp_XoaSanPham
    @masp nchar(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        RETURN 1; 
    END

    DELETE FROM Nhap WHERE Masp = @masp;
    DELETE FROM Xuat WHERE Masp = @masp;


    DELETE FROM Sanpham WHERE masp = @masp;

    RETURN 0; 
END;
--Lệnh thực thi
EXEC usp_XoaSanPham'SP04';
--5. Tạo thủ tục nhập liệu cho bảng Hangsx, với các tham biến truyền vào mahangsx, tenhang, diachi, sodt, email. Hãy kiểm tra xem tenhang đã tồn tại trước đó hay chưa, nếu rồi trả về mã lỗi 1? Nếu có rồi thì không cho nhập và trả về mã lỗi 0.
CREATE PROCEDURE sp_ThemHangsx1
   @mahangsx nchar (10),
   @tenhang nvarchar (20),
   @diachi nvarchar (20),
   @sodt nvarchar (20) ,
   @email nvarchar (30)
AS
BEGIN
     SET NOCOUNT ON;

        IF EXISTS (SELECT * FROM Hangsx WHERE Tenhang = @tenhang)
        BEGIN
        PRINT '1'
        RETURN
    END
        ELSE
        BEGIN
            PRINT 'Không được nhập mã lỗi 0'
        END
END
--Lệnh thực thi
EXEC dbo.spnhaphangsx 'H02','OPPO','China','081-08626262','oppo@gmail.com.cn'
--6. Viết thủ tục nhập dữ liệu cho bảng Nhap với các tham biến sohdn, masp, many, ngaynhap, soluongN, dongiaN. Kiểm tra xem masp có tồn tại trong bảng Sanpham hay không, nếu không trả về 1? many có tồn tại trong bảng nhanvien hay không nếu không trả về 2? ngược lại thì hãy kiểm tra: Nếu sohdn đã tồn tại thì cập nhật bảng Nhập theo sohdn, ngược lại thêm mới bảng Nhạp và trả về mã lỗi 0.
create proc [dbo].[spinsertNhap]
 @sohdn varchar(5),
 @masp varchar(5),
 @manv varchar(5),
 @ngaynhap date,
 @soluongN int,
 @dongiaN int
as
BEGIN
    -- Kiểm tra masp có tồn tại trong bảng Sanpham hay không
    IF NOT EXISTS(SELECT masp FROM Sanpham WHERE masp = @masp)
    BEGIN
        -- Trả về mã lỗi 1 nếu masp không tồn tại
        SELECT 1 AS ErrorCode
        RETURN
    END

    -- Kiểm tra manv có tồn tại trong bảng Nhanvien hay không
    IF NOT EXISTS(SELECT manv FROM Nhanvien WHERE manv = @manv)
    BEGIN
        -- Trả về mã lỗi 2 nếu manv không tồn tại
        SELECT 2 AS ErrorCode
        RETURN
    END

    -- Kiểm tra xem sohdn đã tồn tại chưa
    IF EXISTS(SELECT sohdn FROM Nhap WHERE sohdn = @sohdn)
    BEGIN
        -- Nếu đã tồn tại thì cập nhật bảng Nhap
        UPDATE Nhap
        SET masp = @masp, manv = @manv, ngaynhap = @ngaynhap, soluongN = @soluongN, dongiaN = @dongiaN
        WHERE sohdn = @sohdn
    END
    ELSE
    BEGIN
        -- Nếu chưa tồn tại thì thêm mới vào bảng Nhap
        INSERT INTO Nhap (sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
        VALUES (@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)
    END

    -- Trả về mã lỗi 0 nếu thực hiện thành công
    SELECT 0 AS ErrorCode
END
--Lệnh thực thi 
EXEC nl_NhapHang 'N01','SP02','NV01','02/05/2019','10','17000000';
--7. Viết thủ tục nhập dữ liệu cho bảng xuat với các tham biến sohdx, masp, many, ngayxuat, soluongX. Kiểm tra xem masp có tồn tại trong bảng Sanpham hay không nếu không trả về 1? many có tồn tại trong bảng nhanvien hay không nếu không trả về 2? soluongX<= Soluong nếu không trả về 3? ngược lại thì hãy kiểm tra: Nếu sohdx đã tồn tại thì cập nhật bảng Xuất theo sohdx, ngược lại thêm mới bảng Xuat và trả về mã lỗi 0
CREATE PROCEDURE spNhapDuLieuXuat 
    @sohdx VARCHAR(20),
    @masp VARCHAR(20),
    @manv VARCHAR(20),
    @ngayxuat DATE,
    @soluongX INT
	AS
BEGIN
    -- Kiểm tra mã sản phẩm có tồn tại trong bảng Sanpham hay không
    IF NOT EXISTS (SELECT * FROM Sanpham WHERE Masp = @masp)
    BEGIN
        RETURN 1; -- Trả về mã lỗi 1 nếu mã sản phẩm không tồn tại
    END
    
    -- Kiểm tra mã nhân viên có tồn tại trong bảng Nhanvien hay không
    IF NOT EXISTS (SELECT * FROM Nhanvien WHERE Manv = @manv)
    BEGIN
        RETURN 2; -- Trả về mã lỗi 2 nếu mã nhân viên không tồn tại
    END
    
    -- Kiểm tra số lượng xuất có lớn hơn 0 và không vượt quá số lượng sản phẩm tồn kho
    IF @soluongX <= 0 OR @soluongX > (SELECT Soluong FROM Sanpham WHERE Masp = @masp)
    BEGIN
        RETURN 3; -- Trả về mã lỗi 3 nếu số lượng xuất không hợp lệ
    END
    
    -- Kiểm tra nếu sohdx đã tồn tại thì cập nhật bảng Xuat, ngược lại thêm mới bảng Xuat
    IF EXISTS (SELECT * FROM Xuat WHERE Sohdx = @sohdx)
    BEGIN
        UPDATE Xuat
        SET Masp = @masp, Manv = @manv, Ngayxuat = @ngayxuat, SoluongX = @soluongX
        WHERE Sohdx = @sohdx;
    END
    ELSE
    BEGIN
        INSERT INTO Xuat (Sohdx, Masp, Manv, Ngayxuat, SoluongX)
        VALUES (@sohdx, @masp, @manv, @ngayxuat, @soluongX);
    END
    
    RETURN 0; -- Trả về mã lỗi 0 nếu thêm hoặc cập nhật bảng Xuat thành công
END
--Lệnh thực thi
EXEC nl_Xuat'X01','SP03','NV02','06/14/2020','5'

