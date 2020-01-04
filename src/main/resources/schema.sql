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
	username VARCHAR_IGNORECASE NOT NULL PRIMARY KEY,
	password VARCHAR_IGNORECASE  NOT NULL,
	firstname VARCHAR_IGNORECASE,
	lastname VARCHAR_IGNORECASE,
	enabled boolean NOT NULL
);

CREATE TABLE authorities (
	username VARCHAR_IGNORECASE NOT NULL,
	authority VARCHAR_IGNORECASE NOT NULL,
	CONSTRAINT FK_authorities_users FOREIGN KEY(username) REFERENCES users(username)
);

CREATE UNIQUE INDEX UQ_authorities_username_authority ON authorities (username,authority);

CREATE TABLE groups (
  id BIGINT PRIMARY KEY,
  group_name VARCHAR_IGNORECASE NOT NULL);

CREATE TABLE group_authorities (
  group_id BIGINT NOT NULL,
  authority VARCHAR_IGNORECASE NOT NULL,
  CONSTRAINT FK_group_authorities_group FOREIGN KEY(group_id) REFERENCES groups(id));

CREATE TABLE group_members (
  id BIGINT PRIMARY KEY,
  username VARCHAR_IGNORECASE NOT NULL,
  group_id bigint NOT NULL,
  CONSTRAINT FK_group_members_group FOREIGN KEY(group_id) REFERENCES groups(id));
  

CREATE TABLE oauth_client_details (
  client_id VARCHAR_IGNORECASE PRIMARY KEY,
  resource_ids VARCHAR_IGNORECASE,
  client_secret VARCHAR_IGNORECASE,
  scope VARCHAR_IGNORECASE,
  authorized_grant_types VARCHAR_IGNORECASE,
  web_server_redirect_uri VARCHAR_IGNORECASE,
  authorities VARCHAR_IGNORECASE,
  access_token_validity INTEGER,
  refresh_token_validity INTEGER,
  additional_information VARCHAR(4096),
  autoapprove VARCHAR_IGNORECASE
);

CREATE TABLE oauth_client_token (
  token_id VARCHAR_IGNORECASE,
  token VARCHAR_IGNORECASE,
  authentication_id VARCHAR_IGNORECASE PRIMARY KEY,
  user_name VARCHAR_IGNORECASE,
  client_id VARCHAR_IGNORECASE
);

CREATE TABLE oauth_access_token (
  token_id VARCHAR_IGNORECASE,
  token VARCHAR_IGNORECASE,
  authentication_id VARCHAR_IGNORECASE PRIMARY KEY,
  user_name VARCHAR_IGNORECASE,
  client_id VARCHAR_IGNORECASE,
  authentication VARCHAR_IGNORECASE,
  refresh_token VARCHAR_IGNORECASE
);

CREATE TABLE oauth_refresh_token (
  token_id VARCHAR_IGNORECASE,
  token VARCHAR_IGNORECASE,
  authentication VARCHAR_IGNORECASE
);

CREATE TABLE oauth_code (
  code VARCHAR_IGNORECASE, authentication VARCHAR_IGNORECASE
);

CREATE TABLE oauth_approvals (
	userId VARCHAR_IGNORECASE,
	clientId VARCHAR_IGNORECASE,
	scope VARCHAR_IGNORECASE,
	status VARCHAR(10),
	expiresAt TIMESTAMP,
	lastModifiedAt TIMESTAMP
);

CREATE TABLE ClientDetails (
  appId VARCHAR_IGNORECASE PRIMARY KEY,
  resourceIds VARCHAR_IGNORECASE,
  appSecret VARCHAR_IGNORECASE,
  scope VARCHAR_IGNORECASE,
  grantTypes VARCHAR_IGNORECASE,
  redirectUrl VARCHAR_IGNORECASE,
  authorities VARCHAR_IGNORECASE,
  access_token_validity INTEGER,
  refresh_token_validity INTEGER,
  additionalInformation VARCHAR(4096),
  autoApproveScopes VARCHAR_IGNORECASE
);