USE [master]
GO
/****** Object:  Database [sem4labs]    Script Date: 09/24/2017 18:18:25 ******/
CREATE DATABASE [sem4labs] ON  PRIMARY 
( NAME = N'sem4labs', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\sem4labs.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'sem4labs_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\sem4labs_log.LDF' , SIZE = 768KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [sem4labs] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sem4labs].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sem4labs] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [sem4labs] SET ANSI_NULLS OFF
GO
ALTER DATABASE [sem4labs] SET ANSI_PADDING OFF
GO
ALTER DATABASE [sem4labs] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [sem4labs] SET ARITHABORT OFF
GO
ALTER DATABASE [sem4labs] SET AUTO_CLOSE ON
GO
ALTER DATABASE [sem4labs] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [sem4labs] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [sem4labs] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [sem4labs] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [sem4labs] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [sem4labs] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [sem4labs] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [sem4labs] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [sem4labs] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [sem4labs] SET  ENABLE_BROKER
GO
ALTER DATABASE [sem4labs] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [sem4labs] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [sem4labs] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [sem4labs] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [sem4labs] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [sem4labs] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [sem4labs] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [sem4labs] SET  READ_WRITE
GO
ALTER DATABASE [sem4labs] SET RECOVERY SIMPLE
GO
ALTER DATABASE [sem4labs] SET  MULTI_USER
GO
ALTER DATABASE [sem4labs] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [sem4labs] SET DB_CHAINING OFF
GO
USE [sem4labs]
GO
/****** Object:  Table [dbo].[days_week]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[days_week](
	[dayID] [int] IDENTITY(1,1) NOT NULL,
	[dayName] [varchar](50) NULL,
	[keyword] [varchar](50) NULL,
 CONSTRAINT [PK_days_week] PRIMARY KEY CLUSTERED 
(
	[dayID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[days_week] ON
INSERT [dbo].[days_week] ([dayID], [dayName], [keyword]) VALUES (1, N'MONDAY', N'MON')
INSERT [dbo].[days_week] ([dayID], [dayName], [keyword]) VALUES (2, N'TUESDAY', N'TUE')
INSERT [dbo].[days_week] ([dayID], [dayName], [keyword]) VALUES (3, N'WEDNESDAY', N'WED')
INSERT [dbo].[days_week] ([dayID], [dayName], [keyword]) VALUES (4, N'THURSDAY', N'THU')
INSERT [dbo].[days_week] ([dayID], [dayName], [keyword]) VALUES (5, N'FRIDAY', N'FRI')
INSERT [dbo].[days_week] ([dayID], [dayName], [keyword]) VALUES (6, N'SATURDAY', N'SAT')
SET IDENTITY_INSERT [dbo].[days_week] OFF
/****** Object:  Table [dbo].[tbl_class]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_class](
	[classID] [int] IDENTITY(1,1) NOT NULL,
	[className] [varchar](225) NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_tbl_class] PRIMARY KEY CLUSTERED 
(
	[classID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_class] ON
INSERT [dbo].[tbl_class] ([classID], [className], [status]) VALUES (49, N'VB2K18', 0)
INSERT [dbo].[tbl_class] ([classID], [className], [status]) VALUES (50, N'VB2K19', 1)
INSERT [dbo].[tbl_class] ([classID], [className], [status]) VALUES (54, N'VB2K20', 0)
INSERT [dbo].[tbl_class] ([classID], [className], [status]) VALUES (55, N'VB2K21', 0)
SET IDENTITY_INSERT [dbo].[tbl_class] OFF
/****** Object:  Table [dbo].[tbl_category]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_category](
	[cateID] [int] IDENTITY(1,1) NOT NULL,
	[cateName] [varchar](225) NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_tbl_category] PRIMARY KEY CLUSTERED 
(
	[cateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_category] ON
INSERT [dbo].[tbl_category] ([cateID], [cateName], [status]) VALUES (1, N'Thiet bi Van Phong', 1)
INSERT [dbo].[tbl_category] ([cateID], [cateName], [status]) VALUES (2, N'Dien Lanh', 1)
INSERT [dbo].[tbl_category] ([cateID], [cateName], [status]) VALUES (3, N'May Tinh', 1)
INSERT [dbo].[tbl_category] ([cateID], [cateName], [status]) VALUES (10, N'Nghe Nhin', 1)
INSERT [dbo].[tbl_category] ([cateID], [cateName], [status]) VALUES (11, N'Ngoai vi', 1)
SET IDENTITY_INSERT [dbo].[tbl_category] OFF
/****** Object:  Table [dbo].[tbl_labroom]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_labroom](
	[roomID] [int] IDENTITY(1,1) NOT NULL,
	[roomName] [varchar](225) NULL,
	[status] [tinyint] NULL,
	[width] [float] NULL,
	[length] [float] NULL,
	[datecreate] [date] NULL,
 CONSTRAINT [PK_tbl_labroom] PRIMARY KEY CLUSTERED 
(
	[roomID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_labroom] ON
INSERT [dbo].[tbl_labroom] ([roomID], [roomName], [status], [width], [length], [datecreate]) VALUES (1, N'LAB 1 - H7', 1, 60, 60, CAST(0x213D0B00 AS Date))
INSERT [dbo].[tbl_labroom] ([roomID], [roomName], [status], [width], [length], [datecreate]) VALUES (2, N'LAB 2 - H8', 1, 65, 60, CAST(0x213D0B00 AS Date))
INSERT [dbo].[tbl_labroom] ([roomID], [roomName], [status], [width], [length], [datecreate]) VALUES (3, N'LAB 4 - H10', 0, 43, 39, CAST(0x213D0B00 AS Date))
INSERT [dbo].[tbl_labroom] ([roomID], [roomName], [status], [width], [length], [datecreate]) VALUES (8, N'LAB 3 - H9', 1, 45.3, 56.6, CAST(0x213D0B00 AS Date))
INSERT [dbo].[tbl_labroom] ([roomID], [roomName], [status], [width], [length], [datecreate]) VALUES (9, N'LAB 6 - H11', 1, 34, 56, CAST(0x213D0B00 AS Date))
INSERT [dbo].[tbl_labroom] ([roomID], [roomName], [status], [width], [length], [datecreate]) VALUES (10, N'LAB 7 - H12', 0, 34, 56, CAST(0x213D0B00 AS Date))
INSERT [dbo].[tbl_labroom] ([roomID], [roomName], [status], [width], [length], [datecreate]) VALUES (11, N'LAB 8 - H13', 1, 450, 400, CAST(0x213D0B00 AS Date))
SET IDENTITY_INSERT [dbo].[tbl_labroom] OFF
/****** Object:  Table [dbo].[tbl_department]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_department](
	[departmentID] [int] IDENTITY(1,1) NOT NULL,
	[departmentName] [varchar](225) NULL,
 CONSTRAINT [PK_tbl_department] PRIMARY KEY CLUSTERED 
(
	[departmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_department] ON
INSERT [dbo].[tbl_department] ([departmentID], [departmentName]) VALUES (1, N'Admin')
INSERT [dbo].[tbl_department] ([departmentID], [departmentName]) VALUES (2, N'Instructors')
INSERT [dbo].[tbl_department] ([departmentID], [departmentName]) VALUES (3, N'Technical   Staff   ')
INSERT [dbo].[tbl_department] ([departmentID], [departmentName]) VALUES (4, N'Students')
SET IDENTITY_INSERT [dbo].[tbl_department] OFF
/****** Object:  Table [dbo].[tbl_type_accessory]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_type_accessory](
	[typeID] [int] IDENTITY(1,1) NOT NULL,
	[type_accessory] [varchar](225) NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_tbl_type_accessory] PRIMARY KEY CLUSTERED 
(
	[typeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_type_accessory] ON
INSERT [dbo].[tbl_type_accessory] ([typeID], [type_accessory], [status]) VALUES (1, N'Software', 1)
INSERT [dbo].[tbl_type_accessory] ([typeID], [type_accessory], [status]) VALUES (2, N'Hardware', 1)
SET IDENTITY_INSERT [dbo].[tbl_type_accessory] OFF
/****** Object:  Table [dbo].[tbl_shiftname]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_shiftname](
	[shiftID] [int] IDENTITY(1,1) NOT NULL,
	[starttime] [time](7) NULL,
	[endtime] [time](7) NULL,
	[shiftname] [nvarchar](50) NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_tbl_shiftname] PRIMARY KEY CLUSTERED 
(
	[shiftID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_shiftname] ON
INSERT [dbo].[tbl_shiftname] ([shiftID], [starttime], [endtime], [shiftname], [status]) VALUES (1, CAST(0x07000C41DD3E0000 AS Time), CAST(0x0700DCC9A04F0000 AS Time), N'Tiết 1', 1)
INSERT [dbo].[tbl_shiftname] ([shiftID], [starttime], [endtime], [shiftname], [status]) VALUES (2, CAST(0x0700DCC9A04F0000 AS Time), CAST(0x0700AC5264600000 AS Time), N'Tiết 2', 1)
INSERT [dbo].[tbl_shiftname] ([shiftID], [starttime], [endtime], [shiftname], [status]) VALUES (3, CAST(0x070048F9F66C0000 AS Time), CAST(0x07001882BA7D0000 AS Time), N'Tiết 3', 1)
INSERT [dbo].[tbl_shiftname] ([shiftID], [starttime], [endtime], [shiftname], [status]) VALUES (4, CAST(0x07001882BA7D0000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), N'Tiết 4', 1)
INSERT [dbo].[tbl_shiftname] ([shiftID], [starttime], [endtime], [shiftname], [status]) VALUES (5, CAST(0x0700E80A7E8E0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), N'Tiết 5', 1)
INSERT [dbo].[tbl_shiftname] ([shiftID], [starttime], [endtime], [shiftname], [status]) VALUES (6, CAST(0x0700B893419F0000 AS Time), CAST(0x0700881C05B00000 AS Time), N'Tiết 6', 1)
INSERT [dbo].[tbl_shiftname] ([shiftID], [starttime], [endtime], [shiftname], [status]) VALUES (7, CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), N'Empty', 5)
SET IDENTITY_INSERT [dbo].[tbl_shiftname] OFF
/****** Object:  Table [dbo].[tbl_device]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_device](
	[dID] [int] IDENTITY(1,1) NOT NULL,
	[dName] [varchar](225) NULL,
	[warranty_to] [date] NULL,
	[warranty_from] [date] NULL,
	[description] [varchar](225) NULL,
	[status] [tinyint] NULL,
	[cateID] [int] NULL,
	[roomID] [int] NULL,
	[dateAdd] [date] NULL,
 CONSTRAINT [PK_tbl_device] PRIMARY KEY CLUSTERED 
(
	[dID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_device] ON
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (1, N'May Tinh Tran Anh', CAST(0x3A3E0B00 AS Date), CAST(0xCD3C0B00 AS Date), N'', 1, 3, 1, CAST(0xF2360B00 AS Date))
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (22, N'May Chieu', CAST(0x3A3E0B00 AS Date), CAST(0xCD3C0B00 AS Date), N'', 1, 1, 1, CAST(0x82380B00 AS Date))
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (23, N'TI VI', CAST(0x3A3E0B00 AS Date), CAST(0xCD3C0B00 AS Date), N'', 1, 1, 1, CAST(0x82380B00 AS Date))
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (24, N'Dieu Hoa', CAST(0x3A3E0B00 AS Date), CAST(0xCD3C0B00 AS Date), N'', 1, 2, 1, CAST(0x82380B00 AS Date))
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (25, N'Mic', CAST(0x3A3E0B00 AS Date), CAST(0xCD3C0B00 AS Date), N'', 1, 10, 2, CAST(0x82380B00 AS Date))
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (33, N'Quat Cay ', CAST(0x3A3E0B00 AS Date), CAST(0xCD3C0B00 AS Date), N'', 1, 2, 1, CAST(0x85380B00 AS Date))
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (34, N'May In', CAST(0x3A3E0B00 AS Date), CAST(0xA73F0B00 AS Date), N'', 1, 1, 1, CAST(0x85380B00 AS Date))
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (47, N'CPU', CAST(0x3A3E0B00 AS Date), CAST(0xCD3C0B00 AS Date), N'', 1, 3, 9, CAST(0x85380B00 AS Date))
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (48, N'Loa Cam Tay', CAST(0x013E0B00 AS Date), CAST(0xB33C0B00 AS Date), N'', 1, 1, 1, CAST(0xB33C0B00 AS Date))
INSERT [dbo].[tbl_device] ([dID], [dName], [warranty_to], [warranty_from], [description], [status], [cateID], [roomID], [dateAdd]) VALUES (49, N'Loa', CAST(0x203E0B00 AS Date), CAST(0xB33C0B00 AS Date), N'', 1, 10, 1, CAST(0xB33C0B00 AS Date))
SET IDENTITY_INSERT [dbo].[tbl_device] OFF
/****** Object:  Table [dbo].[tbl_user]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_user](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](225) NULL,
	[password] [varchar](225) NULL,
	[fullname] [nvarchar](225) NULL,
	[address] [nvarchar](225) NULL,
	[gender] [tinyint] NULL,
	[birthday] [datetime] NULL,
	[status] [tinyint] NULL,
	[departmentID] [int] NULL,
	[HOD] [tinyint] NULL,
	[Email] [varchar](225) NULL,
 CONSTRAINT [PK_tbl_member] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_user] ON
INSERT [dbo].[tbl_user] ([userID], [username], [password], [fullname], [address], [gender], [birthday], [status], [departmentID], [HOD], [Email]) VALUES (83, N'nguyensontung', N'tung1234', N'nguyen son tung', N'Hà Nội', 1, CAST(0x000084DC00000000 AS DateTime), 1, 1, 1, NULL)
INSERT [dbo].[tbl_user] ([userID], [username], [password], [fullname], [address], [gender], [birthday], [status], [departmentID], [HOD], [Email]) VALUES (86, N'letuantai', N'123456', N'lê tuấn tài', N'Hà Nội', 0, CAST(0x000084B000000000 AS DateTime), 1, 1, 1, N'tai@gmail.com')
INSERT [dbo].[tbl_user] ([userID], [username], [password], [fullname], [address], [gender], [birthday], [status], [departmentID], [HOD], [Email]) VALUES (87, N'nguyentuanloc', N'123456', N'Nguyễn Tuấn Lộc', N'Hà Nội', 0, CAST(0x000084B000000000 AS DateTime), 1, 1, 1, N'loc@gmail.com')
INSERT [dbo].[tbl_user] ([userID], [username], [password], [fullname], [address], [gender], [birthday], [status], [departmentID], [HOD], [Email]) VALUES (88, N'giaovien1', N'123456', N'Giáo viên 1', N'Hà Nội', 0, CAST(0x000084B000000000 AS DateTime), 1, 2, 1, N'giaovien1@gmail.com')
INSERT [dbo].[tbl_user] ([userID], [username], [password], [fullname], [address], [gender], [birthday], [status], [departmentID], [HOD], [Email]) VALUES (89, N'giaovien2', N'123456', N'Giáo viên 2', N'Hà Nội', 0, CAST(0x00009CF100000000 AS DateTime), 1, 2, 0, N'giaovien2@gmail.com')
INSERT [dbo].[tbl_user] ([userID], [username], [password], [fullname], [address], [gender], [birthday], [status], [departmentID], [HOD], [Email]) VALUES (90, N'kythuat1', N'123456', N'Kỹ thuật 1', N'Hà Nội', 0, CAST(0x00009CF100000000 AS DateTime), 1, 3, 1, N'kythuat1@gmail.com')
INSERT [dbo].[tbl_user] ([userID], [username], [password], [fullname], [address], [gender], [birthday], [status], [departmentID], [HOD], [Email]) VALUES (91, N'kythuat2', N'123456', N'Kỹ thuật 2', N'Hà Nội', 0, CAST(0x00009CF100000000 AS DateTime), 1, 3, 0, N'kythuat2@gmail.com')
INSERT [dbo].[tbl_user] ([userID], [username], [password], [fullname], [address], [gender], [birthday], [status], [departmentID], [HOD], [Email]) VALUES (92, N'hocvien1', N'123456', N'Học viên 1', N'Hà Nội', 0, CAST(0x00009CF100000000 AS DateTime), 1, 4, 1, N'hocvien1@gmail.com')
INSERT [dbo].[tbl_user] ([userID], [username], [password], [fullname], [address], [gender], [birthday], [status], [departmentID], [HOD], [Email]) VALUES (93, N'hocvien2', N'123456', N'Học viên 2', N'Hà Nội', 0, CAST(0x00009CF100000000 AS DateTime), 1, 4, 0, N'hocvien2@gmail.com')
SET IDENTITY_INSERT [dbo].[tbl_user] OFF
/****** Object:  Table [dbo].[tbl_datework]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_datework](
	[dateword] [datetime] NULL,
	[status] [tinyint] NULL,
	[datewordID] [int] IDENTITY(1,1) NOT NULL,
	[dayID] [int] NULL,
 CONSTRAINT [PK_tbl_datework] PRIMARY KEY CLUSTERED 
(
	[datewordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_datework] ON
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A75900000000 AS DateTime), 1, 345, 2)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A75A00000000 AS DateTime), 1, 346, 3)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A75B00000000 AS DateTime), 1, 347, 4)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A75C00000000 AS DateTime), 1, 348, 5)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A75D00000000 AS DateTime), 1, 349, 6)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A75F00000000 AS DateTime), 1, 350, 1)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7C800000000 AS DateTime), 1, 351, 1)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7C900000000 AS DateTime), 1, 352, 2)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7CA00000000 AS DateTime), 1, 353, 3)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7CB00000000 AS DateTime), 1, 354, 4)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7CC00000000 AS DateTime), 1, 355, 5)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7CD00000000 AS DateTime), 1, 356, 6)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7F900000000 AS DateTime), 1, 357, 1)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7FA00000000 AS DateTime), 1, 358, 2)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7FB00000000 AS DateTime), 1, 359, 3)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7FC00000000 AS DateTime), 1, 360, 4)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7FD00000000 AS DateTime), 1, 361, 5)
INSERT [dbo].[tbl_datework] ([dateword], [status], [datewordID], [dayID]) VALUES (CAST(0x0000A7FE00000000 AS DateTime), 1, 362, 6)
SET IDENTITY_INSERT [dbo].[tbl_datework] OFF
/****** Object:  Table [dbo].[tbl_accessory]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_accessory](
	[accessID] [int] IDENTITY(1,1) NOT NULL,
	[typeID] [int] NULL,
	[accessName] [varchar](225) NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_tbl_accessory] PRIMARY KEY CLUSTERED 
(
	[accessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_accessory] ON
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (1, 1, N'Photoshop', 0)
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (2, 2, N'Intel Core i3', 1)
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (3, 1, N'NetBean', 1)
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (4, 1, N'DreamWear', 1)
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (7, 2, N'Teamview', 0)
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (8, 1, N'SQL Sever', 1)
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (9, 1, N'My PHP', 1)
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (11, 1, N'TestAuto', 1)
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (12, 2, N'Intel Core i5', 1)
INSERT [dbo].[tbl_accessory] ([accessID], [typeID], [accessName], [status]) VALUES (13, 1, N'My SQL', 1)
SET IDENTITY_INSERT [dbo].[tbl_accessory] OFF
/****** Object:  Table [dbo].[tbl_complaint]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_complaint](
	[complaintID] [int] IDENTITY(1,1) NOT NULL,
	[userSend] [int] NULL,
	[status] [tinyint] NULL,
	[datesend] [date] NULL,
	[title] [varchar](225) NULL,
	[userProcess] [int] NULL,
 CONSTRAINT [PK_tbl_complaint] PRIMARY KEY CLUSTERED 
(
	[complaintID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_device_accessory]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_device_accessory](
	[dID] [int] NOT NULL,
	[accessID] [int] NOT NULL,
	[a_warranty_to] [date] NULL,
	[a_warranty_from] [date] NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_tbl_device_accessory] PRIMARY KEY CLUSTERED 
(
	[dID] ASC,
	[accessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (1, 1, CAST(0x01380B00 AS Date), CAST(0x3E380B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (22, 2, CAST(0x82380B00 AS Date), CAST(0xCA3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (22, 7, CAST(0x82380B00 AS Date), CAST(0xCA3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (23, 2, CAST(0x82380B00 AS Date), CAST(0xCA3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (23, 7, CAST(0x82380B00 AS Date), CAST(0xCA3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (24, 3, CAST(0x82380B00 AS Date), CAST(0xCA3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (24, 8, CAST(0x82380B00 AS Date), CAST(0xCA3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (25, 3, CAST(0x82380B00 AS Date), CAST(0xCA3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (25, 8, CAST(0x82380B00 AS Date), CAST(0xCA3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (33, 3, CAST(0x85380B00 AS Date), CAST(0xCD3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (33, 8, CAST(0x85380B00 AS Date), CAST(0xCD3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (34, 3, CAST(0x85380B00 AS Date), CAST(0xCD3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (34, 7, CAST(0x85380B00 AS Date), CAST(0xCD3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (34, 8, CAST(0x85380B00 AS Date), CAST(0xCD3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (47, 3, CAST(0x85380B00 AS Date), CAST(0xCD3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (47, 9, CAST(0x85380B00 AS Date), CAST(0xCD3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (47, 11, CAST(0x85380B00 AS Date), CAST(0xCD3C0B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (48, 2, CAST(0x943C0B00 AS Date), CAST(0xFB400B00 AS Date), 1)
INSERT [dbo].[tbl_device_accessory] ([dID], [accessID], [a_warranty_to], [a_warranty_from], [status]) VALUES (49, 9, CAST(0xB33C0B00 AS Date), CAST(0xFB400B00 AS Date), 1)
/****** Object:  Table [dbo].[tbl_contact]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_contact](
	[contactID] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](225) NULL,
	[contents] [varchar](max) NULL,
	[userID] [int] NULL,
 CONSTRAINT [PK_tbl_contact] PRIMARY KEY CLUSTERED 
(
	[contactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_schedule]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schedule](
	[scheduleID] [int] IDENTITY(1,1) NOT NULL,
	[shiftID] [int] NULL,
	[roomID] [int] NULL,
	[dateworkID] [int] NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_tbl_schedule] PRIMARY KEY CLUSTERED 
(
	[scheduleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_schedule] ON
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7003, 1, 1, 351, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7004, 2, 1, 351, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7005, 3, 1, 351, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7006, 4, 1, 351, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7007, 5, 1, 351, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7008, 6, 1, 351, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7009, 1, 1, 352, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7010, 2, 1, 352, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7011, 3, 1, 352, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7012, 4, 1, 352, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7013, 5, 1, 352, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7014, 6, 1, 352, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7015, 1, 1, 353, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7016, 2, 1, 353, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7017, 3, 1, 353, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7018, 4, 1, 353, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7019, 5, 1, 353, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7020, 6, 1, 353, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7021, 1, 1, 354, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7022, 2, 1, 354, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7023, 3, 1, 354, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7024, 4, 1, 354, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7025, 5, 1, 354, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7026, 6, 1, 354, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7027, 1, 1, 355, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7028, 2, 1, 355, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7029, 3, 1, 355, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7030, 4, 1, 355, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7031, 5, 1, 355, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7032, 6, 1, 355, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7033, 1, 1, 356, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7034, 2, 1, 356, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7035, 3, 1, 356, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7036, 4, 1, 356, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7037, 5, 1, 356, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7038, 6, 1, 356, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7039, 1, 8, 351, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7040, 2, 8, 351, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7041, 3, 8, 351, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7042, 4, 8, 351, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7043, 5, 8, 351, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7044, 6, 8, 351, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7045, 1, 8, 352, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7046, 2, 8, 352, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7047, 3, 8, 352, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7048, 4, 8, 352, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7049, 5, 8, 352, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7050, 6, 8, 352, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7051, 1, 8, 353, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7052, 2, 8, 353, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7053, 3, 8, 353, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7054, 4, 8, 353, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7055, 5, 8, 353, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7056, 6, 8, 353, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7057, 1, 8, 354, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7058, 2, 8, 354, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7059, 3, 8, 354, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7060, 4, 8, 354, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7061, 5, 8, 354, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7062, 6, 8, 354, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7063, 1, 8, 355, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7064, 2, 8, 355, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7065, 3, 8, 355, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7066, 4, 8, 355, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7067, 5, 8, 355, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7068, 6, 8, 355, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7069, 1, 8, 356, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7070, 2, 8, 356, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7071, 3, 8, 356, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7072, 4, 8, 356, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7073, 5, 8, 356, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7074, 6, 8, 356, 0)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7075, 1, 1, 357, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7076, 2, 1, 357, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7077, 3, 1, 357, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7078, 4, 1, 357, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7079, 5, 1, 357, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7080, 6, 1, 357, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7081, 1, 1, 358, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7082, 2, 1, 358, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7083, 3, 1, 358, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7084, 4, 1, 358, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7085, 5, 1, 358, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7086, 6, 1, 358, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7087, 1, 1, 359, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7088, 2, 1, 359, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7089, 3, 1, 359, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7090, 4, 1, 359, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7091, 5, 1, 359, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7092, 6, 1, 359, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7093, 1, 1, 360, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7094, 2, 1, 360, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7095, 3, 1, 360, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7096, 4, 1, 360, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7097, 5, 1, 360, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7098, 6, 1, 360, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7099, 1, 1, 361, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7100, 2, 1, 361, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7101, 3, 1, 361, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7102, 4, 1, 361, 1)
GO
print 'Processed 100 total records'
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7103, 5, 1, 361, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7104, 6, 1, 361, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7105, 1, 1, 362, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7106, 2, 1, 362, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7107, 3, 1, 362, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7108, 4, 1, 362, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7109, 5, 1, 362, 1)
INSERT [dbo].[tbl_schedule] ([scheduleID], [shiftID], [roomID], [dateworkID], [status]) VALUES (7110, 6, 1, 362, 1)
SET IDENTITY_INSERT [dbo].[tbl_schedule] OFF
/****** Object:  Table [dbo].[tbl_request]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_request](
	[requestID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NULL,
	[classID] [int] NULL,
	[scheduleID] [int] NULL,
	[courseName] [varchar](225) NULL,
	[sendDate] [datetime] NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_tbl_request] PRIMARY KEY CLUSTERED 
(
	[requestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_request] ON
INSERT [dbo].[tbl_request] ([requestID], [userID], [classID], [scheduleID], [courseName], [sendDate], [status]) VALUES (49, 92, 50, 7003, N'Co s? d? li?u', CAST(0x0000A7C600000000 AS DateTime), 1)
INSERT [dbo].[tbl_request] ([requestID], [userID], [classID], [scheduleID], [courseName], [sendDate], [status]) VALUES (50, 88, 50, 7003, N'PHP', CAST(0x0000A7C600000000 AS DateTime), 2)
INSERT [dbo].[tbl_request] ([requestID], [userID], [classID], [scheduleID], [courseName], [sendDate], [status]) VALUES (51, 88, 50, 7075, N'English 1', CAST(0x0000A7F700000000 AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[tbl_request] OFF
/****** Object:  Table [dbo].[tbl_complaint_device]    Script Date: 09/24/2017 18:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_complaint_device](
	[complaintID] [int] NOT NULL,
	[dID] [int] NOT NULL,
	[complaint_details] [varchar](225) NULL,
 CONSTRAINT [PK_tbl_complaint_device] PRIMARY KEY CLUSTERED 
(
	[complaintID] ASC,
	[dID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK_tbl_device_tbl_category]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_device]  WITH CHECK ADD  CONSTRAINT [FK_tbl_device_tbl_category] FOREIGN KEY([cateID])
REFERENCES [dbo].[tbl_category] ([cateID])
GO
ALTER TABLE [dbo].[tbl_device] CHECK CONSTRAINT [FK_tbl_device_tbl_category]
GO
/****** Object:  ForeignKey [FK_tbl_device_tbl_labroom]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_device]  WITH CHECK ADD  CONSTRAINT [FK_tbl_device_tbl_labroom] FOREIGN KEY([roomID])
REFERENCES [dbo].[tbl_labroom] ([roomID])
GO
ALTER TABLE [dbo].[tbl_device] CHECK CONSTRAINT [FK_tbl_device_tbl_labroom]
GO
/****** Object:  ForeignKey [FK_tbl_user_tbl_department]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_user]  WITH CHECK ADD  CONSTRAINT [FK_tbl_user_tbl_department] FOREIGN KEY([departmentID])
REFERENCES [dbo].[tbl_department] ([departmentID])
GO
ALTER TABLE [dbo].[tbl_user] CHECK CONSTRAINT [FK_tbl_user_tbl_department]
GO
/****** Object:  ForeignKey [FK_tbl_datework_days_week]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_datework]  WITH CHECK ADD  CONSTRAINT [FK_tbl_datework_days_week] FOREIGN KEY([dayID])
REFERENCES [dbo].[days_week] ([dayID])
GO
ALTER TABLE [dbo].[tbl_datework] CHECK CONSTRAINT [FK_tbl_datework_days_week]
GO
/****** Object:  ForeignKey [FK_tbl_accessory_tbl_type_accessory]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_accessory]  WITH CHECK ADD  CONSTRAINT [FK_tbl_accessory_tbl_type_accessory] FOREIGN KEY([typeID])
REFERENCES [dbo].[tbl_type_accessory] ([typeID])
GO
ALTER TABLE [dbo].[tbl_accessory] CHECK CONSTRAINT [FK_tbl_accessory_tbl_type_accessory]
GO
/****** Object:  ForeignKey [FK_tbl_complaint_tbl_user]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_complaint]  WITH CHECK ADD  CONSTRAINT [FK_tbl_complaint_tbl_user] FOREIGN KEY([userSend])
REFERENCES [dbo].[tbl_user] ([userID])
GO
ALTER TABLE [dbo].[tbl_complaint] CHECK CONSTRAINT [FK_tbl_complaint_tbl_user]
GO
/****** Object:  ForeignKey [FK_tbl_complaint_tbl_user1]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_complaint]  WITH CHECK ADD  CONSTRAINT [FK_tbl_complaint_tbl_user1] FOREIGN KEY([userProcess])
REFERENCES [dbo].[tbl_user] ([userID])
GO
ALTER TABLE [dbo].[tbl_complaint] CHECK CONSTRAINT [FK_tbl_complaint_tbl_user1]
GO
/****** Object:  ForeignKey [FK_tbl_device_accessory_tbl_accessory]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_device_accessory]  WITH CHECK ADD  CONSTRAINT [FK_tbl_device_accessory_tbl_accessory] FOREIGN KEY([accessID])
REFERENCES [dbo].[tbl_accessory] ([accessID])
GO
ALTER TABLE [dbo].[tbl_device_accessory] CHECK CONSTRAINT [FK_tbl_device_accessory_tbl_accessory]
GO
/****** Object:  ForeignKey [FK_tbl_device_accessory_tbl_device]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_device_accessory]  WITH CHECK ADD  CONSTRAINT [FK_tbl_device_accessory_tbl_device] FOREIGN KEY([dID])
REFERENCES [dbo].[tbl_device] ([dID])
GO
ALTER TABLE [dbo].[tbl_device_accessory] CHECK CONSTRAINT [FK_tbl_device_accessory_tbl_device]
GO
/****** Object:  ForeignKey [FK_tbl_contact_tbl_user]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_contact]  WITH CHECK ADD  CONSTRAINT [FK_tbl_contact_tbl_user] FOREIGN KEY([userID])
REFERENCES [dbo].[tbl_user] ([userID])
GO
ALTER TABLE [dbo].[tbl_contact] CHECK CONSTRAINT [FK_tbl_contact_tbl_user]
GO
/****** Object:  ForeignKey [FK_tbl_schedule_tbl_datework]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_schedule]  WITH CHECK ADD  CONSTRAINT [FK_tbl_schedule_tbl_datework] FOREIGN KEY([dateworkID])
REFERENCES [dbo].[tbl_datework] ([datewordID])
GO
ALTER TABLE [dbo].[tbl_schedule] CHECK CONSTRAINT [FK_tbl_schedule_tbl_datework]
GO
/****** Object:  ForeignKey [FK_tbl_schedule_tbl_labroom]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_schedule]  WITH CHECK ADD  CONSTRAINT [FK_tbl_schedule_tbl_labroom] FOREIGN KEY([roomID])
REFERENCES [dbo].[tbl_labroom] ([roomID])
GO
ALTER TABLE [dbo].[tbl_schedule] CHECK CONSTRAINT [FK_tbl_schedule_tbl_labroom]
GO
/****** Object:  ForeignKey [FK_tbl_schedule_tbl_shiftname]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_schedule]  WITH CHECK ADD  CONSTRAINT [FK_tbl_schedule_tbl_shiftname] FOREIGN KEY([shiftID])
REFERENCES [dbo].[tbl_shiftname] ([shiftID])
GO
ALTER TABLE [dbo].[tbl_schedule] CHECK CONSTRAINT [FK_tbl_schedule_tbl_shiftname]
GO
/****** Object:  ForeignKey [FK_tbl_request_tbl_class]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_request]  WITH CHECK ADD  CONSTRAINT [FK_tbl_request_tbl_class] FOREIGN KEY([classID])
REFERENCES [dbo].[tbl_class] ([classID])
GO
ALTER TABLE [dbo].[tbl_request] CHECK CONSTRAINT [FK_tbl_request_tbl_class]
GO
/****** Object:  ForeignKey [FK_tbl_request_tbl_schedule]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_request]  WITH CHECK ADD  CONSTRAINT [FK_tbl_request_tbl_schedule] FOREIGN KEY([scheduleID])
REFERENCES [dbo].[tbl_schedule] ([scheduleID])
GO
ALTER TABLE [dbo].[tbl_request] CHECK CONSTRAINT [FK_tbl_request_tbl_schedule]
GO
/****** Object:  ForeignKey [FK_tbl_request_tbl_user]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_request]  WITH CHECK ADD  CONSTRAINT [FK_tbl_request_tbl_user] FOREIGN KEY([userID])
REFERENCES [dbo].[tbl_user] ([userID])
GO
ALTER TABLE [dbo].[tbl_request] CHECK CONSTRAINT [FK_tbl_request_tbl_user]
GO
/****** Object:  ForeignKey [FK_tbl_complaint_device_tbl_complaint]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_complaint_device]  WITH CHECK ADD  CONSTRAINT [FK_tbl_complaint_device_tbl_complaint] FOREIGN KEY([complaintID])
REFERENCES [dbo].[tbl_complaint] ([complaintID])
GO
ALTER TABLE [dbo].[tbl_complaint_device] CHECK CONSTRAINT [FK_tbl_complaint_device_tbl_complaint]
GO
/****** Object:  ForeignKey [FK_tbl_complaint_device_tbl_device]    Script Date: 09/24/2017 18:18:27 ******/
ALTER TABLE [dbo].[tbl_complaint_device]  WITH CHECK ADD  CONSTRAINT [FK_tbl_complaint_device_tbl_device] FOREIGN KEY([dID])
REFERENCES [dbo].[tbl_device] ([dID])
GO
ALTER TABLE [dbo].[tbl_complaint_device] CHECK CONSTRAINT [FK_tbl_complaint_device_tbl_device]
GO
