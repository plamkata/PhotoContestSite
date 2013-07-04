CREATE DATABASE IF NOT EXISTS picture_contests_site CHARACTER SET 'utf8';


CREATE TABLE IF NOT EXISTS user (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    loginame VARCHAR(50) NOT NULL UNIQUE KEY, 
	password VARCHAR(50) NOT NULL, 
	email VARCHAR(100) NOT NULL UNIQUE KEY, 
	is_admin BOOL NOT NULL DEFAULT 0, 
	register_date TIMESTAMP NOT NULL, 
	first_name VARCHAR(100), 
	last_name VARCHAR(100), 
	person_activity VARCHAR(100),  
	spam BOOL NOT NULL DEFAULT 1
) TYPE = innodb;


CREATE TABLE IF NOT EXISTS contest (  
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    title VARCHAR(200) NOT NULL UNIQUE KEY, 
    description VARCHAR(1024), 
    start_date TIMESTAMP(8), 
    end_date TIMESTAMP(8), 
    is_visible BOOL DEFAULT 1, 
    max_user_pictures TINYINT, 
    max_user_votes TINYINT
) TYPE = innodb;


CREATE TABLE IF NOT EXISTS picture (  
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT NOT NULL, 
	contest_id INT,  
    name VARCHAR(200) NOT NULL UNIQUE KEY, 
    format VARCHAR(5) NOT NULL, 
    comment VARCHAR(512)
) TYPE = innodb;

ALTER TABLE picture 
ADD FOREIGN KEY picture_user(user_id) REFERENCES user(id) ON DELETE CASCADE ON UPDATE NO ACTION; 

ALTER TABLE picture 
ADD FOREIGN KEY picture_contest(contest_id) REFERENCES contest(id) ON DELETE CASCADE ON UPDATE NO ACTION;


CREATE TABLE IF NOT EXISTS user_rating (  
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT NOT NULL, 
	picture_id INT NOT NULL,  
    rating TINYINT
) TYPE = innodb;      

ALTER TABLE user_rating 
ADD FOREIGN KEY user_rating_user(user_id) REFERENCES user(id) ON DELETE CASCADE ON UPDATE NO ACTION; 

ALTER TABLE user_rating 
ADD FOREIGN KEY user_rating_picture(picture_id) REFERENCES picture(id) ON DELETE CASCADE ON UPDATE NO ACTION;

