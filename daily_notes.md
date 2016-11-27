# Project Journal

### 15.11.2016
**Define**: a very light-weight Java version of bulletinboard ads application
- Plain http handler: `jetty`
- Plain DB connection: `JDBC`

**Done:**
- JDBC connection to PostgreSQL
- `AdvertisementResource`: getAll, getOne
- `AdvertisementRepository`: selectAll, selectOne
- `AdvertisementHandler`: getAll

### 16.11.2016
**Plan:**
- Use Java 8 
- `AdvertisementRepository` 
  - add insertOne + create table if not exist
  - delete all/ drop table
- add logic inside app: init database
- Test with setup/teardown
- Use env variable to access DB
- try to push to CF
 
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
  - **TODO**
- try to push to CF

### 17.11.2016
**Plan**
- Use env variable to access DB
- try to push to CF

**Done**
- improve exception handling
  - throw exceptions in low level [READ](https://community.oracle.com/docs/DOC-983219)
- use Datasource pool DB connection
- push to CF
  - create executable jar with maven assembly plugin
    - works locally
    - can't push to CF, strange error by javax directory
    - exclude javax dependency, error went away but javax is needed in jetty
  - **TODO**

### 18.11.2016
**Plan**
- Push to CF
- Start performance testing

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
- Simulate load with enduser simulator as application pushed in CF.
  - use getAll: DB will be kept small as the DB efficiency is not to be discussed in the research.
  - calculate response time inside the application
- Get the logs from router in ELK
  - filter: space id, org id, raw app name, time period
  - contact Kibana colleagues for information
- Optimize application configuration with JProfiler
- Log cpu and memory
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
- use pool in load generator
- save response time not after every request
- use chisel to access DB in cf

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
- observe the ELK results
- try to use docker(alpine) and curl to generate load
- still have to find out how to record memory-cpu

**DONE**
- write a script to push load generator with parameters
- write logs in application and compare the response time with ELK.
  - the result is the same. The round trip from load balancer is very short
  - curiously there are two logs: meaning two load balancers/ routers
- connected to chisel
  - easy access with toad extension
  - **TODO: ** connect to DB from excel 
