# WARNING: Using a password on the command line interface can be insecure.
# server1 on 127.0.0.1: ... connected.
# server2 on 127.0.0.1: ... connected.
# WARNING: Objects in server1.db_test_cts but not in server1.db:
#        TABLE: whitelabel_node__comment
#        TABLE: watchdog
#        TABLE: whitelabel_node_revision__field_tags
#        TABLE: whitelabel_node__field_tags
#        TABLE: whitelabel_node_revision__comment
#        TABLE: flyway_schema_history
# Comparing `db` to `db_test_cts`                                  [PASS]
# Comparing `db`.`whitelabel_batch` to `db_test_cts`.`whitelabel_batch`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_batch`
+++ `db_test_cts`.`whitelabel_batch`
@@ -1,8 +1,7 @@
 CREATE TABLE `whitelabel_batch` (
-  `bid` int unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
-  `token` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'A string token generated against the current user''s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
-  `timestamp` int NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
-  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
-  PRIMARY KEY (`bid`),
-  KEY `token` (`token`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores details about batches (processes that run in…'
+  `bid` int unsigned NOT NULL,
+  `token` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `timestamp` int NOT NULL,
+  `batch` longblob,
+  PRIMARY KEY (`bid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_block_content` to `db_test_cts`.`whitelabel_block_content`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_block_content`
+++ `db_test_cts`.`whitelabel_block_content`
@@ -1,11 +1,8 @@
 CREATE TABLE `whitelabel_block_content` (
-  `id` int unsigned NOT NULL AUTO_INCREMENT,
+  `id` int unsigned NOT NULL,
   `revision_id` int unsigned DEFAULT NULL,
-  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`id`),
-  UNIQUE KEY `block_content_field__uuid__value` (`uuid`),
-  UNIQUE KEY `block_content__revision_id` (`revision_id`),
-  KEY `block_content_field__type__target_id` (`type`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for block_content entities.'
+  PRIMARY KEY (`id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_block_content__body` to `db_test_cts`.`whitelabel_block_content__body`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_block_content__body`
+++ `db_test_cts`.`whitelabel_block_content__body`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_block_content__body` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `body_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `body_summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `body_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `body_format` (`body_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for block_content field body.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_block_content_field_data` to `db_test_cts`.`whitelabel_block_content_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_block_content_field_data`
+++ `db_test_cts`.`whitelabel_block_content_field_data`
@@ -1,7 +1,7 @@
 CREATE TABLE `whitelabel_block_content_field_data` (
   `id` int unsigned NOT NULL,
   `revision_id` int unsigned NOT NULL,
-  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `status` tinyint NOT NULL,
   `info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
@@ -9,9 +9,5 @@
   `reusable` tinyint DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`id`,`langcode`),
-  KEY `block_content__id__default_langcode__langcode` (`id`,`default_langcode`,`langcode`),
-  KEY `block_content__revision_id` (`revision_id`),
-  KEY `block_content_field__type__target_id` (`type`),
-  KEY `block_content__status_type` (`status`,`type`,`id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for block_content entities.'
+  PRIMARY KEY (`id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_block_content_field_revision` to `db_test_cts`.`whitelabel_block_content_field_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_block_content_field_revision`
+++ `db_test_cts`.`whitelabel_block_content_field_revision`
@@ -7,6 +7,5 @@
   `changed` int DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`,`langcode`),
-  KEY `block_content__id__default_langcode__langcode` (`id`,`default_langcode`,`langcode`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision data table for block_content entities.'
+  PRIMARY KEY (`revision_id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_block_content_revision` to `db_test_cts`.`whitelabel_block_content_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_block_content_revision`
+++ `db_test_cts`.`whitelabel_block_content_revision`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_block_content_revision` (
   `id` int unsigned NOT NULL,
-  `revision_id` int unsigned NOT NULL AUTO_INCREMENT,
+  `revision_id` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  `revision_user` int unsigned DEFAULT NULL COMMENT 'The ID of the target entity.',
+  `revision_user` int unsigned DEFAULT NULL,
   `revision_created` int DEFAULT NULL,
   `revision_log` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `revision_default` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`),
-  KEY `block_content__id` (`id`),
-  KEY `block_content_field__revision_user__target_id` (`revision_user`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision table for block_content entities.'
+  PRIMARY KEY (`revision_id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_block_content_revision__body` to `db_test_cts`.`whitelabel_block_content_revision__body`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_block_content_revision__body`
+++ `db_test_cts`.`whitelabel_block_content_revision__body`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_block_content_revision__body` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `body_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `body_summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `body_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `body_format` (`body_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for block_content field body.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_bootstrap` to `db_test_cts`.`whitelabel_cache_bootstrap`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_bootstrap`
+++ `db_test_cts`.`whitelabel_cache_bootstrap`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_bootstrap` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_config` to `db_test_cts`.`whitelabel_cache_config`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_config`
+++ `db_test_cts`.`whitelabel_cache_config`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_config` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_container` to `db_test_cts`.`whitelabel_cache_container`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_container`
+++ `db_test_cts`.`whitelabel_cache_container`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_container` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_data` to `db_test_cts`.`whitelabel_cache_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_data`
+++ `db_test_cts`.`whitelabel_cache_data`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_data` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_default` to `db_test_cts`.`whitelabel_cache_default`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_default`
+++ `db_test_cts`.`whitelabel_cache_default`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_default` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_discovery` to `db_test_cts`.`whitelabel_cache_discovery`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_discovery`
+++ `db_test_cts`.`whitelabel_cache_discovery`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_discovery` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_dynamic_page_cache` to `db_test_cts`.`whitelabel_cache_dynamic_page_cache`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_dynamic_page_cache`
+++ `db_test_cts`.`whitelabel_cache_dynamic_page_cache`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_dynamic_page_cache` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_entity` to `db_test_cts`.`whitelabel_cache_entity`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_entity`
+++ `db_test_cts`.`whitelabel_cache_entity`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_entity` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_graphql_definitions` to `db_test_cts`.`whitelabel_cache_graphql_definitions`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_graphql_definitions`
+++ `db_test_cts`.`whitelabel_cache_graphql_definitions`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_graphql_definitions` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_graphql_results` to `db_test_cts`.`whitelabel_cache_graphql_results`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_graphql_results`
+++ `db_test_cts`.`whitelabel_cache_graphql_results`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_graphql_results` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_jsonapi_normalizations` to `db_test_cts`.`whitelabel_cache_jsonapi_normalizations`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_jsonapi_normalizations`
+++ `db_test_cts`.`whitelabel_cache_jsonapi_normalizations`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_jsonapi_normalizations` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_menu` to `db_test_cts`.`whitelabel_cache_menu`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_menu`
+++ `db_test_cts`.`whitelabel_cache_menu`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_menu` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_page` to `db_test_cts`.`whitelabel_cache_page`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_page`
+++ `db_test_cts`.`whitelabel_cache_page`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_page` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_render` to `db_test_cts`.`whitelabel_cache_render`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_render`
+++ `db_test_cts`.`whitelabel_cache_render`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_render` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_rest` to `db_test_cts`.`whitelabel_cache_rest`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_rest`
+++ `db_test_cts`.`whitelabel_cache_rest`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_rest` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cache_toolbar` to `db_test_cts`.`whitelabel_cache_toolbar`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cache_toolbar`
+++ `db_test_cts`.`whitelabel_cache_toolbar`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_cache_toolbar` (
-  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
-  `data` longblob COMMENT 'A collection of data to cache.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or -1 for never.',
-  `created` decimal(14,3) NOT NULL DEFAULT '0.000' COMMENT 'A timestamp with millisecond precision indicating when the cache entry was created.',
-  `serialized` smallint NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
-  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Space-separated list of cache tags for this entry.',
-  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The tag invalidation checksum when this entry was saved.',
-  PRIMARY KEY (`cid`),
-  KEY `expire` (`expire`),
-  KEY `created` (`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Storage for the cache API.'
+  `cid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
+  `data` longblob,
+  `expire` int NOT NULL,
+  `created` decimal(14,3) NOT NULL,
+  `serialized` smallint NOT NULL,
+  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `checksum` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_cachetags` to `db_test_cts`.`whitelabel_cachetags`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_cachetags`
+++ `db_test_cts`.`whitelabel_cachetags`
@@ -1,5 +1,5 @@
 CREATE TABLE `whitelabel_cachetags` (
-  `tag` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'Namespace-prefixed tag string.',
-  `invalidations` int NOT NULL DEFAULT '0' COMMENT 'Number incremented when the tag is invalidated.',
+  `tag` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `invalidations` int NOT NULL,
   PRIMARY KEY (`tag`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cache table for tracking cache tag invalidations.'
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_comment` to `db_test_cts`.`whitelabel_comment`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_comment`
+++ `db_test_cts`.`whitelabel_comment`
@@ -1,9 +1,7 @@
 CREATE TABLE `whitelabel_comment` (
-  `cid` int unsigned NOT NULL AUTO_INCREMENT,
-  `comment_type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `cid` int unsigned NOT NULL,
+  `comment_type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`cid`),
-  UNIQUE KEY `comment_field__uuid__value` (`uuid`),
-  KEY `comment_field__comment_type__target_id` (`comment_type`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for comment entities.'
+  PRIMARY KEY (`cid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_comment__comment_body` to `db_test_cts`.`whitelabel_comment__comment_body`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_comment__comment_body`
+++ `db_test_cts`.`whitelabel_comment__comment_body`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_comment__comment_body` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to, which for an unversioned entity type is the same as the entity id',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `comment_body_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `comment_body_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `comment_body_format` (`comment_body_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for comment field comment_body.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_comment_entity_statistics` to `db_test_cts`.`whitelabel_comment_entity_statistics`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_comment_entity_statistics`
+++ `db_test_cts`.`whitelabel_comment_entity_statistics`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_comment_entity_statistics` (
-  `entity_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'The entity_id of the entity for which the statistics are compiled.',
-  `entity_type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT 'node' COMMENT 'The entity_type of the entity to which this comment is a reply.',
-  `field_name` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field_name of the field that was used to add this comment.',
-  `cid` int NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_comment".cid of the last comment.',
-  `last_comment_timestamp` int NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from "whitelabel_comment".changed.',
-  `last_comment_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from "whitelabel_comment".name.',
-  `last_comment_uid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from "whitelabel_comment".uid.',
-  `comment_count` int unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this entity.',
-  PRIMARY KEY (`entity_id`,`entity_type`,`field_name`),
-  KEY `last_comment_timestamp` (`last_comment_timestamp`),
-  KEY `comment_count` (`comment_count`),
-  KEY `last_comment_uid` (`last_comment_uid`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Maintains statistics of entity and comments posts to show …'
+  `entity_id` int unsigned NOT NULL,
+  `entity_type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `field_name` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `cid` int NOT NULL,
+  `last_comment_timestamp` int NOT NULL,
+  `last_comment_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `last_comment_uid` int unsigned NOT NULL,
+  `comment_count` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`entity_type`,`field_name`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_comment_field_data` to `db_test_cts`.`whitelabel_comment_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_comment_field_data`
+++ `db_test_cts`.`whitelabel_comment_field_data`
@@ -1,11 +1,11 @@
 CREATE TABLE `whitelabel_comment_field_data` (
   `cid` int unsigned NOT NULL,
-  `comment_type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `comment_type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `status` tinyint NOT NULL,
-  `uid` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  `pid` int unsigned DEFAULT NULL COMMENT 'The ID of the target entity.',
-  `entity_id` int unsigned DEFAULT NULL COMMENT 'The ID of the target entity.',
+  `uid` int unsigned NOT NULL,
+  `pid` int unsigned DEFAULT NULL,
+  `entity_id` int unsigned DEFAULT NULL,
   `subject` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `mail` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
@@ -17,13 +17,5 @@
   `entity_type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `field_name` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `default_langcode` tinyint NOT NULL,
-  PRIMARY KEY (`cid`,`langcode`),
-  KEY `comment__id__default_langcode__langcode` (`cid`,`default_langcode`,`langcode`),
-  KEY `comment_field__comment_type__target_id` (`comment_type`),
-  KEY `comment_field__uid__target_id` (`uid`),
-  KEY `comment_field__created` (`created`),
-  KEY `comment__status_comment_type` (`status`,`comment_type`,`cid`),
-  KEY `comment__status_pid` (`pid`,`status`),
-  KEY `comment__num_new` (`entity_id`,`entity_type`,`comment_type`,`status`,`created`,`cid`,`thread`(191)),
-  KEY `comment__entity_langcode` (`entity_id`,`entity_type`,`comment_type`,`default_langcode`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for comment entities.'
+  PRIMARY KEY (`cid`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_config` to `db_test_cts`.`whitelabel_config`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_config`
+++ `db_test_cts`.`whitelabel_config`
@@ -1,6 +1,6 @@
 CREATE TABLE `whitelabel_config` (
-  `collection` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'Primary Key: Config object collection.',
-  `name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'Primary Key: Config object name.',
-  `data` longblob COMMENT 'A serialized configuration object data.',
+  `collection` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `data` longblob,
   PRIMARY KEY (`collection`,`name`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for configuration data.'
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_content_moderation_state` to `db_test_cts`.`whitelabel_content_moderation_state`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_content_moderation_state`
+++ `db_test_cts`.`whitelabel_content_moderation_state`
@@ -1,9 +1,7 @@
 CREATE TABLE `whitelabel_content_moderation_state` (
-  `id` int unsigned NOT NULL AUTO_INCREMENT,
+  `id` int unsigned NOT NULL,
   `revision_id` int unsigned DEFAULT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`id`),
-  UNIQUE KEY `content_moderation_state_field__uuid__value` (`uuid`),
-  UNIQUE KEY `content_moderation_state__revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for content_moderation_state entities.'
+  PRIMARY KEY (`id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_content_moderation_state_field_data` to `db_test_cts`.`whitelabel_content_moderation_state_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_content_moderation_state_field_data`
+++ `db_test_cts`.`whitelabel_content_moderation_state_field_data`
@@ -2,18 +2,13 @@
   `id` int unsigned NOT NULL,
   `revision_id` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  `uid` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  `workflow` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL COMMENT 'The ID of the target entity.',
+  `uid` int unsigned NOT NULL,
+  `workflow` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
   `moderation_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `content_entity_type_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `content_entity_id` int DEFAULT NULL,
   `content_entity_revision_id` int DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`id`,`langcode`),
-  UNIQUE KEY `content_moderation_state__lookup` (`content_entity_type_id`,`content_entity_id`,`content_entity_revision_id`,`workflow`,`langcode`),
-  KEY `content_moderation_state__id__default_langcode__langcode` (`id`,`default_langcode`,`langcode`),
-  KEY `content_moderation_state__revision_id` (`revision_id`),
-  KEY `content_moderation_state_field__uid__target_id` (`uid`),
-  KEY `content_moderation_state__09628d8dbc` (`workflow`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for content_moderation_state entities.'
+  PRIMARY KEY (`id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_content_moderation_state_field_revision` to `db_test_cts`.`whitelabel_content_moderation_state_field_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_content_moderation_state_field_revision`
+++ `db_test_cts`.`whitelabel_content_moderation_state_field_revision`
@@ -2,17 +2,13 @@
   `id` int unsigned NOT NULL,
   `revision_id` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  `uid` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  `workflow` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL COMMENT 'The ID of the target entity.',
+  `uid` int unsigned NOT NULL,
+  `workflow` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
   `moderation_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `content_entity_type_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `content_entity_id` int DEFAULT NULL,
   `content_entity_revision_id` int DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`,`langcode`),
-  UNIQUE KEY `content_moderation_state__lookup` (`content_entity_type_id`,`content_entity_id`,`content_entity_revision_id`,`workflow`,`langcode`),
-  KEY `content_moderation_state__id__default_langcode__langcode` (`id`,`default_langcode`,`langcode`),
-  KEY `content_moderation_state_field__uid__target_id` (`uid`),
-  KEY `content_moderation_state__09628d8dbc` (`workflow`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision data table for content_moderation_state…'
+  PRIMARY KEY (`revision_id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_content_moderation_state_revision` to `db_test_cts`.`whitelabel_content_moderation_state_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_content_moderation_state_revision`
+++ `db_test_cts`.`whitelabel_content_moderation_state_revision`
@@ -1,8 +1,7 @@
 CREATE TABLE `whitelabel_content_moderation_state_revision` (
   `id` int unsigned NOT NULL,
-  `revision_id` int unsigned NOT NULL AUTO_INCREMENT,
+  `revision_id` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `revision_default` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`),
-  KEY `content_moderation_state__id` (`id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision table for content_moderation_state entities.'
+  PRIMARY KEY (`revision_id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_dashboard_revalidate` to `db_test_cts`.`whitelabel_dashboard_revalidate`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_dashboard_revalidate`
+++ `db_test_cts`.`whitelabel_dashboard_revalidate`
@@ -1,16 +1,10 @@
 CREATE TABLE `whitelabel_dashboard_revalidate` (
-  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique record ID.',
-  `nid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_node".nid of the page.',
-  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The URL slug for the page.',
-  `lang` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The language code for the page.',
-  `tenant` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Identifier for the tenant.',
-  `status` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this record has been revalidated.',
-  `created` int NOT NULL DEFAULT '0' COMMENT 'Timestamp when the record was created.',
-  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The URL for the page.',
-  PRIMARY KEY (`id`),
-  KEY `nid` (`nid`),
-  KEY `slug` (`slug`(191)),
-  KEY `lang` (`lang`),
-  KEY `tenant` (`tenant`(191)),
-  KEY `status` (`status`)
-) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of pages that were automatically revalidated.'
+  `id` int NOT NULL,
+  `nid` int unsigned NOT NULL,
+  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  `lang` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  `tenant` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  `status` tinyint unsigned NOT NULL,
+  `created` int NOT NULL,
+  PRIMARY KEY (`id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_entity_usage` to `db_test_cts`.`whitelabel_entity_usage`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_entity_usage`
+++ `db_test_cts`.`whitelabel_entity_usage`
@@ -1,18 +1,14 @@
 CREATE TABLE `whitelabel_entity_usage` (
-  `target_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'The target entity ID.',
-  `target_id_string` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The target ID, when the entity uses string IDs.',
-  `target_type` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The target entity type.',
-  `source_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'The source entity ID.',
-  `source_id_string` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL COMMENT 'The source ID, when the entity uses string IDs.',
-  `source_type` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The source entity type.',
-  `source_langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The source entity language code.',
-  `source_vid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The source entity revision ID.',
-  `method` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The method used to track the target, generally the plugin ID.',
-  `field_name` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field in the source entity containing the target entity.',
-  `count` int unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times the target entity is referenced in this case.',
-  PRIMARY KEY (`target_id`,`target_id_string`,`target_type`,`source_id`,`source_type`,`source_langcode`,`source_vid`,`method`,`field_name`),
-  KEY `target_entity` (`target_type`,`target_id`),
-  KEY `source_entity` (`source_type`,`source_id`),
-  KEY `target_entity_string` (`target_type`,`target_id_string`),
-  KEY `source_entity_string` (`source_type`,`source_id_string`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track entities that reference other entities.'
+  `target_id` int unsigned NOT NULL,
+  `target_id_string` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `target_type` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `source_id` int unsigned NOT NULL,
+  `source_id_string` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
+  `source_type` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `source_langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `source_vid` int unsigned NOT NULL,
+  `method` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `field_name` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `count` int unsigned NOT NULL,
+  PRIMARY KEY (`target_id`,`target_id_string`,`target_type`,`source_id`,`source_type`,`source_langcode`,`source_vid`,`method`,`field_name`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_file_managed` to `db_test_cts`.`whitelabel_file_managed`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_file_managed`
+++ `db_test_cts`.`whitelabel_file_managed`
@@ -1,8 +1,8 @@
 CREATE TABLE `whitelabel_file_managed` (
-  `fid` int unsigned NOT NULL AUTO_INCREMENT,
+  `fid` int unsigned NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  `uid` int unsigned DEFAULT NULL COMMENT 'The ID of the target entity.',
+  `uid` int unsigned DEFAULT NULL,
   `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
   `filemime` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
@@ -10,10 +10,5 @@
   `status` tinyint NOT NULL,
   `created` int DEFAULT NULL,
   `changed` int NOT NULL,
-  PRIMARY KEY (`fid`),
-  UNIQUE KEY `file_field__uuid__value` (`uuid`),
-  KEY `file_field__uid__target_id` (`uid`),
-  KEY `file_field__uri` (`uri`(191)),
-  KEY `file_field__status` (`status`),
-  KEY `file_field__changed` (`changed`)
-) ENGINE=InnoDB AUTO_INCREMENT=696 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for file entities.'
+  PRIMARY KEY (`fid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_file_usage` to `db_test_cts`.`whitelabel_file_usage`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_file_usage`
+++ `db_test_cts`.`whitelabel_file_usage`
@@ -1,11 +1,8 @@
 CREATE TABLE `whitelabel_file_usage` (
-  `fid` int unsigned NOT NULL COMMENT 'File ID.',
-  `module` varchar(50) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
-  `type` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
-  `id` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
-  `count` int unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
-  PRIMARY KEY (`fid`,`type`,`id`,`module`),
-  KEY `type_id` (`type`,`id`),
-  KEY `fid_count` (`fid`,`count`),
-  KEY `fid_module` (`fid`,`module`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track where a file is used.'
+  `fid` int unsigned NOT NULL,
+  `module` varchar(50) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `type` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `id` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `count` int unsigned NOT NULL,
+  PRIMARY KEY (`fid`,`type`,`id`,`module`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_flood` to `db_test_cts`.`whitelabel_flood`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_flood`
+++ `db_test_cts`.`whitelabel_flood`
@@ -1,10 +1,8 @@
 CREATE TABLE `whitelabel_flood` (
-  `fid` int NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
-  `event` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
-  `identifier` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
-  `timestamp` int NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
-  `expiration` int NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
-  PRIMARY KEY (`fid`),
-  KEY `allow` (`event`,`identifier`,`timestamp`),
-  KEY `purge` (`expiration`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Flood controls the threshold of events, such as the number…'
+  `fid` int NOT NULL,
+  `event` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `identifier` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `timestamp` int NOT NULL,
+  `expiration` int NOT NULL,
+  PRIMARY KEY (`fid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_history` to `db_test_cts`.`whitelabel_history`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_history`
+++ `db_test_cts`.`whitelabel_history`
@@ -1,7 +1,6 @@
 CREATE TABLE `whitelabel_history` (
-  `uid` int NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_users".uid that read the "whitelabel_node" nid.',
-  `nid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_node".nid that was read.',
-  `timestamp` int NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
-  PRIMARY KEY (`uid`,`nid`),
-  KEY `nid` (`nid`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='A record of which "whitelabel_users" have read which …'
+  `uid` int NOT NULL,
+  `nid` int unsigned NOT NULL,
+  `timestamp` int NOT NULL,
+  PRIMARY KEY (`uid`,`nid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_key_value` to `db_test_cts`.`whitelabel_key_value`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_key_value`
+++ `db_test_cts`.`whitelabel_key_value`
@@ -1,6 +1,6 @@
 CREATE TABLE `whitelabel_key_value` (
-  `collection` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'A named collection of key and value pairs.',
-  `name` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The key of the key-value pair. As KEY is a SQL reserved keyword, name was chosen instead.',
-  `value` longblob NOT NULL COMMENT 'The value.',
+  `collection` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `name` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `value` longblob NOT NULL,
   PRIMARY KEY (`collection`,`name`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Generic key-value storage table. See the state system for…'
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_key_value_expire` to `db_test_cts`.`whitelabel_key_value_expire`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_key_value_expire`
+++ `db_test_cts`.`whitelabel_key_value_expire`
@@ -1,8 +1,7 @@
 CREATE TABLE `whitelabel_key_value_expire` (
-  `collection` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'A named collection of key and value pairs.',
-  `name` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The key of the key/value pair.',
-  `value` longblob NOT NULL COMMENT 'The value of the key/value pair.',
-  `expire` int NOT NULL DEFAULT '2147483647' COMMENT 'The time since Unix epoch in seconds when this item expires. Defaults to the maximum possible time.',
-  PRIMARY KEY (`collection`,`name`),
-  KEY `expire` (`expire`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Generic key/value storage table with an expiration.'
+  `collection` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `name` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `value` longblob NOT NULL,
+  `expire` int NOT NULL,
+  PRIMARY KEY (`collection`,`name`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media` to `db_test_cts`.`whitelabel_media`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media`
+++ `db_test_cts`.`whitelabel_media`
@@ -1,11 +1,8 @@
 CREATE TABLE `whitelabel_media` (
-  `mid` int unsigned NOT NULL AUTO_INCREMENT,
+  `mid` int unsigned NOT NULL,
   `vid` int unsigned DEFAULT NULL,
-  `bundle` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `bundle` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`mid`),
-  UNIQUE KEY `media_field__uuid__value` (`uuid`),
-  UNIQUE KEY `media__vid` (`vid`),
-  KEY `media_field__bundle__target_id` (`bundle`)
-) ENGINE=InnoDB AUTO_INCREMENT=599 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for media entities.'
+  PRIMARY KEY (`mid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media__field_media_audio_file` to `db_test_cts`.`whitelabel_media__field_media_audio_file`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media__field_media_audio_file`
+++ `db_test_cts`.`whitelabel_media__field_media_audio_file`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_media__field_media_audio_file` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_audio_file_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_media_audio_file_display` tinyint unsigned DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
-  `field_media_audio_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'A description of the file.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_audio_file_target_id` (`field_media_audio_file_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for media field field_media_audio_file.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_audio_file_target_id` int unsigned NOT NULL,
+  `field_media_audio_file_display` tinyint unsigned DEFAULT NULL,
+  `field_media_audio_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media__field_media_document` to `db_test_cts`.`whitelabel_media__field_media_document`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media__field_media_document`
+++ `db_test_cts`.`whitelabel_media__field_media_document`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_media__field_media_document` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_document_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_media_document_display` tinyint unsigned DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
-  `field_media_document_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'A description of the file.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_document_target_id` (`field_media_document_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for media field field_media_document.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_document_target_id` int unsigned NOT NULL,
+  `field_media_document_display` tinyint unsigned DEFAULT NULL,
+  `field_media_document_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media__field_media_image` to `db_test_cts`.`whitelabel_media__field_media_image`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media__field_media_image`
+++ `db_test_cts`.`whitelabel_media__field_media_image`
@@ -1,17 +1,14 @@
 CREATE TABLE `whitelabel_media__field_media_image` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_image_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_media_image_alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Alternative image text, for the image''s ''alt'' attribute.',
-  `field_media_image_title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Image title text, for the image''s ''title'' attribute.',
-  `field_media_image_width` int unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
-  `field_media_image_height` int unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_image_target_id` (`field_media_image_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for media field field_media_image.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_image_target_id` int unsigned NOT NULL,
+  `field_media_image_alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_media_image_title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_media_image_width` int unsigned DEFAULT NULL,
+  `field_media_image_height` int unsigned DEFAULT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media__field_media_oembed_video` to `db_test_cts`.`whitelabel_media__field_media_oembed_video`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media__field_media_oembed_video`
+++ `db_test_cts`.`whitelabel_media__field_media_oembed_video`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_media__field_media_oembed_video` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_media_oembed_video_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for media field field_media_oembed_video.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media__field_media_video_file` to `db_test_cts`.`whitelabel_media__field_media_video_file`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media__field_media_video_file`
+++ `db_test_cts`.`whitelabel_media__field_media_video_file`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_media__field_media_video_file` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_video_file_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_media_video_file_display` tinyint unsigned DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
-  `field_media_video_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'A description of the file.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_video_file_target_id` (`field_media_video_file_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for media field field_media_video_file.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_video_file_target_id` int unsigned NOT NULL,
+  `field_media_video_file_display` tinyint unsigned DEFAULT NULL,
+  `field_media_video_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media_field_data` to `db_test_cts`.`whitelabel_media_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media_field_data`
+++ `db_test_cts`.`whitelabel_media_field_data`
@@ -1,27 +1,21 @@
 CREATE TABLE `whitelabel_media_field_data` (
   `mid` int unsigned NOT NULL,
   `vid` int unsigned NOT NULL,
-  `bundle` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `bundle` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `status` tinyint NOT NULL,
-  `uid` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
+  `uid` int unsigned NOT NULL,
   `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
-  `thumbnail__target_id` int unsigned DEFAULT NULL COMMENT 'The ID of the file entity.',
-  `thumbnail__alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Alternative image text, for the image''s ''alt'' attribute.',
-  `thumbnail__title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Image title text, for the image''s ''title'' attribute.',
-  `thumbnail__width` int unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
-  `thumbnail__height` int unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
+  `thumbnail__target_id` int unsigned DEFAULT NULL,
+  `thumbnail__alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `thumbnail__title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `thumbnail__width` int unsigned DEFAULT NULL,
+  `thumbnail__height` int unsigned DEFAULT NULL,
   `created` int DEFAULT NULL,
   `changed` int DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
   `content_translation_source` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
   `content_translation_outdated` tinyint DEFAULT NULL,
-  PRIMARY KEY (`mid`,`langcode`),
-  KEY `media__id__default_langcode__langcode` (`mid`,`default_langcode`,`langcode`),
-  KEY `media__vid` (`vid`),
-  KEY `media_field__bundle__target_id` (`bundle`),
-  KEY `media_field__uid__target_id` (`uid`),
-  KEY `media_field__thumbnail__target_id` (`thumbnail__target_id`),
-  KEY `media__status_bundle` (`status`,`bundle`,`mid`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for media entities.'
+  PRIMARY KEY (`mid`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media_field_revision` to `db_test_cts`.`whitelabel_media_field_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media_field_revision`
+++ `db_test_cts`.`whitelabel_media_field_revision`
@@ -3,21 +3,18 @@
   `vid` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `status` tinyint NOT NULL,
-  `uid` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
+  `uid` int unsigned NOT NULL,
   `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
-  `thumbnail__target_id` int unsigned DEFAULT NULL COMMENT 'The ID of the file entity.',
-  `thumbnail__alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Alternative image text, for the image''s ''alt'' attribute.',
-  `thumbnail__title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Image title text, for the image''s ''title'' attribute.',
-  `thumbnail__width` int unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
-  `thumbnail__height` int unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
+  `thumbnail__target_id` int unsigned DEFAULT NULL,
+  `thumbnail__alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `thumbnail__title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `thumbnail__width` int unsigned DEFAULT NULL,
+  `thumbnail__height` int unsigned DEFAULT NULL,
   `created` int DEFAULT NULL,
   `changed` int DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
   `content_translation_source` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
   `content_translation_outdated` tinyint DEFAULT NULL,
-  PRIMARY KEY (`vid`,`langcode`),
-  KEY `media__id__default_langcode__langcode` (`mid`,`default_langcode`,`langcode`),
-  KEY `media_field__uid__target_id` (`uid`),
-  KEY `media_field__thumbnail__target_id` (`thumbnail__target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision data table for media entities.'
+  PRIMARY KEY (`vid`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media_revision` to `db_test_cts`.`whitelabel_media_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media_revision`
+++ `db_test_cts`.`whitelabel_media_revision`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_media_revision` (
   `mid` int unsigned NOT NULL,
-  `vid` int unsigned NOT NULL AUTO_INCREMENT,
+  `vid` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  `revision_user` int unsigned DEFAULT NULL COMMENT 'The ID of the target entity.',
+  `revision_user` int unsigned DEFAULT NULL,
   `revision_created` int DEFAULT NULL,
   `revision_log_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `revision_default` tinyint DEFAULT NULL,
-  PRIMARY KEY (`vid`),
-  KEY `media__mid` (`mid`),
-  KEY `media_field__revision_user__target_id` (`revision_user`)
-) ENGINE=InnoDB AUTO_INCREMENT=633 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision table for media entities.'
+  PRIMARY KEY (`vid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media_revision__field_media_audio_file` to `db_test_cts`.`whitelabel_media_revision__field_media_audio_file`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media_revision__field_media_audio_file`
+++ `db_test_cts`.`whitelabel_media_revision__field_media_audio_file`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_media_revision__field_media_audio_file` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_audio_file_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_media_audio_file_display` tinyint unsigned DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
-  `field_media_audio_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'A description of the file.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_audio_file_target_id` (`field_media_audio_file_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for media field field_media_audio…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_audio_file_target_id` int unsigned NOT NULL,
+  `field_media_audio_file_display` tinyint unsigned DEFAULT NULL,
+  `field_media_audio_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media_revision__field_media_document` to `db_test_cts`.`whitelabel_media_revision__field_media_document`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media_revision__field_media_document`
+++ `db_test_cts`.`whitelabel_media_revision__field_media_document`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_media_revision__field_media_document` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_document_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_media_document_display` tinyint unsigned DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
-  `field_media_document_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'A description of the file.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_document_target_id` (`field_media_document_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for media field field_media…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_document_target_id` int unsigned NOT NULL,
+  `field_media_document_display` tinyint unsigned DEFAULT NULL,
+  `field_media_document_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media_revision__field_media_image` to `db_test_cts`.`whitelabel_media_revision__field_media_image`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media_revision__field_media_image`
+++ `db_test_cts`.`whitelabel_media_revision__field_media_image`
@@ -1,17 +1,14 @@
 CREATE TABLE `whitelabel_media_revision__field_media_image` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_image_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_media_image_alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Alternative image text, for the image''s ''alt'' attribute.',
-  `field_media_image_title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Image title text, for the image''s ''title'' attribute.',
-  `field_media_image_width` int unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
-  `field_media_image_height` int unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_image_target_id` (`field_media_image_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for media field field_media_image.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_image_target_id` int unsigned NOT NULL,
+  `field_media_image_alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_media_image_title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_media_image_width` int unsigned DEFAULT NULL,
+  `field_media_image_height` int unsigned DEFAULT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media_revision__field_media_oembed_video` to `db_test_cts`.`whitelabel_media_revision__field_media_oembed_video`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media_revision__field_media_oembed_video`
+++ `db_test_cts`.`whitelabel_media_revision__field_media_oembed_video`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_media_revision__field_media_oembed_video` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_media_oembed_video_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for media field field_media_oembed…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_media_revision__field_media_video_file` to `db_test_cts`.`whitelabel_media_revision__field_media_video_file`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_media_revision__field_media_video_file`
+++ `db_test_cts`.`whitelabel_media_revision__field_media_video_file`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_media_revision__field_media_video_file` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_video_file_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_media_video_file_display` tinyint unsigned DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
-  `field_media_video_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'A description of the file.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_video_file_target_id` (`field_media_video_file_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for media field field_media_video…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_video_file_target_id` int unsigned NOT NULL,
+  `field_media_video_file_display` tinyint unsigned DEFAULT NULL,
+  `field_media_video_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_menu_link_content` to `db_test_cts`.`whitelabel_menu_link_content`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_menu_link_content`
+++ `db_test_cts`.`whitelabel_menu_link_content`
@@ -1,10 +1,8 @@
 CREATE TABLE `whitelabel_menu_link_content` (
-  `id` int unsigned NOT NULL AUTO_INCREMENT,
+  `id` int unsigned NOT NULL,
   `revision_id` int unsigned DEFAULT NULL,
   `bundle` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`id`),
-  UNIQUE KEY `menu_link_content_field__uuid__value` (`uuid`),
-  UNIQUE KEY `menu_link_content__revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for menu_link_content entities.'
+  PRIMARY KEY (`id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_menu_link_content_data` to `db_test_cts`.`whitelabel_menu_link_content_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_menu_link_content_data`
+++ `db_test_cts`.`whitelabel_menu_link_content_data`
@@ -7,9 +7,9 @@
   `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `menu_name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  `link__uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `link__title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `link__options` longblob COMMENT 'Serialized array of options for the link.',
+  `link__uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `link__title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `link__options` longblob,
   `external` tinyint DEFAULT NULL,
   `rediscover` tinyint DEFAULT NULL,
   `weight` int DEFAULT NULL,
@@ -18,9 +18,5 @@
   `changed` int DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`id`,`langcode`),
-  KEY `menu_link_content__id__default_langcode__langcode` (`id`,`default_langcode`,`langcode`),
-  KEY `menu_link_content__revision_id` (`revision_id`),
-  KEY `menu_link_content_field__link__uri` (`link__uri`(30)),
-  KEY `menu_link_content__enabled_bundle` (`enabled`,`bundle`,`id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for menu_link_content entities.'
+  PRIMARY KEY (`id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_menu_link_content_field_revision` to `db_test_cts`.`whitelabel_menu_link_content_field_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_menu_link_content_field_revision`
+++ `db_test_cts`.`whitelabel_menu_link_content_field_revision`
@@ -5,14 +5,12 @@
   `enabled` tinyint NOT NULL,
   `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
-  `link__uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `link__title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `link__options` longblob COMMENT 'Serialized array of options for the link.',
+  `link__uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `link__title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `link__options` longblob,
   `external` tinyint DEFAULT NULL,
   `changed` int DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`,`langcode`),
-  KEY `menu_link_content__id__default_langcode__langcode` (`id`,`default_langcode`,`langcode`),
-  KEY `menu_link_content_field__link__uri` (`link__uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision data table for menu_link_content entities.'
+  PRIMARY KEY (`revision_id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_menu_link_content_revision` to `db_test_cts`.`whitelabel_menu_link_content_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_menu_link_content_revision`
+++ `db_test_cts`.`whitelabel_menu_link_content_revision`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_menu_link_content_revision` (
   `id` int unsigned NOT NULL,
-  `revision_id` int unsigned NOT NULL AUTO_INCREMENT,
+  `revision_id` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  `revision_user` int unsigned DEFAULT NULL COMMENT 'The ID of the target entity.',
+  `revision_user` int unsigned DEFAULT NULL,
   `revision_created` int DEFAULT NULL,
   `revision_log_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `revision_default` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`),
-  KEY `menu_link_content__id` (`id`),
-  KEY `menu_link_content__ef029a1897` (`revision_user`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision table for menu_link_content entities.'
+  PRIMARY KEY (`revision_id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_menu_tree` to `db_test_cts`.`whitelabel_menu_tree`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_menu_tree`
+++ `db_test_cts`.`whitelabel_menu_tree`
@@ -1,37 +1,33 @@
 CREATE TABLE `whitelabel_menu_tree` (
-  `menu_name` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ''tools'') are part of the same menu.',
-  `mlid` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
-  `id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'Unique machine name: the plugin ID.',
-  `parent` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The plugin ID for the parent of this link.',
-  `route_name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL COMMENT 'The machine name of a defined Symfony Route this menu link represents.',
-  `route_param_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'An encoded string of route parameters for loading by route.',
-  `route_parameters` longblob COMMENT 'Serialized array of route parameters of this menu link.',
-  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The external path this link points to (when not using a route).',
-  `title` longblob COMMENT 'The serialized title for the link. May be a TranslatableMarkup.',
-  `description` longblob COMMENT 'The serialized description of this link - used for admin pages and title attribute. May be a TranslatableMarkup.',
-  `class` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'The class for this link plugin.',
-  `options` longblob COMMENT 'A serialized array of URL options, such as a query string or HTML attributes.',
-  `provider` varchar(50) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
-  `enabled` smallint NOT NULL DEFAULT '1' COMMENT 'A flag for whether the link should be rendered in menus. (0 = a disabled menu link that may be shown on admin screens, 1 = a normal, visible link)',
-  `discovered` smallint NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link was discovered, so can be purged on rebuild',
-  `expanded` smallint NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
-  `weight` int NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
-  `metadata` longblob COMMENT 'A serialized array of data that may be used by the plugin instance.',
-  `has_children` smallint NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any enabled links have this link as a parent (1 = enabled children exist, 0 = no enabled children).',
-  `depth` smallint NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with empty parent will have depth == 1.',
-  `p1` int unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the parent link mlid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
-  `p2` int unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
-  `p3` int unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
-  `p4` int unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
-  `p5` int unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
-  `p6` int unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
-  `p7` int unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
-  `p8` int unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
-  `p9` int unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
-  `form_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'meh',
-  PRIMARY KEY (`mlid`),
-  UNIQUE KEY `id` (`id`),
-  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
-  KEY `menu_parent_expand_child` (`menu_name`,`expanded`,`has_children`,`parent`(16)),
-  KEY `route_values` (`route_name`(32),`route_param_key`(16))
-) ENGINE=InnoDB AUTO_INCREMENT=882 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Contains the menu tree hierarchy.'
+  `menu_name` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `mlid` int unsigned NOT NULL,
+  `id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `parent` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `route_name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
+  `route_param_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `route_parameters` longblob,
+  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  `title` longblob,
+  `description` longblob,
+  `class` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  `options` longblob,
+  `provider` varchar(50) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `enabled` smallint NOT NULL,
+  `discovered` smallint NOT NULL,
+  `expanded` smallint NOT NULL,
+  `weight` int NOT NULL,
+  `metadata` longblob,
+  `has_children` smallint NOT NULL,
+  `depth` smallint NOT NULL,
+  `p1` int unsigned NOT NULL,
+  `p2` int unsigned NOT NULL,
+  `p3` int unsigned NOT NULL,
+  `p4` int unsigned NOT NULL,
+  `p5` int unsigned NOT NULL,
+  `p6` int unsigned NOT NULL,
+  `p7` int unsigned NOT NULL,
+  `p8` int unsigned NOT NULL,
+  `p9` int unsigned NOT NULL,
+  `form_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  PRIMARY KEY (`mlid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_miniorange_saml_idpdata` to `db_test_cts`.`whitelabel_miniorange_saml_idpdata`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_miniorange_saml_idpdata`
+++ `db_test_cts`.`whitelabel_miniorange_saml_idpdata`
@@ -1,35 +1,35 @@
 CREATE TABLE `whitelabel_miniorange_saml_idpdata` (
-  `id` int unsigned NOT NULL AUTO_INCREMENT,
+  `id` int unsigned NOT NULL,
   `mo_sp_idp_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `mo_sp_idp_issuer` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `mo_sp_nameid_format` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  `mo_sp_sso_binding_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'HTTP-Redirect',
+  `mo_sp_sso_binding_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `mo_sp_login_url` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  `mo_sp_slo_binding_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'HTTP-Redirect',
+  `mo_sp_slo_binding_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `mo_sp_logout_url` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `mo_sp_cert` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `mo_sp_sign_algorithm` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  `mo_sp_sign_sso_and_slo_request` int NOT NULL DEFAULT '0',
-  `mo_sp_enable_login_with_saml` int NOT NULL DEFAULT '0',
-  `mo_sp_send_slo_in_iframe` int NOT NULL DEFAULT '0',
-  `mo_sp_character_encoding` int NOT NULL DEFAULT '0',
-  `mo_sp_fetch_metadata_after_some_time` int NOT NULL DEFAULT '0',
+  `mo_sp_sign_sso_and_slo_request` int NOT NULL,
+  `mo_sp_enable_login_with_saml` int NOT NULL,
+  `mo_sp_send_slo_in_iframe` int NOT NULL,
+  `mo_sp_character_encoding` int NOT NULL,
+  `mo_sp_fetch_metadata_after_some_time` int NOT NULL,
   `mo_saml_metadata_url` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `mo_saml_default_domain` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `mo_saml_idp_guest_account` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
-  `mo_saml_username_attribute` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'NameID',
-  `mo_saml_email_attribute` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'NameID',
+  `mo_saml_username_attribute` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `mo_saml_email_attribute` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `mo_saml_custom_attrs_map_arr` longblob,
-  `mo_saml_enable_rolemapping` int NOT NULL DEFAULT '0',
-  `mo_saml_disable_role_update` int NOT NULL DEFAULT '0',
+  `mo_saml_enable_rolemapping` int NOT NULL,
+  `mo_saml_disable_role_update` int NOT NULL,
   `mo_saml_default_role` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `mo_saml_role_attr_name` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `mo_saml_role_mapping_arr` longblob,
-  `mo_saml_enable_profile_mapping` int NOT NULL DEFAULT '0',
+  `mo_saml_enable_profile_mapping` int NOT NULL,
   `mo_saml_profile_type` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `mo_saml_profile_mapping_attributes` longblob,
-  `mo_sp_show_login_url` int NOT NULL DEFAULT '0',
+  `mo_sp_show_login_url` int NOT NULL,
   `mo_sp_login_link_text` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `miniorange_saml_role_attr_separator` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   PRIMARY KEY (`id`)
-) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores Identity Providers information'
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node` to `db_test_cts`.`whitelabel_node`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node`
+++ `db_test_cts`.`whitelabel_node`
@@ -1,11 +1,8 @@
 CREATE TABLE `whitelabel_node` (
-  `nid` int unsigned NOT NULL AUTO_INCREMENT,
+  `nid` int unsigned NOT NULL,
   `vid` int unsigned DEFAULT NULL,
-  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`nid`),
-  UNIQUE KEY `node_field__uuid__value` (`uuid`),
-  UNIQUE KEY `node__vid` (`vid`),
-  KEY `node_field__type__target_id` (`type`)
-) ENGINE=InnoDB AUTO_INCREMENT=4039 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for node entities.'
+  PRIMARY KEY (`nid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__body` to `db_test_cts`.`whitelabel_node__body`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__body`
+++ `db_test_cts`.`whitelabel_node__body`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node__body` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `body_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `body_summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `body_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `body_format` (`body_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field body.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_another_subheadline` to `db_test_cts`.`whitelabel_node__field_another_subheadline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_another_subheadline`
+++ `db_test_cts`.`whitelabel_node__field_another_subheadline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_another_subheadline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_another_subheadline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_another_subheadline.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_answer_html` to `db_test_cts`.`whitelabel_node__field_answer_html`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_answer_html`
+++ `db_test_cts`.`whitelabel_node__field_answer_html`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node__field_answer_html` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_answer_html_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_answer_html_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_answer_html_format` (`field_answer_html_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_answer_html.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_author` to `db_test_cts`.`whitelabel_node__field_author`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_author`
+++ `db_test_cts`.`whitelabel_node__field_author`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_author` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_author_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_author.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_biography` to `db_test_cts`.`whitelabel_node__field_biography`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_biography`
+++ `db_test_cts`.`whitelabel_node__field_biography`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node__field_biography` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_biography_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_biography_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_biography_format` (`field_biography_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_biography.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_button_label` to `db_test_cts`.`whitelabel_node__field_button_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_button_label`
+++ `db_test_cts`.`whitelabel_node__field_button_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_button_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_button_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_button_label.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_button_link` to `db_test_cts`.`whitelabel_node__field_button_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_button_link`
+++ `db_test_cts`.`whitelabel_node__field_button_link`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_button_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_button_link_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_button_link_target_id` (`field_button_link_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_button_link.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_button_link_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_callto_label` to `db_test_cts`.`whitelabel_node__field_callto_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_callto_label`
+++ `db_test_cts`.`whitelabel_node__field_callto_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_callto_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_callto_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_callto_label.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_canonical` to `db_test_cts`.`whitelabel_node__field_canonical`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_canonical`
+++ `db_test_cts`.`whitelabel_node__field_canonical`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_canonical` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_canonical_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_canonical.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_city_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_city_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_city_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_city_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_city_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_city_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_city_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_city_title` to `db_test_cts`.`whitelabel_node__field_cfi_city_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_city_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_city_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_city_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_city_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_city_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_company_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_company_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_company_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_company_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_company_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_company_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_company_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_company_title` to `db_test_cts`.`whitelabel_node__field_cfi_company_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_company_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_company_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_company_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_company_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_company_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_email_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_email_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_email_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_email_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_email_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_email_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_email_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_email_title` to `db_test_cts`.`whitelabel_node__field_cfi_email_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_email_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_email_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_email_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_email_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_email_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_firstname_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_firstname_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_firstname_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_firstname_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_firstname_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_firstname_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_firstname_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_firstname_title` to `db_test_cts`.`whitelabel_node__field_cfi_firstname_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_firstname_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_firstname_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_firstname_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_firstname_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_firstname_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_fleetsize_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_fleetsize_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_fleetsize_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_fleetsize_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_fleetsize_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_fleetsize_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_fleetsize_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_fleetsize_title` to `db_test_cts`.`whitelabel_node__field_cfi_fleetsize_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_fleetsize_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_fleetsize_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_fleetsize_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_fleetsize_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_fleetsize_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_fleetsize_visible` to `db_test_cts`.`whitelabel_node__field_cfi_fleetsize_visible`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_fleetsize_visible`
+++ `db_test_cts`.`whitelabel_node__field_cfi_fleetsize_visible`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_fleetsize_visible` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_fleetsize_visible_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_fleetsize_visible.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_housenumber_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_housenumber_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_housenumber_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_housenumber_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_housenumber_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_housenumber_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_housenumber_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_housenumber_title` to `db_test_cts`.`whitelabel_node__field_cfi_housenumber_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_housenumber_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_housenumber_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_housenumber_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_housenumber_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_housenumber_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_lastname_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_lastname_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_lastname_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_lastname_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_lastname_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_lastname_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_lastname_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_lastname_title` to `db_test_cts`.`whitelabel_node__field_cfi_lastname_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_lastname_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_lastname_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_lastname_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_lastname_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_lastname_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_message_placeholder` to `db_test_cts`.`whitelabel_node__field_cfi_message_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_message_placeholder`
+++ `db_test_cts`.`whitelabel_node__field_cfi_message_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_message_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_message_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_message_placeholder.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_message_title` to `db_test_cts`.`whitelabel_node__field_cfi_message_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_message_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_message_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_message_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_message_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_message_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_phonenumber_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_phonenumber_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_phonenumber_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_phonenumber_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_phonenumber_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_phonenumber_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_phonenumber_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_phonenumber_title` to `db_test_cts`.`whitelabel_node__field_cfi_phonenumber_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_phonenumber_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_phonenumber_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_phonenumber_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_phonenumber_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_phonenumber_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_request_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_request_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_request_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_request_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_request_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_request_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_request_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_request_options` to `db_test_cts`.`whitelabel_node__field_cfi_request_options`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_request_options`
+++ `db_test_cts`.`whitelabel_node__field_cfi_request_options`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_request_options` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_request_options_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_request_options.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_request_visible` to `db_test_cts`.`whitelabel_node__field_cfi_request_visible`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_request_visible`
+++ `db_test_cts`.`whitelabel_node__field_cfi_request_visible`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_request_visible` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_request_visible_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_request_visible.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_street_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_street_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_street_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_street_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_street_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_street_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_street_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_street_title` to `db_test_cts`.`whitelabel_node__field_cfi_street_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_street_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_street_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_street_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_street_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_street_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_title_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_title_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_title_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_title_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_title_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_title_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_title_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_title_options` to `db_test_cts`.`whitelabel_node__field_cfi_title_options`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_title_options`
+++ `db_test_cts`.`whitelabel_node__field_cfi_title_options`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_title_options` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_title_options_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_title_options.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_zipcode_mandatory` to `db_test_cts`.`whitelabel_node__field_cfi_zipcode_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_zipcode_mandatory`
+++ `db_test_cts`.`whitelabel_node__field_cfi_zipcode_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_zipcode_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_zipcode_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_zipcode_mandatory.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_cfi_zipcode_title` to `db_test_cts`.`whitelabel_node__field_cfi_zipcode_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_cfi_zipcode_title`
+++ `db_test_cts`.`whitelabel_node__field_cfi_zipcode_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_cfi_zipcode_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_zipcode_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_cfi_zipcode_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_color` to `db_test_cts`.`whitelabel_node__field_color`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_color`
+++ `db_test_cts`.`whitelabel_node__field_color`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_color` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_color_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_color_value` (`field_color_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_color.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_color_variation` to `db_test_cts`.`whitelabel_node__field_color_variation`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_color_variation`
+++ `db_test_cts`.`whitelabel_node__field_color_variation`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_color_variation` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_color_variation_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_color_variation_value` (`field_color_variation_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_color_variation.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_columns` to `db_test_cts`.`whitelabel_node__field_columns`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_columns`
+++ `db_test_cts`.`whitelabel_node__field_columns`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_columns` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_columns_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_columns_target_id` (`field_columns_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_columns.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_columns_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_comment_placeholder` to `db_test_cts`.`whitelabel_node__field_comment_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_comment_placeholder`
+++ `db_test_cts`.`whitelabel_node__field_comment_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_comment_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_comment_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_comment_placeholder.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_companies_gallery` to `db_test_cts`.`whitelabel_node__field_companies_gallery`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_companies_gallery`
+++ `db_test_cts`.`whitelabel_node__field_companies_gallery`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_companies_gallery` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_companies_gallery_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_companies_gallery_target_id` (`field_companies_gallery_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_companies_gallery.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_companies_gallery_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_company_placeholder` to `db_test_cts`.`whitelabel_node__field_company_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_company_placeholder`
+++ `db_test_cts`.`whitelabel_node__field_company_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_company_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_company_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_company_placeholder.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_confirmation_send_message` to `db_test_cts`.`whitelabel_node__field_confirmation_send_message`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_confirmation_send_message`
+++ `db_test_cts`.`whitelabel_node__field_confirmation_send_message`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_confirmation_send_message` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_confirmation_send_message_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_confirmation_send_message.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_contact` to `db_test_cts`.`whitelabel_node__field_contact`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_contact`
+++ `db_test_cts`.`whitelabel_node__field_contact`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_contact` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_contact_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_contact_target_id` (`field_contact_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_contact.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_contact_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_contact_columns` to `db_test_cts`.`whitelabel_node__field_contact_columns`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_contact_columns`
+++ `db_test_cts`.`whitelabel_node__field_contact_columns`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_contact_columns` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_contact_columns_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_contact_columns_target_id` (`field_contact_columns_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_contact_columns.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_contact_columns_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_contact_details_headline` to `db_test_cts`.`whitelabel_node__field_contact_details_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_contact_details_headline`
+++ `db_test_cts`.`whitelabel_node__field_contact_details_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_contact_details_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_contact_details_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_contact_details_headline.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_contact_label` to `db_test_cts`.`whitelabel_node__field_contact_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_contact_label`
+++ `db_test_cts`.`whitelabel_node__field_contact_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_contact_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_contact_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_contact_label.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_contact_links` to `db_test_cts`.`whitelabel_node__field_contact_links`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_contact_links`
+++ `db_test_cts`.`whitelabel_node__field_contact_links`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_contact_links` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_contact_links_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_contact_links_target_id` (`field_contact_links_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_contact_links.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_contact_links_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_contact_title` to `db_test_cts`.`whitelabel_node__field_contact_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_contact_title`
+++ `db_test_cts`.`whitelabel_node__field_contact_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_contact_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_contact_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_contact_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_contacts` to `db_test_cts`.`whitelabel_node__field_contacts`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_contacts`
+++ `db_test_cts`.`whitelabel_node__field_contacts`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_contacts` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_contacts_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_contacts_target_id` (`field_contacts_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_contacts.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_contacts_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_copyright` to `db_test_cts`.`whitelabel_node__field_copyright`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_copyright`
+++ `db_test_cts`.`whitelabel_node__field_copyright`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_copyright` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_copyright_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_copyright.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_data_protection` to `db_test_cts`.`whitelabel_node__field_data_protection`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_data_protection`
+++ `db_test_cts`.`whitelabel_node__field_data_protection`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node__field_data_protection` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_data_protection_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_data_protection_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_data_protection_format` (`field_data_protection_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_data_protection.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_date` to `db_test_cts`.`whitelabel_node__field_date`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_date`
+++ `db_test_cts`.`whitelabel_node__field_date`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_date` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_date_value` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The date value.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_date_value` (`field_date_value`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_date.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_date_value` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_description` to `db_test_cts`.`whitelabel_node__field_description`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_description`
+++ `db_test_cts`.`whitelabel_node__field_description`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_description` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_description_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_description.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_description_html` to `db_test_cts`.`whitelabel_node__field_description_html`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_description_html`
+++ `db_test_cts`.`whitelabel_node__field_description_html`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node__field_description_html` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_description_html_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_description_html_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_description_html_format` (`field_description_html_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_description_html.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_description_long` to `db_test_cts`.`whitelabel_node__field_description_long`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_description_long`
+++ `db_test_cts`.`whitelabel_node__field_description_long`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_description_long` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_description_long_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_description_long.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_domain_access` to `db_test_cts`.`whitelabel_node__field_domain_access`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_domain_access`
+++ `db_test_cts`.`whitelabel_node__field_domain_access`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_domain_access` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_domain_access_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_domain_access_target_id` (`field_domain_access_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_domain_access.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_domain_access_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_domain_all_affiliates` to `db_test_cts`.`whitelabel_node__field_domain_all_affiliates`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_domain_all_affiliates`
+++ `db_test_cts`.`whitelabel_node__field_domain_all_affiliates`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_domain_all_affiliates` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_domain_all_affiliates_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_domain_all_affiliates.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_email` to `db_test_cts`.`whitelabel_node__field_email`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_email`
+++ `db_test_cts`.`whitelabel_node__field_email`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_email` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_email_value` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_email.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_email_placeholder` to `db_test_cts`.`whitelabel_node__field_email_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_email_placeholder`
+++ `db_test_cts`.`whitelabel_node__field_email_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_email_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_email_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_email_placeholder.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_email_validation_text` to `db_test_cts`.`whitelabel_node__field_email_validation_text`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_email_validation_text`
+++ `db_test_cts`.`whitelabel_node__field_email_validation_text`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_email_validation_text` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_email_validation_text_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_email_validation_text.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_facebook` to `db_test_cts`.`whitelabel_node__field_facebook`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_facebook`
+++ `db_test_cts`.`whitelabel_node__field_facebook`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node__field_facebook` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_facebook_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `field_facebook_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `field_facebook_options` longblob COMMENT 'Serialized array of options for the link.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_facebook_uri` (`field_facebook_uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_facebook.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_facebook_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_facebook_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_facebook_options` longblob,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_facebook_link` to `db_test_cts`.`whitelabel_node__field_facebook_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_facebook_link`
+++ `db_test_cts`.`whitelabel_node__field_facebook_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_facebook_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_facebook_link_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_facebook_link.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_fact_1` to `db_test_cts`.`whitelabel_node__field_fact_1`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_fact_1`
+++ `db_test_cts`.`whitelabel_node__field_fact_1`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_fact_1` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_1_value` int NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_fact_1.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_fact_1_label` to `db_test_cts`.`whitelabel_node__field_fact_1_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_fact_1_label`
+++ `db_test_cts`.`whitelabel_node__field_fact_1_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_fact_1_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_1_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_fact_1_label.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_fact_2` to `db_test_cts`.`whitelabel_node__field_fact_2`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_fact_2`
+++ `db_test_cts`.`whitelabel_node__field_fact_2`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_fact_2` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_2_value` int NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_fact_2.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_fact_2_label` to `db_test_cts`.`whitelabel_node__field_fact_2_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_fact_2_label`
+++ `db_test_cts`.`whitelabel_node__field_fact_2_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_fact_2_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_2_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_fact_2_label.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_fact_3` to `db_test_cts`.`whitelabel_node__field_fact_3`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_fact_3`
+++ `db_test_cts`.`whitelabel_node__field_fact_3`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_fact_3` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_3_value` int NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_fact_3.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_fact_3_label` to `db_test_cts`.`whitelabel_node__field_fact_3_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_fact_3_label`
+++ `db_test_cts`.`whitelabel_node__field_fact_3_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_fact_3_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_3_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_fact_3_label.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_fallback_email` to `db_test_cts`.`whitelabel_node__field_fallback_email`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_fallback_email`
+++ `db_test_cts`.`whitelabel_node__field_fallback_email`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_fallback_email` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fallback_email_value` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_fallback_email.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_file` to `db_test_cts`.`whitelabel_node__field_file`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_file`
+++ `db_test_cts`.`whitelabel_node__field_file`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_file` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_file_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_file_target_id` (`field_file_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_file.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_file_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_firstname_placeholder` to `db_test_cts`.`whitelabel_node__field_firstname_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_firstname_placeholder`
+++ `db_test_cts`.`whitelabel_node__field_firstname_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_firstname_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_firstname_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_firstname_placeholder.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_footer` to `db_test_cts`.`whitelabel_node__field_footer`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_footer`
+++ `db_test_cts`.`whitelabel_node__field_footer`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_footer` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_footer_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_footer_target_id` (`field_footer_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_footer.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_footer_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_footer_section` to `db_test_cts`.`whitelabel_node__field_footer_section`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_footer_section`
+++ `db_test_cts`.`whitelabel_node__field_footer_section`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_footer_section` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_footer_section_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_footer_section_target_id` (`field_footer_section_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_footer_section.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_footer_section_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_google_map_iframe_link` to `db_test_cts`.`whitelabel_node__field_google_map_iframe_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_google_map_iframe_link`
+++ `db_test_cts`.`whitelabel_node__field_google_map_iframe_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_google_map_iframe_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_google_map_iframe_link_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_google_map_iframe_link.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_header` to `db_test_cts`.`whitelabel_node__field_header`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_header`
+++ `db_test_cts`.`whitelabel_node__field_header`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_header` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_header_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_header_target_id` (`field_header_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_header.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_header_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_headline` to `db_test_cts`.`whitelabel_node__field_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_headline`
+++ `db_test_cts`.`whitelabel_node__field_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_headline.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_hr_tiles` to `db_test_cts`.`whitelabel_node__field_hr_tiles`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_hr_tiles`
+++ `db_test_cts`.`whitelabel_node__field_hr_tiles`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_hr_tiles` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_hr_tiles_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_hr_tiles_target_id` (`field_hr_tiles_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_hr_tiles.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_hr_tiles_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_href` to `db_test_cts`.`whitelabel_node__field_href`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_href`
+++ `db_test_cts`.`whitelabel_node__field_href`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_href` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_href_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_href.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_icon_choise` to `db_test_cts`.`whitelabel_node__field_icon_choise`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_icon_choise`
+++ `db_test_cts`.`whitelabel_node__field_icon_choise`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_icon_choise` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_icon_choise_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_icon_choise_value` (`field_icon_choise_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_icon_choise.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_image` to `db_test_cts`.`whitelabel_node__field_image`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_image`
+++ `db_test_cts`.`whitelabel_node__field_image`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_image` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_image_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_image_target_id` (`field_image_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_image.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_image_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_image_link` to `db_test_cts`.`whitelabel_node__field_image_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_image_link`
+++ `db_test_cts`.`whitelabel_node__field_image_link`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_image_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_image_link_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_image_link_target_id` (`field_image_link_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_image_link.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_image_link_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_image_position` to `db_test_cts`.`whitelabel_node__field_image_position`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_image_position`
+++ `db_test_cts`.`whitelabel_node__field_image_position`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_image_position` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_image_position_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_image_position_value` (`field_image_position_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_image_position.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_image_type` to `db_test_cts`.`whitelabel_node__field_image_type`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_image_type`
+++ `db_test_cts`.`whitelabel_node__field_image_type`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_image_type` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_image_type_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_image_type_value` (`field_image_type_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_image_type.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_instagram` to `db_test_cts`.`whitelabel_node__field_instagram`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_instagram`
+++ `db_test_cts`.`whitelabel_node__field_instagram`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node__field_instagram` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_instagram_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `field_instagram_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `field_instagram_options` longblob COMMENT 'Serialized array of options for the link.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_instagram_uri` (`field_instagram_uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_instagram.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_instagram_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_instagram_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_instagram_options` longblob,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_instagram_link` to `db_test_cts`.`whitelabel_node__field_instagram_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_instagram_link`
+++ `db_test_cts`.`whitelabel_node__field_instagram_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_instagram_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_instagram_link_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_instagram_link.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_items` to `db_test_cts`.`whitelabel_node__field_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_items`
+++ `db_test_cts`.`whitelabel_node__field_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_items_target_id` (`field_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_label` to `db_test_cts`.`whitelabel_node__field_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_label`
+++ `db_test_cts`.`whitelabel_node__field_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_label.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_lastname_placeholder` to `db_test_cts`.`whitelabel_node__field_lastname_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_lastname_placeholder`
+++ `db_test_cts`.`whitelabel_node__field_lastname_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_lastname_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_lastname_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_lastname_placeholder.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_lines` to `db_test_cts`.`whitelabel_node__field_lines`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_lines`
+++ `db_test_cts`.`whitelabel_node__field_lines`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_lines` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_lines_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_lines.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_link_label` to `db_test_cts`.`whitelabel_node__field_link_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_link_label`
+++ `db_test_cts`.`whitelabel_node__field_link_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_link_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_link_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_link_label.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_link_title_attribute` to `db_test_cts`.`whitelabel_node__field_link_title_attribute`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_link_title_attribute`
+++ `db_test_cts`.`whitelabel_node__field_link_title_attribute`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_link_title_attribute` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_link_title_attribute_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_link_title_attribute.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_linkedin` to `db_test_cts`.`whitelabel_node__field_linkedin`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_linkedin`
+++ `db_test_cts`.`whitelabel_node__field_linkedin`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node__field_linkedin` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_linkedin_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `field_linkedin_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `field_linkedin_options` longblob COMMENT 'Serialized array of options for the link.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_linkedin_uri` (`field_linkedin_uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_linkedin.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_linkedin_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_linkedin_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_linkedin_options` longblob,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_linkedin_link` to `db_test_cts`.`whitelabel_node__field_linkedin_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_linkedin_link`
+++ `db_test_cts`.`whitelabel_node__field_linkedin_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_linkedin_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_linkedin_link_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_linkedin_link.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_location_items` to `db_test_cts`.`whitelabel_node__field_location_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_location_items`
+++ `db_test_cts`.`whitelabel_node__field_location_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_location_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_location_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_location_items_target_id` (`field_location_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_location_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_location_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_location_name` to `db_test_cts`.`whitelabel_node__field_location_name`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_location_name`
+++ `db_test_cts`.`whitelabel_node__field_location_name`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_location_name` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_location_name_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_location_name.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_location_title` to `db_test_cts`.`whitelabel_node__field_location_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_location_title`
+++ `db_test_cts`.`whitelabel_node__field_location_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_location_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_location_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_location_title.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_logo` to `db_test_cts`.`whitelabel_node__field_logo`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_logo`
+++ `db_test_cts`.`whitelabel_node__field_logo`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_logo` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_logo_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_logo_target_id` (`field_logo_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_logo.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_logo_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_managing` to `db_test_cts`.`whitelabel_node__field_managing`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_managing`
+++ `db_test_cts`.`whitelabel_node__field_managing`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_managing` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_managing_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_managing_target_id` (`field_managing_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_managing.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_managing_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_media_image` to `db_test_cts`.`whitelabel_node__field_media_image`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_media_image`
+++ `db_test_cts`.`whitelabel_node__field_media_image`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_media_image` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_image_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_image_target_id` (`field_media_image_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_media_image.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_image_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_metadata` to `db_test_cts`.`whitelabel_node__field_metadata`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_metadata`
+++ `db_test_cts`.`whitelabel_node__field_metadata`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_metadata` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_metadata_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_metadata_target_id` (`field_metadata_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_metadata.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_metadata_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_name` to `db_test_cts`.`whitelabel_node__field_name`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_name`
+++ `db_test_cts`.`whitelabel_node__field_name`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_name` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_name_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_name.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_navi` to `db_test_cts`.`whitelabel_node__field_navi`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_navi`
+++ `db_test_cts`.`whitelabel_node__field_navi`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_navi` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_navi_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_navi_target_id` (`field_navi_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_navi.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_navi_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_navi_complex_links` to `db_test_cts`.`whitelabel_node__field_navi_complex_links`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_navi_complex_links`
+++ `db_test_cts`.`whitelabel_node__field_navi_complex_links`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_navi_complex_links` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_navi_complex_links_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_navi_complex_links_target_id` (`field_navi_complex_links_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_navi_complex_links.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_navi_complex_links_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_navi_items` to `db_test_cts`.`whitelabel_node__field_navi_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_navi_items`
+++ `db_test_cts`.`whitelabel_node__field_navi_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_navi_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_navi_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_navi_items_target_id` (`field_navi_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_navi_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_navi_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_opens_in_new_tab` to `db_test_cts`.`whitelabel_node__field_opens_in_new_tab`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_opens_in_new_tab`
+++ `db_test_cts`.`whitelabel_node__field_opens_in_new_tab`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_opens_in_new_tab` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_opens_in_new_tab_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_opens_in_new_tab.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_optional_text` to `db_test_cts`.`whitelabel_node__field_optional_text`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_optional_text`
+++ `db_test_cts`.`whitelabel_node__field_optional_text`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_optional_text` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_optional_text_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_optional_text.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_page_slug` to `db_test_cts`.`whitelabel_node__field_page_slug`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_page_slug`
+++ `db_test_cts`.`whitelabel_node__field_page_slug`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_page_slug` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_page_slug_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_page_slug.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_paragraphs` to `db_test_cts`.`whitelabel_node__field_paragraphs`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_paragraphs`
+++ `db_test_cts`.`whitelabel_node__field_paragraphs`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_paragraphs` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_paragraphs_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_paragraphs_target_id` (`field_paragraphs_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_paragraphs.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_paragraphs_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_phone` to `db_test_cts`.`whitelabel_node__field_phone`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_phone`
+++ `db_test_cts`.`whitelabel_node__field_phone`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_phone` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_phone_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_phone.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_phone_placeholder` to `db_test_cts`.`whitelabel_node__field_phone_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_phone_placeholder`
+++ `db_test_cts`.`whitelabel_node__field_phone_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_phone_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_phone_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_phone_placeholder.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_pillars_items` to `db_test_cts`.`whitelabel_node__field_pillars_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_pillars_items`
+++ `db_test_cts`.`whitelabel_node__field_pillars_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_pillars_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_pillars_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_pillars_items_target_id` (`field_pillars_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_pillars_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_pillars_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_play_video_label` to `db_test_cts`.`whitelabel_node__field_play_video_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_play_video_label`
+++ `db_test_cts`.`whitelabel_node__field_play_video_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_play_video_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_play_video_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_play_video_label.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_position` to `db_test_cts`.`whitelabel_node__field_position`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_position`
+++ `db_test_cts`.`whitelabel_node__field_position`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_position` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_position_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_position.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_primary_color_scheme` to `db_test_cts`.`whitelabel_node__field_primary_color_scheme`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_primary_color_scheme`
+++ `db_test_cts`.`whitelabel_node__field_primary_color_scheme`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_primary_color_scheme` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_primary_color_scheme_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_primary_color_scheme.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_question` to `db_test_cts`.`whitelabel_node__field_question`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_question`
+++ `db_test_cts`.`whitelabel_node__field_question`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_question` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_question_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_question.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_questions_and_answers` to `db_test_cts`.`whitelabel_node__field_questions_and_answers`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_questions_and_answers`
+++ `db_test_cts`.`whitelabel_node__field_questions_and_answers`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_questions_and_answers` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_questions_and_answers_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_questions_and_answers_target_id` (`field_questions_and_answers_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_questions_and_answers.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_questions_and_answers_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_quote` to `db_test_cts`.`whitelabel_node__field_quote`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_quote`
+++ `db_test_cts`.`whitelabel_node__field_quote`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node__field_quote` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_quote_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_quote_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_quote_format` (`field_quote_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_quote.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_quotes` to `db_test_cts`.`whitelabel_node__field_quotes`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_quotes`
+++ `db_test_cts`.`whitelabel_node__field_quotes`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_quotes` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_quotes_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_quotes_target_id` (`field_quotes_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_quotes.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_quotes_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_region` to `db_test_cts`.`whitelabel_node__field_region`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_region`
+++ `db_test_cts`.`whitelabel_node__field_region`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_region` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_region_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_region.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_right_column` to `db_test_cts`.`whitelabel_node__field_right_column`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_right_column`
+++ `db_test_cts`.`whitelabel_node__field_right_column`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_right_column` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_right_column_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_right_column_target_id` (`field_right_column_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_right_column.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_right_column_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_robots` to `db_test_cts`.`whitelabel_node__field_robots`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_robots`
+++ `db_test_cts`.`whitelabel_node__field_robots`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_robots` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_robots_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_robots_value` (`field_robots_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_robots.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_section_columns` to `db_test_cts`.`whitelabel_node__field_section_columns`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_section_columns`
+++ `db_test_cts`.`whitelabel_node__field_section_columns`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_section_columns` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_section_columns_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_section_columns_target_id` (`field_section_columns_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_section_columns.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_section_columns_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_section_tab_timeline` to `db_test_cts`.`whitelabel_node__field_section_tab_timeline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_section_tab_timeline`
+++ `db_test_cts`.`whitelabel_node__field_section_tab_timeline`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_section_tab_timeline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_section_tab_timeline_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_section_tab_timeline_target_id` (`field_section_tab_timeline_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_section_tab_timeline.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_section_tab_timeline_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_section_timeline` to `db_test_cts`.`whitelabel_node__field_section_timeline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_section_timeline`
+++ `db_test_cts`.`whitelabel_node__field_section_timeline`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_section_timeline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_section_timeline_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_section_timeline_target_id` (`field_section_timeline_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_section_timeline.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_section_timeline_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_sections` to `db_test_cts`.`whitelabel_node__field_sections`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_sections`
+++ `db_test_cts`.`whitelabel_node__field_sections`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_sections` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_sections_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_sections_target_id` (`field_sections_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_sections.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_sections_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_service_link` to `db_test_cts`.`whitelabel_node__field_service_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_service_link`
+++ `db_test_cts`.`whitelabel_node__field_service_link`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_service_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_service_link_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_service_link_target_id` (`field_service_link_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_service_link.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_service_link_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_services` to `db_test_cts`.`whitelabel_node__field_services`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_services`
+++ `db_test_cts`.`whitelabel_node__field_services`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_services` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_services_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_services_target_id` (`field_services_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_services.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_services_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_services_references` to `db_test_cts`.`whitelabel_node__field_services_references`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_services_references`
+++ `db_test_cts`.`whitelabel_node__field_services_references`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_services_references` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_services_references_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_services_references_target_id` (`field_services_references_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_services_references.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_services_references_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_slogan` to `db_test_cts`.`whitelabel_node__field_slogan`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_slogan`
+++ `db_test_cts`.`whitelabel_node__field_slogan`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_slogan` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_slogan_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_slogan_target_id` (`field_slogan_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_slogan.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_slogan_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_social` to `db_test_cts`.`whitelabel_node__field_social`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_social`
+++ `db_test_cts`.`whitelabel_node__field_social`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_social` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_social_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_social_target_id` (`field_social_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_social.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_social_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_split_items` to `db_test_cts`.`whitelabel_node__field_split_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_split_items`
+++ `db_test_cts`.`whitelabel_node__field_split_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_split_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_split_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_split_items_target_id` (`field_split_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_split_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_split_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_steps` to `db_test_cts`.`whitelabel_node__field_steps`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_steps`
+++ `db_test_cts`.`whitelabel_node__field_steps`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_steps` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_steps_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_steps_target_id` (`field_steps_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_steps.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_steps_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_street_homen_placeholder` to `db_test_cts`.`whitelabel_node__field_street_homen_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_street_homen_placeholder`
+++ `db_test_cts`.`whitelabel_node__field_street_homen_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_street_homen_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_street_homen_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_street_homen_placeholder.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_subheadline` to `db_test_cts`.`whitelabel_node__field_subheadline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_subheadline`
+++ `db_test_cts`.`whitelabel_node__field_subheadline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_subheadline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_subheadline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_subheadline.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_subtitle` to `db_test_cts`.`whitelabel_node__field_subtitle`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_subtitle`
+++ `db_test_cts`.`whitelabel_node__field_subtitle`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_subtitle` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_subtitle_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_subtitle.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_supervisory` to `db_test_cts`.`whitelabel_node__field_supervisory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_supervisory`
+++ `db_test_cts`.`whitelabel_node__field_supervisory`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_supervisory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_supervisory_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_supervisory_target_id` (`field_supervisory_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_supervisory.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_supervisory_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_supervisory_headline` to `db_test_cts`.`whitelabel_node__field_supervisory_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_supervisory_headline`
+++ `db_test_cts`.`whitelabel_node__field_supervisory_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_supervisory_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_supervisory_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_supervisory_headline.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_target` to `db_test_cts`.`whitelabel_node__field_target`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_target`
+++ `db_test_cts`.`whitelabel_node__field_target`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_target` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_target_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_target_target_id` (`field_target_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_target.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_target_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_target_headline` to `db_test_cts`.`whitelabel_node__field_target_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_target_headline`
+++ `db_test_cts`.`whitelabel_node__field_target_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_target_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_target_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_target_headline.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_text_illustration_items` to `db_test_cts`.`whitelabel_node__field_text_illustration_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_text_illustration_items`
+++ `db_test_cts`.`whitelabel_node__field_text_illustration_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_text_illustration_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_text_illustration_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_text_illustration_items_target_id` (`field_text_illustration_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_text_illustration_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_text_illustration_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_timeline_line` to `db_test_cts`.`whitelabel_node__field_timeline_line`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_timeline_line`
+++ `db_test_cts`.`whitelabel_node__field_timeline_line`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_timeline_line` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_timeline_line_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_timeline_line_target_id` (`field_timeline_line_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_timeline_line.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_timeline_line_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_timeline_tab` to `db_test_cts`.`whitelabel_node__field_timeline_tab`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_timeline_tab`
+++ `db_test_cts`.`whitelabel_node__field_timeline_tab`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_timeline_tab` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_timeline_tab_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_timeline_tab_target_id` (`field_timeline_tab_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_timeline_tab.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_timeline_tab_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_times` to `db_test_cts`.`whitelabel_node__field_times`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_times`
+++ `db_test_cts`.`whitelabel_node__field_times`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_times` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_times_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_times.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_top_text` to `db_test_cts`.`whitelabel_node__field_top_text`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_top_text`
+++ `db_test_cts`.`whitelabel_node__field_top_text`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_top_text` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_top_text_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_top_text.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_tracker_collapse_items` to `db_test_cts`.`whitelabel_node__field_tracker_collapse_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_tracker_collapse_items`
+++ `db_test_cts`.`whitelabel_node__field_tracker_collapse_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_tracker_collapse_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_tracker_collapse_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_tracker_collapse_items_target_id` (`field_tracker_collapse_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_tracker_collapse_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_tracker_collapse_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_tracker_sections` to `db_test_cts`.`whitelabel_node__field_tracker_sections`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_tracker_sections`
+++ `db_test_cts`.`whitelabel_node__field_tracker_sections`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_tracker_sections` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_tracker_sections_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_tracker_sections_target_id` (`field_tracker_sections_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_tracker_sections.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_tracker_sections_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_validation_message` to `db_test_cts`.`whitelabel_node__field_validation_message`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_validation_message`
+++ `db_test_cts`.`whitelabel_node__field_validation_message`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_validation_message` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_validation_message_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_validation_message.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_video` to `db_test_cts`.`whitelabel_node__field_video`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_video`
+++ `db_test_cts`.`whitelabel_node__field_video`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node__field_video` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_video_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_video_target_id` (`field_video_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_video.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_video_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_vtt_file` to `db_test_cts`.`whitelabel_node__field_vtt_file`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_vtt_file`
+++ `db_test_cts`.`whitelabel_node__field_vtt_file`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node__field_vtt_file` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_vtt_file_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_vtt_file_display` tinyint unsigned DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
-  `field_vtt_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'A description of the file.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_vtt_file_target_id` (`field_vtt_file_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_vtt_file.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_vtt_file_target_id` int unsigned NOT NULL,
+  `field_vtt_file_display` tinyint unsigned DEFAULT NULL,
+  `field_vtt_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_xing` to `db_test_cts`.`whitelabel_node__field_xing`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_xing`
+++ `db_test_cts`.`whitelabel_node__field_xing`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node__field_xing` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_xing_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `field_xing_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `field_xing_options` longblob COMMENT 'Serialized array of options for the link.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_xing_uri` (`field_xing_uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_xing.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_xing_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_xing_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_xing_options` longblob,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_xing_link` to `db_test_cts`.`whitelabel_node__field_xing_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_xing_link`
+++ `db_test_cts`.`whitelabel_node__field_xing_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_xing_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_xing_link_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_xing_link.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_your_request_headline` to `db_test_cts`.`whitelabel_node__field_your_request_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_your_request_headline`
+++ `db_test_cts`.`whitelabel_node__field_your_request_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_your_request_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_your_request_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_your_request_headline.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node__field_zip_city_placeholder` to `db_test_cts`.`whitelabel_node__field_zip_city_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node__field_zip_city_placeholder`
+++ `db_test_cts`.`whitelabel_node__field_zip_city_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node__field_zip_city_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_zip_city_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for node field field_zip_city_placeholder.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_access` to `db_test_cts`.`whitelabel_node_access`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_access`
+++ `db_test_cts`.`whitelabel_node_access`
@@ -1,11 +1,11 @@
 CREATE TABLE `whitelabel_node_access` (
-  `nid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_node".nid this record affects.',
-  `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The "whitelabel_language".langcode of this node.',
-  `fallback` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether this record should be used as a fallback if a language condition is not provided.',
-  `gid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row''s privileges on the node.',
-  `realm` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Modules can define one or more realms by implementing hook_node_grants().',
-  `grant_view` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
-  `grant_update` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
-  `grant_delete` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
+  `nid` int unsigned NOT NULL,
+  `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `fallback` tinyint unsigned NOT NULL,
+  `gid` int unsigned NOT NULL,
+  `realm` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `grant_view` tinyint unsigned NOT NULL,
+  `grant_update` tinyint unsigned NOT NULL,
+  `grant_delete` tinyint unsigned NOT NULL,
   PRIMARY KEY (`nid`,`gid`,`realm`,`langcode`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Identifies which realm/grant pairs a user must possess in…'
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_field_data` to `db_test_cts`.`whitelabel_node_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_field_data`
+++ `db_test_cts`.`whitelabel_node_field_data`
@@ -1,10 +1,10 @@
 CREATE TABLE `whitelabel_node_field_data` (
   `nid` int unsigned NOT NULL,
   `vid` int unsigned NOT NULL,
-  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `status` tinyint NOT NULL,
-  `uid` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
+  `uid` int unsigned NOT NULL,
   `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `created` int NOT NULL,
   `changed` int NOT NULL,
@@ -16,14 +16,5 @@
   `content_translation_outdated` tinyint DEFAULT NULL,
   `publish_on` int DEFAULT NULL,
   `unpublish_on` int DEFAULT NULL,
-  PRIMARY KEY (`nid`,`langcode`),
-  KEY `node__id__default_langcode__langcode` (`nid`,`default_langcode`,`langcode`),
-  KEY `node__vid` (`vid`),
-  KEY `node_field__type__target_id` (`type`),
-  KEY `node_field__uid__target_id` (`uid`),
-  KEY `node_field__created` (`created`),
-  KEY `node_field__changed` (`changed`),
-  KEY `node__status_type` (`status`,`type`,`nid`),
-  KEY `node__frontpage` (`promote`,`status`,`sticky`,`created`),
-  KEY `node__title_type` (`title`(191),`type`(4))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for node entities.'
+  PRIMARY KEY (`nid`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_field_revision` to `db_test_cts`.`whitelabel_node_field_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_field_revision`
+++ `db_test_cts`.`whitelabel_node_field_revision`
@@ -3,7 +3,7 @@
   `vid` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `status` tinyint NOT NULL,
-  `uid` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
+  `uid` int unsigned NOT NULL,
   `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `created` int DEFAULT NULL,
   `changed` int DEFAULT NULL,
@@ -15,7 +15,5 @@
   `content_translation_outdated` tinyint DEFAULT NULL,
   `publish_on` int DEFAULT NULL,
   `unpublish_on` int DEFAULT NULL,
-  PRIMARY KEY (`vid`,`langcode`),
-  KEY `node__id__default_langcode__langcode` (`nid`,`default_langcode`,`langcode`),
-  KEY `node_field__uid__target_id` (`uid`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision data table for node entities.'
+  PRIMARY KEY (`vid`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision` to `db_test_cts`.`whitelabel_node_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision`
+++ `db_test_cts`.`whitelabel_node_revision`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision` (
   `nid` int unsigned NOT NULL,
-  `vid` int unsigned NOT NULL AUTO_INCREMENT,
+  `vid` int NOT NULL AUTO_INCREMENT,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  `revision_uid` int unsigned DEFAULT NULL COMMENT 'The ID of the target entity.',
+  `revision_uid` int unsigned DEFAULT NULL,
   `revision_timestamp` int DEFAULT NULL,
   `revision_log` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `revision_default` tinyint DEFAULT NULL,
-  PRIMARY KEY (`vid`),
-  KEY `node__nid` (`nid`),
-  KEY `node_field__langcode` (`langcode`),
-  KEY `node_field__revision_uid__target_id` (`revision_uid`)
-) ENGINE=InnoDB AUTO_INCREMENT=10719 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision table for node entities.'
+  PRIMARY KEY (`vid`)
+) ENGINE=InnoDB AUTO_INCREMENT=10377 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__body` to `db_test_cts`.`whitelabel_node_revision__body`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__body`
+++ `db_test_cts`.`whitelabel_node_revision__body`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node_revision__body` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `body_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `body_summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `body_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `body_format` (`body_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field body.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_another_subheadline` to `db_test_cts`.`whitelabel_node_revision__field_another_subheadline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_another_subheadline`
+++ `db_test_cts`.`whitelabel_node_revision__field_another_subheadline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_another_subheadline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_another_subheadline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_another…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_answer_html` to `db_test_cts`.`whitelabel_node_revision__field_answer_html`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_answer_html`
+++ `db_test_cts`.`whitelabel_node_revision__field_answer_html`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node_revision__field_answer_html` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_answer_html_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_answer_html_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_answer_html_format` (`field_answer_html_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_answer_html.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_author` to `db_test_cts`.`whitelabel_node_revision__field_author`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_author`
+++ `db_test_cts`.`whitelabel_node_revision__field_author`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_author` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_author_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_author.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_biography` to `db_test_cts`.`whitelabel_node_revision__field_biography`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_biography`
+++ `db_test_cts`.`whitelabel_node_revision__field_biography`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node_revision__field_biography` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_biography_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_biography_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_biography_format` (`field_biography_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_biography.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_button_label` to `db_test_cts`.`whitelabel_node_revision__field_button_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_button_label`
+++ `db_test_cts`.`whitelabel_node_revision__field_button_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_button_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_button_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_button_label.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_button_link` to `db_test_cts`.`whitelabel_node_revision__field_button_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_button_link`
+++ `db_test_cts`.`whitelabel_node_revision__field_button_link`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_button_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_button_link_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_button_link_target_id` (`field_button_link_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_button_link.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_button_link_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_callto_label` to `db_test_cts`.`whitelabel_node_revision__field_callto_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_callto_label`
+++ `db_test_cts`.`whitelabel_node_revision__field_callto_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_callto_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_callto_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_callto_label.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_canonical` to `db_test_cts`.`whitelabel_node_revision__field_canonical`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_canonical`
+++ `db_test_cts`.`whitelabel_node_revision__field_canonical`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_canonical` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_canonical_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_canonical.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_city_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_city_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_city_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_city_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_city_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_city_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_city…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_city_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_city_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_city_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_city_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_city_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_city_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_city…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_company_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_company_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_company_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_company_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_company_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_company_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_company…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_company_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_company_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_company_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_company_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_company_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_company_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_company…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_email_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_email_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_email_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_email_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_email_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_email_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_email…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_email_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_email_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_email_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_email_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_email_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_email_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_email…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_firstname_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_firstname_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_firstname_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_firstname_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_firstname_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_firstname_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_firstname…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_firstname_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_firstname_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_firstname_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_firstname_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_firstname_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_firstname_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_firstname…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_fleetsize_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_fleetsize_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_fleetsize_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_fleetsize_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_fleetsize_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_fleetsize_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_fleetsize…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_fleetsize_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_fleetsize_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_fleetsize_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_fleetsize_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_fleetsize_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_fleetsize_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_fleetsize…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_fleetsize_visible` to `db_test_cts`.`whitelabel_node_revision__field_cfi_fleetsize_visible`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_fleetsize_visible`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_fleetsize_visible`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_fleetsize_visible` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_fleetsize_visible_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_fleetsize…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_housenumber_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_housenumber_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_housenumber_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_housenumber_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_housenumber_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_housenumber_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_housenumber_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_housenumber_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_housenumber_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_housenumber_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_housenumber_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_housenumber_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_lastname_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_lastname_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_lastname_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_lastname_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_lastname_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_lastname_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_lastname…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_lastname_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_lastname_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_lastname_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_lastname_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_lastname_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_lastname_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_lastname…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_message_placeholder` to `db_test_cts`.`whitelabel_node_revision__field_cfi_message_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_message_placeholder`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_message_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_message_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_message_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_message…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_message_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_message_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_message_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_message_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_message_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_message_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_message…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_phonenumber_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_phonenumber_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_phonenumber_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_phonenumber_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_phonenumber_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_phonenumber_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_phonenumber_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_phonenumber_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_phonenumber_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_phonenumber_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_phonenumber_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_phonenumber_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_request_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_request_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_request_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_request_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_request_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_request_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_request…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_request_options` to `db_test_cts`.`whitelabel_node_revision__field_cfi_request_options`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_request_options`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_request_options`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_request_options` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_request_options_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_request…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_request_visible` to `db_test_cts`.`whitelabel_node_revision__field_cfi_request_visible`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_request_visible`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_request_visible`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_request_visible` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_request_visible_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_request…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_street_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_street_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_street_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_street_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_street_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_street_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_street…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_street_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_street_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_street_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_street_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_street_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_street_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_street…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_title_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_title_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_title_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_title_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_title_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_title_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_title…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_title_options` to `db_test_cts`.`whitelabel_node_revision__field_cfi_title_options`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_title_options`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_title_options`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_title_options` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_title_options_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_title…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_zipcode_mandatory` to `db_test_cts`.`whitelabel_node_revision__field_cfi_zipcode_mandatory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_zipcode_mandatory`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_zipcode_mandatory`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_zipcode_mandatory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_zipcode_mandatory_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_zipcode…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_cfi_zipcode_title` to `db_test_cts`.`whitelabel_node_revision__field_cfi_zipcode_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_cfi_zipcode_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_cfi_zipcode_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_cfi_zipcode_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_cfi_zipcode_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_cfi_zipcode…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_color` to `db_test_cts`.`whitelabel_node_revision__field_color`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_color`
+++ `db_test_cts`.`whitelabel_node_revision__field_color`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_color` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_color_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_color_value` (`field_color_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_color.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_color_variation` to `db_test_cts`.`whitelabel_node_revision__field_color_variation`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_color_variation`
+++ `db_test_cts`.`whitelabel_node_revision__field_color_variation`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_color_variation` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_color_variation_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_color_variation_value` (`field_color_variation_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_color…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_columns` to `db_test_cts`.`whitelabel_node_revision__field_columns`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_columns`
+++ `db_test_cts`.`whitelabel_node_revision__field_columns`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_columns` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_columns_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_columns_target_id` (`field_columns_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_columns.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_columns_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_comment_placeholder` to `db_test_cts`.`whitelabel_node_revision__field_comment_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_comment_placeholder`
+++ `db_test_cts`.`whitelabel_node_revision__field_comment_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_comment_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_comment_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_comment…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_companies_gallery` to `db_test_cts`.`whitelabel_node_revision__field_companies_gallery`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_companies_gallery`
+++ `db_test_cts`.`whitelabel_node_revision__field_companies_gallery`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_companies_gallery` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_companies_gallery_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_companies_gallery_target_id` (`field_companies_gallery_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_companies…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_companies_gallery_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_company_placeholder` to `db_test_cts`.`whitelabel_node_revision__field_company_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_company_placeholder`
+++ `db_test_cts`.`whitelabel_node_revision__field_company_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_company_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_company_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_company…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_confirmation_send_message` to `db_test_cts`.`whitelabel_node_revision__field_confirmation_send_message`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_confirmation_send_message`
+++ `db_test_cts`.`whitelabel_node_revision__field_confirmation_send_message`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_confirmation_send_message` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_confirmation_send_message_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_confirmation…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_contact` to `db_test_cts`.`whitelabel_node_revision__field_contact`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_contact`
+++ `db_test_cts`.`whitelabel_node_revision__field_contact`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_contact` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_contact_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_contact_target_id` (`field_contact_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_contact.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_contact_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_contact_columns` to `db_test_cts`.`whitelabel_node_revision__field_contact_columns`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_contact_columns`
+++ `db_test_cts`.`whitelabel_node_revision__field_contact_columns`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_contact_columns` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_contact_columns_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_contact_columns_target_id` (`field_contact_columns_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_contact…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_contact_columns_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_contact_details_headline` to `db_test_cts`.`whitelabel_node_revision__field_contact_details_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_contact_details_headline`
+++ `db_test_cts`.`whitelabel_node_revision__field_contact_details_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_contact_details_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_contact_details_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_contact…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_contact_label` to `db_test_cts`.`whitelabel_node_revision__field_contact_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_contact_label`
+++ `db_test_cts`.`whitelabel_node_revision__field_contact_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_contact_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_contact_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_contact_label.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_contact_links` to `db_test_cts`.`whitelabel_node_revision__field_contact_links`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_contact_links`
+++ `db_test_cts`.`whitelabel_node_revision__field_contact_links`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_contact_links` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_contact_links_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_contact_links_target_id` (`field_contact_links_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_contact_links.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_contact_links_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_contact_title` to `db_test_cts`.`whitelabel_node_revision__field_contact_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_contact_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_contact_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_contact_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_contact_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_contact_title.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_contacts` to `db_test_cts`.`whitelabel_node_revision__field_contacts`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_contacts`
+++ `db_test_cts`.`whitelabel_node_revision__field_contacts`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_contacts` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_contacts_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_contacts_target_id` (`field_contacts_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_contacts.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_contacts_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_copyright` to `db_test_cts`.`whitelabel_node_revision__field_copyright`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_copyright`
+++ `db_test_cts`.`whitelabel_node_revision__field_copyright`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_copyright` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_copyright_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_copyright.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_data_protection` to `db_test_cts`.`whitelabel_node_revision__field_data_protection`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_data_protection`
+++ `db_test_cts`.`whitelabel_node_revision__field_data_protection`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node_revision__field_data_protection` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_data_protection_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_data_protection_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_data_protection_format` (`field_data_protection_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_data…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_date` to `db_test_cts`.`whitelabel_node_revision__field_date`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_date`
+++ `db_test_cts`.`whitelabel_node_revision__field_date`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_date` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_date_value` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The date value.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_date_value` (`field_date_value`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_date.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_date_value` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_description` to `db_test_cts`.`whitelabel_node_revision__field_description`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_description`
+++ `db_test_cts`.`whitelabel_node_revision__field_description`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_description` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_description_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_description.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_description_html` to `db_test_cts`.`whitelabel_node_revision__field_description_html`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_description_html`
+++ `db_test_cts`.`whitelabel_node_revision__field_description_html`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node_revision__field_description_html` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_description_html_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_description_html_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_description_html_format` (`field_description_html_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_description…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_description_long` to `db_test_cts`.`whitelabel_node_revision__field_description_long`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_description_long`
+++ `db_test_cts`.`whitelabel_node_revision__field_description_long`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_description_long` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_description_long_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_description…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_domain_access` to `db_test_cts`.`whitelabel_node_revision__field_domain_access`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_domain_access`
+++ `db_test_cts`.`whitelabel_node_revision__field_domain_access`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_domain_access` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_domain_access_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_domain_access_target_id` (`field_domain_access_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_domain_access.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_domain_access_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_domain_all_affiliates` to `db_test_cts`.`whitelabel_node_revision__field_domain_all_affiliates`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_domain_all_affiliates`
+++ `db_test_cts`.`whitelabel_node_revision__field_domain_all_affiliates`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_domain_all_affiliates` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_domain_all_affiliates_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_domain_all…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_email` to `db_test_cts`.`whitelabel_node_revision__field_email`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_email`
+++ `db_test_cts`.`whitelabel_node_revision__field_email`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_email` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_email_value` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_email.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_email_placeholder` to `db_test_cts`.`whitelabel_node_revision__field_email_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_email_placeholder`
+++ `db_test_cts`.`whitelabel_node_revision__field_email_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_email_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_email_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_email…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_email_validation_text` to `db_test_cts`.`whitelabel_node_revision__field_email_validation_text`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_email_validation_text`
+++ `db_test_cts`.`whitelabel_node_revision__field_email_validation_text`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_email_validation_text` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_email_validation_text_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_email…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_facebook` to `db_test_cts`.`whitelabel_node_revision__field_facebook`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_facebook`
+++ `db_test_cts`.`whitelabel_node_revision__field_facebook`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node_revision__field_facebook` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_facebook_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `field_facebook_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `field_facebook_options` longblob COMMENT 'Serialized array of options for the link.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_facebook_uri` (`field_facebook_uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_facebook.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_facebook_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_facebook_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_facebook_options` longblob,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_facebook_link` to `db_test_cts`.`whitelabel_node_revision__field_facebook_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_facebook_link`
+++ `db_test_cts`.`whitelabel_node_revision__field_facebook_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_facebook_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_facebook_link_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_facebook_link.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_fact_1` to `db_test_cts`.`whitelabel_node_revision__field_fact_1`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_fact_1`
+++ `db_test_cts`.`whitelabel_node_revision__field_fact_1`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_fact_1` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_1_value` int NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_fact_1.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_fact_1_label` to `db_test_cts`.`whitelabel_node_revision__field_fact_1_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_fact_1_label`
+++ `db_test_cts`.`whitelabel_node_revision__field_fact_1_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_fact_1_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_1_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_fact_1_label.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_fact_2` to `db_test_cts`.`whitelabel_node_revision__field_fact_2`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_fact_2`
+++ `db_test_cts`.`whitelabel_node_revision__field_fact_2`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_fact_2` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_2_value` int NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_fact_2.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_fact_2_label` to `db_test_cts`.`whitelabel_node_revision__field_fact_2_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_fact_2_label`
+++ `db_test_cts`.`whitelabel_node_revision__field_fact_2_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_fact_2_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_2_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_fact_2_label.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_fact_3` to `db_test_cts`.`whitelabel_node_revision__field_fact_3`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_fact_3`
+++ `db_test_cts`.`whitelabel_node_revision__field_fact_3`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_fact_3` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_3_value` int NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_fact_3.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_fact_3_label` to `db_test_cts`.`whitelabel_node_revision__field_fact_3_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_fact_3_label`
+++ `db_test_cts`.`whitelabel_node_revision__field_fact_3_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_fact_3_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fact_3_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_fact_3_label.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_fallback_email` to `db_test_cts`.`whitelabel_node_revision__field_fallback_email`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_fallback_email`
+++ `db_test_cts`.`whitelabel_node_revision__field_fallback_email`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_fallback_email` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_fallback_email_value` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_fallback…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_file` to `db_test_cts`.`whitelabel_node_revision__field_file`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_file`
+++ `db_test_cts`.`whitelabel_node_revision__field_file`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_file` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_file_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_file_target_id` (`field_file_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_file.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_file_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_firstname_placeholder` to `db_test_cts`.`whitelabel_node_revision__field_firstname_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_firstname_placeholder`
+++ `db_test_cts`.`whitelabel_node_revision__field_firstname_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_firstname_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_firstname_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_firstname…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_footer` to `db_test_cts`.`whitelabel_node_revision__field_footer`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_footer`
+++ `db_test_cts`.`whitelabel_node_revision__field_footer`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_footer` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_footer_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_footer_target_id` (`field_footer_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_footer.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_footer_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_footer_section` to `db_test_cts`.`whitelabel_node_revision__field_footer_section`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_footer_section`
+++ `db_test_cts`.`whitelabel_node_revision__field_footer_section`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_footer_section` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_footer_section_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_footer_section_target_id` (`field_footer_section_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_footer…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_footer_section_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_google_map_iframe_link` to `db_test_cts`.`whitelabel_node_revision__field_google_map_iframe_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_google_map_iframe_link`
+++ `db_test_cts`.`whitelabel_node_revision__field_google_map_iframe_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_google_map_iframe_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_google_map_iframe_link_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_google_map…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_header` to `db_test_cts`.`whitelabel_node_revision__field_header`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_header`
+++ `db_test_cts`.`whitelabel_node_revision__field_header`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_header` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_header_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_header_target_id` (`field_header_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_header.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_header_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_headline` to `db_test_cts`.`whitelabel_node_revision__field_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_headline`
+++ `db_test_cts`.`whitelabel_node_revision__field_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_headline.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_hr_tiles` to `db_test_cts`.`whitelabel_node_revision__field_hr_tiles`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_hr_tiles`
+++ `db_test_cts`.`whitelabel_node_revision__field_hr_tiles`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_hr_tiles` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_hr_tiles_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_hr_tiles_target_id` (`field_hr_tiles_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_hr_tiles.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_hr_tiles_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_href` to `db_test_cts`.`whitelabel_node_revision__field_href`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_href`
+++ `db_test_cts`.`whitelabel_node_revision__field_href`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_href` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_href_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_href.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_icon_choise` to `db_test_cts`.`whitelabel_node_revision__field_icon_choise`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_icon_choise`
+++ `db_test_cts`.`whitelabel_node_revision__field_icon_choise`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_icon_choise` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_icon_choise_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_icon_choise_value` (`field_icon_choise_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_icon_choise.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_image` to `db_test_cts`.`whitelabel_node_revision__field_image`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_image`
+++ `db_test_cts`.`whitelabel_node_revision__field_image`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_image` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_image_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_image_target_id` (`field_image_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_image.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_image_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_image_link` to `db_test_cts`.`whitelabel_node_revision__field_image_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_image_link`
+++ `db_test_cts`.`whitelabel_node_revision__field_image_link`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_image_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_image_link_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_image_link_target_id` (`field_image_link_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_image_link.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_image_link_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_image_position` to `db_test_cts`.`whitelabel_node_revision__field_image_position`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_image_position`
+++ `db_test_cts`.`whitelabel_node_revision__field_image_position`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_image_position` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_image_position_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_image_position_value` (`field_image_position_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_image…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_image_type` to `db_test_cts`.`whitelabel_node_revision__field_image_type`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_image_type`
+++ `db_test_cts`.`whitelabel_node_revision__field_image_type`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_image_type` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_image_type_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_image_type_value` (`field_image_type_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_image_type.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_instagram` to `db_test_cts`.`whitelabel_node_revision__field_instagram`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_instagram`
+++ `db_test_cts`.`whitelabel_node_revision__field_instagram`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node_revision__field_instagram` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_instagram_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `field_instagram_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `field_instagram_options` longblob COMMENT 'Serialized array of options for the link.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_instagram_uri` (`field_instagram_uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_instagram.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_instagram_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_instagram_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_instagram_options` longblob,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_instagram_link` to `db_test_cts`.`whitelabel_node_revision__field_instagram_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_instagram_link`
+++ `db_test_cts`.`whitelabel_node_revision__field_instagram_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_instagram_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_instagram_link_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_instagram…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_items` to `db_test_cts`.`whitelabel_node_revision__field_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_items`
+++ `db_test_cts`.`whitelabel_node_revision__field_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_items_target_id` (`field_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_label` to `db_test_cts`.`whitelabel_node_revision__field_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_label`
+++ `db_test_cts`.`whitelabel_node_revision__field_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_label.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_lastname_placeholder` to `db_test_cts`.`whitelabel_node_revision__field_lastname_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_lastname_placeholder`
+++ `db_test_cts`.`whitelabel_node_revision__field_lastname_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_lastname_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_lastname_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_lastname…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_lines` to `db_test_cts`.`whitelabel_node_revision__field_lines`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_lines`
+++ `db_test_cts`.`whitelabel_node_revision__field_lines`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_lines` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_lines_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_lines.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_link_label` to `db_test_cts`.`whitelabel_node_revision__field_link_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_link_label`
+++ `db_test_cts`.`whitelabel_node_revision__field_link_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_link_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_link_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_link_label.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_link_title_attribute` to `db_test_cts`.`whitelabel_node_revision__field_link_title_attribute`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_link_title_attribute`
+++ `db_test_cts`.`whitelabel_node_revision__field_link_title_attribute`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_link_title_attribute` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_link_title_attribute_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_link_title…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_linkedin` to `db_test_cts`.`whitelabel_node_revision__field_linkedin`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_linkedin`
+++ `db_test_cts`.`whitelabel_node_revision__field_linkedin`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node_revision__field_linkedin` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_linkedin_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `field_linkedin_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `field_linkedin_options` longblob COMMENT 'Serialized array of options for the link.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_linkedin_uri` (`field_linkedin_uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_linkedin.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_linkedin_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_linkedin_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_linkedin_options` longblob,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_linkedin_link` to `db_test_cts`.`whitelabel_node_revision__field_linkedin_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_linkedin_link`
+++ `db_test_cts`.`whitelabel_node_revision__field_linkedin_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_linkedin_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_linkedin_link_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_linkedin_link.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_location_items` to `db_test_cts`.`whitelabel_node_revision__field_location_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_location_items`
+++ `db_test_cts`.`whitelabel_node_revision__field_location_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_location_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_location_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_location_items_target_id` (`field_location_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_location…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_location_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_location_name` to `db_test_cts`.`whitelabel_node_revision__field_location_name`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_location_name`
+++ `db_test_cts`.`whitelabel_node_revision__field_location_name`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_location_name` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_location_name_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_location_name.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_location_title` to `db_test_cts`.`whitelabel_node_revision__field_location_title`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_location_title`
+++ `db_test_cts`.`whitelabel_node_revision__field_location_title`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_location_title` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_location_title_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_location…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_logo` to `db_test_cts`.`whitelabel_node_revision__field_logo`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_logo`
+++ `db_test_cts`.`whitelabel_node_revision__field_logo`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_logo` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_logo_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_logo_target_id` (`field_logo_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_logo.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_logo_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_managing` to `db_test_cts`.`whitelabel_node_revision__field_managing`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_managing`
+++ `db_test_cts`.`whitelabel_node_revision__field_managing`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_managing` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_managing_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_managing_target_id` (`field_managing_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_managing.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_managing_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_media_image` to `db_test_cts`.`whitelabel_node_revision__field_media_image`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_media_image`
+++ `db_test_cts`.`whitelabel_node_revision__field_media_image`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_media_image` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_media_image_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_media_image_target_id` (`field_media_image_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_media_image.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_media_image_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_metadata` to `db_test_cts`.`whitelabel_node_revision__field_metadata`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_metadata`
+++ `db_test_cts`.`whitelabel_node_revision__field_metadata`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_metadata` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_metadata_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_metadata_target_id` (`field_metadata_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_metadata.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_metadata_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_name` to `db_test_cts`.`whitelabel_node_revision__field_name`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_name`
+++ `db_test_cts`.`whitelabel_node_revision__field_name`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_name` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_name_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_name.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_navi` to `db_test_cts`.`whitelabel_node_revision__field_navi`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_navi`
+++ `db_test_cts`.`whitelabel_node_revision__field_navi`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_navi` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_navi_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_navi_target_id` (`field_navi_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_navi.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_navi_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_navi_complex_links` to `db_test_cts`.`whitelabel_node_revision__field_navi_complex_links`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_navi_complex_links`
+++ `db_test_cts`.`whitelabel_node_revision__field_navi_complex_links`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_navi_complex_links` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_navi_complex_links_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_navi_complex_links_target_id` (`field_navi_complex_links_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_navi_complex…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_navi_complex_links_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_navi_items` to `db_test_cts`.`whitelabel_node_revision__field_navi_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_navi_items`
+++ `db_test_cts`.`whitelabel_node_revision__field_navi_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_navi_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_navi_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_navi_items_target_id` (`field_navi_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_navi_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_navi_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_opens_in_new_tab` to `db_test_cts`.`whitelabel_node_revision__field_opens_in_new_tab`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_opens_in_new_tab`
+++ `db_test_cts`.`whitelabel_node_revision__field_opens_in_new_tab`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_opens_in_new_tab` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_opens_in_new_tab_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_opens_in_new…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_optional_text` to `db_test_cts`.`whitelabel_node_revision__field_optional_text`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_optional_text`
+++ `db_test_cts`.`whitelabel_node_revision__field_optional_text`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_optional_text` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_optional_text_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_optional_text.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_page_slug` to `db_test_cts`.`whitelabel_node_revision__field_page_slug`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_page_slug`
+++ `db_test_cts`.`whitelabel_node_revision__field_page_slug`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_page_slug` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_page_slug_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_page_slug.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_paragraphs` to `db_test_cts`.`whitelabel_node_revision__field_paragraphs`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_paragraphs`
+++ `db_test_cts`.`whitelabel_node_revision__field_paragraphs`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_paragraphs` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_paragraphs_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_paragraphs_target_id` (`field_paragraphs_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_paragraphs.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_paragraphs_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_phone` to `db_test_cts`.`whitelabel_node_revision__field_phone`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_phone`
+++ `db_test_cts`.`whitelabel_node_revision__field_phone`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_phone` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_phone_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_phone.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_phone_placeholder` to `db_test_cts`.`whitelabel_node_revision__field_phone_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_phone_placeholder`
+++ `db_test_cts`.`whitelabel_node_revision__field_phone_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_phone_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_phone_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_phone…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_pillars_items` to `db_test_cts`.`whitelabel_node_revision__field_pillars_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_pillars_items`
+++ `db_test_cts`.`whitelabel_node_revision__field_pillars_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_pillars_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_pillars_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_pillars_items_target_id` (`field_pillars_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_pillars_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_pillars_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_play_video_label` to `db_test_cts`.`whitelabel_node_revision__field_play_video_label`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_play_video_label`
+++ `db_test_cts`.`whitelabel_node_revision__field_play_video_label`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_play_video_label` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_play_video_label_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_play_video…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_position` to `db_test_cts`.`whitelabel_node_revision__field_position`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_position`
+++ `db_test_cts`.`whitelabel_node_revision__field_position`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_position` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_position_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_position.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_primary_color_scheme` to `db_test_cts`.`whitelabel_node_revision__field_primary_color_scheme`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_primary_color_scheme`
+++ `db_test_cts`.`whitelabel_node_revision__field_primary_color_scheme`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_primary_color_scheme` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_primary_color_scheme_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_primary_color…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_question` to `db_test_cts`.`whitelabel_node_revision__field_question`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_question`
+++ `db_test_cts`.`whitelabel_node_revision__field_question`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_question` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_question_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_question.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_questions_and_answers` to `db_test_cts`.`whitelabel_node_revision__field_questions_and_answers`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_questions_and_answers`
+++ `db_test_cts`.`whitelabel_node_revision__field_questions_and_answers`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_questions_and_answers` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_questions_and_answers_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_questions_and_answers_target_id` (`field_questions_and_answers_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_questions_and…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_questions_and_answers_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_quote` to `db_test_cts`.`whitelabel_node_revision__field_quote`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_quote`
+++ `db_test_cts`.`whitelabel_node_revision__field_quote`
@@ -1,14 +1,11 @@
 CREATE TABLE `whitelabel_node_revision__field_quote` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_quote_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `field_quote_format` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_quote_format` (`field_quote_format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_quote.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_quotes` to `db_test_cts`.`whitelabel_node_revision__field_quotes`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_quotes`
+++ `db_test_cts`.`whitelabel_node_revision__field_quotes`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_quotes` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_quotes_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_quotes_target_id` (`field_quotes_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_quotes.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_quotes_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_region` to `db_test_cts`.`whitelabel_node_revision__field_region`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_region`
+++ `db_test_cts`.`whitelabel_node_revision__field_region`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_region` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_region_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_region.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_right_column` to `db_test_cts`.`whitelabel_node_revision__field_right_column`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_right_column`
+++ `db_test_cts`.`whitelabel_node_revision__field_right_column`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_right_column` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_right_column_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_right_column_target_id` (`field_right_column_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_right_column.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_right_column_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_robots` to `db_test_cts`.`whitelabel_node_revision__field_robots`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_robots`
+++ `db_test_cts`.`whitelabel_node_revision__field_robots`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_robots` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_robots_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_robots_value` (`field_robots_value`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_robots.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_section_columns` to `db_test_cts`.`whitelabel_node_revision__field_section_columns`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_section_columns`
+++ `db_test_cts`.`whitelabel_node_revision__field_section_columns`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_section_columns` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_section_columns_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_section_columns_target_id` (`field_section_columns_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_section…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_section_columns_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_section_tab_timeline` to `db_test_cts`.`whitelabel_node_revision__field_section_tab_timeline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_section_tab_timeline`
+++ `db_test_cts`.`whitelabel_node_revision__field_section_tab_timeline`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_section_tab_timeline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_section_tab_timeline_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_section_tab_timeline_target_id` (`field_section_tab_timeline_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_section_tab…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_section_tab_timeline_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_section_timeline` to `db_test_cts`.`whitelabel_node_revision__field_section_timeline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_section_timeline`
+++ `db_test_cts`.`whitelabel_node_revision__field_section_timeline`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_section_timeline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_section_timeline_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_section_timeline_target_id` (`field_section_timeline_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_section…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_section_timeline_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_sections` to `db_test_cts`.`whitelabel_node_revision__field_sections`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_sections`
+++ `db_test_cts`.`whitelabel_node_revision__field_sections`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_sections` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_sections_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_sections_target_id` (`field_sections_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_sections.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_sections_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_service_link` to `db_test_cts`.`whitelabel_node_revision__field_service_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_service_link`
+++ `db_test_cts`.`whitelabel_node_revision__field_service_link`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_service_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_service_link_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_service_link_target_id` (`field_service_link_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_service_link.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_service_link_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_services` to `db_test_cts`.`whitelabel_node_revision__field_services`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_services`
+++ `db_test_cts`.`whitelabel_node_revision__field_services`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_services` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_services_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_services_target_id` (`field_services_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_services.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_services_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_services_references` to `db_test_cts`.`whitelabel_node_revision__field_services_references`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_services_references`
+++ `db_test_cts`.`whitelabel_node_revision__field_services_references`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_services_references` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_services_references_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_services_references_target_id` (`field_services_references_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_services…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_services_references_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_slogan` to `db_test_cts`.`whitelabel_node_revision__field_slogan`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_slogan`
+++ `db_test_cts`.`whitelabel_node_revision__field_slogan`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_slogan` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_slogan_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_slogan_target_id` (`field_slogan_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_slogan.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_slogan_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_social` to `db_test_cts`.`whitelabel_node_revision__field_social`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_social`
+++ `db_test_cts`.`whitelabel_node_revision__field_social`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_social` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_social_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_social_target_id` (`field_social_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_social.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_social_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_split_items` to `db_test_cts`.`whitelabel_node_revision__field_split_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_split_items`
+++ `db_test_cts`.`whitelabel_node_revision__field_split_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_split_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_split_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_split_items_target_id` (`field_split_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_split_items.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_split_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_steps` to `db_test_cts`.`whitelabel_node_revision__field_steps`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_steps`
+++ `db_test_cts`.`whitelabel_node_revision__field_steps`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_steps` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_steps_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_steps_target_id` (`field_steps_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_steps.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_steps_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_street_homen_placeholder` to `db_test_cts`.`whitelabel_node_revision__field_street_homen_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_street_homen_placeholder`
+++ `db_test_cts`.`whitelabel_node_revision__field_street_homen_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_street_homen_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_street_homen_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_street_homen…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_subheadline` to `db_test_cts`.`whitelabel_node_revision__field_subheadline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_subheadline`
+++ `db_test_cts`.`whitelabel_node_revision__field_subheadline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_subheadline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_subheadline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_subheadline.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_subtitle` to `db_test_cts`.`whitelabel_node_revision__field_subtitle`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_subtitle`
+++ `db_test_cts`.`whitelabel_node_revision__field_subtitle`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_subtitle` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_subtitle_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_subtitle.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_supervisory` to `db_test_cts`.`whitelabel_node_revision__field_supervisory`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_supervisory`
+++ `db_test_cts`.`whitelabel_node_revision__field_supervisory`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_supervisory` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_supervisory_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_supervisory_target_id` (`field_supervisory_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_supervisory.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_supervisory_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_supervisory_headline` to `db_test_cts`.`whitelabel_node_revision__field_supervisory_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_supervisory_headline`
+++ `db_test_cts`.`whitelabel_node_revision__field_supervisory_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_supervisory_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_supervisory_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_supervisory…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_target` to `db_test_cts`.`whitelabel_node_revision__field_target`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_target`
+++ `db_test_cts`.`whitelabel_node_revision__field_target`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_target` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_target_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_target_target_id` (`field_target_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_target.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_target_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_target_headline` to `db_test_cts`.`whitelabel_node_revision__field_target_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_target_headline`
+++ `db_test_cts`.`whitelabel_node_revision__field_target_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_target_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_target_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_target…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_text_illustration_items` to `db_test_cts`.`whitelabel_node_revision__field_text_illustration_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_text_illustration_items`
+++ `db_test_cts`.`whitelabel_node_revision__field_text_illustration_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_text_illustration_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_text_illustration_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_text_illustration_items_target_id` (`field_text_illustration_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_text…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_text_illustration_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_timeline_line` to `db_test_cts`.`whitelabel_node_revision__field_timeline_line`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_timeline_line`
+++ `db_test_cts`.`whitelabel_node_revision__field_timeline_line`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_timeline_line` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_timeline_line_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_timeline_line_target_id` (`field_timeline_line_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_timeline_line.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_timeline_line_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_timeline_tab` to `db_test_cts`.`whitelabel_node_revision__field_timeline_tab`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_timeline_tab`
+++ `db_test_cts`.`whitelabel_node_revision__field_timeline_tab`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_timeline_tab` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_timeline_tab_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_timeline_tab_target_id` (`field_timeline_tab_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_timeline_tab.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_timeline_tab_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_times` to `db_test_cts`.`whitelabel_node_revision__field_times`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_times`
+++ `db_test_cts`.`whitelabel_node_revision__field_times`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_times` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_times_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_times.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_top_text` to `db_test_cts`.`whitelabel_node_revision__field_top_text`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_top_text`
+++ `db_test_cts`.`whitelabel_node_revision__field_top_text`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_top_text` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_top_text_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_top_text.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_tracker_collapse_items` to `db_test_cts`.`whitelabel_node_revision__field_tracker_collapse_items`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_tracker_collapse_items`
+++ `db_test_cts`.`whitelabel_node_revision__field_tracker_collapse_items`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_tracker_collapse_items` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_tracker_collapse_items_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_tracker_collapse_items_target_id` (`field_tracker_collapse_items_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_tracker…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_tracker_collapse_items_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_tracker_sections` to `db_test_cts`.`whitelabel_node_revision__field_tracker_sections`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_tracker_sections`
+++ `db_test_cts`.`whitelabel_node_revision__field_tracker_sections`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_tracker_sections` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_tracker_sections_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_tracker_sections_target_id` (`field_tracker_sections_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_tracker…'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_tracker_sections_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_validation_message` to `db_test_cts`.`whitelabel_node_revision__field_validation_message`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_validation_message`
+++ `db_test_cts`.`whitelabel_node_revision__field_validation_message`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_validation_message` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_validation_message_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_validation…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_video` to `db_test_cts`.`whitelabel_node_revision__field_video`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_video`
+++ `db_test_cts`.`whitelabel_node_revision__field_video`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_video` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_video_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_video_target_id` (`field_video_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_video.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_video_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_vtt_file` to `db_test_cts`.`whitelabel_node_revision__field_vtt_file`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_vtt_file`
+++ `db_test_cts`.`whitelabel_node_revision__field_vtt_file`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node_revision__field_vtt_file` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_vtt_file_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `field_vtt_file_display` tinyint unsigned DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
-  `field_vtt_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'A description of the file.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_vtt_file_target_id` (`field_vtt_file_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_vtt_file.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_vtt_file_target_id` int unsigned NOT NULL,
+  `field_vtt_file_display` tinyint unsigned DEFAULT NULL,
+  `field_vtt_file_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_xing` to `db_test_cts`.`whitelabel_node_revision__field_xing`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_xing`
+++ `db_test_cts`.`whitelabel_node_revision__field_xing`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_node_revision__field_xing` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_xing_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `field_xing_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `field_xing_options` longblob COMMENT 'Serialized array of options for the link.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_xing_uri` (`field_xing_uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_xing.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_xing_uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_xing_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `field_xing_options` longblob,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_xing_link` to `db_test_cts`.`whitelabel_node_revision__field_xing_link`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_xing_link`
+++ `db_test_cts`.`whitelabel_node_revision__field_xing_link`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_xing_link` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_xing_link_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_xing_link.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_your_request_headline` to `db_test_cts`.`whitelabel_node_revision__field_your_request_headline`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_your_request_headline`
+++ `db_test_cts`.`whitelabel_node_revision__field_your_request_headline`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_your_request_headline` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_your_request_headline_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_your_request…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_node_revision__field_zip_city_placeholder` to `db_test_cts`.`whitelabel_node_revision__field_zip_city_placeholder`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_node_revision__field_zip_city_placeholder`
+++ `db_test_cts`.`whitelabel_node_revision__field_zip_city_placeholder`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_node_revision__field_zip_city_placeholder` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_zip_city_placeholder_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for node field field_zip_city…'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_paragraph__field_text` to `db_test_cts`.`whitelabel_paragraph__field_text`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_paragraph__field_text`
+++ `db_test_cts`.`whitelabel_paragraph__field_text`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_paragraph__field_text` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_text_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for paragraph field field_text.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_paragraph_revision__field_text` to `db_test_cts`.`whitelabel_paragraph_revision__field_text`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_paragraph_revision__field_text`
+++ `db_test_cts`.`whitelabel_paragraph_revision__field_text`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_paragraph_revision__field_text` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_text_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for paragraph field field_text.'
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_paragraphs_item` to `db_test_cts`.`whitelabel_paragraphs_item`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_paragraphs_item`
+++ `db_test_cts`.`whitelabel_paragraphs_item`
@@ -1,11 +1,8 @@
 CREATE TABLE `whitelabel_paragraphs_item` (
-  `id` int unsigned NOT NULL AUTO_INCREMENT,
+  `id` int unsigned NOT NULL,
   `revision_id` int unsigned DEFAULT NULL,
-  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`id`),
-  UNIQUE KEY `paragraph_field__uuid__value` (`uuid`),
-  UNIQUE KEY `paragraph__revision_id` (`revision_id`),
-  KEY `paragraph_field__type__target_id` (`type`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for paragraph entities.'
+  PRIMARY KEY (`id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_paragraphs_item_field_data` to `db_test_cts`.`whitelabel_paragraphs_item_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_paragraphs_item_field_data`
+++ `db_test_cts`.`whitelabel_paragraphs_item_field_data`
@@ -1,7 +1,7 @@
 CREATE TABLE `whitelabel_paragraphs_item_field_data` (
   `id` int unsigned NOT NULL,
   `revision_id` int unsigned NOT NULL,
-  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `type` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `status` tinyint NOT NULL,
   `created` int DEFAULT NULL,
@@ -11,10 +11,5 @@
   `behavior_settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`id`,`langcode`),
-  KEY `paragraph__id__default_langcode__langcode` (`id`,`default_langcode`,`langcode`),
-  KEY `paragraph__revision_id` (`revision_id`),
-  KEY `paragraph_field__type__target_id` (`type`),
-  KEY `paragraph__status_type` (`status`,`type`,`id`),
-  KEY `paragraphs__parent_fields` (`parent_type`,`parent_id`,`parent_field_name`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for paragraph entities.'
+  PRIMARY KEY (`id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_paragraphs_item_revision` to `db_test_cts`.`whitelabel_paragraphs_item_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_paragraphs_item_revision`
+++ `db_test_cts`.`whitelabel_paragraphs_item_revision`
@@ -1,8 +1,7 @@
 CREATE TABLE `whitelabel_paragraphs_item_revision` (
   `id` int unsigned NOT NULL,
-  `revision_id` int unsigned NOT NULL AUTO_INCREMENT,
+  `revision_id` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `revision_default` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`),
-  KEY `paragraph__id` (`id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision table for paragraph entities.'
+  PRIMARY KEY (`revision_id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_paragraphs_item_revision_field_data` to `db_test_cts`.`whitelabel_paragraphs_item_revision_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_paragraphs_item_revision_field_data`
+++ `db_test_cts`.`whitelabel_paragraphs_item_revision_field_data`
@@ -10,7 +10,5 @@
   `behavior_settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`,`langcode`),
-  KEY `paragraph__id__default_langcode__langcode` (`id`,`default_langcode`,`langcode`),
-  KEY `paragraphs__parent_fields` (`parent_type`,`parent_id`,`parent_field_name`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision data table for paragraph entities.'
+  PRIMARY KEY (`revision_id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_path_alias` to `db_test_cts`.`whitelabel_path_alias`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_path_alias`
+++ `db_test_cts`.`whitelabel_path_alias`
@@ -1,15 +1,10 @@
 CREATE TABLE `whitelabel_path_alias` (
-  `id` int unsigned NOT NULL AUTO_INCREMENT,
+  `id` int unsigned NOT NULL,
   `revision_id` int unsigned DEFAULT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `status` tinyint NOT NULL,
-  PRIMARY KEY (`id`),
-  UNIQUE KEY `path_alias_field__uuid__value` (`uuid`),
-  UNIQUE KEY `path_alias__revision_id` (`revision_id`),
-  KEY `path_alias__status` (`status`,`id`),
-  KEY `path_alias__alias_langcode_id_status` (`alias`(191),`langcode`,`id`,`status`),
-  KEY `path_alias__path_langcode_id_status` (`path`(191),`langcode`,`id`,`status`)
-) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for path_alias entities.'
+  PRIMARY KEY (`id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_path_alias_revision` to `db_test_cts`.`whitelabel_path_alias_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_path_alias_revision`
+++ `db_test_cts`.`whitelabel_path_alias_revision`
@@ -1,11 +1,10 @@
 CREATE TABLE `whitelabel_path_alias_revision` (
   `id` int unsigned NOT NULL,
-  `revision_id` int unsigned NOT NULL AUTO_INCREMENT,
+  `revision_id` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `status` tinyint NOT NULL,
   `revision_default` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`),
-  KEY `path_alias__id` (`id`)
-) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision table for path_alias entities.'
+  PRIMARY KEY (`revision_id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_queue` to `db_test_cts`.`whitelabel_queue`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_queue`
+++ `db_test_cts`.`whitelabel_queue`
@@ -1,10 +1,8 @@
 CREATE TABLE `whitelabel_queue` (
-  `item_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
-  `name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The queue name.',
-  `data` longblob COMMENT 'The arbitrary data for the item.',
-  `expire` int NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
-  `created` int NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
-  PRIMARY KEY (`item_id`),
-  KEY `name_created` (`name`,`created`),
-  KEY `expire` (`expire`)
-) ENGINE=InnoDB AUTO_INCREMENT=7517 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores items in queues.'
+  `item_id` int NOT NULL AUTO_INCREMENT,
+  `name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `data` longblob,
+  `expire` int DEFAULT '0',
+  `created` int NOT NULL,
+  PRIMARY KEY (`item_id`)
+) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_router` to `db_test_cts`.`whitelabel_router`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_router`
+++ `db_test_cts`.`whitelabel_router`
@@ -1,10 +1,9 @@
 CREATE TABLE `whitelabel_router` (
-  `name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'Primary Key: Machine name of this route',
-  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The path for this URI',
-  `pattern_outline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The pattern',
-  `fit` int NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
-  `route` longblob COMMENT 'A serialized Route object',
-  `number_parts` smallint NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
-  PRIMARY KEY (`name`),
-  KEY `pattern_outline_parts` (`pattern_outline`(191),`number_parts`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Maps paths to various callbacks (access, page and title)'
+  `name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  `pattern_outline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  `fit` int NOT NULL,
+  `route` longblob,
+  `number_parts` smallint NOT NULL,
+  PRIMARY KEY (`name`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_s3fs_file` to `db_test_cts`.`whitelabel_s3fs_file`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_s3fs_file`
+++ `db_test_cts`.`whitelabel_s3fs_file`
@@ -1,9 +1,8 @@
 CREATE TABLE `whitelabel_s3fs_file` (
-  `uri` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'The S3 URI of the file.',
-  `filesize` bigint unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
-  `timestamp` int unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
-  `dir` int NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this object is a directory.',
-  `version` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT 'The S3 VersionId of the object.',
-  PRIMARY KEY (`uri`),
-  KEY `timestamp` (`timestamp`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Stores metadata about files in S3.'
+  `uri` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
+  `filesize` bigint unsigned NOT NULL,
+  `timestamp` int unsigned NOT NULL,
+  `dir` int NOT NULL,
+  `version` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
+  PRIMARY KEY (`uri`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin
# Comparing `db`.`whitelabel_search_dataset` to `db_test_cts`.`whitelabel_search_dataset`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_search_dataset`
+++ `db_test_cts`.`whitelabel_search_dataset`
@@ -1,8 +1,8 @@
 CREATE TABLE `whitelabel_search_dataset` (
-  `sid` int unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
-  `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The "whitelabel_languages".langcode of the item variant.',
-  `type` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'Type of item, e.g. node.',
-  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'List of space-separated words from the item.',
-  `reindex` int unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
+  `sid` int unsigned NOT NULL,
+  `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `type` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  `reindex` int unsigned NOT NULL,
   PRIMARY KEY (`sid`,`langcode`,`type`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores items that will be searched.'
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_search_index` to `db_test_cts`.`whitelabel_search_index`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_search_index`
+++ `db_test_cts`.`whitelabel_search_index`
@@ -1,9 +1,8 @@
 CREATE TABLE `whitelabel_search_index` (
-  `word` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The "whitelabel_search_total".word that is associated with the search item.',
-  `sid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_search_dataset".sid of the searchable item to which the word belongs.',
-  `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The "whitelabel_languages".langcode of the item variant.',
-  `type` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The "whitelabel_search_dataset".type of the searchable item to which the word belongs.',
-  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
-  PRIMARY KEY (`word`,`sid`,`langcode`,`type`),
-  KEY `sid_type` (`sid`,`langcode`,`type`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores the search index, associating words, items and…'
+  `word` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  `sid` int unsigned NOT NULL,
+  `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `type` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `score` float DEFAULT NULL,
+  PRIMARY KEY (`word`,`sid`,`langcode`,`type`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_search_total` to `db_test_cts`.`whitelabel_search_total`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_search_total`
+++ `db_test_cts`.`whitelabel_search_total`
@@ -1,5 +1,5 @@
 CREATE TABLE `whitelabel_search_total` (
-  `word` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
-  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf''s law to equalize the probability distribution.',
+  `word` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
+  `count` float DEFAULT NULL,
   PRIMARY KEY (`word`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores search totals for words.'
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_semaphore` to `db_test_cts`.`whitelabel_semaphore`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_semaphore`
+++ `db_test_cts`.`whitelabel_semaphore`
@@ -1,8 +1,6 @@
 CREATE TABLE `whitelabel_semaphore` (
-  `name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
-  `value` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
-  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
-  PRIMARY KEY (`name`),
-  KEY `value` (`value`),
-  KEY `expire` (`expire`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table for holding semaphores, locks, flags, etc. that…'
+  `name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `value` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `expire` double NOT NULL,
+  PRIMARY KEY (`name`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_sequences` to `db_test_cts`.`whitelabel_sequences`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_sequences`
+++ `db_test_cts`.`whitelabel_sequences`
@@ -1,4 +1,4 @@
 CREATE TABLE `whitelabel_sequences` (
-  `value` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
+  `value` int unsigned NOT NULL,
   PRIMARY KEY (`value`)
-) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores IDs.'
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_sessions` to `db_test_cts`.`whitelabel_sessions`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_sessions`
+++ `db_test_cts`.`whitelabel_sessions`
@@ -1,10 +1,8 @@
 CREATE TABLE `whitelabel_sessions` (
-  `uid` int unsigned NOT NULL COMMENT 'The "whitelabel_users".uid corresponding to a session, or 0 for anonymous user.',
-  `sid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'A session ID (hashed). The value is generated by Drupal''s session handlers.',
-  `hostname` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
-  `timestamp` int NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
-  `session` longblob COMMENT 'The serialized contents of the user''s session, an array of name/value pairs that persists across page requests by this session ID. Drupal loads the user''s session from here at the start of each request and saves it at the end.',
-  PRIMARY KEY (`sid`),
-  KEY `timestamp` (`timestamp`),
-  KEY `uid` (`uid`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Drupal''s session handlers read and write into the sessions…'
+  `uid` int unsigned NOT NULL,
+  `sid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `hostname` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `timestamp` int NOT NULL,
+  `session` longblob,
+  PRIMARY KEY (`sid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_shortcut` to `db_test_cts`.`whitelabel_shortcut`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_shortcut`
+++ `db_test_cts`.`whitelabel_shortcut`
@@ -1,9 +1,7 @@
 CREATE TABLE `whitelabel_shortcut` (
-  `id` int unsigned NOT NULL AUTO_INCREMENT,
-  `shortcut_set` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `id` int unsigned NOT NULL,
+  `shortcut_set` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`id`),
-  UNIQUE KEY `shortcut_field__uuid__value` (`uuid`),
-  KEY `shortcut_field__shortcut_set__target_id` (`shortcut_set`)
-) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for shortcut entities.'
+  PRIMARY KEY (`id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_shortcut_field_data` to `db_test_cts`.`whitelabel_shortcut_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_shortcut_field_data`
+++ `db_test_cts`.`whitelabel_shortcut_field_data`
@@ -1,15 +1,12 @@
 CREATE TABLE `whitelabel_shortcut_field_data` (
   `id` int unsigned NOT NULL,
-  `shortcut_set` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `shortcut_set` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `weight` int DEFAULT NULL,
-  `link__uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The URI of the link.',
-  `link__title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The link text.',
-  `link__options` longblob COMMENT 'Serialized array of options for the link.',
+  `link__uri` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `link__title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `link__options` longblob,
   `default_langcode` tinyint NOT NULL,
-  PRIMARY KEY (`id`,`langcode`),
-  KEY `shortcut__id__default_langcode__langcode` (`id`,`default_langcode`,`langcode`),
-  KEY `shortcut_field__shortcut_set__target_id` (`shortcut_set`),
-  KEY `shortcut_field__link__uri` (`link__uri`(30))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for shortcut entities.'
+  PRIMARY KEY (`id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_shortcut_set_users` to `db_test_cts`.`whitelabel_shortcut_set_users`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_shortcut_set_users`
+++ `db_test_cts`.`whitelabel_shortcut_set_users`
@@ -1,6 +1,5 @@
 CREATE TABLE `whitelabel_shortcut_set_users` (
-  `uid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_users".uid for this set.',
-  `set_name` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The "whitelabel_shortcut_set".set_name that will be displayed for this user.',
-  PRIMARY KEY (`uid`),
-  KEY `set_name` (`set_name`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Maps users to shortcut sets.'
+  `uid` int unsigned NOT NULL,
+  `set_name` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`uid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_taxonomy_index` to `db_test_cts`.`whitelabel_taxonomy_index`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_taxonomy_index`
+++ `db_test_cts`.`whitelabel_taxonomy_index`
@@ -1,9 +1,8 @@
 CREATE TABLE `whitelabel_taxonomy_index` (
-  `nid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_node".nid this record tracks.',
-  `tid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
-  `status` int NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
-  `sticky` tinyint DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
-  `created` int NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
-  PRIMARY KEY (`nid`,`tid`),
-  KEY `term_node` (`tid`,`status`,`sticky`,`created`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Maintains denormalized information about node/term…'
+  `nid` int unsigned NOT NULL,
+  `tid` int unsigned NOT NULL,
+  `status` int NOT NULL,
+  `sticky` tinyint DEFAULT NULL,
+  `created` int NOT NULL,
+  PRIMARY KEY (`nid`,`tid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_taxonomy_term__field_page` to `db_test_cts`.`whitelabel_taxonomy_term__field_page`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_taxonomy_term__field_page`
+++ `db_test_cts`.`whitelabel_taxonomy_term__field_page`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_taxonomy_term__field_page` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_page_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_page_target_id` (`field_page_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for taxonomy_term field field_page.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_page_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_taxonomy_term__parent` to `db_test_cts`.`whitelabel_taxonomy_term__parent`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_taxonomy_term__parent`
+++ `db_test_cts`.`whitelabel_taxonomy_term__parent`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_taxonomy_term__parent` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `parent_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `revision_id` (`revision_id`),
-  KEY `parent_target_id` (`parent_target_id`),
-  KEY `bundle_delta_target_id` (`bundle`,`delta`,`parent_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for taxonomy_term field parent.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `parent_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_taxonomy_term_data` to `db_test_cts`.`whitelabel_taxonomy_term_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_taxonomy_term_data`
+++ `db_test_cts`.`whitelabel_taxonomy_term_data`
@@ -1,11 +1,8 @@
 CREATE TABLE `whitelabel_taxonomy_term_data` (
-  `tid` int unsigned NOT NULL AUTO_INCREMENT,
+  `tid` int unsigned NOT NULL,
   `revision_id` int unsigned DEFAULT NULL,
-  `vid` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `vid` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`tid`),
-  UNIQUE KEY `taxonomy_term_field__uuid__value` (`uuid`),
-  UNIQUE KEY `taxonomy_term__revision_id` (`revision_id`),
-  KEY `taxonomy_term_field__vid__target_id` (`vid`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for taxonomy_term entities.'
+  PRIMARY KEY (`tid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_taxonomy_term_field_data` to `db_test_cts`.`whitelabel_taxonomy_term_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_taxonomy_term_field_data`
+++ `db_test_cts`.`whitelabel_taxonomy_term_field_data`
@@ -1,7 +1,7 @@
 CREATE TABLE `whitelabel_taxonomy_term_field_data` (
   `tid` int unsigned NOT NULL,
   `revision_id` int unsigned NOT NULL,
-  `vid` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
+  `vid` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `status` tinyint NOT NULL,
   `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
@@ -11,11 +11,5 @@
   `changed` int DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`tid`,`langcode`),
-  KEY `taxonomy_term__id__default_langcode__langcode` (`tid`,`default_langcode`,`langcode`),
-  KEY `taxonomy_term__revision_id` (`revision_id`),
-  KEY `taxonomy_term_field__name` (`name`(191)),
-  KEY `taxonomy_term__status_vid` (`status`,`vid`,`tid`),
-  KEY `taxonomy_term__tree` (`vid`,`weight`,`name`(191)),
-  KEY `taxonomy_term__vid_name` (`vid`,`name`(191))
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for taxonomy_term entities.'
+  PRIMARY KEY (`tid`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_taxonomy_term_field_revision` to `db_test_cts`.`whitelabel_taxonomy_term_field_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_taxonomy_term_field_revision`
+++ `db_test_cts`.`whitelabel_taxonomy_term_field_revision`
@@ -9,7 +9,5 @@
   `changed` int DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
   `revision_translation_affected` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`,`langcode`),
-  KEY `taxonomy_term__id__default_langcode__langcode` (`tid`,`default_langcode`,`langcode`),
-  KEY `taxonomy_term_field__description__format` (`description__format`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision data table for taxonomy_term entities.'
+  PRIMARY KEY (`revision_id`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_taxonomy_term_revision` to `db_test_cts`.`whitelabel_taxonomy_term_revision`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_taxonomy_term_revision`
+++ `db_test_cts`.`whitelabel_taxonomy_term_revision`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_taxonomy_term_revision` (
   `tid` int unsigned NOT NULL,
-  `revision_id` int unsigned NOT NULL AUTO_INCREMENT,
+  `revision_id` int unsigned NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  `revision_user` int unsigned DEFAULT NULL COMMENT 'The ID of the target entity.',
+  `revision_user` int unsigned DEFAULT NULL,
   `revision_created` int DEFAULT NULL,
   `revision_log_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
   `revision_default` tinyint DEFAULT NULL,
-  PRIMARY KEY (`revision_id`),
-  KEY `taxonomy_term__tid` (`tid`),
-  KEY `taxonomy_term_field__revision_user__target_id` (`revision_user`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The revision table for taxonomy_term entities.'
+  PRIMARY KEY (`revision_id`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_taxonomy_term_revision__field_page` to `db_test_cts`.`whitelabel_taxonomy_term_revision__field_page`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_taxonomy_term_revision__field_page`
+++ `db_test_cts`.`whitelabel_taxonomy_term_revision__field_page`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_taxonomy_term_revision__field_page` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_page_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_page_target_id` (`field_page_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for taxonomy_term field field_page.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_page_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_taxonomy_term_revision__parent` to `db_test_cts`.`whitelabel_taxonomy_term_revision__parent`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_taxonomy_term_revision__parent`
+++ `db_test_cts`.`whitelabel_taxonomy_term_revision__parent`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_taxonomy_term_revision__parent` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `parent_target_id` int unsigned NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `parent_target_id` (`parent_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision archive storage for taxonomy_term field parent.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `parent_target_id` int unsigned NOT NULL,
+  PRIMARY KEY (`entity_id`,`revision_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_user__field_domain_access` to `db_test_cts`.`whitelabel_user__field_domain_access`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_user__field_domain_access`
+++ `db_test_cts`.`whitelabel_user__field_domain_access`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_user__field_domain_access` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to, which for an unversioned entity type is the same as the entity id',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_domain_access_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_domain_access_target_id` (`field_domain_access_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for user field field_domain_access.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_domain_access_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_user__field_domain_admin` to `db_test_cts`.`whitelabel_user__field_domain_admin`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_user__field_domain_admin`
+++ `db_test_cts`.`whitelabel_user__field_domain_admin`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_user__field_domain_admin` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to, which for an unversioned entity type is the same as the entity id',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `field_domain_admin_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `field_domain_admin_target_id` (`field_domain_admin_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for user field field_domain_admin.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `field_domain_admin_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_user__field_domain_all_affiliates` to `db_test_cts`.`whitelabel_user__field_domain_all_affiliates`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_user__field_domain_all_affiliates`
+++ `db_test_cts`.`whitelabel_user__field_domain_all_affiliates`
@@ -1,12 +1,10 @@
 CREATE TABLE `whitelabel_user__field_domain_all_affiliates` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to, which for an unversioned entity type is the same as the entity id',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
   `field_domain_all_affiliates_value` tinyint NOT NULL,
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for user field field_domain_all_affiliates.'
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_user__roles` to `db_test_cts`.`whitelabel_user__roles`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_user__roles`
+++ `db_test_cts`.`whitelabel_user__roles`
@@ -1,13 +1,10 @@
 CREATE TABLE `whitelabel_user__roles` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to, which for an unversioned entity type is the same as the entity id',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `roles_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL COMMENT 'The ID of the target entity.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `roles_target_id` (`roles_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for user field roles.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `roles_target_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_user__user_picture` to `db_test_cts`.`whitelabel_user__user_picture`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_user__user_picture`
+++ `db_test_cts`.`whitelabel_user__user_picture`
@@ -1,17 +1,14 @@
 CREATE TABLE `whitelabel_user__user_picture` (
-  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
-  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
-  `entity_id` int unsigned NOT NULL COMMENT 'The entity id this data is attached to',
-  `revision_id` int unsigned NOT NULL COMMENT 'The entity revision id this data is attached to, which for an unversioned entity type is the same as the entity id',
-  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The language code for this data item.',
-  `delta` int unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
-  `user_picture_target_id` int unsigned NOT NULL COMMENT 'The ID of the file entity.',
-  `user_picture_alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Alternative image text, for the image''s ''alt'' attribute.',
-  `user_picture_title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Image title text, for the image''s ''title'' attribute.',
-  `user_picture_width` int unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
-  `user_picture_height` int unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
-  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`),
-  KEY `bundle` (`bundle`),
-  KEY `revision_id` (`revision_id`),
-  KEY `user_picture_target_id` (`user_picture_target_id`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data storage for user field user_picture.'
+  `bundle` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `deleted` tinyint NOT NULL,
+  `entity_id` int unsigned NOT NULL,
+  `revision_id` int unsigned NOT NULL,
+  `langcode` varchar(32) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `delta` int unsigned NOT NULL,
+  `user_picture_target_id` int unsigned NOT NULL,
+  `user_picture_alt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `user_picture_title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
+  `user_picture_width` int unsigned DEFAULT NULL,
+  `user_picture_height` int unsigned DEFAULT NULL,
+  PRIMARY KEY (`entity_id`,`deleted`,`delta`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_users` to `db_test_cts`.`whitelabel_users`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_users`
+++ `db_test_cts`.`whitelabel_users`
@@ -1,7 +1,6 @@
 CREATE TABLE `whitelabel_users` (
-  `uid` int unsigned NOT NULL AUTO_INCREMENT,
+  `uid` int unsigned NOT NULL,
   `uuid` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
   `langcode` varchar(12) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
-  PRIMARY KEY (`uid`),
-  UNIQUE KEY `user_field__uuid__value` (`uuid`)
-) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The base table for user entities.'
+  PRIMARY KEY (`uid`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_users_data` to `db_test_cts`.`whitelabel_users_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_users_data`
+++ `db_test_cts`.`whitelabel_users_data`
@@ -1,10 +1,8 @@
 CREATE TABLE `whitelabel_users_data` (
-  `uid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_users".uid this record affects.',
-  `module` varchar(50) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The name of the module declaring the variable.',
-  `name` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'The identifier of the data.',
-  `value` longblob COMMENT 'The value.',
-  `serialized` tinyint unsigned DEFAULT '0' COMMENT 'Whether value is serialized.',
-  PRIMARY KEY (`uid`,`module`,`name`),
-  KEY `module` (`module`),
-  KEY `name` (`name`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores module data as key/value pairs per user.'
+  `uid` int unsigned NOT NULL,
+  `module` varchar(50) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `name` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
+  `value` longblob,
+  `serialized` tinyint unsigned DEFAULT NULL,
+  PRIMARY KEY (`uid`,`module`,`name`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_users_field_data` to `db_test_cts`.`whitelabel_users_field_data`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_users_field_data`
+++ `db_test_cts`.`whitelabel_users_field_data`
@@ -14,10 +14,5 @@
   `login` int DEFAULT NULL,
   `init` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `default_langcode` tinyint NOT NULL,
-  PRIMARY KEY (`uid`,`langcode`),
-  UNIQUE KEY `user__name` (`name`,`langcode`),
-  KEY `user__id__default_langcode__langcode` (`uid`,`default_langcode`,`langcode`),
-  KEY `user_field__mail` (`mail`(191)),
-  KEY `user_field__created` (`created`),
-  KEY `user_field__access` (`access`)
-) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The data table for user entities.'
+  PRIMARY KEY (`uid`,`langcode`)
+) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
# Comparing `db`.`whitelabel_watchdog` to `db_test_cts`.`whitelabel_watchdog`   [FAIL]
# Object definitions differ. (--changes-for=server1)
#

--- `db`.`whitelabel_watchdog`
+++ `db_test_cts`.`whitelabel_watchdog`
@@ -1,17 +1,17 @@
 CREATE TABLE `whitelabel_watchdog` (
   `wid` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
-  `uid` int unsigned NOT NULL DEFAULT '0' COMMENT 'The "whitelabel_users".uid of the user who triggered the event.',
-  `type` varchar(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
-  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
+  `uid` int NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
+  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
+  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
   `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
-  `severity` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event. ranges from 0 (Emergency) to 7 (Debug)',
-  `link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Link to view the result of the event.',
-  `location` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'URL of the origin of the event.',
-  `referer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'URL of referring page.',
-  `hostname` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
+  `severity` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
+  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
+  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
+  `referer` text COMMENT 'URL of referring page.',
+  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
   `timestamp` int NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
   PRIMARY KEY (`wid`),
   KEY `type` (`type`),
   KEY `uid` (`uid`),
   KEY `severity` (`severity`)
-) ENGINE=InnoDB AUTO_INCREMENT=471321 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table that contains logs of all system events.'
+) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb3 COMMENT='Table that contains logs of all system events.'
Compare failed. One or more differences found.
