-- 293. Users Schema --------------------------------------
CREATE DATABASE instagram;
USE instagram;

CREATE TABLE users (
    PRIMARY KEY (id),
    id         INT          AUTO_INCREMENT,
    username   VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP    DEFAULT NOW()
);

DESC users;


-- 295. Photos Schema --------------------------------------
CREATE TABLE photos (
    PRIMARY KEY (id),
    id         INT          AUTO_INCREMENT,
    image_url  VARCHAR(255) NOT NULL,
    user_id    INT          NOT NULL,
               FOREIGN KEY (user_id) REFERENCES users(id),
    created_at TIMESTAMP    DEFAULT NOW()
);

DESC photos;


-- 297. Comments Schema --------------------------------------
CREATE TABLE comments (
    PRIMARY KEY (id),
    id           INT          AUTO_INCREMENT,
    comment_text VARCHAR(255) NOT NULL,
    user_id      INT          NOT NULL,
                 FOREIGN KEY (user_id) REFERENCES users(id),
    photo_id     INT          NOT NULL,
                 FOREIGN KEY (photo_id) REFERENCES photos(id),
    created_at   TIMESTAMP    DEFAULT NOW()
);

DESC comments;


-- 299. Likes Schema --------------------------------------
CREATE TABLE likes (
    PRIMARY KEY (user_id, photo_id),
    user_id    INT       NOT NULL,
               FOREIGN KEY (user_id) REFERENCES users(id),
    photo_id   INT       NOT NULL,
               FOREIGN KEY (photo_id) REFERENCES photos(id),
    created_at TIMESTAMP DEFAULT NOW()
);

DESC likes;


-- 301. Followers Schema --------------------------------------
CREATE TABLE followers (
    PRIMARY KEY (follower_id, followee_id),
    follower_id INT      NOT NULL,
                FOREIGN KEY (follower_id) REFERENCES users(id),
    followee_id INT      NOT NULL,
                FOREIGN KEY (followee_id) REFERENCES users(id),
                CONSTRAINT same_user CHECK (follower_id <> followee_id),
    created_at TIMESTAMP DEFAULT NOW()
);

DESC followers;


-- 305. Implementing Hashtags Table --------------------------------------
CREATE TABLE tags (
    PRIMARY KEY (id),
    id         INT          AUTO_INCREMENT,
    tag_name   VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP    DEFAULT NOW()
);

CREATE TABLE photo_tags (
    PRIMARY KEY (tag_id, photo_id),
    tag_id   INT       NOT NULL,
               FOREIGN KEY (tag_id) REFERENCES tags(id),
    photo_id INT       NOT NULL,
               FOREIGN KEY (photo_id) REFERENCES photos(id)
);

SHOW TABLES;
