/*
Created: 28-11-2019
Modified: 08-12-2019
Model: Microsoft SQL Server 2017
Database: MS SQL Server 2017
*/


-- Create tables section -------------------------------------------------

-- Table Appointment
-- CREATE DATABASE DentalOffice
USE DentalOffice
CREATE TABLE [Appointment]
(
 [AptID] Int NOT NULL,
 [AptDate] Date NOT NULL,
 [AptTime] Time NOT NULL,
 [AptStatus] Char(1) NOT NULL,
 [VisitReason] Varchar(max) NOT NULL,
 [PatientID] Int NOT NULL,
 [RoomID] Int NULL,
 [ProviderID] Int NULL
 CONSTRAINT CHK_AptStatus CHECK (AptStatus IN ('N','O','X','C'))
)
go

-- Create indexes for table Appointment

CREATE INDEX [IX_Relationship3] ON [Appointment] ([PatientID])
go

CREATE INDEX [IX_Relationship12] ON [Appointment] ([RoomID])
go

CREATE INDEX [IX_Relationship1] ON [Appointment] ([ProviderID])
go

-- Add keys for table Appointment

ALTER TABLE [Appointment] ADD CONSTRAINT [PK_Appointment] PRIMARY KEY ([AptID])
go

-- Table Patient

CREATE TABLE [Patient]
(
 [PatientID] Int NOT NULL,
 [PatientFN] Varchar(100) NOT NULL,
 [PatientLN] Varchar(100) NOT NULL,
 [PatientAddL1] Varchar(max) NOT NULL,
 [PatientAddL2] Varchar(max) NOT NULL,
 [PatientCity] Varchar(100) NOT NULL,
 [PatientState] Char(2) NOT NULL,
 [PatientZip] Int NOT NULL,
 [PatientPhone] Bigint NOT NULL,
 [PatientGender] Char(1) NOT NULL,
 [PatientDOB] Date NOT NULL,
 [PatientEmail] Varchar(100) NOT NULL,
 [PatientEmergencyName] Varchar(100) NOT NULL,
 [PatientEmergencyNo] Bigint NOT NULL
)
go

-- Add keys for table Patient

ALTER TABLE [Patient] ADD CONSTRAINT [PK_Patient] PRIMARY KEY ([PatientID])
go

-- Table TreatmentSummary

CREATE TABLE [TreatmentSummary]
(
 [TreatmentID] Int NOT NULL,
 [Notes] Varchar(max) NULL,
 [AppointmentID] Int NOT NULL,
 [TCID] Int NULL
)
go

-- Create indexes for table TreatmentSummary

CREATE INDEX [IX_Relationship2] ON [TreatmentSummary] ([AppointmentID])
go

CREATE INDEX [IX_Relationship9] ON [TreatmentSummary] ([TCID])
go

-- Add keys for table TreatmentSummary

ALTER TABLE [TreatmentSummary] ADD CONSTRAINT [PK_TreatmentSummary] PRIMARY KEY ([TreatmentID])
go

-- Table Prescription

CREATE TABLE [Prescription]
(
 [PrescriptionID] Int NOT NULL,
 [PrescriptionImage] Image NOT NULL,
 [Pharmacy] Varchar(100) NULL,
 [TreatmentID] Int NOT NULL
)
go

-- Create indexes for table Prescription

CREATE INDEX [IX_Relationship1] ON [Prescription] ([TreatmentID])
go

-- Add keys for table Prescription

ALTER TABLE [Prescription] ADD CONSTRAINT [PK_Prescription] PRIMARY KEY ([PrescriptionID])
go

-- Table PatientHistory

CREATE TABLE [PatientHistory]
(
 [PatientHistoryID] Int NOT NULL,
 [PatientGenHealth] Varchar(100) NULL,
 [PatientAllergy] Varchar(100) NULL,
 [PatientMedication] Varchar(200) NULL,
 [PatientBP] Char(6) NOT NULL,
 [PatientID] Int NOT NULL
)
go

-- Create indexes for table PatientHistory

CREATE INDEX [IX_Relationship6] ON [PatientHistory] ([PatientID])
go

-- Add keys for table PatientHistory

ALTER TABLE [PatientHistory] ADD CONSTRAINT [PK_PatientHistory] PRIMARY KEY ([PatientHistoryID])
go

-- Table Insurance

