
/* Mock Data for Tables */

/* PatientPerson */
INSERT INTO PatientPerson (FirstName, LastName, DateOfBirth, GenderID, RaceID) VALUES ('John', 'Doe', '1967-12-23', 2, 1);
INSERT INTO PatientPerson (FirstName, LastName, DateOfBirth, GenderID, RaceID) VALUES ('Jane', 'Doe', '1968-12-21', 3, 1);
INSERT INTO PatientPerson (FirstName, LastName, DateOfBirth, GenderID, RaceID) VALUES ('Carth', 'Onasis', '1987-03-12', 2, 6);
INSERT INTO PatientPerson (FirstName, LastName, DateOfBirth, GenderID, RaceID) VALUES ('Bastilla', 'Shan', '1967-29-07', 3, 6);
INSERT INTO PatientPerson (FirstName, LastName, DateOfBirth, GenderID, RaceID) VALUES ('Canderous', 'Ordo', '1967-12-11', 2, 1);

/* DoctorPerson */
INSERT INTO DoctorPerson (FirstName, LastName) VALUES ('Sam', 'Bradford');
INSERT INTO DoctorPerson (FirstName, LastName) VALUES ('Nick', 'Foles');
INSERT INTO DoctorPerson (FirstName, LastName) VALUES ('Aaron', 'Rodgers');
INSERT INTO DoctorPerson (FirstName, LastName) VALUES ('Peyton', 'Manning');

/* Contact */
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (1235555, NULL, NULL, 'asdasd@gmail.com', NULL);
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (1236575, NULL, NULL, 'asdasd@gmail.com', NULL);
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (3453534, NULL, NULL, 'asdasd@gmail.com', NULL);
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (1321321, NULL, NULL, 'asdasd@gmail.com', NULL);
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (7897879, NULL, NULL, 'asdasd@gmail.com', NULL);
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (4564654, NULL, NULL, 'asdasd@gmail.com', NULL);
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (4535345, 4353455, NULL, 'asdasd@gmail.com', NULL);
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (5675675, 2342434, NULL, 'asdasd@gmail.com', NULL);
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (8798987, 2343243, NULL, 'asdasd@gmail.com', NULL);
INSERT INTO Contact (MainPhone, WorkPhone, AltPhone, MainEmail, AltEmail)
VALUES (1342432, 3242343, NULL, 'asdasd@gmail.com', NULL);

/* Address */
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('546 Random Dr.', NULL, NULL, 'Geneva', 23, '34543');
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('43 Kent Ave.', NULL, NULL, 'Geneva', 22, '34533');
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('6546 Main Rd.', NULL, NULL, 'Geneva', 43, '45645');
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('122 Couroscant Dr.', NULL, NULL, 'Geneva', 34, '65433');
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('6456 Are Rd.', NULL, NULL, 'Geneva', 45, '13212');
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('324 Apple Pl.', NULL, NULL, 'Geneva', 11, '24324');
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('12312 Chicago Ave.', NULL, NULL, 'Geneva', 12, '53422');
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('46 Ohio Dr.', NULL, NULL, 'Geneva', 21, '76533');
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('3242 Dane Rd.', NULL, NULL, 'Geneva', 7, '76574');
INSERT INTO Address (StreetAddress1, StreetAddress2, POBox, City, StateID, PostalCode)
VALUES ('42 Wallaby Ln.', NULL, NULL, 'Sydney', 6, '87645');

/* InsuranceProvider */
INSERT INTO InsuranceProvider (InsuranceProviderName) VALUES ('Medi');
INSERT INTO InsuranceProvider (InsuranceProviderName) VALUES ('Care Provision');

/* Pharmacy */
INSERT INTO Pharmacy (PharmacyName, AddressID) VALUES ('Mart', 8);
INSERT INTO Pharmacy (PharmacyName, AddressID) VALUES ('Aide', 7);

/* CareProvider */
INSERT INTO CareProvider (CareProviderName, AddressID, ContactID) VALUES ('ExoGeni', 10, 10);
INSERT INTO CareProvider (CareProviderName, AddressID, ContactID) VALUES ('Binary Helix', 9, 9);

/* Office (CareProviderID) */
INSERT INTO Office VALUES (1);

/* Hospital (CareProviderID) */
INSERT INTO Hospital VALUES (2);

/* HospitalAcceptedInsurance (InsuranceProviderID, CareProviderID) */
INSERT INTO HospitalAcceptedInsurance VALUES (1, 1);
INSERT INTO HospitalAcceptedInsurance VALUES (1, 2);
INSERT INTO HospitalAcceptedInsurance VALUES (2, 1);
INSERT INTO HospitalAcceptedInsurance VALUES (2, 2);

/* PatientEmContacts (PatientID, ContactID) */
INSERT INTO PatientEmContacts VALUES (1, 2);
INSERT INTO PatientEmContacts VALUES (2, 1);
INSERT INTO PatientEmContacts VALUES (3, 4);
INSERT INTO PatientEmContacts VALUES (4, 3);
INSERT INTO PatientEmContacts VALUES (5, 6);

