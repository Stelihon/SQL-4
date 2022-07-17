-- количество исполнителей в каждом жанре
SELECT 		g.genere_music 			AS 	"Direction", 
			COUNT(e.name) 			AS 	"Quantity"
FROM 		executor 				AS 	e
INNER JOIN 	executor_genere 		AS 	eg
ON 			e.id = eg.executor_id 
INNER JOIN 	genere 					AS 	g
ON 			eg.genere_id = g.id 
GROUP BY 	g.genere_music
ORDER BY 	COUNT(e.name) 			DESC; 

-- количество треков, вошедших в альбомы 2019-2020 годов
SELECT 		COUNT(t.song_title) 	AS 	"Quantity traks"
FROM 		track 					AS 	t
INNER JOIN 	album 					AS 	a 
ON 			t.album_id = a.id 
WHERE 		a.release_year 			BETWEEN 2019 AND 2020;

-- средняя продолжительность треков по каждому альбому
SELECT 		a.name 										AS 	"Album", 
			ROUND(AVG(t.duration)::NUMERIC,0) 			AS "Song duration in seconds" 
FROM 		track 										AS 	t
INNER JOIN 	album 										AS 	a 
ON 			t.album_id = a.id 
GROUP BY 	a.name;

-- все исполнители, которые не выпустят альбомы в 2020 году
SELECT 	name	 										AS "Executor"
FROM 	executor
WHERE 	name NOT IN (SELECT		e.name 
					FROM 		executor 				AS 	e
					INNER JOIN 	executor_album 			AS 	ea 
					ON 			e.id = ea.executor_id 
					INNER JOIN 	album 					AS 	a 
					ON 			a.id = ea.album_id 
					WHERE a.release_year = 2020
					GROUP BY e.name);

-- названия сборников, в которых встречаются отдельные исполнительные (Rammstein);
SELECT 		c.name 						AS 	"Collection with Rammstein"
FROM 		collection 					AS 	c 
INNER JOIN 	track_collection 			AS 	tc 
ON 			c.id = tc.collection_id 
INNER JOIN 	track 						AS 	t 
ON 			t.id = tc.track_id 
INNER JOIN 	album 						AS 	a 
ON 			a.id = t.album_id 
INNER JOIN 	executor_album 				AS 	ea 
ON 			a.id = ea.album_id 
INNER JOIN 	executor 					AS 	e 
ON 			e.id = ea.executor_id 
WHERE 		e.name = 'Rammstein'
GROUP BY 	c.name;

-- названия альбомов, в которых присутствуют исполнители более 1 жанра;
SELECT 		DISTINCT a.name 		AS 	"Album"
FROM 		album 					AS 	a
INNER JOIN 	executor_album 			AS 	ea 
ON 			a.id = ea.album_id 
INNER JOIN 	executor 				AS 	e 
ON 			e.id = ea.executor_id
INNER JOIN 	executor_genere 		AS 	eg 
ON 			eg.executor_id = e.id 
INNER JOIN 	genere 					AS 	g 
ON 			g.id = eg.genere_id 
GROUP BY 	a.name, 
			e.name
HAVING 		COUNT(DISTINCT g.genere_music) > 1;

-- наименование треков, которые не входят в сборники
SELECT 		t.song_title 				AS 	"Song title"
FROM 		track 						AS 	t
LEFT JOIN 	track_collection 			AS ct
ON 			t.id = ct.track_id 
WHERE 		ct.track_id 				IS NULL; 

-- исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
SELECT 		e.name 					AS 	"Executor"
FROM 		executor 				AS 	e 
INNER JOIN 	executor_album 			AS 	ea 
ON 			e.id = ea.executor_id 
INNER JOIN 	album 					AS 	a 
ON 			a.id = ea.album_id 
INNER JOIN 	track 					AS 	t
ON 			t.album_id = a.id 
WHERE 		t.duration = (SELECT MIN(duration) FROM track);

-- название альбомов, содержащих наименьшее количество треков.

SELECT 		a.name 				AS 	"Album"
FROM 		album 				AS 	a 
INNER JOIN 	track 				AS 	t
ON 			a.id = t.album_id 
GROUP BY 	a.name 
having  COUNT(t.song_title) = (SELECT MIN(quantity) FROM (SELECT COUNT(t.song_title) AS quantity
																						FROM album   	  AS a
																						INNER JOIN track  AS t 
																						ON    a.id = t.album_id 
																						GROUP BY a.name)
																					 AS foo)	



													