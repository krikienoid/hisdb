
/* Views */

CREATE VIEW AddressView AS
SELECT
    Address.AddressID,
    Address.StreetAddress1,
    Address.StreetAddress2,
    Address.POBox,
    Address.BuildingName,
    Address.Floor,
    Address.OfficeName,
    Address.Room,
    Address.City,
    AddressState.StateAbbr,
    Address.PostalCode
FROM Address
LEFT JOIN AddressState ON Address.StateID = AddressState.StateID;

CREATE VIEW PatientPersonView AS
SELECT
    Patient.PatientID,
    PatientPerson.FirstName,
    PatientPerson.LastName,
    PatientPerson.DateOfBirth,
    PersonGender.GenderName,
    PersonRace.RaceName
FROM Patient
LEFT JOIN PatientPerson ON Patient.PatientID = PatientPerson.PatientID
LEFT JOIN PersonGender  ON PatientPerson.GenderID   = PersonGender.GenderID
LEFT JOIN PersonRace    ON PatientPerson.RaceID     = PersonRace.RaceID;

CREATE VIEW DoctorPersonView AS
SELECT
    Doctor.DoctorID,
    DoctorPerson.FirstName,
    DoctorPerson.LastName,
    Doctor.CareProviderID
FROM Doctor
LEFT JOIN DoctorPerson ON Doctor.DoctorID = DoctorPerson.DoctorID;

CREATE VIEW DoctorPatientLookupView AS
SELECT
    PatientPersonView.PatientID,
    PatientPersonView.FirstName,
    PatientPersonView.LastName,
    PatientPersonView.DateOfBirth,
    PatientPersonView.GenderName,
    PatientPersonView.RaceName,
    DoctorPersonView.DoctorID,
    DoctorPersonView.FirstName AS DoctorFirstName,
    DoctorPersonView.LastName  AS DoctorLastName,
    CareProvider.CareProviderID,
    CareProvider.CareProviderName
FROM PatientPersonView
LEFT JOIN DoctorAssignedPatients
    ON PatientPersonView.PatientID = DoctorAssignedPatients.PatientID
LEFT JOIN DoctorPersonView
    ON DoctorPersonView.DoctorID = DoctorAssignedPatients.DoctorID
LEFT JOIN CareProvider
    ON DoctorPersonView.CareProviderID = CareProvider.CareProviderID;

/* Patient Information */

CREATE VIEW PatientInformationView AS
SELECT
    PatientPerson.PatientID,
    PatientPerson.FirstName,
    PatientPerson.LastName,

    Contact.MainPhone,
    Contact.WorkPhone,
    Contact.AltPhone,
    Contact.MainEmail,
    Contact.AltEmail,

    Address.StreetAddress1,
    Address.StreetAddress2,
    Address.POBox,
    Address.City,
    AddressState.StateName,
    Address.PostalCode
FROM Address
INNER JOIN AddressState
    ON Address.StateID = AddressState.StateID
INNER JOIN
    Patient ON Address.AddressID = Patient.AddressID
INNER JOIN
    Contact ON Patient.ContactID = Contact.ContactID
INNER JOIN
    PatientPerson ON Patient.PatientID = PatientPerson.PatientID;

/* Patient Health Records */

CREATE VIEW PatientDiagnosisRecordView AS
SELECT
    PatientPersonView.PatientID,
    PatientPersonView.FirstName,
    PatientPersonView.LastName,
    PatientPersonView.DateOfBirth,
    PatientPersonView.RaceName,
    PatientPersonView.GenderName,

    DiagnosisKind.DiagnosisName,
    Diagnosis.DiagnosisDate
FROM Diagnosis
JOIN DiagnosisKind
    ON Diagnosis.DiagnosisKindID = DiagnosisKind.DiagnosisKindID
JOIN PatientPersonView
    ON Diagnosis.PatientID = PatientPersonView.PatientID;

CREATE VIEW PatientPrescriptionRecordView AS
SELECT
    PatientPersonView.PatientID,
    PatientPersonView.FirstName,
    PatientPersonView.LastName,
    PatientPersonView.DateOfBirth,
    PatientPersonView.RaceName,
    PatientPersonView.GenderName,

    DrugKind.DrugName,
    Prescription.Dosage,
    Prescription.StartDate,
    Prescription.EndDate
FROM Prescription
JOIN DrugKind
    ON Prescription.DrugKindID = DrugKind.DrugKindID
JOIN PatientPersonView
    ON Prescription.PatientID = PatientPersonView.PatientID;

CREATE VIEW PatientVaccinationRecordView AS
SELECT
    PatientPersonView.PatientID,
    PatientPersonView.FirstName,
    PatientPersonView.LastName,
    PatientPersonView.DateOfBirth,
    PatientPersonView.RaceName,
    PatientPersonView.GenderName,

    VaccinationKind.VaccinationName,
    PatientVaccinations.VacDate
FROM PatientVaccinations
JOIN VaccinationKind
    ON PatientVaccinations.VacKindID = VaccinationKind.VaccinationKindID
JOIN PatientPersonView
    ON PatientVaccinations.PatientID = PatientPersonView.PatientID;

CREATE VIEW PatientProcedureRecordView AS
SELECT
    PatientPersonView.PatientID,
    PatientPersonView.FirstName,
    PatientPersonView.LastName,
    PatientPersonView.DateOfBirth,
    PatientPersonView.RaceName,
    PatientPersonView.GenderName,

    ProcedureKind.ProcedureName,
    PatientProcedures.ProcDate
FROM PatientProcedures
JOIN ProcedureKind
    ON PatientProcedures.ProcKindID = ProcedureKind.ProcedureKindID
JOIN PatientPersonView
    ON PatientProcedures.PatientID = PatientPersonView.PatientID;

/* Doctor Scheduling */

CREATE VIEW DoctorAvailableHoursView AS
SELECT DISTINCT
    DoctorPerson.DoctorID,
    DoctorPerson.FirstName,
    DoctorPerson.LastName,
    DoctorAvailableHours.DayOfTheWeek,
    DoctorAvailableHours.AvailableFrom,
    DoctorAvailableHours.AvailableTo
FROM DoctorAvailableHours
LEFT OUTER JOIN DoctorPerson
    ON DoctorPerson.DoctorID = DoctorAvailableHours.DoctorID;

CREATE VIEW DoctorAppointmentsView AS
SELECT DISTINCT
    Appointment.AppointmentID,
    Appointment.DoctorID,
        DoctorPerson.FirstName AS DoctorFirstName,
        DoctorPerson.LastName  AS DoctorLastName,
    Appointment.CareProviderID,
        CareProvider.CareProviderName,
    Appointment.PatientID,
        PatientPerson.FirstName AS PatientFirstName,
        PatientPerson.LastName  AS PatientLastName,
    Appointment.StartTime,
    Appointment.EndTime,
    Appointment.Reason
FROM Appointment
LEFT OUTER JOIN DoctorPerson
    ON Appointment.DoctorID = DoctorPerson.DoctorID
LEFT OUTER JOIN PatientPerson
    ON Appointment.PatientID = PatientPerson.PatientID
LEFT OUTER JOIN CareProvider
    ON Appointment.CareProviderID = CareProvider.CareProviderID;
