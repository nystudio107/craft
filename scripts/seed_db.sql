# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.3.22-MariaDB-1:10.3.22+maria~bionic)
# Database: project
# Generation Time: 2020-03-17 16:41:10 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table changedattributes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changedattributes`;

CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table changedfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changedfields`;

CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,'2020-03-17 15:32:49','2020-03-17 15:32:49','b681e7de-2ead-4f83-acab-d72d673528d2');

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table drafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drafts`;

CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `trackChanges` tinyint(1) NOT NULL DEFAULT 0,
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-03-17 15:32:49','2020-03-17 15:32:49',NULL,'b7f05743-8db3-449b-80b9-8407e730392a');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2020-03-17 15:32:49','2020-03-17 15:32:49','b152d9d4-697c-4dd1-97f8-895ccd2630cc');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Common','2020-03-17 15:32:49','2020-03-17 15:32:49','95855d50-1ce1-4cd7-a8a3-356268868262');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table gqlschemas
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gqlschemas`;

CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text DEFAULT NULL,
  `isPublic` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table gqltokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gqltokens`;

CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqltokens_name_unq_idx` (`name`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `maintenance`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.4.9','3.4.10',0,'{\"dateModified\":\"@config/project.yaml\",\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"plugins\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\"}','5g9J89YLpBm6','2020-03-17 15:32:49','2020-03-17 16:32:20','634d2885-9ff9-4a4a-a2bd-68dd79ea7989');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'app','Install','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','76b60dcc-5d6f-4054-b956-dc836a14a474'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','f5cdea23-19ea-4afb-884e-d02dbdf34866'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','4cb57ef3-7570-4cd2-8d70-a661e4cfecfa'),
	(4,NULL,'app','m150403_184533_field_version','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','6b276c6d-13bd-4036-b0e2-5853069ff3ae'),
	(5,NULL,'app','m150403_184729_type_columns','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','4bdfed4b-e850-4f48-959b-d012e6ae3247'),
	(6,NULL,'app','m150403_185142_volumes','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','478b7d6b-e41a-4f68-810e-72a73c9d0f76'),
	(7,NULL,'app','m150428_231346_userpreferences','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','cf59ab05-0729-4c4f-9f7d-60c949fb7c0f'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','daf2b5c1-6b46-4659-a171-91f538940e5b'),
	(9,NULL,'app','m150617_213829_update_email_settings','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','9dcd0f38-83c9-4d5f-a311-a6536a4c9f32'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','d6a03fb0-34b6-4719-b892-03ef57acf164'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','31c41e31-6e4e-4804-8d19-8f67ab55029c'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','3ee894c6-252c-4761-85cd-7efd5a3418f7'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','5fc20fb7-ec73-43c1-9e6f-f04957a7820f'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','6afdf742-641b-4845-8836-a84c4956efb8'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','4cd360e7-4421-454c-a6ef-31be972f919a'),
	(16,NULL,'app','m151209_000000_move_logo','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','2eada73b-16bc-44fe-bd12-2b292cd893d7'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','94cef26e-129b-47b0-b953-0c9382e2b623'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','51d80c7f-d62d-46a7-91a5-e6b57388f26c'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','3ea50d49-c59d-4b0c-8db3-188e185cf107'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','35bda20a-ea20-441d-9dd7-abe0be41364a'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','062b9c24-3f2f-4943-86ad-6d6760990083'),
	(22,NULL,'app','m160727_194637_column_cleanup','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','529dc4ed-a3f6-4511-b204-8469f5b8616f'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','ec119661-c28a-4b78-b885-1a617112300b'),
	(24,NULL,'app','m160807_144858_sites','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','537432f7-f4fa-4629-8370-a5710b402117'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','05ddf9d6-b878-4fdc-8b73-b2ce75fb47e4'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','e5516860-07f6-4fa8-b037-7433d249e4ce'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','105877d3-8166-4706-adf9-bd0162eb8c91'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','2f79a257-0428-449f-a330-865041902b66'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','299f0d14-2537-4cab-a447-68efbdcbbe02'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','92e0d0b5-d6b6-4fbd-98e5-343e64e92342'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','3fe429a2-e83d-4068-9489-18511965fef9'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','e8f5f18a-2277-447a-ad05-540f985ec08a'),
	(33,NULL,'app','m161007_130653_update_email_settings','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','6061ecf5-2267-4ce6-bdd2-9158b721be11'),
	(34,NULL,'app','m161013_175052_newParentId','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','ebbac4a2-4c1b-4964-8448-3b6717a1e1eb'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','d8456a9a-3e25-458a-89dc-ee2329dda126'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','eda62ffc-7a1b-471d-862b-809e664eeda0'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','16117c57-e9b4-4228-8541-dc5e4ef476c8'),
	(38,NULL,'app','m161029_124145_email_message_languages','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','8b373fe8-31d7-4990-a346-68ad5c3c01b8'),
	(39,NULL,'app','m161108_000000_new_version_format','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','91a48dc4-facf-4fac-a9d9-c17937c2ebe0'),
	(40,NULL,'app','m161109_000000_index_shuffle','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','af24fe0c-3808-4c60-9ae6-b32f9d5f1e0d'),
	(41,NULL,'app','m161122_185500_no_craft_app','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','71a58952-3eca-4204-ac8d-b56b67771f67'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','7b984677-4e54-4494-aae0-28ae8f3b9696'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','432aa8d1-8715-422e-900f-4af67af52e7e'),
	(44,NULL,'app','m170114_161144_udates_permission','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','944531a3-5589-4dc5-8eef-665974cb0ec2'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','29ffbc98-9bed-4a5e-b57f-91901ad4cbf7'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','8ace5ff7-1d3d-477e-a8f2-d81c35f53198'),
	(47,NULL,'app','m170206_142126_system_name','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','247014e3-4352-42d8-915a-53dc6565f854'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','cbd433c9-1361-4df3-8587-5e461fa00d0f'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','c9ca48d1-8b95-4ded-ace9-2db6368b6d4d'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','3a88ea5f-51c1-4eee-904e-b23192d21f26'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','0bbdad12-b9ec-4406-a3e6-b552d703b6bd'),
	(52,NULL,'app','m170228_171113_system_messages','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','0ca3bdb4-9155-4e77-8a10-45c15f77f334'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','ee9c3865-ad28-4f8c-a205-5768a87b5354'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','2a4f27fb-b47f-471b-88e6-8e2a8a44bdc8'),
	(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','e515ce81-2763-4d9d-9cda-9358aa289500'),
	(56,NULL,'app','m170612_000000_route_index_shuffle','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','e82ee075-4837-4cc7-9b31-03de877573e1'),
	(57,NULL,'app','m170621_195237_format_plugin_handles','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','77e86917-c4dc-4928-a59f-a9702d2e6b75'),
	(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','96ee0558-1a71-4c78-8570-3dd5ae516e36'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','d479d9c2-c27d-4e57-a86a-c962d84664a1'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','fe1ab5fb-6d2e-4a8b-bbdc-aae36b91865b'),
	(61,NULL,'app','m170704_134916_sites_tables','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','6f21d50d-6162-48d6-9d01-e203fb37cc38'),
	(62,NULL,'app','m170706_183216_rename_sequences','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','a2d6c3ab-8ce3-45cb-bc80-8ca1483d66ec'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','2a4042b7-2844-40c7-a6d4-75934cee3bf4'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','3947331b-d858-417d-885e-f88d929dee7e'),
	(65,NULL,'app','m170810_201318_create_queue_table','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','97f02286-73f5-4e5a-9707-3c8844f6ece4'),
	(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','c687a1fa-08e0-4d4b-86b6-b18d6f37de82'),
	(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','d37a55ec-aac4-4efd-8c3f-b1bf57f0357e'),
	(68,NULL,'app','m171011_214115_site_groups','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','b6d6ef1b-5f83-4352-9ffc-a0527f6a2386'),
	(69,NULL,'app','m171012_151440_primary_site','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','0a34e4b0-6749-4aa4-96c7-c70b0f132014'),
	(70,NULL,'app','m171013_142500_transform_interlace','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','564e8860-bb12-4a54-bcb7-350868d91e4e'),
	(71,NULL,'app','m171016_092553_drop_position_select','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','ad24fc66-a9d6-441d-a4b5-dd0eea387e18'),
	(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','d186877c-e93e-4583-b5a8-0fd3c008808f'),
	(73,NULL,'app','m171107_000000_assign_group_permissions','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','9b05cc1d-89a7-4294-9ae2-3d9788ebe356'),
	(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','3f7eecf0-05c1-463e-86c3-691c9d038752'),
	(75,NULL,'app','m171126_105927_disabled_plugins','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','87113f97-b949-4dea-b0d4-34f3298cc599'),
	(76,NULL,'app','m171130_214407_craftidtokens_table','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','886bec31-5b09-469d-a1c0-4f8f3285bdaf'),
	(77,NULL,'app','m171202_004225_update_email_settings','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','82994cbc-ab20-40ad-bbe5-28e369094402'),
	(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','d4025f1f-c87d-47ab-a720-632e68f97185'),
	(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','c46b462c-cced-4ef0-9167-7040d65d1922'),
	(80,NULL,'app','m171218_143135_longtext_query_column','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','50bd1d2e-7b35-4d7b-94d7-5169d95d5f3f'),
	(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','05c588f5-8134-4de6-a1f2-022a54443977'),
	(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','c044674e-8630-4991-804e-f132d8939dfe'),
	(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','1bcfa423-6097-45a2-95e0-d0fcb7b78588'),
	(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','92a6e711-9435-44a3-9a50-0459656a1b43'),
	(85,NULL,'app','m180128_235202_set_tag_slugs','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','30acb6ab-b796-4277-aa42-df385c623c16'),
	(86,NULL,'app','m180202_185551_fix_focal_points','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','b9d6de51-463a-4346-b9ec-9898a8212f59'),
	(87,NULL,'app','m180217_172123_tiny_ints','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','d36b4f44-3a37-4944-a751-c78afeff13c8'),
	(88,NULL,'app','m180321_233505_small_ints','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','c9299282-3ba3-4c49-90e2-e46769319296'),
	(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','9c35e722-24aa-4447-8857-8648632c364d'),
	(90,NULL,'app','m180404_182320_edition_changes','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','ee20847e-38a2-4c0c-8ef4-171826ea75f1'),
	(91,NULL,'app','m180411_102218_fix_db_routes','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','f940fe4b-15a8-45e4-9b1e-5c79fd7d3d36'),
	(92,NULL,'app','m180416_205628_resourcepaths_table','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','cfd67897-ed0a-4cc6-a9cd-a0a8bca82046'),
	(93,NULL,'app','m180418_205713_widget_cleanup','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','9406be23-3844-4fe1-ba81-9952639adb22'),
	(94,NULL,'app','m180425_203349_searchable_fields','2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 15:32:49','4ac7f163-36ab-4daa-97ea-d2c940139f3a'),
	(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','9242e713-390d-4fde-92f1-72046cc1af23'),
	(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','d802b4d0-85d6-4a24-a652-f4b3f99875d0'),
	(97,NULL,'app','m180518_173000_permissions_to_uid','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','10716f9c-f945-4338-ad82-4134c189eef3'),
	(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','52725d29-d15d-4005-98ac-c1f5931abca1'),
	(99,NULL,'app','m180521_172900_project_config_table','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','a787ff30-fe2e-4621-8455-78dbae540aa3'),
	(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','5af0e28c-7b44-4cbd-a465-ce9fe013fd4d'),
	(101,NULL,'app','m180731_162030_soft_delete_sites','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','a4c2855b-ed0b-4fcc-981d-72dd66e8c836'),
	(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','1179bf53-e7b4-4f37-87e0-19d25e273fbe'),
	(103,NULL,'app','m180810_214439_soft_delete_elements','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','6b4e7b45-4f7e-4e49-b966-33f97f57787f'),
	(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','aa64e186-f4cd-4f1b-b634-1584532e92a3'),
	(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','5aa553bf-3055-478f-9ac2-f5c0308034a4'),
	(106,NULL,'app','m180904_112109_permission_changes','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','05537744-08c0-41f9-b07b-8c2461fc88d9'),
	(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','fdd54be4-df99-4c1c-95e1-4752e666dc26'),
	(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','4eab419b-7a7a-48dc-8adb-1ce5f6c65ced'),
	(109,NULL,'app','m181016_183648_set_default_user_settings','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','c254ab44-b22f-42fb-a966-119a592c52df'),
	(110,NULL,'app','m181017_225222_system_config_settings','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','10bb678d-c419-4011-af0a-61a1f360d60a'),
	(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','ead5f9ce-5416-437f-a41b-7d59bd506d06'),
	(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','2afd30fe-ec83-41eb-84f9-059c62f67c28'),
	(113,NULL,'app','m181112_203955_sequences_table','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','0bb45c37-bf8a-41ce-a819-40a1ab308275'),
	(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','a4321864-5b3a-412e-a20b-61e398fc162b'),
	(115,NULL,'app','m181128_193942_fix_project_config','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','48cb5b73-332b-4f53-aedd-0a7c1ad8d6c8'),
	(116,NULL,'app','m181130_143040_fix_schema_version','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','ac595885-a4c6-4b20-9db8-4b2e759df364'),
	(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','d39dcccf-2f81-4956-a273-488f90a53cce'),
	(118,NULL,'app','m181213_102500_config_map_aliases','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','f9959ab1-d272-4c9f-950a-988341527641'),
	(119,NULL,'app','m181217_153000_fix_structure_uids','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','7fb01bd2-770f-4786-9445-ca7835d6192c'),
	(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','304456e4-3eef-4554-aaf4-25de8d4d8e4c'),
	(121,NULL,'app','m190108_110000_cleanup_project_config','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','0cadaf1e-8bdf-4a32-ac53-a19c8a3e549d'),
	(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','901a04ee-d21a-4fa9-b5c1-705273ab9750'),
	(123,NULL,'app','m190109_172845_fix_colspan','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','1c55e584-00a5-4ac4-a925-93bd36ae21fc'),
	(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','2e25e256-ffee-4a23-85f0-337be023e0e1'),
	(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','391bbaf0-a895-4465-9940-33d83fa9d847'),
	(126,NULL,'app','m190112_124737_fix_user_settings','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','c958de28-9197-47f0-a7a9-0cd71c92d2ec'),
	(127,NULL,'app','m190112_131225_fix_field_layouts','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','111633e4-8238-4f5e-b74e-3e3fa6b7a823'),
	(128,NULL,'app','m190112_201010_more_soft_deletes','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','37673509-5738-48c5-8820-f2937ebe6207'),
	(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','048c266d-faa1-45e9-bffd-795098c9eceb'),
	(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','698c8af2-dc26-4f0b-a613-df29a1d64cea'),
	(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','bbadc515-29e3-4e72-983d-73ebe2a6d3d6'),
	(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','93f562f9-df26-4bf2-a7d2-15ec540fd8ba'),
	(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','6d577a9b-1dc6-428e-bbdb-ec2e1fbe4d10'),
	(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','8fd33771-ba56-4e3c-a0c1-db64dbf397df'),
	(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','b651598c-a68c-44ae-a2cc-1b9c6a91de50'),
	(136,NULL,'app','m190312_152740_element_revisions','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','c0013ac7-8921-4a46-951f-3ca75d0fcb90'),
	(137,NULL,'app','m190327_235137_propagation_method','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','a7ccb5ee-d425-4562-9166-610a574aaedc'),
	(138,NULL,'app','m190401_223843_drop_old_indexes','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','63178149-be89-4a35-b3a4-d39baa3e460e'),
	(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','c723ef07-0a96-4075-8562-c0ac6f800cc2'),
	(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','f10d6a3f-2b60-4a38-8b81-1de1279f9a9c'),
	(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','f62680a8-3144-4acf-ac64-cee6933dd9a4'),
	(142,NULL,'app','m190504_150349_preview_targets','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','ec39c01a-ffb4-4fd0-bdac-8e646e9e5da4'),
	(143,NULL,'app','m190516_184711_job_progress_label','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','c2ac9dbc-dcfe-4aff-b537-947b9ad0d010'),
	(144,NULL,'app','m190523_190303_optional_revision_creators','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','f1084b28-ae8d-4029-ada9-809243d1e3d5'),
	(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','daef2e58-e70d-4d19-bd29-b1cd3ddba043'),
	(146,NULL,'app','m190605_223807_unsaved_drafts','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','b3f12b5f-170e-4d65-b495-e438cf053eb7'),
	(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','a3c3f568-6caa-45ed-b910-4f70829b8891'),
	(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','d1ac09e9-eaa6-481d-9e9d-20e9a0ea962e'),
	(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','7cd4cbc7-f24d-46a0-84a8-e7178e078c92'),
	(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','af1f1741-b4ee-4f9f-bbf2-84cd5c332911'),
	(151,NULL,'app','m190711_153020_drop_snapshots','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','48fda000-2a7f-4c8b-b49f-49d24beb73d0'),
	(152,NULL,'app','m190712_195914_no_draft_revisions','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','a7552067-cb7f-4b93-b1f2-c68dad4a5fbe'),
	(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','455b7f1c-0e17-4c84-b187-410fced7fae3'),
	(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','ab2dbccb-ba1e-4b55-ab13-6b4fa4988129'),
	(155,NULL,'app','m190823_020339_optional_draft_creators','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','b5abaf26-a846-4b65-8b08-bc7cf39ab94e'),
	(156,NULL,'app','m190913_152146_update_preview_targets','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','88a480e3-13a3-4917-90a7-9990a05d37d2'),
	(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','c0afad71-01e7-4de3-873b-c0e1013b4e11'),
	(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','7a603c4d-5c7c-4167-bf2b-6c7469936e5d'),
	(159,NULL,'app','m191206_001148_change_tracking','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','4cfac7c3-58d0-4d12-a463-9569554ee58d'),
	(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','b3c0c58e-82d8-48cc-a5fd-a3a6655425ae'),
	(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','8f35f8e3-a0a5-41b4-aacb-6b872d2cab2d'),
	(162,NULL,'app','m200127_172522_queue_channels','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','3562857e-a221-4c5f-aaed-30f58ff4263b'),
	(163,NULL,'app','m200211_175048_truncate_element_query_cache','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','f9012bd0-ba10-497a-8915-3cb12e8126c3'),
	(164,NULL,'app','m200213_172522_new_elements_index','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','73c39a4e-65f3-4b74-b323-b5b59f9e641c'),
	(165,NULL,'app','m200228_195211_long_deprecation_messages','2020-03-17 15:32:50','2020-03-17 15:32:50','2020-03-17 15:32:50','0b8bfac4-287a-4c81-9441-ac4d13e2dfc9'),
	(166,4,'plugin','Install','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','7cca439e-b9c2-498e-8a4e-f3b1ac15b070'),
	(167,4,'plugin','m181013_122446_add_remote_ip','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','e16faf8e-a3fd-4d5b-a4b8-1a90e8f5e592'),
	(168,4,'plugin','m181013_171315_truncate_match_type','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','d6a47c0d-f305-4da9-8bad-89e7b633e77a'),
	(169,4,'plugin','m181013_202455_add_redirect_src_match','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','a9a94491-ef51-43e6-8d29-89be7530900a'),
	(170,4,'plugin','m181018_123901_add_stats_info','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','ccb4d4c1-20d1-4b26-ae54-aab7adef2b7b'),
	(171,4,'plugin','m181018_135656_add_redirect_status','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','c7573839-cf85-4c0c-aa36-e967af5cc368'),
	(172,4,'plugin','m181213_233502_add_site_id','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','d4dbefdd-d059-4f8e-bf60-35f9829a408a'),
	(173,4,'plugin','m181216_043222_rebuild_indexes','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','434729f5-2e1a-49f3-8683-c6199261801d'),
	(174,4,'plugin','m190416_212500_widget_type_update','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','34ffdc24-0a80-445d-867d-df742d737a01'),
	(175,4,'plugin','m200109_144310_add_redirectSrcUrl_index','2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 15:48:40','a0045e91-cb7f-4256-b331-61bca90b2312'),
	(176,5,'plugin','Install','2020-03-17 15:48:52','2020-03-17 15:48:52','2020-03-17 15:48:52','ffc59df7-5a26-42b5-83cb-6bd95a55b1eb'),
	(177,5,'plugin','m180314_002755_field_type','2020-03-17 15:48:52','2020-03-17 15:48:52','2020-03-17 15:48:52','6e5f09de-7bf1-4d06-bef1-3cc6509bf874'),
	(178,5,'plugin','m180314_002756_base_install','2020-03-17 15:48:52','2020-03-17 15:48:52','2020-03-17 15:48:52','dedf186e-c0a5-4c55-b4ed-6434270f3de2'),
	(179,5,'plugin','m180502_202319_remove_field_metabundles','2020-03-17 15:48:52','2020-03-17 15:48:52','2020-03-17 15:48:52','dfca12bb-2349-425f-96f5-1dc8e2ee35c8'),
	(180,5,'plugin','m180711_024947_commerce_products','2020-03-17 15:48:52','2020-03-17 15:48:52','2020-03-17 15:48:52','9239ba11-0816-4d8e-85f4-868ca0bcc5d1'),
	(181,5,'plugin','m190401_220828_longer_handles','2020-03-17 15:48:52','2020-03-17 15:48:52','2020-03-17 15:48:52','ce5d883a-0cb6-40d1-a062-fa70becbb9f4'),
	(182,5,'plugin','m190518_030221_calendar_events','2020-03-17 15:48:52','2020-03-17 15:48:52','2020-03-17 15:48:52','4e0443b9-31c4-47e0-9ec9-06e0673d4055'),
	(183,8,'plugin','Install','2020-03-17 15:49:06','2020-03-17 15:49:06','2020-03-17 15:49:06','a5ffe8b2-3c1f-4dbe-9369-a3b08427137d'),
	(184,8,'plugin','m190625_151715_add_indexes','2020-03-17 15:49:06','2020-03-17 15:49:06','2020-03-17 15:49:06','3f228f0c-9e01-4087-a2d2-0208ab1c4837');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKeyStatus`, `licensedEdition`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'fastcgi-cache-bust','1.0.8','1.0.0','unknown',NULL,'2020-03-17 15:48:24','2020-03-17 15:48:24','2020-03-17 16:33:09','040546ee-d205-4297-8734-7b94a074d68a'),
	(2,'image-optimize','1.6.11','1.0.0','invalid',NULL,'2020-03-17 15:48:26','2020-03-17 15:48:26','2020-03-17 16:33:09','0d3e41f3-14b4-49fa-aaed-f7ef21f22fda'),
	(3,'minify','1.2.9','1.0.0','unknown',NULL,'2020-03-17 15:48:37','2020-03-17 15:48:37','2020-03-17 16:33:09','412c9c9b-724b-4c3d-aa93-1960cc357fff'),
	(4,'retour','3.1.35','3.0.9','invalid',NULL,'2020-03-17 15:48:40','2020-03-17 15:48:40','2020-03-17 16:33:09','dfcff684-dbbc-4002-ae74-b5c36ddd721a'),
	(5,'seomatic','3.2.47','3.0.8','invalid',NULL,'2020-03-17 15:48:51','2020-03-17 15:48:51','2020-03-17 16:33:09','858bb623-4ac4-452f-94e2-1c705d0feebd'),
	(6,'twigpack','1.2.0','1.0.0','unknown',NULL,'2020-03-17 15:48:59','2020-03-17 15:48:59','2020-03-17 16:33:09','15623529-b636-436d-a745-5e8451e2f926'),
	(7,'typogrify','1.1.18','1.0.0','unknown',NULL,'2020-03-17 15:49:02','2020-03-17 15:49:02','2020-03-17 16:33:09','102f9bd2-5a5c-4848-ad6d-ec3352b57119'),
	(8,'webperf','1.0.18','1.0.1','invalid',NULL,'2020-03-17 15:49:06','2020-03-17 15:49:06','2020-03-17 16:33:09','907c34c2-4092-45e0-bdb2-f07687199e6c');

