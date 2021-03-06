/*specify persistent DB file*/
-- sqlite3 mydatabase.db

-- PRAGMA foreign_keys = ON
-- .mode COLUMNS
-- .header ON

/*CREATE TABLEs*/
CREATE TABLE album (id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(128) NOT NULL, release_year INTEGER);
CREATE TABLE artist (id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(128) NOT NULL);
CREATE TABLE track(id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(128) NOT NULL, album_id INT REFERENCES album(id));
CREATE TABLE artist_album(artist_id INT REFERENCES artist(id), album_id INT REFERENCES album(id));

/*Populate tables*/
.read setup.sql

/* Show all albums */
SELECT * from album;
-- id          title                release_year
-- ----------  -------------------  ------------
-- 1           Super Awesome Album  1990
-- 2           Super Funky Album
-- 3           Super Disco Album    1978
-- 4           Super Hairband Albu  1984
-- 5           Super Dubstep Album

/* Showing all albums made between 1975 and 1990 */
SELECT * from album WHERE release_year < 1990 AND release_year > 1975;
-- id          title              release_year
-- ----------  -----------------  ------------
-- 3           Super Disco Album  1978
-- 4           Super Hairband Al  1984
-- 8           Super Disco Album  1978
-- 9           Super Hairband Al  1984

/* Show all albums whose names start with Super D. */
SELECT * from album WHERE title LIKE 'Super D%';
-- id          title              release_year
-- ----------  -----------------  ------------
-- 3           Super Disco Album  1978
-- 5           Super Dubstep Alb
-- 8           Super Disco Album  1978

/* Show all albums that have no release year */
SELECT * from album WHERE release_year IS NULL;
-- id          title              release_year
-- ----------  -----------------  ------------
-- 2           Super Funky Album
-- 5           Super Dubstep Alb
-- 7           Super Funky Album

/* Show all track titles from Super Funky Album */
SELECT track.title FROM track, album WHERE track.album_id = album.id AND album.title = 'Super Funky Album';
            -- title
            -- -------------------
            -- Super Funky Track 1
            -- Super Funky Track 2
            -- Super Funky Track 3
            
/* Show all track titles from Super Funky Album and change title to Track_Title in output */
SELECT track.title AS Track_Title FROM track, album WHERE track.album_id = album.id AND album.title = 'Super Funky Album';
/*  output:
            Track_Title
            -------------------
            Super Funky Track 1
            Super Funky Track 2
            Super Funky Track 3

/* Select all album titles by Han Solo */
SELECT album.title FROM album, artist, artist_album WHERE artist.id = artist_album.artist_id AND album.id = artist_album.album_id AND artist.name = 'Han Solo';
/*  output:
            title
            -----------------
            Super Disco Album
            Super Hairband Al       */

/* Select the average year all albums were released */
SELECT AVG(release_year) from album;
/*  output:
        avg(release_year)
        -----------------
        1984.0              */

/* Select average year all albums by Leia and the Ewoks were released */
SELECT AVG(release_year) FROM album, artist, artist_album WHERE artist.id = artist_album.artist_id AND album.id = artist_album.album_id AND artist.name = 'Leia and the Ewoks';
/*  output:
        AVG(release_year)
        -----------------
        1990.0              */

/* Select the number of artists */
SELECT COUNT(id) FROM artist;
/*  output:
        count(id)
        ----------
        3                   */

/* Select the number of tracks on Super Dubstep Album */
SELECT COUNT(track.id) FROM track, album WHERE album.id = track.album_id and album.title = 'Super Dubstep Album';
/*  output:
        COUNT(track.id)
        ---------------
        5               */