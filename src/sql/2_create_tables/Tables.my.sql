
/* Data Tables */

/* Data Kinds */

CREATE TABLE AddressState (
    StateID       int         PRIMARY KEY AUTO_INCREMENT,
    StateAbbr     varchar(2)  NOT NULL,
    StateName     varchar(30) NOT NULL
);

CREATE TABLE PersonGender (
    GenderID      int         PRIMARY KEY AUTO_INCREMENT,
    GenderName    varchar(60) NOT NULL
);

CREATE TABLE PersonRace (
    RaceID        int         PRIMARY KEY AUTO_INCREMENT,
    RaceName      varchar(60) NOT NULL
);

/* Person IDs */

CREATE TABLE PatientPerson (
    PatientID      int         PRIMARY KEY AUTO_INCREMENT,
    FirstName      varchar(20) NOT NULL,
    LastName       varchar(20) NOT NULL,
    DateOfBirth    date        NOT NULL,
    GenderID       int         REFERENCES PersonGender(GenderID),
    RaceID         int         REFERENCES PersonRace(RaceID)
);

CREATE TABLE DoctorPerson (
    DoctorID       int         PRIMARY KEY AUTO_INCREMENT,
    FirstName      varchar(20) NOT NULL,
    LastName       varchar(20) NOT NULL
);

/* Entities */

CREATE TABLE DoctorAvailableHours (
    DoctorID       int         REFERENCES DoctorPerson(DoctorID),
    DayOfTheWeek   tinyint     NOT NULL,
    AvailableFrom  time        NOT NULL,
    AvailableTo    time        NOT NULL
);

CREATE TABLE Address (
    AddressID      int         PRIMARY KEY AUTO_INCREMENT,
    StreetAddress1 varchar(50) NOT NULL,
    StreetAddress2 varchar(50),
    POBox          int,
    BuildingName   varchar(50),
    Floor          varchar(10),
    OfficeName     varchar(50),
    Room           varchar(10),
    City           varchar(50) NOT NULL,
    StateID        int         REFERENCES AddressState(StateID),
    PostalCode     varchar(20) NOT NULL
);

CREATE TABLE Contact (
    ContactID      int         PRIMARY KEY AUTO_INCREMENT,
    MainPhone      int         NOT NULL,
    WorkPhone      int,
    AltPhone       int,
    MainEmail      varchar(50) NOT NULL,
    AltEmail       varchar(50)
);

CREATE TABLE Pharmacy (
    PharmacyID     int         PRIMARY KEY AUTO_INCREMENT,
    PharmacyName   varchar(50) NOT NULL,
    AddressID      int         REFERENCES Address(AddressID)
);

CREATE TABLE CareProvider (
    CareProviderID   int         PRIMARY KEY AUTO_INCREMENT,
    CareProviderName varchar(50) NOT NULL,
    AddressID        int         REFERENCES Address(AddressID),
    ContactID        int         REFERENCES Contact(ContactID)
);

CREATE TABLE Office (
    CareProviderID   int         REFERENCES CareProvider(CareProviderID)
    /* Data specific to doctors' offices */
);

CREATE TABLE Hospital (
    CareProviderID   int         REFERENCES CareProvider(CareProviderID)
    /* Data specific to hospitals */
);

CREATE TABLE InsuranceProvider (
    InsuranceProviderID   int         PRIMARY KEY AUTO_INCREMENT,
    InsuranceProviderName varchar(50) NOT NULL
);

CREATE TABLE HospitalAcceptedInsurance (
    InsuranceProviderID int REFERENCES InsuranceProvider(InsuranceProviderID),
    CareProviderID      int REFERENCES CareProvider(CareProviderID)
);

