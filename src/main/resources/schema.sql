DROP TABLE IF EXISTS authorities;

DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS group_members;

DROP TABLE IF EXISTS group_authorities;

DROP TABLE IF EXISTS groups;

DROP TABLE IF EXISTS oauth_client_details;

DROP TABLE IF EXISTS oauth_client_token;

DROP TABLE IF EXISTS oauth_access_token;

DROP TABLE IF EXISTS oauth_refresh_token;

DROP TABLE IF EXISTS oauth_code;

DROP TABLE IF EXISTS oauth_approvals;

DROP TABLE IF EXISTS ClientDetails;

CREATE TABLE users(
	username VARCHAR(255) NOT NULL PRIMARY KEY,
	password VARCHAR(255) NOT NULL,
	firstname VARCHAR(255),
	lastname VARCHAR(255),
	enabled boolean NOT NULL
);

CREATE TABLE authorities (
	username VARCHAR(255) NOT NULL,
	authority VARCHAR(255) NOT NULL,
	CONSTRAINT FK_authorities_users FOREIGN KEY(username) REFERENCES users(username)
);

CREATE UNIQUE INDEX UQ_authorities_username_authority ON authorities (username,authority);

CREATE TABLE groups (
  id BIGINT PRIMARY KEY,
  group_name VARCHAR(255) NOT NULL);

CREATE TABLE group_authorities (
  group_id BIGINT NOT NULL,
  authority VARCHAR(255) NOT NULL,
  CONSTRAINT FK_group_authorities_group FOREIGN KEY(group_id) REFERENCES groups(id));

CREATE TABLE group_members (
  id BIGINT PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  group_id bigint NOT NULL,
  CONSTRAINT FK_group_members_group FOREIGN KEY(group_id) REFERENCES groups(id));
  

CREATE TABLE oauth_client_details (
  client_id VARCHAR(255) PRIMARY KEY,
  resource_ids VARCHAR(255),
  client_secret LONG VARBINARY,
  scope LONG VARBINARY,
  authorized_grant_types VARCHAR(255),
  web_server_redirect_uri LONG VARBINARY,
  authorities VARCHAR(255),
  access_token_validity INTEGER,
  refresh_token_validity INTEGER,
  additional_information VARCHAR(4096),
  autoapprove VARCHAR(255)
);

CREATE TABLE oauth_client_token (
  token_id VARCHAR(255),
  token LONG VARBINARY,
  authentication_id VARCHAR(255) PRIMARY KEY,
  user_name VARCHAR(255),
  client_id VARCHAR(255)
);

CREATE TABLE oauth_access_token (
  token_id VARCHAR(255),
  token LONG VARBINARY,
  authentication_id VARCHAR(255) PRIMARY KEY,
  user_name VARCHAR(255),
  client_id VARCHAR(255),
  authentication LONG VARBINARY,
  refresh_token VARCHAR(255)
);

CREATE TABLE oauth_refresh_token (
  token_id VARCHAR(255),
  token LONG VARBINARY,
  authentication LONG VARBINARY
);

CREATE TABLE oauth_code (
  code VARCHAR(255), authentication LONG VARBINARY
);

CREATE TABLE oauth_approvals (
	userId VARCHAR(255),
	clientId VARCHAR(255),
	scope VARCHAR(255),
	status VARCHAR(10),
	expiresAt TIMESTAMP,
	lastModifiedAt TIMESTAMP
);

CREATE TABLE ClientDetails (
  appId VARCHAR(255) PRIMARY KEY,
  resourceIds VARCHAR(255),
  appSecret VARCHAR(255),
  scope VARCHAR(255),
  grantTypes VARCHAR(255),
  redirectUrl VARCHAR(255),
  authorities VARCHAR(255),
  access_token_validity INTEGER,
  refresh_token_validity INTEGER,
  additionalInformation VARCHAR(4096),
  autoApproveScopes VARCHAR(255)
);