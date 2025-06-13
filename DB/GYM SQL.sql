Create database Gym;

Create Table Plan_Type (
	Plan_Type_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	TypeofPlan varchar(255) NOT NULL
)

Create Table User_Type (
	User_Type_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	TypeofUser varchar(255) NOT NULL
)

Create Table Authentication_Role (
	Authentication_Role_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	Role varchar(255) NOT NULL
)

Create Table Authentication_Tbl (
	Authentication_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	Authentication_Role_ID int FOREIGN KEY REFERENCES Authentication_Role(Authentication_Role_ID),
	User_Type_ID int FOREIGN KEY REFERENCES User_Type(User_Type_ID)
)

Create Table User_Tbl (
	User_ID int IDENTITY (1, 1) NOT NULL ,
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NOT NULL,
	DateOfBirth date ,
	Gender varchar(255) NOT NULL,
	Email varchar(255) ,
	Phone varchar(255) ,
	Address varchar(255) ,
	Trainer_ID int ,
	Status varchar(255) default 'Inactive' ,
	User_Type_ID int FOREIGN KEY REFERENCES User_Type(User_Type_ID),
	CONSTRAINT "PK_User_Tbl" PRIMARY KEY  CLUSTERED ("User_ID"),
	CONSTRAINT "FK_User_Trainer" FOREIGN KEY("Trainer_ID") REFERENCES "dbo"."User_Tbl" ("User_ID"),
	CONSTRAINT "CK_Birthdate" CHECK (DateOfBirth < getdate())
)

Create index CurrentCard 
ON User_Tbl(User_ID);

Create Table Card_History (
	Card_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	Prev_Card varchar(255) unique ,
	User_ID int FOREIGN KEY REFERENCES User_Tbl(User_ID)
)

Create Table Plan_Tbl (
	Plan_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	Attachment image NOT NULL,
	Description text ,
	Duration date NOT NULL,
	Member_ID int FOREIGN KEY REFERENCES User_Tbl(User_ID),
	Trainer_ID int FOREIGN KEY REFERENCES User_Tbl(User_ID),
	Plan_Type_ID int FOREIGN KEY REFERENCES Plan_Type(Plan_Type_ID)
)

Create Table Attendance (
	Attendance_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	Entry_time datetime NOT NULL default getdate(),
	Exit_time datetime NOT NULL,
	User_ID int FOREIGN KEY REFERENCES User_Tbl(User_ID)
)

Create Table Transaction_Tbl (
	Transaction_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	TransactionDateTime datetime NOT NULL default getdate(),
	AmountPaid money NOT NULL,
	User_ID int FOREIGN KEY REFERENCES User_Tbl(User_ID)
)

Create Table MembershipSubscription (
	Subscription_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	Subscription_Name varchar(255) NOT NULL,
	Description text ,
	Duration int NOT NULL,
	Price money NOT NULL,
)

Create Table Membership (
	Membership_ID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
	Transaction_ID int,
	User_ID int FOREIGN KEY REFERENCES User_Tbl(User_ID),
	Subscription_ID int FOREIGN KEY REFERENCES MembershipSubscription(Subscription_ID),
)

Insert "User_Type"  Values('Member')
Insert "User_Type"  Values('Trainer')
Insert "User_Type"  Values('Admin')
Insert "User_Type"  Values('Receptionist')
Insert "User_Type"  Values('Guest')

Insert "User_Tbl"  Values('Mark' , 'John' ,'2000-04-20','Male',NULL,'01245440879','20 Alexandria Street Matrooh Egypt',NULL,'Inactive',2)
Insert "User_Tbl"  Values('Mina' , 'Safwat' ,'2004-06-30','Male',NULL,'01210446751','50 Alexandria Street Matrooh Egypt',1,'Inactive',1)

Insert "MembershipSubscription"  Values('30Day',NULL,30,300)

Insert "Membership"  Values('2024-04-25' , '2024-05-25' ,NULL,2,1)
go