/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table projectconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projectconfig`;

CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;

INSERT INTO `projectconfig` (`path`, `value`)
VALUES
	('dateModified','1584460146'),
	('email.fromEmail','\"andrew@nystudio107.com\"'),
	('email.fromName','\"$SITE_NAME\"'),
	('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),
	('fieldGroups.95855d50-1ce1-4cd7-a8a3-356268868262.name','\"Common\"'),
	('plugins.fastcgi-cache-bust.edition','\"standard\"'),
	('plugins.fastcgi-cache-bust.enabled','true'),
	('plugins.fastcgi-cache-bust.schemaVersion','\"1.0.0\"'),
	('plugins.image-optimize.edition','\"standard\"'),
	('plugins.image-optimize.enabled','true'),
	('plugins.image-optimize.schemaVersion','\"1.0.0\"'),
	('plugins.minify.edition','\"standard\"'),
	('plugins.minify.enabled','true'),
	('plugins.minify.schemaVersion','\"1.0.0\"'),
	('plugins.retour.edition','\"standard\"'),
	('plugins.retour.enabled','true'),
	('plugins.retour.schemaVersion','\"3.0.9\"'),
	('plugins.seomatic.edition','\"standard\"'),
	('plugins.seomatic.enabled','true'),
	('plugins.seomatic.schemaVersion','\"3.0.8\"'),
	('plugins.twigpack.edition','\"standard\"'),
	('plugins.twigpack.enabled','true'),
	('plugins.twigpack.schemaVersion','\"1.0.0\"'),
	('plugins.typogrify.edition','\"standard\"'),
	('plugins.typogrify.enabled','true'),
	('plugins.typogrify.schemaVersion','\"1.0.0\"'),
	('plugins.webperf.edition','\"standard\"'),
	('plugins.webperf.enabled','true'),
	('plugins.webperf.schemaVersion','\"1.0.1\"'),
	('siteGroups.680ffe49-fcdf-4397-8c38-0513456a0001.name','\"$SITE_NAME\"'),
	('sites.3e87fd4e-2b83-46f0-8b8e-5e5032649cf1.baseUrl','\"$SITE_URL\"'),
	('sites.3e87fd4e-2b83-46f0-8b8e-5e5032649cf1.handle','\"default\"'),
	('sites.3e87fd4e-2b83-46f0-8b8e-5e5032649cf1.hasUrls','true'),
	('sites.3e87fd4e-2b83-46f0-8b8e-5e5032649cf1.language','\"en-US\"'),
	('sites.3e87fd4e-2b83-46f0-8b8e-5e5032649cf1.name','\"$SITE_NAME\"'),
	('sites.3e87fd4e-2b83-46f0-8b8e-5e5032649cf1.primary','true'),
	('sites.3e87fd4e-2b83-46f0-8b8e-5e5032649cf1.siteGroup','\"680ffe49-fcdf-4397-8c38-0513456a0001\"'),
	('sites.3e87fd4e-2b83-46f0-8b8e-5e5032649cf1.sortOrder','1'),
	('system.edition','\"solo\"'),
	('system.live','true'),
	('system.name','\"$SITE_NAME\"'),
	('system.schemaVersion','\"3.4.10\"'),
	('system.timeZone','\"America/Los_Angeles\"'),
	('users.allowPublicRegistration','false'),
	('users.defaultGroup','null'),
	('users.photoSubpath','\"\"'),
	('users.photoVolumeUid','null'),
	('users.requireEmailVerification','true');

/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resourcepaths`;

CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;

INSERT INTO `resourcepaths` (`hash`, `path`)
VALUES
	('13799368','@lib/fileupload'),
	('23cf717f','@lib/fabric'),
	('25c2fc0','@nystudio107/webperf/assetbundles/webperf/dist'),
	('332a291','@craft/web/assets/utilities/dist'),
	('35d8ec85','@nystudio107/imageoptimize/assetbundles/imageoptimize/dist'),
	('3689a541','@lib/garnishjs'),
	('3e93206b','@nystudio107/seomatic/assetbundles/seomatic/dist'),
	('43be43ca','@craft/web/assets/updateswidget/dist'),
	('50bbaa26','@craft/web/assets/pluginstore/dist'),
	('534b2c7','@lib/d3'),
	('5583fb98','@lib/xregexp'),
	('59c09a5b','@craft/web/assets/cp/dist'),
	('5fefbf12','@lib/selectize'),
	('627667a9','@app/web/assets/plugins/dist'),
	('71d024c','@nystudio107/retour/assetbundles/retour/dist'),
	('7d0401a4','@craft/web/assets/recententries/dist'),
	('873bae11','@bower/jquery/dist'),
	('8a93f684','@lib/jquery.payment'),
	('96b4596c','@lib/velocity'),
	('a244ae4c','@craft/web/assets/dashboard/dist'),
	('a8ab05e4','@lib/element-resize-detector'),
	('b919296','@lib/picturefill'),
	('c35ae54','@lib/jquery-touch-events'),
	('c6a37378','@craft/web/assets/plugins/dist'),
	('d21dc5e6','@modules/sitemodule/assetbundles/sitemodule/dist'),
	('d2ca8280','@lib/axios'),
	('d81dc2c9','@lib/jquery-ui'),
	('db078887','@craft/web/assets/feed/dist'),
	('db1e48ff','@craft/web/assets/clearcaches/dist'),
	('e3b064f6','@app/web/assets/cp/dist'),
	('e412b5c3','@craft/web/assets/craftsupport/dist'),
	('ec14020e','@craft/web/assets/login/dist'),
	('ee8592cf','@craft/web/assets/dbbackup/dist'),
	('f40fcc9d','@nystudio107/webperf/assetbundles/boomerang/dist/js'),
	('ff2121f5','@lib/vue');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table retour_redirects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `retour_redirects`;