CREATE TABLE [Insurance]
(
 [InsuranceID] Int NOT NULL,
 [InsuranceNumber] Bigint NOT NULL,
 [InsuranceCompany] Varchar(100) NOT NULL,
 [PatientID] Int NULL
)
go

-- Create indexes for table Insurance

CREATE INDEX [IX_Relationship4] ON [Insurance] ([PatientID])
go

-- Add keys for table Insurance

ALTER TABLE [Insurance] ADD CONSTRAINT [PK_Insurance] PRIMARY KEY ([InsuranceID])
go

-- Table ExaminationRecord

CREATE TABLE [ExaminationRecord]
(
 [ExaminationRecordID] Int NOT NULL,
 [Plaque] Char(1) NOT NULL,
 [Stains] Char(1) NOT NULL,
 [Abrasions] Char(1) NOT NULL,
 [Overhang] Char(1) NOT NULL,
 [ContactPost] Char(1) NULL,
 [GumColour] Char(1) NOT NULL,
 [GumRecession] Char(1) NULL,
 [Pockets] Char(1) NOT NULL,
 [AppointmentID] Int NOT NULL
)
go

-- Create indexes for table ExaminationRecord

CREATE INDEX [IX_Relationship5] ON [ExaminationRecord] ([AppointmentID])
go

-- Add keys for table ExaminationRecord

ALTER TABLE [ExaminationRecord] ADD CONSTRAINT [PK_ExaminationRecord] PRIMARY KEY ([ExaminationRecordID])
go

-- Table TreatmentCatalog

CREATE TABLE [TreatmentCatalog]
(
 [TCID] Int NOT NULL,
 [TreatmentName] Varchar(150) NOT NULL,
 [TreatmentCharge] Float NOT NULL
)
go

-- Add keys for table TreatmentCatalog

ALTER TABLE [TreatmentCatalog] ADD CONSTRAINT [PK_TreatmentCatalog] PRIMARY KEY ([TCID])
go

-- Table TeethInformation

CREATE TABLE [TeethInformation]
(
 [TeethInfoID] Int NOT NULL,
 [TotalTeeth] Int NOT NULL,
 [FakeTeeth] Int DEFAULT 0 NOT NULL,
 [GenCondition] Varchar(255) NULL,
 [PatientID] Int NULL
)
go

-- Create indexes for table TeethInformation

CREATE INDEX [IX_Relationship7] ON [TeethInformation] ([PatientID])
go

-- Add keys for table TeethInformation

ALTER TABLE [TeethInformation] ADD CONSTRAINT [PK_TeethInformation] PRIMARY KEY ([TeethInfoID])
go

-- Table Provider

CREATE TABLE [Provider]
(
 [ProviderID] Int NOT NULL,
 [ProviderFN] Varchar(100) NOT NULL,
 [ProviderLN] Varchar(100) NOT NULL,
 [ProviderRole] Varchar(20) NOT NULL,
 [ProviderAddL1] Varchar(200) NOT NULL,
 [ProviderAddL2] Varchar(200) NOT NULL,
 [ProviderCity] Varchar(50) NOT NULL,
 [ProviderState] Varchar(50) NOT NULL,
 [ProviderZipCode] Int NOT NULL,
 [ProviderPhone] Bigint NOT NULL,
 [ProviderGender] Char(1) NOT NULL,
 [ProviderEmail] Varchar(50) NOT NULL,
 [ProviderDOB] Date NOT NULL
)
go

-- Add keys for table Provider

ALTER TABLE [Provider] ADD CONSTRAINT [PK_Provider] PRIMARY KEY ([ProviderID])
go

-- Table ConfidentialDocument

CREATE TABLE [ConfidentialDocument]
(
 [ConfDocID] Bigint NOT NULL,
 [SSN] Char(9) NOT NULL,
 [AccountNumber] Bigint NOT NULL,
 [RountingNumber] Bigint NOT NULL,
 [BankName] Char(100) NOT NULL,
 [TaxIDNumber] Bigint NOT NULL,
 [ProviderID] Int NULL
)
go

-- Create indexes for table ConfidentialDocument

CREATE INDEX [IX_Relationship3] ON [ConfidentialDocument] ([ProviderID])
go

-- Add keys for table ConfidentialDocument

ALTER TABLE [ConfidentialDocument] ADD CONSTRAINT [PK_ConfidentialDocument] PRIMARY KEY ([ConfDocID])
go

ALTER TABLE [ConfidentialDocument] ADD CONSTRAINT [ConfDocID] UNIQUE  ([ConfDocID])
go

