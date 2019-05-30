create table MAIL_RELAY_STATUS
(
    mimeMessageId VARCHAR2(256) NOT NULL,
    state VARCHAR2(256),
    errorMessage VARCHAR2(256),
    recipients VARCHAR2(256),
    "from" VARCHAR2(256)
);