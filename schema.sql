DROP DATABASE insta_clone;
CREATE DATABASE insta_clone;
USE insta_clone;

CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
	);

-- INSERT INTO users (username) VALUES
-- ('BlueTheCat'),
-- ('CharlieBrown'),
-- ('ColtSteele'),
-- ('ureladen');

CREATE TABLE photos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW()
);

-- INSERT INTO photos(image_url,user_id) VALUES
-- ('/asdfaskl',1),
-- ('/asdfas5641kl',2),
-- ('/asdfas5641kl',2);

CREATE TABLE comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id)
);

CREATE TABLE likes(	
    photo_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY(user_id,photo_id)
);

-- INSERT INTO likes(user_id,photo_id) VALUES
-- (4,1),
-- (2,1),
-- (3,2),
-- (4,3);
-- Won't work because of Primary Key constraints
-- INSERT INTO likes(user_id,photo_id) VALUES(4,3);

CREATE TABLE follows (
	follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id,followee_id)
);

CREATE TABLE tags(
	id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
	photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id,tag_id)
);
-- 

