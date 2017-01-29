SELECT state, query, client_addr FROM 
pg_stat_activity;

select count(*) from pg_stat_activity;
SELECT count(*)FROM pg_stat_activity where query = 'SELECT * FROM advertisement';

select * from resultsfromapp where correlationid='dcaccb7b-0597-452d-8cab-62a24815a552';
select * from resultsfromapp order by responsetime DESC limit 10;