USE c_cs108_jevans2;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS photos;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS questions;
DROP TABLE If EXISTS answers;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS friends;
DROP TABLE IF EXISTS challenges;
DROP TABLE IF EXISTS messages;

CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT,
    username CHAR(64),
    salt CHAR(32),
    digest CHAR(64),
    photo_id INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);

CREATE TABLE photos (
	photo_id INT NOT NULL AUTO_INCREMENT,
	ftype CHAR(3),
	height INT,
	width INT,
	data MEDIUMBLOB NOT NULL,
	PRIMARY KEY (photo_id)
);

CREATE TABLE quizzes (
	quiz_id INT NOT NULL AUTO_INCREMENT,
	user_id INT,
	name VARCHAR(150),
	description TEXT,
	single_page BOOLEAN, 
	random_questions BOOLEAN,
	immediate_correct BOOLEAN,
	practice_mode BOOLEAN,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (quiz_id)
);

CREATE TABLE questions (
	question_id INT NOT NULL AUTO_INCREMENT,
	quiz_id INT,
	answer_id INT,
	photo_id INT,
	question_type BLOB,
	question TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (question_id)
);

CREATE TABLE tags (
	tag_id INT NOT NULL AUTO_INCREMENT,
	quiz_id INT,
	tag TEXT,
	PRIMARY KEY (tag_id)
);

CREATE TABLE answers (
	answer_id INT NOT NULL AUTO_INCREMENT,
	answer TEXT,
	PRIMARY KEY (answer_id)
);

CREATE TABLE messages (
	sender CHAR(64),
	receiver CHAR(64),
	message TEXT
);

CREATE TABLE friends (
	friend_id INT NOT NULL AUTO_INCREMENT,
	sender INT,
	receiver INT,
	status INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (friend_id)
);

CREATE TABLE scores (
	score_id INT NOT NULL AUTO_INCREMENT,
	quiz_id INT, 
	user_id INT,
	score INT, 
	start_time TIMESTAMP DEFAULT 0,
	finish_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (score_id)
);

CREATE TABLE challenges (
	challenge_id INT NOT NULL AUTO_INCREMENT,
	sender_user_id INT,
	receiver_user_id INT,
	link VARCHAR(100),
	PRIMARY KEY (challenge_id)
);