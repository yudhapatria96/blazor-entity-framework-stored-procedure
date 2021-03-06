USE [master]
GO
/****** Object:  Database [buatbelajar]    Script Date: 06/09/2021 08:12:25 ******/
CREATE DATABASE [buatbelajar]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'buatbelajar', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQL2016\MSSQL\DATA\buatbelajar.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'buatbelajar_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQL2016\MSSQL\DATA\buatbelajar_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [buatbelajar] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [buatbelajar].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [buatbelajar] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [buatbelajar] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [buatbelajar] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [buatbelajar] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [buatbelajar] SET ARITHABORT OFF 
GO
ALTER DATABASE [buatbelajar] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [buatbelajar] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [buatbelajar] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [buatbelajar] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [buatbelajar] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [buatbelajar] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [buatbelajar] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [buatbelajar] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [buatbelajar] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [buatbelajar] SET  ENABLE_BROKER 
GO
ALTER DATABASE [buatbelajar] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [buatbelajar] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [buatbelajar] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [buatbelajar] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [buatbelajar] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [buatbelajar] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [buatbelajar] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [buatbelajar] SET RECOVERY FULL 
GO
ALTER DATABASE [buatbelajar] SET  MULTI_USER 
GO
ALTER DATABASE [buatbelajar] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [buatbelajar] SET DB_CHAINING OFF 
GO
ALTER DATABASE [buatbelajar] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [buatbelajar] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [buatbelajar] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'buatbelajar', N'ON'
GO
ALTER DATABASE [buatbelajar] SET QUERY_STORE = OFF
GO
USE [buatbelajar]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [buatbelajar]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[Salary] [int] NULL,
	[DepartmentId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete Stored Procedure
Create procedure [dbo].[DeleteEmployee]
@ID int
as
Begin
     Delete from Employees where ID = @ID
End
GO
/****** Object:  StoredProcedure [dbo].[GetEmployees]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetEmployees]
as
begin
	Select ID, FirstName, LastName, Gender, Salary, DepartmentId
	from Employees
end
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeesByDepartment]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create procedure [dbo].[GetEmployeesByDepartment]
@DepartmentId int,
@DepartmentName nvarchar(50) out
as
Begin
     Select @DepartmentName = Name
     from Departments where ID = @DepartmentId

     Select * from Employees
     where DepartmentId = @DepartmentId

End
GO
/****** Object:  StoredProcedure [dbo].[InsertEmployee]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- Insert Stored Procedure
Create procedure [dbo].[InsertEmployee]
@FirstName nvarchar(50),
@LastName nvarchar(50),
@Gender nvarchar(50),
@Salary int,
@DepartmentId int
as
Begin
     Insert into Employees(FirstName, LastName, Gender, Salary, DepartmentId)
     values (@FirstName, @LastName, @Gender, @Salary, @DepartmentId)
End
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteEmployee]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_DeleteEmployee]
@empId int
AS
BEGIN
	DELETE Employees Where EmployeeId = @empId;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEmployeeById]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetEmployeeById]
@empId int 
AS
BEGIN
	SELECT * FROM Employees where EmployeeId = @empId;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEmployees]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetEmployees]
AS
BEGIN
	SELECT * FROM Employees
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertEmployee]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_InsertEmployee]
@empName varchar(200), 
@city varchar(200), 
@country varchar(200), 
@gender varchar(200)
AS
BEGIN
	INSERT INTO Employees(NAME, City, Country, Gender)
	VALUES(@empName, @city, @country, @gender)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateEmployee]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateEmployee]
@empId int,
@empName varchar(200), 
@city varchar(200), 
@country varchar(200), 
@gender varchar(200)
AS
BEGIN
	UPDATE Employees SET Name=@empName,City = @city, Country=@country, Gender=@gender where 
	EmployeeId=@empId;
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 06/09/2021 08:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update Stored Procedure
Create procedure [dbo].[UpdateEmployee]
@ID int,
@FirstName nvarchar(50),
@LastName nvarchar(50),
@Gender nvarchar(50),
@Salary int,
@DepartmentId int
as
Begin
     Update Employees Set
     FirstName = @FirstName, LastName = @LastName, Gender = @Gender,
     Salary = @Salary, DepartmentId = @DepartmentId
     where ID = @ID
End
GO
USE [master]
GO
ALTER DATABASE [buatbelajar] SET  READ_WRITE 
GO
