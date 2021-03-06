# Project Journal

### 15.11.2016
**Define**: a very light-weight Java version of bulletinboard ads application
- Plain http handler: `jetty`
- Plain DB connection: `JDBC`

**Done:**
- [x] JDBC connection to PostgreSQL
- [x] `AdvertisementResource`: getAll, getOne
- [x] `AdvertisementRepository`: selectAll, selectOne
- [x] `AdvertisementHandler`: getAll

### 16.11.2016
**TODO:**
- [x] Use Java 8 
- [x] `AdvertisementRepository` 
  - add insertOne + create table if not exist
  - delete all/ drop table
- [x] add logic inside app: init database
- [x] Test with setup/teardown
- [x] Use env variable to access DB
- [x] try to push to CF
 
**DONE:**
- Use Java 8 
  - use try-with-resources
- `AdvertisementRepository` 
  - add insertOne + create table if not exist
  - delete all/ drop table
- `InitDBHandler`
  - add new handler
  - use many contexts
- use query parameter in handlers
- add logic inside app: init database
  - DB inited with a size
- Test with setup/teardown
  - only setup
- Use env variable to access DB
  - **TODO** try to push to CF

### 17.11.2016
**Plan**
- [x] Use env variable to access DB
- [x] try to push to CF

**Done**
- improve exception handling
  - throw exceptions in low level [READ](https://community.oracle.com/docs/DOC-983219)
- use Datasource pool DB connection
- push to CF
  - create executable jar with maven assembly plugin
    - works locally
    - can't push to CF, strange error by javax directory
    - exclude javax dependency, error went away but javax is needed in jetty

### 18.11.2016
**Plan**
- [x] Push to CF
- [x] Start performance testing

**Done**
- Push to CF
  - lower version of assembly plugin produces no corrupt file
  - use port number from environment variable
- Start testing 
  - create JMeter test plan 

### 22.11.2016
Review: 
- JMeter relies to much on the settings and configuration from host machine. When it hits the celine, it is might well be the JMeter can not generate so much load at all. Therefore, we should use a load generator which can also scale. 
- The raw data should be handled. Although tools provide convenience to generate charts and visualize trends, it is quite rigid. Maybe excel can be used to connect to DB and handle data. 
- CPU and memory consumption is hard to measure as for Java, the JProfiler or JMX should first be used to optimize the hardware configuration.

**TODO**
- [x] Simulate load with enduser simulator as application pushed in CF.
  - use getAll: DB will be kept small as the DB efficiency is not to be discussed in the research.
  - calculate response time inside the application
- [x] Get the logs from router in ELK
  - filter: space id, org id, raw app name, time period
  - contact Kibana colleagues for information
- [ ] Optimize application configuration with JProfiler
- [ ] Log cpu and memory
  - maybe with the ruby script?
  
**Done**
- Simulate load with enduser simulator as application pushed in CF.
  - Simulator is written to generate load with given parallel request number and load generate period
  - Response time is written in DB.

### 24.11.2016
Review:
- PG connection with Postgres has problem handling multiple connections: should use pool.
- PostgreSQL plan has limitation in CF: maximum 100 connections.
  - Error occurred: too many clients
  - this means when generate load, the parallel access to DB should be considered.
- DB in CF cannot be accessed directly.

**TODO**
- [x] use pool in load generator
- [x] save response time not after every request
- [x] use chisel to access DB in cf

**Done**
- use pool in load generator
  - create table if not exists
  - insert into
- save response time not after every request
  - save the response time in an array and insert the data at the end of the application

### 25.11.2016
Review: 
- improve the load generator with parameter to save the round of test.
- the start command for the application in cloud foundry can only be defined in manifest or by pushing. 
- logstash response time seems extemely fast.

**TODO**
- [x] observe the ELK results
- [ ] try to use docker(alpine) and curl to generate load
- [ ] still have to find out how to record memory-cpu

**DONE**
- write a script to push load generator with parameters
- write logs in application and compare the response time with ELK.
  - the result is the same. The round trip from load balancer is very short
  - curiously there are two logs: meaning two load balancers/ routers
- connected to chisel
  - easy access with toad extension
  - [ ] **TODO: ** connect to DB from excel 

### 29.11.2016
**TODO**
- [x] observe the ELK results

**DONE**
- Application queries logstash from ELK

**BUT**
- Logs are not complete investigate into the reasons
- [x] load generator sends a fixed number of requests

### 30.11.2016
**TODO**
- [x] ELK loses logs or what?

**DONE**
- ELK doesn't save all the logs. Jens has inquired the logstash colleagues. It turns out there are different quotas for logs: per second and per day. In oder to get all the logs, we might need to use dev landscape. But first we have to be sure, what kind of quota is enough in our cases. 
- [ ] **TODO** find out the limit of java application. 

### 1.12.2016
Meeting with elastic search colleague:
- dev landschaft can be provided for one week with unlimited logs
- Go router in CF has performance issues
- logging library helps to record response time, etc.
- or log with Json string to collect start and end time
- Canary landschaft has bigger DB plans
- Dev landschaft has no DB, but is a diego
- scale the router? 
  - [x] log timestamp in load generator
  - [x] log timestamp and response time in java application
  - [ ] compare and decide where does the bottle neck come from: DB or network

### 2.12.2016
 - [x] log timestamp and response time in java application
 - [ ] compare and decide where does the bottleneck come from: DB or network
   - logs from Kibana is incomplete. Can not ensure what is exactly the bottleneck. Therefore the only safe way to store the information is to save them in a DB. 
   - [ ] **TODO** instead of logging, save the response time in DB 
   - [ ] **TODO** pass correlation id to application from load generator
   
### 6.12.2016
To rule out whether DB is the bottleneck:
- [x] scale the application, to see the requests can also scale
  - the average requests can be handled stayed about 22,000 per minute. So the application should not be the bottleneck
- [x] try to use a bigger db in canary landschaft, to see if more requests can be handled
  - paid service is not allowed 
- [x] instead of logging, save the response time in DB 
- [x] pass correlation id to application from load generator
- [x] pushed an application with no connection or usage of DB
  -  the total requests handled and response time has no visible change
  -  the bottleneck should be the router in cloud foundry
- [x] two identical applications are pushed with different DB service but the same route
  - no visible change in performance
- [x] used canary landschaft to host applications
  - no visible change in performance
- [x] contacted cloud foundry colleague to confirm the limitation of router

Consider next steps if the router is the bottleneck:
- use another cloud foundry instance: anynines, AWS
- use monsoon

### 7.12.2016
- [x]email CF performance team 
- [x]implement node.js IO application

### 8.12.2016
- [x]implement node.js IO application
- [x] deploy node to cloud
- [x] test node application
  - results are similar as java
- ? why are all the requests around 20,000 per minute
  - try sending request locally 100 and 200 parallel in 1 minute, there is no visible difference
  - is there something wrong with load generation?
- ? How does node.js handle parallisation
  - there is only one thread
  - the total parallel running promise might be limited
- [x]create load generator in Java with multithreading 
  - has similar results like node load generator
  
###09.12 
- [x] start local testing without docker container
  - performance and test results are influenced by whether a parallel tast , like browsing is carried out in the computer
  - log will drag performance down. In cloud foundry may be different
  - [ ] google how to measure CPU and Memory with time axel
  - the test results seem unrealistic 
  - scaling in monsoon will not be easy, do not consider it at moment
  - set monsoon in the samce source location to reduce network latency
- [x] logging responsetime inside application 
- [ ] try exel graph

Result: 
- DB is fast enough: 0.5 millisecond
- Load generator lose last several logs due to unfinished promise

### 13.12.2016
- [x] establish monsoon instance with docker container
  - [x] JAVA APP
  - [x] Node APP
  - [x] Load generator
- [x] prepare meeting with Tim 

### 14.12.2016
Meeting with Tim:
- HA proxy limits the connection to 100 req/sec
- useful links https://github.infra.hana.ondemand.com/cloudfoundry/cf-docs/wiki/Operations
- useful tools: locust,hay go end user simulator, zipkin trace application
- [ ] investigate node.js pg insert error
- [ ] investigate java insert error
- [ ] document meeting with kim 

### 15&16.12.2016
- [x] work around the limitation of HA-Proxy
	- with keep agent alive
- [x] fix the node.js pg insert error
	- with `pg-promise` db interface

### 20.12.2016
- [ ] scalibility test
  - java scaling is not linear, why?
  - [x]node application has `too many clients` error and has 1/3 requests comparing to java
    - solved with use of `pg-promise`
  - [x] check out why node application produces error when scaled
    - with use of `pg-promise` the failure is gone and scale 80% linear
- suggestions from Thomas:
  - [x] instead of throw error, log the failed request and save them in DB
  - [ ] send a set number of requests every certain time period, so to reproduce the load test. https://www.youtube.com/watch?v=lJ8ydIuPFeU
  - [ ] have a look at the implementation example of `Framework Benchmark`. https://github.com/TechEmpower/FrameworkBenchmarks/tree/master/frameworks/JavaScript/nodejs
    - they used mongo db and sequelize (a node orm), shall try them
  - [ ] if the connection total to DB is limited, then is there a library which can make a request and send it til a connection is free? 
- suggestions from Jens 
  - [ ] find out why is node slow, with logs, with profiler
  - [x] give node application the same size of memory
    - doesn't change much, but node needs fewer memory, if 3 instances of small node matches one instance of big java, does it count as same efficient? 
  - [x] use another DB driver
    - tried `pg-promise` still bad performance.
  - [ ] use another DB, e.g. Hana or use Diego/Docker
    - will try to use mongodb or sequelize
  - [ ] find out, whether the java and node application running on the same node in CF or if one can control it. 
    - meet with Tim tomorrow?
  - [ ] test locally 
  
  ### 21.12.2016
- if 3 instances of small node matches one instance of big java, does it count as same efficient? 
  - not exactly. Memory is not that expensive. In cloud, the CPU is more expensive than memory. Measuring the CPU consumption and know how much CPU Java and node needs respectively is important. Have a look at the pricing of cloud. Calculate how much does it cost when the requests increment. It might also be an argument. 
- Meeting with Tim
  - when cf is under load, metric information is flushing into Riemann. Riemann will write it into the influxDB. The writing is slow. When Riemann has to handle the flushing in data at the same time, it is under great stress. Metrics input will be stopped, which produces difficulty for the operating team in CF SAP. So, I should stop testing in CF Canary. It is said I will be given a dev landschaft. 
  - Understanding the containerisation of Cloud foundry and how the CPU performance is calculated. To test the exact performance and have a clean environment is almost impossible. https://docs.cloudfoundry.org/concepts/architecture/warden.html#cpu
  - CF Canary has 100 Diego(Garden), 50 DEA(Warden).
  - Garden=go Warden. 
- [ ] find why node is slower. 
  - [x] used sequelizer: there is even too many clients error, reason is: if set max as 50, then every instance tries to open 50 connections. Then it exceeds the 100 limit of postgres. Therefore, looks further into java application. It seems it uses one connection per instance, the limit is never exceeded. And the query stays fast. use(select * from pg_stat_activity;) to query the active connections 
   
### 28.12.2016
- find a way to define pool size in node
  - postgres DB has a limitation of 100 connections. There are other connections like from chisel and from browser, then the poolsize should be under 95. That is only one instance. If one starts scaling, then the connection wouldn't be enough. 
  - however, it seems with 10*8 parallel requests, 20 instances and 80 instances doesn't have much difference. 
- is it possible that java application is not pooling correctly? Use DBPC for a change. 

### 02.01.2016
- tried other connection pool implementation to make the node application perform better. 
  - [x] generic pool
  - [x] pg.native
  at the end decide to use pg.native. However, as java is also using a faster connection pool. node still consumes only half as many requests.

### 03.01.2016
- postgresql backing service is down. With error message (HTTP code 409) unexpected - `Container f8502acff5170f77d25aab7af757c7322d3fa3246543b1218855a8838b585a5e is restarting, wait until the container is running.`.Write to CF Users to ask why this is happening and meanwhile deleted and recreated the service.
- pushed different version of node implementation in the github. 
- test: node can scale almost linear. Java not. Thomas suggests: java uses twice more cpu, arguement: two node applications have the same share of cpu and can perform as well (nearly). 

### 04/05 01.2016
- write the thesis

### 10.01.2016
- Discussion with Jens:
  - the node application might run simply more slowly than java application. However, all considered, node application consumes much less cpu resource, instead, java application needs over 100%. In actual world, people pay for the cpu usage and memory. Therefore, comparing them with same resource configuration should be done. 
  - java application needs to write a large amount of data into database. It goes into error in cloud. batch should be used to improve performance. 
  - java application reaches a certain amount of total requests, then the throughput will no longer increase. This is solved by saving the response time in database and compare. There is a clear matching between long request time of total request time and database requests time. This means the database is the bottleneck(100 connection). One should use another database that has more resource.

- [x] use batch 
- [x] log responsetime in database
- [x] try using hana db
  - it is even slower
- [ ] try ton set the criteria for testing:
  - with fixed cpu usage, comparing memory consumption
    - node: 1x4 
    - java: 1x8
  - with fixed average response time, comparing cpu usage and memory consumption 
    - node: 1x4
    - java: 1x8
  - with fixed throughput and response time, comparing cpu usage and number of instances 
- [ ] there might be memory leak, as memory consumption doesn't go down after the load test is ended. 
  
### 11.01.2017
- [ ] manually save cpu and memory in table
- [ ] find out the warm-up phase for java, and how to carry it out
- [ ] gathering rational statistics:
  - [ ] use excel to connect to and duplicate db?
  - [ ] draw first graphs
- [ ] there might be memory leak, as memory consumption doesn't go down after the load test is ended.   
  - node application's memory goes down after sometime (hours?).
    


















































