CREATE TABLE resources (Id BIGINT AUTO_INCREMENT NOT NULL, DTYPE VARCHAR(31), Alias VARCHAR(255), PRIMARY KEY (Id))
CREATE TABLE images (ResourceId BIGINT NOT NULL, Original VARCHAR(255), Uuid LONGBLOB, PRIMARY KEY (ResourceId))
CREATE TABLE resources_images (ResourceId BIGINT NOT NULL, ImageId BIGINT NOT NULL, RelateId BIGINT NOT NULL, PRIMARY KEY (ResourceId))
CREATE TABLE grants (ResourceId BIGINT NOT NULL, Action VARCHAR(255), Pattern VARCHAR(255), UserId BIGINT NOT NULL, PRIMARY KEY (ResourceId))
CREATE UNIQUE INDEX INDEX_grants_Pattern_Action ON grants (Pattern, Action)
CREATE TABLE sessions (ResourceId BIGINT NOT NULL, Signature INTEGER, UserId BIGINT NOT NULL, PRIMARY KEY (ResourceId))
CREATE TABLE users_tokens (ResourceId BIGINT NOT NULL, Token INTEGER NOT NULL, Type INTEGER NOT NULL, UserId BIGINT NOT NULL, PRIMARY KEY (ResourceId))
CREATE TABLE users (ResourceId BIGINT NOT NULL, Email VARCHAR(255) NOT NULL, EmailConfirmed TINYINT(1) default 0, EmailNew VARCHAR(255), Identity VARCHAR(255) NOT NULL, Name VARCHAR(255) NOT NULL, Origin VARCHAR(255) NOT NULL, Pwdhash VARCHAR(255), Random INTEGER, Registered DATETIME, PRIMARY KEY (ResourceId))
CREATE UNIQUE INDEX INDEX_users_Origin_Identity_Email ON users (Origin, Identity, Email)
CREATE TABLE portals (ResourceId BIGINT NOT NULL, Content LONGTEXT, Shared TINYINT(1) default 0, Title VARCHAR(255) NOT NULL, ThumbnailId BIGINT, UserId BIGINT NOT NULL, PRIMARY KEY (ResourceId))
CREATE TABLE aspects (RelateId BIGINT, Aspect VARCHAR(255))
ALTER TABLE images ADD CONSTRAINT FK_images_ResourceId FOREIGN KEY (ResourceId) REFERENCES resources (Id) ON DELETE CASCADE
ALTER TABLE resources_images ADD CONSTRAINT FK_resources_images_ResourceId FOREIGN KEY (ResourceId) REFERENCES resources (Id) ON DELETE CASCADE
ALTER TABLE resources_images ADD CONSTRAINT FK_resources_images_RelateId FOREIGN KEY (RelateId) REFERENCES resources (Id) ON DELETE CASCADE
ALTER TABLE resources_images ADD CONSTRAINT FK_resources_images_ImageId FOREIGN KEY (ImageId) REFERENCES resources (Id)
ALTER TABLE grants ADD CONSTRAINT FK_grants_ResourceId FOREIGN KEY (ResourceId) REFERENCES resources (Id) ON DELETE CASCADE
ALTER TABLE grants ADD CONSTRAINT FK_grants_UserId FOREIGN KEY (UserId) REFERENCES resources (Id)
ALTER TABLE sessions ADD CONSTRAINT FK_sessions_UserId FOREIGN KEY (UserId) REFERENCES resources (Id)
ALTER TABLE sessions ADD CONSTRAINT FK_sessions_ResourceId FOREIGN KEY (ResourceId) REFERENCES resources (Id) ON DELETE CASCADE
ALTER TABLE users_tokens ADD CONSTRAINT FK_users_tokens_ResourceId FOREIGN KEY (ResourceId) REFERENCES resources (Id) ON DELETE CASCADE
ALTER TABLE users_tokens ADD CONSTRAINT FK_users_tokens_UserId FOREIGN KEY (UserId) REFERENCES resources (Id)
ALTER TABLE users ADD CONSTRAINT FK_users_ResourceId FOREIGN KEY (ResourceId) REFERENCES resources (Id) ON DELETE CASCADE
ALTER TABLE portals ADD CONSTRAINT FK_portals_UserId FOREIGN KEY (UserId) REFERENCES resources (Id)
ALTER TABLE portals ADD CONSTRAINT FK_portals_ResourceId FOREIGN KEY (ResourceId) REFERENCES resources (Id) ON DELETE CASCADE
ALTER TABLE portals ADD CONSTRAINT FK_portals_ThumbnailId FOREIGN KEY (ThumbnailId) REFERENCES resources (Id)
ALTER TABLE aspects ADD CONSTRAINT FK_aspects_RelateId FOREIGN KEY (RelateId) REFERENCES resources (Id) ON DELETE CASCADE
