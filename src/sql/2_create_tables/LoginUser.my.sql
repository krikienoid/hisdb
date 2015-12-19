
/* Login Info */

CREATE TABLE LoginRole (
    RoleID        int         PRIMARY KEY AUTO_INCREMENT,
    RoleName      varchar(30) NOT NULL
);

INSERT INTO LoginRole (RoleName) VALUES ('Admin');
INSERT INTO LoginRole (RoleName) VALUES ('Doctor');
INSERT INTO LoginRole (RoleName) VALUES ('Patient');

CREATE TABLE LoginUser (
    UserID        int          PRIMARY KEY AUTO_INCREMENT,
    UserName      varchar(32)  COLLATE utf8_unicode_ci NOT NULL,
    Password      varchar(32)  COLLATE utf8_unicode_ci NOT NULL,
    Email         varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    RegIP         varchar(15)  COLLATE utf8_unicode_ci NOT NULL,
    RegDate       datetime     NOT NULL,
    RoleID        int          REFERENCES LoginRole(RoleID),
    UNIQUE KEY UserName (UserName)
);