-- Table License

CREATE TABLE [License]
(
 [LicenseID] Int NOT NULL,
 [LicenseNumber] Bigint NOT NULL,
 [Speciality] Varchar(50) NULL,
 [LicenseExpiryDate] Date NOT NULL,
 [LicenseStatus] Varchar(50) NOT NULL,
 [ProviderID] Int NOT NULL
)
go

-- Create indexes for table License

CREATE INDEX [IX_Relationship1] ON [License] ([ProviderID])
go

-- Add keys for table License

ALTER TABLE [License] ADD CONSTRAINT [PK_License] PRIMARY KEY ([LicenseID])
go

ALTER TABLE [License] ADD CONSTRAINT [LicenseNumber] UNIQUE  ([LicenseNumber])
go

-- Table BlockTime

CREATE TABLE [BlockTime]
(
 [BlockID] Int NOT NULL,
 [BlockTD] Int NOT NULL,
 [BlockRate] Float NOT NULL,
 [ProviderID] Int NULL
)
go

-- Create indexes for table BlockTime

CREATE INDEX [IX_Relationship6] ON [BlockTime] ([ProviderID])
go

-- Add keys for table BlockTime

ALTER TABLE [BlockTime] ADD CONSTRAINT [PK_BlockTime] PRIMARY KEY ([BlockID])
go

ALTER TABLE [BlockTime] ADD CONSTRAINT [BlockID] UNIQUE  ([BlockID])
go

-- Table Room

CREATE TABLE [Room]
(
 [RoomID] Int NOT NULL,
 [RoomNumber] Int NOT NULL,
 [LocID] Int NULL
)
go

-- Create indexes for table Room

CREATE INDEX [IX_Relationship10] ON [Room] ([LocID])
go

-- Add keys for table Room

ALTER TABLE [Room] ADD CONSTRAINT [PK_Room] PRIMARY KEY ([RoomID])
go

ALTER TABLE [Room] ADD CONSTRAINT [RoomNo] UNIQUE  ([RoomID])
go

-- Table Equipment

CREATE TABLE [Equipment]
(
 [EqID] Int NOT NULL,
 [EqName] Varchar(255) NOT NULL,
 [NextMaintenance] Date NULL,
 [RoomID] Int NULL
)
go

-- Create indexes for table Equipment

CREATE INDEX [IX_Relationship2] ON [Equipment] ([RoomID])
go

CREATE INDEX [IX_Relationship1] ON [Equipment] ([RoomID])
go

-- Add keys for table Equipment

ALTER TABLE [Equipment] ADD CONSTRAINT [PK_Equipment] PRIMARY KEY ([EqID])
go

ALTER TABLE [Equipment] ADD CONSTRAINT [EqID] UNIQUE  ([EqID])
go

-- Table Location

CREATE TABLE [Location]
(
 [LocID] Int NOT NULL,
 [StreetName] Varchar(255) NULL,
 [City] Varchar(50) NOT NULL,
 [State] Char(2) NOT NULL,
 [ZipCode] Char(5) NOT NULL
)
go

-- Add keys for table Location

ALTER TABLE [Location] ADD CONSTRAINT [PK_Location] PRIMARY KEY ([LocID])
go

ALTER TABLE [Location] ADD CONSTRAINT [LocID] UNIQUE  ([LocID])
go

-- Table Supply

CREATE TABLE [Supply]
(
 [SupplyID] Int NOT NULL,
 [SupplyName] Varchar(50) NOT NULL,
 [SupplyQty] Int NOT NULL,
 [LocID] Int NULL
)
go

-- Create indexes for table Supply

CREATE INDEX [IX_Relationship11] ON [Supply] ([LocID])
go

-- Add keys for table Supply

ALTER TABLE [Supply] ADD CONSTRAINT [PK_Supply] PRIMARY KEY ([SupplyID])
go

ALTER TABLE [Supply] ADD CONSTRAINT [SupplyID] UNIQUE  ([SupplyID])
go

-- Table SystemAccount

CREATE TABLE [SystemAccount]
(
 [AccountID] Int NOT NULL,
 [Username] Varchar(100) NOT NULL,
 [Password] Varchar(100) NOT NULL,
 [Role] Varchar(100) NOT NULL
)
go

-- Add keys for table SystemAccount

ALTER TABLE [SystemAccount] ADD CONSTRAINT [PK_SystemAccount] PRIMARY KEY ([AccountID])
go

