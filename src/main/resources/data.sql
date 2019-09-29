INSERT INTO users VALUES ('user','$2a$10$itoKSZKhDILW9mGYkhFQR.pxBuf8YIE/pUutAHvsDxUAfF7KXHlG.','UserPerson','UserPL',1);

INSERT INTO users VALUES ('admin', '$2a$10$kIvj3GVD71KgmTQ3gUBwu.CwyFppYBsgTPVo89xkxvYX77/l9OTda', 'Admin', 'Admin', '1');

INSERT INTO authorities VALUES ('user','USER');

INSERT INTO authorities VALUES ('admin', 'USER');

INSERT INTO groups VALUES (1, 'ADMIN_GROUP');

INSERT INTO group_authorities VALUES (1, 'ADMIN');

INSERT INTO group_members VALUES (1, 'admin', 1);

INSERT INTO oauth_client_details
	(client_id, client_secret, scope, authorized_grant_types,
	web_server_redirect_uri, authorities, access_token_validity,
	refresh_token_validity, additional_information, autoapprove)
VALUES
	('client', '$2a$10$GKbnTlaCNgjqLzXPsOiZOOT/U/wvpBOr5AqLNFyMBEWCPYzsrxHVC', 'all',
	'password,authorization_code,refresh_token,client_credentials', 'http://localhost:8080/login/oauth2/code/test', null, 36000, 36000, null, true);
