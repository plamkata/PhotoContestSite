/*!40014
  set
    @prev_unique_checks = @@unique_checks,
    @prev_foreign_key_checks = @@foreign_key_checks,
    unique_checks = 0,
    foreign_key_checks = 0
*/;
/*!40101
  set
    @prev_character_set_client = @@character_set_client,
    @prev_character_set_connection = @@character_set_connection,
    @prev_character_set_results = @@character_set_results,
    @prev_sql_mode = @@sql_mode,
    character_set_client = utf8,
    character_set_connection = utf8,
    character_set_results = utf8,
    sql_mode = 'no_auto_value_on_zero'
*/;
/*!40111
  set
    @prev_sql_notes = @@sql_notes,
    sql_notes = 0
*/;
drop table if exists `contest`;

CREATE TABLE `contest` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(200) NOT NULL,
  `description` varchar(1024) default NULL,
  `start_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `is_visible` tinyint(1) default '1',
  `max_user_pictures` tinyint(4) default NULL,
  `max_user_votes` tinyint(4) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists `picture`;

CREATE TABLE `picture` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `contest_id` int(11) default NULL,
  `name` varchar(200) NOT NULL,
  `comment` varchar(512) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `picture_user` (`user_id`),
  KEY `picture_contest` (`contest_id`),
  CONSTRAINT `picture_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `picture_ibfk_2` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL auto_increment,
  `loginame` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `is_admin` tinyint(1) NOT NULL default '0',
  `register_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `first_name` varchar(100) default NULL,
  `last_name` varchar(100) default NULL,
  `person_activitiy` varchar(100) default NULL,
  `spam` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `loginame` (`loginame`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists `user_rating`;

CREATE TABLE `user_rating` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `picture_id` int(11) NOT NULL,
  `rating` tinyint(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `user_rating_user` (`user_id`),
  KEY `user_rating_picture` (`picture_id`),
  CONSTRAINT `user_rating_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `user_rating_ibfk_2` FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40014
  set
    unique_checks = @prev_unique_checks,
    foreign_key_checks = @prev_foreign_key_checks
*/;
/*!40101
  set
    character_set_client = @prev_character_set_client,
    character_set_connection = @prev_character_set_connection,
    character_set_results = @prev_character_set_results,
    sql_mode = @prev_sql_mode
*/;
/*!40111
  set
    sql_notes = @prev_sql_notes
*/;
