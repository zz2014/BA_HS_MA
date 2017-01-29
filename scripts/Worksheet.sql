
UPDATE aggregatedresults
   SET dbaverage=1157.7204040978941377 WHERE testround = 1;

SELECT 
       averagert,
       trueparallel,
       maxrt,
       totalrequests,
       loadgeneratorinstances,
       appinstances,
       testround
  FROM aggregatedresults ORDER BY testround desc;

DELETE FROM loadtestresult;
DELETE FROM aggregatedresults;

INSERT INTO aggregatedresults (totalrequests,
                               averagert,
                               maxrt,
                               trueparallel,
                               testround,
                               loadgeneratorinstances,
                               appinstances,
                               loadgeneratorparallel,
                               apptype)
   SELECT total,
          average,
          max,
          trueparallel,
          testround,
          instancenumber,
          appinstances,
          parallelrequests,
          apptype
     FROM (  SELECT count (lo.parallelrequests) AS total,
                    avg (lo.responsetime) AS average,
                    max (lo.responsetime) AS max,
                    (  (count (lo.parallelrequests) / 60)
                     / (1000 / avg (lo.responsetime)))
                       AS trueparallel,
                    lo.testround,
                    lo.instancenumber,
                    lo.appinstances,
                    parallelrequests,
                    lo.apptype
               FROM loadtestresult AS lo
               where lo.error=false
           GROUP BY lo.appinstances,
                    lo.parallelrequests,
                    lo.testround,
                    lo.apptype,
                    lo.instancenumber) AS gr
    WHERE NOT EXISTS
             (SELECT *
                FROM aggregatedresults
               WHERE     aggregatedresults.apptype = gr.apptype
                     AND aggregatedresults.testround = gr.testround);


SELECT count (parallelrequests) AS total,
         avg (responsetime) AS average,
         max (responsetime) AS max,
         instancenumber,
         parallelrequests,
         testround,
         apptype,
         appinstances
    FROM loadtestresult
    where error=false
GROUP BY appinstances,
         parallelrequests,
         testround,
         apptype,
         instancenumber
ORDER BY apptype, testround;

SELECT   count(*)
    FROM loadtestresult
where responsetime>=1000 and testround=3;



select correlation_id, responsetime 
from loadtestresult 
where testround=23 
order by responsetime DESC limit 50;

select responsetime from loadtestresult 
where correlation_id='f3338226-3072-4c21-baa5-c74d9c004438';

DELETE FROM aggregatedresults
      WHERE testround > 1;

DELETE FROM loadtestresult;


CREATE TABLE aggregatedResults
(
   cpu                      NUMERIC,
   memory                   NUMERIC,
   trueparallel             NUMERIC,
   averageRT                NUMERIC,
   maxRT                    NUMERIC,
   testround                INT,
   totalrequests            INT,
   loadgeneratorinstances   INT,
   appinstances             INT,
   loadgeneratorparallel    INT,
   dbaverage                NUMERIC,
   apptype                  VARCHAR (20),
   PRIMARY KEY
      (testround,
       apptype,
       appinstances,
       loadgeneratorinstances,
       loadgeneratorparallel)
);