CREATE TABLE Bill (
    BillID               int           PRIMARY KEY AUTO_INCREMENT,
    PatientID            int           REFERENCES PatientPerson(PatientID),
    CareProviderID       int           REFERENCES CareProvider(CareProviderID),
    InsuranceProviderID  int           REFERENCES InsuranceProvider(InsuranceProviderID),
    DateIssued           date          NOT NULL,
    DateDue              date          NOT NULL,
    DatePaid             date,
    AmountCovered        numeric(15,2) NOT NULL,
    AmountDue            numeric(15,2) NOT NULL,
    AmountPaid           numeric(15,2) NOT NULL
);

CREATE TABLE Prescription (
    PrescriptionID       int           PRIMARY KEY AUTO_INCREMENT,
    PatientID            int           REFERENCES PatientPerson(PatientID),
    DoctorID             int           REFERENCES DoctorPerson(DoctorID),
    DrugKindID           int           REFERENCES DrugKind(DrugKindID),
    Dosage               int           NOT NULL,
    StartDate            date          NOT NULL,
    EndDate              date          NOT NULL
);

CREATE TABLE Diagnosis (
    DiagnosisID          int           PRIMARY KEY AUTO_INCREMENT,
    PatientID            int           REFERENCES PatientPerson(PatientID),
    DoctorID             int           REFERENCES DoctorPerson(DoctorID),
    DiagnosisKindID      int           REFERENCES DiagnosisKind(DiagnosisKindID),
    DiagnosisDate        date          NOT NULL,
    RecommendedTreatment varchar(500)  NOT NULL
);

CREATE TABLE Visit (
    VisitID        int      PRIMARY KEY AUTO_INCREMENT,
    PatientID      int      REFERENCES PatientPerson(PatientID),
    DoctorID       int      REFERENCES DoctorPerson(DoctorID),
    CareProviderID int      REFERENCES CareProvider(CareProviderID),
    ProcKindID     int      REFERENCES ProcedureKind(ProcedureKindID),
    StartTime      datetime NOT NULL,
    EndTime        datetime NOT NULL
);

CREATE TABLE Appointment (
    AppointmentID  int      PRIMARY KEY AUTO_INCREMENT,
    PatientID      int      REFERENCES PatientPerson(PatientID),
    DoctorID       int      REFERENCES DoctorPerson(DoctorID),
    CareProviderID int      REFERENCES CareProvider(CareProviderID),
    StartTime      datetime NOT NULL,
    EndTime        datetime NOT NULL,
    Reason         varchar(200)
);

CREATE TABLE DoctorAssignedPatients (
    DoctorID   int  REFERENCES DoctorPerson(DoctorID),
    PatientID  int  REFERENCES PatientPerson(PatientID),
    PRIMARY KEY (DoctorID, PatientID)
);

CREATE TABLE Doctor (
    DoctorID       int  REFERENCES DoctorPerson(DoctorID),
    CareProviderID int  REFERENCES CareProvider(CareProviderID),
    LoginUserID    int  REFERENCES LoginUser(UserID)
);

CREATE TABLE PatientVaccinations (
    PatientID  int  REFERENCES PatientPerson(PatientID),
    VacKindID  int  REFERENCES VaccinationKind(VaccinationKindID),
    VacDate    date NOT NULL,
    PRIMARY KEY (PatientID, VacKindID, VacDate)
);

CREATE TABLE PatientProcedures (
    PatientID  int  REFERENCES PatientPerson(PatientID),
    ProcKindID int  REFERENCES ProcedureKind(ProcedureKindID),
    ProcDate   date NOT NULL,
    PRIMARY KEY (PatientID, ProcKindID, ProcDate)
);

CREATE TABLE PatientEmContacts (
    PatientID  int  REFERENCES PatientPerson(PatientID),
    ContactID  int  REFERENCES Contact(ContactID),
    PRIMARY KEY (PatientID, ContactID)
);

