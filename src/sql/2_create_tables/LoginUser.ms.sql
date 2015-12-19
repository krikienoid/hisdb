
/* Login Info */

CREATE TABLE LoginRole (
    RoleID        int         PRIMARY KEY IDENTITY,
    RoleName      varchar(30) NOT NULL
);

INSERT INTO LoginRole (RoleName) VALUES ('Admin');
INSERT INTO LoginRole (RoleName) VALUES ('Doctor');
INSERT INTO LoginRole (RoleName) VALUES ('Patient');

CREATE TABLE LoginUser (
    UserID        int          PRIMARY KEY IDENTITY,
    UserName      varchar(32)  COLLATE Latin1_General_CI_AI NOT NULL,
    Password      varchar(32)  COLLATE Latin1_General_CI_AI NOT NULL,
    Email         varchar(255) COLLATE Latin1_General_CI_AI NOT NULL,
    RegIP         varchar(15)  COLLATE Latin1_General_CI_AI NOT NULL,
    RegDate       datetime     NOT NULL,
    RoleID        int          REFERENCES LoginRole(RoleID),
    CONSTRAINT AK_UserName UNIQUE (UserName)
);