/* Doctor */
INSERT INTO Doctor (DoctorID, CareProviderID) VALUES (1, 1);
INSERT INTO Doctor (DoctorID, CareProviderID) VALUES (2, 1);
INSERT INTO Doctor (DoctorID, CareProviderID) VALUES (3, 2);
INSERT INTO Doctor (DoctorID, CareProviderID) VALUES (4, 2);

/* DoctorAvailableHours (DoctorID, DayOfTheWeek, AvailableFrom, AvailableTo) */
INSERT INTO DoctorAvailableHours VALUES (1, 2, '06:00:00', '14:00:00');
INSERT INTO DoctorAvailableHours VALUES (2, 4, '06:00:00', '14:00:00');
INSERT INTO DoctorAvailableHours VALUES (3, 6, '06:00:00', '14:00:00');
INSERT INTO DoctorAvailableHours VALUES (4, 3, '06:00:00', '14:00:00');

/* Patient */
INSERT INTO Patient (PatientID, InsuranceProviderID, PharmacyID, AddressID, ContactID) VALUES (1, 1, 1, 1, 1);
INSERT INTO Patient (PatientID, InsuranceProviderID, PharmacyID, AddressID, ContactID) VALUES (2, 1, 1, 1, 2);
INSERT INTO Patient (PatientID, InsuranceProviderID, PharmacyID, AddressID, ContactID) VALUES (3, 1, 1, 2, 3);
INSERT INTO Patient (PatientID, InsuranceProviderID, PharmacyID, AddressID, ContactID) VALUES (4, 2, 2, 2, 4);
INSERT INTO Patient (PatientID, InsuranceProviderID, PharmacyID, AddressID, ContactID) VALUES (5, 2, 2, 3, 5);

/* PatientProcedures (PatientID, ProcKindID, ProcDate) */
INSERT INTO PatientProcedures VALUES (1, 34, '1998-09-10');
INSERT INTO PatientProcedures VALUES (2, 14, '1998-09-10');

/* PatientVaccinations (PatientID, VacKindID, VacDate) */
INSERT INTO PatientVaccinations VALUES (1, 32, '1967-12-23');
INSERT INTO PatientVaccinations VALUES (1, 54, '1967-12-23');
INSERT INTO PatientVaccinations VALUES (1, 23, '1967-12-23');

/* DoctorAssignedPatients (DoctorID, PatientID) */
INSERT INTO DoctorAssignedPatients VALUES (1, 1);
INSERT INTO DoctorAssignedPatients VALUES (1, 2);
INSERT INTO DoctorAssignedPatients VALUES (2, 3);
INSERT INTO DoctorAssignedPatients VALUES (3, 4);
INSERT INTO DoctorAssignedPatients VALUES (4, 5);

/* Bill */
INSERT INTO Bill (PatientID, CareProviderID, InsuranceProviderID, DateIssued, DateDue, DatePaid, AmountCovered, AmountDue, AmountPaid)
VALUES (1, 1, 1, '1976-12-23', '1976-12-30', '1976-12-23', 500.00, 1000.00, 1000.00);
INSERT INTO Bill (PatientID, CareProviderID, InsuranceProviderID, DateIssued, DateDue, DatePaid, AmountCovered, AmountDue, AmountPaid)
VALUES (1, 1, 1, '1976-12-23', '1976-12-30', '1976-12-23', 500.00, 3000.00, 3000.00);

/* Appointment */
INSERT INTO Appointment (PatientID, DoctorID, CareProviderID, StartTime, EndTime, Reason)
VALUES (1, 1, 1, '2015-5-1 06:00:00', '2015-5-1 06:30:00', 'Stomach ache');
INSERT INTO Appointment (PatientID, DoctorID, CareProviderID, StartTime, EndTime, Reason)
VALUES (2, 1, 1, '2015-5-8 07:00:00', '2015-5-8 07:30:00', 'Ill');

/* Visit */
INSERT INTO Visit (PatientID, DoctorID, CareProviderID, ProcKindID, StartTime, EndTime)
VALUES (1, 1, 1, 32, '2015-4-29 07:00:00', '2015-4-29 07:30:00');
INSERT INTO Visit (PatientID, DoctorID, CareProviderID, ProcKindID, StartTime, EndTime)
VALUES (1, 1, 1, 32, '2015-4-26 07:00:00', '2015-4-26 07:30:00');

/* Prescription */
INSERT INTO Prescription (PatientID, DoctorID, DrugKindID, Dosage, StartDate, EndDate)
VALUES (1, 1, 32, 45, '1976-12-23', '1976-12-30');
INSERT INTO Prescription (PatientID, DoctorID, DrugKindID, Dosage, StartDate, EndDate)
VALUES (1, 1, 32, 45, '1976-12-23', '1976-12-30');

/* Diagnosis */
INSERT INTO Diagnosis (PatientID, DoctorID, DiagnosisKindID, DiagnosisDate, RecommendedTreatment)
VALUES (1, 1, 23, '1998-09-09', 'rest');
INSERT INTO Diagnosis (PatientID, DoctorID, DiagnosisKindID, DiagnosisDate, RecommendedTreatment)
VALUES (2, 1, 23, '1998-09-09', 'sleep');
