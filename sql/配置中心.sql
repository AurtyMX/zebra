CREATE DATABASE
IF NOT EXISTS zebra DEFAULT CHARACTER
SET = 'utf8';

USE zebra;

CREATE TABLE SERVER_VERSION_CONF (
	SID INT (11) NOT NULL AUTO_INCREMENT,
	SERVER_NAME VARCHAR (100),
	SERVER_VERSION VARCHAR (20),
	SERVER_VERSION_DESC VARCHAR (1000),
	INSERTDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	UPDDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`SID`)
);

CREATE TABLE SERVER_TEST_CONF (
	SID INT (11) NOT NULL AUTO_INCREMENT,
	SERVER_NAME VARCHAR (200),
	METHOD_NAME VARCHAR (100),
	REQUEST VARCHAR (1000),
	RESPONSE VARCHAR (1000),
	ATTACHMENTS VARCHAR (1000),
	DESCRIPT VARCHAR (500),
	INSERTDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	UPDDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`SID`)
);

CREATE INDEX SERVER_TEST_CONF_IDX ON SERVER_TEST_CONF (SERVER_NAME, METHOD_NAME);

CREATE TABLE GATEWAY_CONF (
	SID INT (11) NOT NULL AUTO_INCREMENT,
	SERVER_NAME VARCHAR (100),
	SERVER_GROUP VARCHAR (20),
	SERVER_VERSION VARCHAR (20),
	SERVER_SET VARCHAR (10),
	SERVER_PATH VARCHAR (30),
	SERVER_TEXT text,
	TAG text,
	INSERTDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	UPDDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	GATEWAY_SET VARCHAR (20) DEFAULT '0',
	PRIMARY KEY (`SID`)
);

CREATE INDEX GATEWAY_CONF_IDX ON GATEWAY_CONF (SERVER_NAME);

CREATE TABLE CONF_CENTER (
	SID INT (11) NOT NULL AUTO_INCREMENT,
	TYPE INT,
	SERVER_NAME VARCHAR (100),
	SERVER_SCOPE VARCHAR (20),
	SERVER_SCOPE_NAME VARCHAR (20),
	CONF_TEXT text,
	INSERTDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	UPDDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`SID`)
);

CREATE UNIQUE INDEX CONF_CENTER_INDEX ON CONF_CENTER (
	SERVER_NAME,
	TYPE,
	SERVER_SCOPE
);

CREATE TABLE SERVER_MANAGER_CONF (
	SID INT (11) NOT NULL AUTO_INCREMENT,
	SERVER_NAME VARCHAR (200),
	M_TYPE CHAR (2),
	SERVER_IP VARCHAR (16),
	DATA text,
	INSERTDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	UPDDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`SID`)
);

CREATE INDEX SERVER_MANAGER_CONF_IDX ON SERVER_MANAGER_CONF (SERVER_NAME, M_TYPE);

CREATE UNIQUE INDEX SERVER_MANAGER_UNQ_IDX ON SERVER_MANAGER_CONF (
	SERVER_NAME,
	M_TYPE,
	SERVER_IP
);

CREATE TABLE CONF_CENTER_HISTORY (
	SID INT,
	-- ID
	TYPE INT,
	-- 0 RESOURCE 1BIZ SERVER_NAME VARCHAR (100),
	SERVER_SCOPE VARCHAR (20),
	SERVER_SCOPE_NAME VARCHAR (20),
	CONF_TEXT text,
	VERSION_INFO VARCHAR (50),
	INSERTDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	UPDDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE INDEX CONF_CENTER_HISTORY_IDX ON CONF_CENTER_HISTORY (SID);

CREATE TABLE GATEWAY_CONF_HIS (
	SID INT,
	-- ID
	SERVER_NAME VARCHAR (100),
	SERVER_GROUP VARCHAR (20),
	SERVER_VERSION VARCHAR (20),
	SERVER_SET VARCHAR (10),
	SERVER_PATH VARCHAR (30),
	SERVER_TEXT text,
	TAG text,
	VERSION_INFO VARCHAR (50),
	INSERTDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	UPDDATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	GATEWAY_SET VARCHAR (20)
);

CREATE INDEX GATEWAY_CONF_HIS_IDX ON GATEWAY_CONF_HIS (SERVER_NAME);

INSERT INTO CONF_CENTER (
	TYPE,
	SERVER_NAME,
	SERVER_SCOPE,
	SERVER_SCOPE_NAME,
	CONF_TEXT
)
VALUES
	(
		0,
		'zebra.console',
		'global',
		'',
		'zebra.grpc.registryAddress=http://etcdIP1:2379,http://etcdIP2:2379,http://etcdIP3:2379
zebra.grpc.port=50003'
);

INSERT INTO CONF_CENTER (
	TYPE,
	SERVER_NAME,
	SERVER_SCOPE,
	SERVER_SCOPE_NAME,
	CONF_TEXT
)
VALUES
	(
		0,
		'zebra.monitor',
		'global',
		'',
		'zebra.grpc.registryAddress=http://etcdIP1:2379,http://etcdIP2:2379,http://etcdIP3:2379
zebra.grpc.port=50003
refresh_interval_ms=10000
server.port=8083'
	);