CREATE TABLE IF NOT EXISTS genere (
	id             SERIAL          PRIMARY KEY,
	genere_music   VARCHAR(150)    UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS executor (
	id             SERIAL          PRIMARY KEY,
	name           VARCHAR(150)    UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS album (
	id 				SERIAL 			PRIMARY KEY,
	name 			VARCHAR(200) 	NOT NULL,
	release_year 	INTEGER 		NOT NULL 
									CHECK(release_year BETWEEN 1500 AND 2100)
);


CREATE TABLE IF NOT EXISTS executor_album (
	id 				INTEGER 		PRIMARY KEY,
	executor_id 	INTEGER 		NOT NULL REFERENCES executor(id),
	album_id 		INTEGER 		NOT NULL REFERENCES album(id)
);


CREATE TABLE IF NOT EXISTS executor_genere (
	id 				INTEGER 		PRIMARY KEY,
	genere_id 		INTEGER 		NOT NULL REFERENCES genere(id),
	executor_id 	INTEGER 		NOT NULL REFERENCES executor(id)
);


CREATE TABLE IF NOT EXISTS track (
	id 				SERIAL 			PRIMARY KEY,
	song_title 		VARCHAR(150)	NOT NULL,
	album_id 		INTEGER 		NOT NULL REFERENCES album(id),
	duration 		INTEGER			NOT NULL
									CHECK(duration BETWEEN 15 AND 3600)
);

	
CREATE TABLE IF NOT EXISTS collection (
	id 				SERIAL 			PRIMARY KEY ,
	name 			VARCHAR(150) 	NOT NULL,
	release_year 	INTEGER 		NOT NULL
									CHECK(release_year BETWEEN 1500 AND 2100)
);


CREATE TABLE IF NOT EXISTS track_collection (
	id 				INTEGER 		PRIMARY KEY,
	track_id 		INTEGER 		NOT NULL REFERENCES track(id),
	collection_id 	INTEGER 		NOT NULL REFERENCES collection(id)
);

drop table genere
drop table executor_genere