ALTER TABLE [SystemAccount] ADD CONSTRAINT [AccountID] UNIQUE  ([AccountID])
go

-- Table Invoice

CREATE TABLE [Invoice]
(
 [InvoiceID] Int NOT NULL PRIMARY KEY IDENTITY(1,1),
 [TotalAmount] Float NOT NULL,
 [AppointmentID] Int NOT NULL
)
go

-- Create indexes for table Invoice

CREATE INDEX [IX_Relationship10] ON [Invoice] ([AppointmentID])
go


-- Table Payment

CREATE TABLE [Payment]
(
 [PaymentID] Int NOT NULL,
 [PaymentMethod] Varchar(250) NOT NULL,
 [PaidAmount] Float NOT NULL,
 [DateOfPayment] Date NOT NULL,
 [PaymentDoneBy] Varchar(250) NOT NULL,
 [InvoiceID] Int NULL
)
go

-- Create indexes for table Payment

CREATE INDEX [IX_Relationship12] ON [Payment] ([InvoiceID])
go

-- Add keys for table Payment

ALTER TABLE [Payment] ADD CONSTRAINT [PK_Payment] PRIMARY KEY ([PaymentID])
go

ALTER TABLE [Payment] ADD CONSTRAINT [PaymentID] UNIQUE  ([PaymentID])
go

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [Prescription] ADD CONSTRAINT [A prescription is related to only one treatment summary] FOREIGN KEY ([TreatmentID]) REFERENCES [TreatmentSummary] ([TreatmentID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [TreatmentSummary] ADD CONSTRAINT [An appointment can have multiple treatment summaries] FOREIGN KEY ([AppointmentID]) REFERENCES [Appointment] ([AptID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Appointment] ADD CONSTRAINT [A patient can book multiple appointments] FOREIGN KEY ([PatientID]) REFERENCES [Patient] ([PatientID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Insurance] ADD CONSTRAINT [A patient can have multiple insurances] FOREIGN KEY ([PatientID]) REFERENCES [Patient] ([PatientID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [ExaminationRecord] ADD CONSTRAINT [An appointment can have only one Examination Record] FOREIGN KEY ([AppointmentID]) REFERENCES [Appointment] ([AptID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [PatientHistory] ADD CONSTRAINT [A patient history can be related to only one patient] FOREIGN KEY ([PatientID]) REFERENCES [Patient] ([PatientID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [TeethInformation] ADD CONSTRAINT [A patient can have many teeth information records] FOREIGN KEY ([PatientID]) REFERENCES [Patient] ([PatientID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [TreatmentSummary] ADD CONSTRAINT [A treatment can be related to many Treatment Summary] FOREIGN KEY ([TCID]) REFERENCES [TreatmentCatalog] ([TCID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Supply] ADD CONSTRAINT [A location can have many supplies] FOREIGN KEY ([LocID]) REFERENCES [Location] ([LocID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Room] ADD CONSTRAINT [A location can have many Rooms] FOREIGN KEY ([LocID]) REFERENCES [Location] ([LocID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [BlockTime] ADD CONSTRAINT [Every block will be related to a provider] FOREIGN KEY ([ProviderID]) REFERENCES [Provider] ([ProviderID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [ConfidentialDocument] ADD CONSTRAINT [Every confidential document will be related to one provider] FOREIGN KEY ([ProviderID]) REFERENCES [Provider] ([ProviderID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [License] ADD CONSTRAINT [A provider should have one or many licenses] FOREIGN KEY ([ProviderID]) REFERENCES [Provider] ([ProviderID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Payment] ADD CONSTRAINT [An invoice can have different types of payment] FOREIGN KEY ([InvoiceID]) REFERENCES [Invoice] ([InvoiceID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Invoice] ADD CONSTRAINT [An appoinment can have many invoices] FOREIGN KEY ([AppointmentID]) REFERENCES [Appointment] ([AptID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Appointment] ADD CONSTRAINT [A room can be used for many appointments] FOREIGN KEY ([RoomID]) REFERENCES [Room] ([RoomID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Appointment] ADD CONSTRAINT [A provider can have multiple appointments] FOREIGN KEY ([ProviderID]) REFERENCES [Provider] ([ProviderID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Equipment] ADD CONSTRAINT [A room can have multiple equipments] FOREIGN KEY ([RoomID]) REFERENCES [Room] ([RoomID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go