CREATE TABLE `retour_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT 301,
  `hitCount` int(11) DEFAULT 1,
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_redirects_siteId_idx` (`siteId`),
  KEY `retour_redirects_associatedElementId_fk` (`associatedElementId`),
  CONSTRAINT `retour_redirects_associatedElementId_fk` FOREIGN KEY (`associatedElementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table retour_static_redirects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `retour_static_redirects`;

CREATE TABLE `retour_static_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT 301,
  `hitCount` int(11) DEFAULT 1,
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_static_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_static_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_static_redirects_siteId_idx` (`siteId`),
  CONSTRAINT `retour_static_redirects_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table retour_stats
# ------------------------------------------------------------

DROP TABLE IF EXISTS `retour_stats`;

CREATE TABLE `retour_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `referrerUrl` varchar(2000) DEFAULT '',
  `remoteIp` varchar(45) DEFAULT '',
  `userAgent` varchar(255) DEFAULT '',
  `exceptionMessage` varchar(255) DEFAULT '',
  `exceptionFilePath` varchar(255) DEFAULT '',
  `exceptionFileLine` int(11) DEFAULT 0,
  `hitCount` int(11) DEFAULT 1,
  `hitLastTime` datetime DEFAULT NULL,
  `handledByRetour` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `retour_stats_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_stats_siteId_idx` (`siteId`),
  CONSTRAINT `retour_stats_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `retour_stats` WRITE;
/*!40000 ALTER TABLE `retour_stats` DISABLE KEYS */;

INSERT INTO `retour_stats` (`id`, `dateCreated`, `dateUpdated`, `uid`, `siteId`, `redirectSrcUrl`, `referrerUrl`, `remoteIp`, `userAgent`, `exceptionMessage`, `exceptionFilePath`, `exceptionFileLine`, `hitCount`, `hitLastTime`, `handledByRetour`)
VALUES
	(1,'2020-03-17 15:48:42','2020-03-17 16:33:00','e3184a85-2255-4b5d-bf48-4066e9b8bd10',1,'/favicon.ico','http://localhost:8000/admin/utilities/db-backup','172.19.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.5 Safari/605.1.15','Template not found: favicon.ico','/var/www/project/cms/vendor/craftcms/cms/src/controllers/TemplatesController.php',90,9,'2020-03-17 16:33:00',0);

/*!40000 ALTER TABLE `retour_stats` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table revisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `revisions`;

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'username',0,1,' admin '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' andrew nystudio107 com '),
	(1,'slug',0,1,'');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table seomatic_metabundles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `seomatic_metabundles`;

CREATE TABLE `seomatic_metabundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int(11) DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(255) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int(11) DEFAULT NULL,
  `sourceAltSiteSettings` text DEFAULT NULL,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text DEFAULT NULL,
  `metaSiteVars` text DEFAULT NULL,
  `metaSitemapVars` text DEFAULT NULL,
  `metaContainers` text DEFAULT NULL,
  `redirectsContainer` text DEFAULT NULL,
  `frontendTemplatesContainer` text DEFAULT NULL,
  `metaBundleSettings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;

INSERT INTO `seomatic_metabundles` (`id`, `dateCreated`, `dateUpdated`, `uid`, `bundleVersion`, `sourceBundleType`, `sourceId`, `sourceName`, `sourceHandle`, `sourceType`, `sourceTemplate`, `sourceSiteId`, `sourceAltSiteSettings`, `sourceDateUpdated`, `metaGlobalVars`, `metaSiteVars`, `metaSitemapVars`, `metaContainers`, `redirectsContainer`, `frontendTemplatesContainer`, `metaBundleSettings`)
VALUES
	(1,'2020-03-17 15:48:52','2020-03-17 15:48:52','c10d4d49-b719-4e49-95cc-907eae7de2ed','1.0.46','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','',1,'[]','2020-03-17 15:48:51','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"nystudio107\",\"genericAlternateName\":\"nys\",\"genericDescription\":\"We do technology-based consulting, branding, design, and development. Making the web better one site at a time, with a focus on performance, usability & SEO\",\"genericUrl\":\"https://nystudio107.com/\",\"genericImage\":\"https://nystudio107-ems2qegf7x6qiqq.netdna-ssl.com/img/site/nys_logo_seo.png\",\"genericImageWidth\":\"1042\",\"genericImageHeight\":\"1042\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"info@nystudio107.com\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"Webster\",\"genericAddressRegion\":\"NY\",\"genericPostalCode\":\"14580\",\"genericAddressCountry\":\"US\",\"genericGeoLatitude\":\"43.2365384\",\"genericGeoLongitude\":\"-77.49211620000001\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"Andrew Welch, Polly Welch\",\"organizationFoundingDate\":\"2013-05-02\",\"organizationFoundingLocation\":\"Webster, NY\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]}},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"no-referrer-when-downgrade\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"none\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creator\":{\"id\":\"{seomatic.site.creator.genericUrl}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{seomatic.site.identity.genericUrl}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{seomatic.site.creator.genericUrl}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');

/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sequences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sequences`;

CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'pdljTk13yVoRTN8ncvgT6uJUBdwxD3JFPEZocUZlfiIjqOSQqcszbxuVUDhu_iKxWhcRkgoCdkCJKM3RUCJioQZtQEStqeOpC_lQ','2020-03-17 15:47:45','2020-03-17 15:53:30','1434f70c-608f-43c5-9660-9266c29cb797'),
	(2,1,'KPpF47pGl23ZEzsBHWqdnymEA4vX9vRkT_uS02MT5Qj_ab9_kLhDt8xfmFmBbNyc5QXIyGP_SQbm_UF0Uz0Ve_e8wk36xAOZvPH7','2020-03-17 16:13:28','2020-03-17 16:18:45','0711ca28-00bf-482f-a671-43535e1ec187'),
	(3,1,'KjQqRHmgHooBELn8p39g_z9JhNABWNQ-GmKZcxKrLBNV-IEVBFcXIyOyucanbEvqc1Z5MbLXrSsqqcbmrT7SQpGpUAA4PS0Mxbde','2020-03-17 16:29:45','2020-03-17 16:29:45','1a027b74-04df-45d8-a357-4cfc02eae11e'),
	(4,1,'OOUZY9NrSbN_LmrJskzJgCE5y5U_aFGgxX8jLBozBtetDwafhO3tpzhuPunYjtN8MSSTjOIu_qQKmrlQJvDOMfRiN2qIcglfB-TN','2020-03-17 16:32:52','2020-03-17 16:33:09','75b22d9c-d036-45d7-ba27-5d54504cc1e5');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'$SITE_NAME','2020-03-17 15:32:49','2020-03-17 15:32:49',NULL,'680ffe49-fcdf-4397-8c38-0513456a0001');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,'$SITE_NAME','default','en-US',1,'$SITE_URL',1,'2020-03-17 15:32:49','2020-03-17 15:32:49',NULL,'3e87fd4e-2b83-46f0-8b8e-5e5032649cf1');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-US\"}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'admin',NULL,NULL,NULL,'andrew@nystudio107.com','$2y$13$YTIT1Z/90nKGJ7bRisRCDuNpkIGrk/GrpO9FurYDDzDghkIhx3yVO',1,0,0,0,'2020-03-17 16:32:52',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-03-17 15:32:49','2020-03-17 15:32:49','2020-03-17 16:32:52','cbbc3d22-3825-479c-ba28-e0bca86748d2');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table webperf_data_samples
# ------------------------------------------------------------

DROP TABLE IF EXISTS `webperf_data_samples`;

CREATE TABLE `webperf_data_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint(20) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `dns` int(11) DEFAULT NULL,
  `connect` int(11) DEFAULT NULL,
  `firstByte` int(11) DEFAULT NULL,
  `firstPaint` int(11) DEFAULT NULL,
  `firstContentfulPaint` int(11) DEFAULT NULL,
  `domInteractive` int(11) DEFAULT NULL,
  `pageLoad` int(11) DEFAULT NULL,
  `countryCode` varchar(2) DEFAULT NULL,
  `device` varchar(50) DEFAULT NULL,
  `browser` varchar(50) DEFAULT NULL,
  `os` varchar(50) DEFAULT NULL,
  `mobile` tinyint(1) DEFAULT NULL,
  `craftTotalMs` int(11) DEFAULT NULL,
  `craftDbMs` int(11) DEFAULT NULL,
  `craftDbCnt` int(11) DEFAULT NULL,
  `craftTwigMs` int(11) DEFAULT NULL,
  `craftTwigCnt` int(11) DEFAULT NULL,
  `craftOtherMs` int(11) DEFAULT NULL,
  `craftOtherCnt` int(11) DEFAULT NULL,
  `craftTotalMemory` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webperf_data_samples_url_idx` (`url`),
  KEY `webperf_data_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_data_samples_requestId_idx` (`requestId`),
  KEY `webperf_data_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_data_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `webperf_data_samples` WRITE;
/*!40000 ALTER TABLE `webperf_data_samples` DISABLE KEYS */;

INSERT INTO `webperf_data_samples` (`id`, `dateCreated`, `dateUpdated`, `uid`, `requestId`, `siteId`, `title`, `url`, `queryString`, `dns`, `connect`, `firstByte`, `firstPaint`, `firstContentfulPaint`, `domInteractive`, `pageLoad`, `countryCode`, `device`, `browser`, `os`, `mobile`, `craftTotalMs`, `craftDbMs`, `craftDbCnt`, `craftTwigMs`, `craftTwigCnt`, `craftOtherMs`, `craftOtherCnt`, `craftTotalMemory`)
VALUES
	(1,'2020-03-17 15:49:16','2020-03-17 15:49:16','1ae5a9d4-bb6a-44e9-b62d-7f1a412feb3a',7219243089404105062,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,1178,NULL,NULL,1197,1300,'??','Macintosh','Safari 13.0.5','OS X Catalina 10.15',0,1725,19,37,0,0,1705,431,6753560),
	(3,'2020-03-17 15:49:36','2020-03-17 15:49:36','896983bb-496e-405a-bd64-c227d474f7d7',6874873889020294904,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,351,NULL,NULL,419,422,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,410,16,28,0,0,393,111,6565408),
	(4,'2020-03-17 15:58:40','2020-03-17 15:58:40','a34b0d17-98e1-4158-8798-13b48771f590',6244040475410868965,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,1158,1206,1206,1202,1205,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,1363,21,31,0,0,1342,342,7262728),
	(5,'2020-03-17 16:17:12','2020-03-17 16:17:12','43f94833-caaf-446a-87c2-a17e5b77d7b5',4457031445383885073,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,1,1882,1941,1941,1934,1940,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,2237,26,31,0,0,2210,435,7278880),
	(6,'2020-03-17 16:17:30','2020-03-17 16:17:30','8c0d1dda-0173-4fbc-920e-0ecb11f8e85d',4827709507947154270,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,418,NULL,NULL,456,460,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,637,17,28,0,0,619,111,6710432),
	(7,'2020-03-17 16:18:24','2020-03-17 16:18:25','199dede6-e718-4095-86d7-0d04a17d332a',6689065480365258910,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,580,630,630,611,618,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,429,17,31,0,0,412,342,6052680),
	(8,'2020-03-17 16:18:49','2020-03-17 16:18:49','729bf66c-bcbd-4110-909a-f0fb0e663392',3938844362355440200,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,1296,NULL,NULL,1328,1335,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,1609,19,31,0,0,1590,435,6822400),
	(10,'2020-03-17 16:22:45','2020-03-17 16:26:42','b71496ed-6bbf-4027-a553-aaa032e26c52',7003146698888495438,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,4,NULL,NULL,29,36,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,298,16,28,0,0,282,111,6109120),
	(11,'2020-03-17 16:26:45','2020-03-17 16:26:45','1267413a-d16c-4ded-8663-d3bbcfbfc7a9',8171950937354787673,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,614,667,667,1077,1247,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,493,18,31,0,0,474,343,5890488),
	(12,'2020-03-17 16:26:55','2020-03-17 16:26:56','49b8ec15-21ec-4aaa-ae1a-cb115755eea4',3975503173459092656,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,398,483,483,678,823,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,489,16,28,0,0,473,111,6109120),
	(13,'2020-03-17 16:29:58','2020-03-17 16:29:59','755b1ee7-0591-477b-aab1-a798c45dac58',5604250606847390331,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,1952,2005,2005,1993,2480,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,2290,20,31,0,0,2269,435,6868240),
	(14,'2020-03-17 16:32:28','2020-03-17 16:32:29','774388de-2ca8-45ad-9cde-58369f38ed92',4015136226679722355,1,'&#x1f6a7; |','http://localhost:8000/',NULL,NULL,NULL,2754,NULL,NULL,2803,3290,'??','Macintosh','Chrome 80','OS X Catalina 10.15',0,2458,23,31,0,0,2435,435,7010184);

/*!40000 ALTER TABLE `webperf_data_samples` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table webperf_error_samples
# ------------------------------------------------------------

DROP TABLE IF EXISTS `webperf_error_samples`;

CREATE TABLE `webperf_error_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint(20) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `type` varchar(16) DEFAULT '',
  `pageErrors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webperf_error_samples_url_idx` (`url`),
  KEY `webperf_error_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_error_samples_requestId_idx` (`requestId`),
  KEY `webperf_error_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_error_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `webperf_error_samples` WRITE;
/*!40000 ALTER TABLE `webperf_error_samples` DISABLE KEYS */;

INSERT INTO `webperf_error_samples` (`id`, `dateCreated`, `dateUpdated`, `uid`, `requestId`, `siteId`, `title`, `url`, `queryString`, `type`, `pageErrors`)
VALUES
	(1,'2020-03-17 15:49:16','2020-03-17 15:49:16','ab5666c9-6468-48f0-9567-b17c2caa4240',7219243089404105062,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(2,'2020-03-17 15:49:21','2020-03-17 15:49:21','2c524207-706f-40c2-b7f1-588697a0c3a4',5408688328742409068,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(3,'2020-03-17 15:49:36','2020-03-17 15:49:36','2bbf8fb3-da3c-4b9e-a01f-c4ab7e908f6d',6874873889020294904,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(4,'2020-03-17 15:58:40','2020-03-17 15:58:40','d240aeac-f82a-414d-a574-4afaca4689dd',6244040475410868965,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(5,'2020-03-17 16:17:12','2020-03-17 16:17:12','0505bbb5-ad23-4dda-a22f-b8acdf686030',4457031445383885073,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(6,'2020-03-17 16:17:30','2020-03-17 16:17:30','d604cd76-c85f-4554-8fa8-517ef828a67e',4827709507947154270,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(7,'2020-03-17 16:18:24','2020-03-17 16:18:24','09a7997b-0981-4bf8-847d-bb4955ec9f2e',6689065480365258910,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(8,'2020-03-17 16:18:49','2020-03-17 16:18:49','102764b4-068f-46f4-8cd9-236f5ef6a297',3938844362355440200,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(9,'2020-03-17 16:22:44','2020-03-17 16:22:44','7870bf40-e934-411f-b486-b18b9892f0fe',4071912861662906614,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(10,'2020-03-17 16:22:45','2020-03-17 16:22:45','b4f356c0-30f8-4197-985d-45962414800e',7003146698888495438,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(11,'2020-03-17 16:26:45','2020-03-17 16:26:45','b563b019-27b6-4b52-be2e-f4a7463d8f61',8171950937354787673,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]'),
	(12,'2020-03-17 16:26:55','2020-03-17 16:26:55','6bec6cf4-ecb4-4180-8d32-6334ea093859',3975503173459092656,1,'&#x1f6a7; |','http://localhost:8000/','','craft','[{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"},{\"level\":\"error\",\"message\":\"Manifest file not found at: @webroot/dist/\",\"category\":\"nystudio107\\\\twigpack\\\\helpers\\\\Manifest::reportError\"}]');

/*!40000 ALTER TABLE `webperf_error_samples` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-03-17 15:47:46','2020-03-17 15:47:46','294f31fe-f176-40d7-8ad1-a1de0217a82d'),
	(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-03-17 15:47:46','2020-03-17 15:47:46','50576be8-e41d-4acb-a53b-b213a416ee59'),
	(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-03-17 15:47:46','2020-03-17 15:47:46','1325c971-44d6-4f77-b9e3-58cd0fba6101'),
	(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-03-17 15:47:46','2020-03-17 15:47:46','af45dfb1-145b-475e-92bd-3fa4dfb90d67');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
