USE c_cs108_cheeawai1;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS photos;
DROP TABLE IF EXISTS quizzes;

CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT,
    username CHAR(64),
    salt CHAR(32),
    digest CHAR(64),
    photo_id INT,
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
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (quiz_id)
);

CREATE TABLE friends (
	friend_id INT NOT NULL AUTO_INCREMENT,
	sender INT,
	reciever INT,
	status INT,
	PRIMARY KEY (friend_id)
);

CREATE TABLE scores (
	score_id INT NOT NULL AUTO_INCREMENT,
	quiz_id INT, 
	score INT, 
	utime TIME,
	taken_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (pid)
);

CREATE TABLE challenges (
	challenge_id INT NOT NULL AUTO_INCREMENT,
	sender INT,
	receiver INT,
	link STRING,
	best_score INT,
	PRIMARY KEY (challenge_id)
);