CREATE TABLE Patient (
    PatientID           int REFERENCES PatientPerson(PatientID),
    InsuranceProviderID int REFERENCES InsuranceProvider(InsuranceProviderID),
    PharmacyID          int REFERENCES Pharmacy(PharmacyID),
    AddressID           int REFERENCES Address(AddressID),
    ContactID           int REFERENCES Contact(ContactID),
    LoginUserID         int REFERENCES LoginUser(UserID)
);

/* Init Data */

INSERT INTO AddressState (StateAbbr, StateName) VALUES ('AL', 'Alabama');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('AK', 'Alaska');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('AS', 'American Samoa');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('AZ', 'Arizona');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('AR', 'Arkansas');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('CA', 'California');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('CO', 'Colorado');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('CT', 'Connecticut');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('DE', 'Delaware');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('DC', 'District of Columbia');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('FM', 'Federated States of Micronesia');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('FL', 'Florida');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('GA', 'Georgia');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('GU', 'Guam');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('HI', 'Hawaii');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('ID', 'Idaho');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('IL', 'Illinois');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('IN', 'Indiana');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('IA', 'Iowa');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('KS', 'Kansas');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('KY', 'Kentucky');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('LA', 'Louisiana');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('ME', 'Maine');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('MH', 'Marshall Islands');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('MD', 'Maryland');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('MA', 'Massachusetts');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('MI', 'Michigan');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('MN', 'Minnesota');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('MS', 'Mississippi');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('MO', 'Missouri');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('MT', 'Montana');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('NE', 'Nebraska');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('NV', 'Nevada');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('NH', 'New Hampshire');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('NJ', 'New Jersey');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('NM', 'New Mexico');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('NY', 'New York');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('NC', 'North Carolina');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('ND', 'North Dakota');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('MP', 'Northern Mariana Islands');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('OH', 'Ohio');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('OK', 'Oklahoma');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('OR', 'Oregon');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('PW', 'Palau');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('PA', 'Pennsylvania');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('PR', 'Puerto Rico');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('RI', 'Rhode Island');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('SC', 'South Carolina');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('SD', 'South Dakota');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('TN', 'Tennessee');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('TX', 'Texas');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('UT', 'Utah');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('VT', 'Vermont');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('VI', 'Virgin Islands');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('VA', 'Virginia');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('WA', 'Washington');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('WV', 'West Virginia');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('WI', 'Wisconsin');
INSERT INTO AddressState (StateAbbr, StateName) VALUES ('WY', 'Wyoming');

INSERT INTO PersonGender (GenderName) VALUES ('Unspecified');
INSERT INTO PersonGender (GenderName) VALUES ('Male');
INSERT INTO PersonGender (GenderName) VALUES ('Female');
INSERT INTO PersonGender (GenderName) VALUES ('Unknown (No physical exam)');
INSERT INTO PersonGender (GenderName) VALUES ('Indeterminate (Physical exam taken, but inconclusive)');
INSERT INTO PersonGender (GenderName) VALUES ('Male once female');
INSERT INTO PersonGender (GenderName) VALUES ('Female once male');
INSERT INTO PersonGender (GenderName) VALUES ('Male been both');
INSERT INTO PersonGender (GenderName) VALUES ('Female been both');
INSERT INTO PersonGender (GenderName) VALUES ('Hermaphrodite');
INSERT INTO PersonGender (GenderName) VALUES ('Other');

INSERT INTO PersonRace (RaceName) VALUES ('Unspecified');
INSERT INTO PersonRace (RaceName) VALUES ('American Indian or Alaska Native');
INSERT INTO PersonRace (RaceName) VALUES ('Asian');
INSERT INTO PersonRace (RaceName) VALUES ('Black or African American, not of Hispanic origin');
INSERT INTO PersonRace (RaceName) VALUES ('Hispanic');
INSERT INTO PersonRace (RaceName) VALUES ('White, not of Hispanic origin');
INSERT INTO PersonRace (RaceName) VALUES ('Native Hawaiian or Other Pacific Islander');
INSERT INTO PersonRace (RaceName) VALUES ('Other');
