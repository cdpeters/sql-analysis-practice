-- instagram database clone schema --------------------------
DROP DATABASE IF EXISTS instagram_clone;
CREATE DATABASE instagram_clone;
USE instagram_clone; 

-- users ----------------------------------------------------
CREATE TABLE users (
    PRIMARY KEY (id),
    id         INT          AUTO_INCREMENT,
    username   VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP    DEFAULT NOW()
);

-- photos ---------------------------------------------------
CREATE TABLE photos (
    PRIMARY KEY (id),
    id         INT          AUTO_INCREMENT,
    image_url  VARCHAR(255) NOT NULL,
    user_id    INT          NOT NULL,
               FOREIGN KEY (user_id) REFERENCES users(id),
    created_at TIMESTAMP    DEFAULT NOW()
);

-- comments -------------------------------------------------
CREATE TABLE comments (
    PRIMARY KEY (id),
    id           INT          AUTO_INCREMENT,
    comment_text VARCHAR(255) NOT NULL,
    photo_id     INT          NOT NULL,
                 FOREIGN KEY (photo_id) REFERENCES photos(id),
    user_id      INT          NOT NULL,
                 FOREIGN KEY (user_id) REFERENCES users(id),
    created_at   TIMESTAMP    DEFAULT NOW()
);

-- likes ----------------------------------------------------
CREATE TABLE likes (
    PRIMARY KEY (user_id, photo_id),
    user_id    INT       NOT NULL,
               FOREIGN KEY (user_id) REFERENCES users(id),
    photo_id   INT       NOT NULL,
               FOREIGN KEY (photo_id) REFERENCES photos(id),
    created_at TIMESTAMP DEFAULT NOW()
);

-- followers -------------------------------------------------
CREATE TABLE followers (
    PRIMARY KEY (follower_id, followee_id),
    follower_id INT      NOT NULL,
                FOREIGN KEY (follower_id) REFERENCES users(id),
    followee_id INT      NOT NULL,
                FOREIGN KEY (followee_id) REFERENCES users(id),
                CONSTRAINT prevent_self_follow CHECK (follower_id <> followee_id),
    created_at TIMESTAMP DEFAULT NOW()
);

-- tags ------------------------------------------------------
CREATE TABLE tags (
    PRIMARY KEY (id),
    id         INT          AUTO_INCREMENT,
    tag_name   VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP    DEFAULT NOW()
);

CREATE TABLE photo_tags (
    PRIMARY KEY (photo_id, tag_id),
    photo_id INT       NOT NULL,
               FOREIGN KEY (photo_id) REFERENCES photos(id),
    tag_id   INT       NOT NULL,
               FOREIGN KEY (tag_id) REFERENCES tags(id)
);

SHOW TABLES;
