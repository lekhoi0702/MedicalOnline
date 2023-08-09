CREATE DATABASE HEALTHCARE;
GO

USE HEALTHCARE;
GO


CREATE TABLE KHACH_HANG (
	MAKH INT PRIMARY KEY IDENTITY,
	FIRST_NAME NVARCHAR(10) NOT NULL,
	LAST_NAME NVARCHAR(10) NOT NULL,
	NGAYSINH DATE NOT NULL,
	PHONE_NUMBER VARCHAR(20),
	EMAIL VARCHAR(100)
);

CREATE TABLE BAC_SI (
	MABS INT PRIMARY KEY IDENTITY,
	FIRST_NAME NVARCHAR(10) NOT NULL,
	LAST_NAME NVARCHAR(10) NOT NULL,
	NGAYSINH DATE NOT NULL,
	CHUYEN_KHOA NVARCHAR(50) NOT NULL,
	PHONE_NUMBER VARCHAR(20),
	EMAIL VARCHAR(100)
);

CREATE TABLE USERS (
	ID INT PRIMARY KEY IDENTITY,
	USERNAME VARCHAR(10) NOT NULL,
	PASSWRD VARCHAR(16) NOT NULL,
	ROLES INT NOT NULL,
	MABS INT,
	MAKH INT,
	FOREIGN KEY (MABS) REFERENCES BAC_SI(MABS),
	FOREIGN KEY (MAKH) REFERENCES KHACH_HANG(MAKH),
);

CREATE TABLE LICH_HEN(
	MALH INT PRIMARY KEY IDENTITY,
	MABS INT,
	MAKH INT,
	NGAY_HEN DATETIME NOT NULL,
	STATUS INT NOT NULL,
	FOREIGN KEY (MABS) REFERENCES BAC_SI(MABS),
	FOREIGN KEY (MAKH) REFERENCES KHACH_HANG(MAKH),
);

CREATE TABLE CHAN_DOAN (
	MACD INT PRIMARY KEY IDENTITY,
	MAKH INT,
	MABS INT,
	NGAY_KHAM DATETIME NOT NULL,
	KQ_KHAM NVARCHAR(100) NOT NULL,
	DON_THUOC NVARCHAR(100),
	FOREIGN KEY (MABS) REFERENCES BAC_SI(MABS),
	FOREIGN KEY (MAKH) REFERENCES KHACH_HANG(MAKH),
);

CREATE TABLE BAC_SI_INFO (
    MABS INT PRIMARY KEY,
    NUM_PATIENT INT,
    EXPERIENCE NVARCHAR(100),
    INTRODUCTION NVARCHAR(500),
    FOREIGN KEY (MABS) REFERENCES BAC_SI(MABS)
);
CREATE TABLE DANHGIA (
	MADG INT PRIMARY KEY IDENTITY,
	MALH INT,
	MAKH INT,
	MABS INT,
	MESSAGE NVARCHAR(500),
	THOIGIAN TIME
	FOREIGN KEY (MALH) REFERENCES LICH_HEN(MALH),
	FOREIGN KEY (MAKH) REFERENCES KHACH_HANG(MAKH),
	FOREIGN KEY (MABS) REFERENCES BAC_SI(MABS)

)

CREATE TABLE ADDCALL (
	ID INT PRIMARY KEY IDENTITY,
	MALH INT,
	MABS INT,
	MAKH INT,
	TOKEN NVARCHAR(500) NOT NULL,
	FOREIGN KEY (MALH) REFERENCES LICH_HEN(MALH),
	FOREIGN KEY (MABS) REFERENCES BAC_SI(MABS),
	FOREIGN KEY (MAKH) REFERENCES KHACH_HANG(MAKH)
)

ALTER TABLE ADDCALL ADD CHANNEL NVARCHAR(20) NOT NULL;
ALTER TABLE CHAN_DOAN ADD DANH_GIA_SAO INT;
ALTER TABLE BAC_SI ADD DANH_GIA REAL;
ALTER TABLE BAC_SI ADD GIOI_THIEU NVARCHAR(500);
ALTER TABLE BAC_SI ADD AVATAR NVARCHAR(500);
ALTER TABLE LICH_HEN ADD GIOHEN TIME
ALTER TABLE LICH_HEN ALTER COLUMN NGAY_HEN DATE
ALTER TABLE CHAN_DOAN ALTER COLUMN NGAY_KHAM DATE






