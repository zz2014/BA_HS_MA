- push java application to CF - working with assembly plugin 
- java 
   - warm-up2, 
- elevate java efficiency:
   - pooling: DBPC,HIRAKI 
- use concurrency library for saving response time

- what have been tried to elevate node efficiency:
   - pg library: pg-node, pg-pool, pg-promise,sequelizer, generic pool
   - consulting the internet benchmark testing sequelizer
   - use hana db

- write more about finding limitation in HAProxy:
   - scale the application, to see the requests can also scale
   - two identical applications are pushed with different DB service but the same route
   - pushed an application with no connection or usage of DB
   - create load generator in Java with multithreading

- discussion about whether 3 node = 1 java:
   - cost of memory and cpu 
   - therefore fair test strategy: comparing with existing benchmarks

- write in technological background, not using excel directly

- Future work: 
  - video of the guy 
  - test with framework

- log from Kibana: only time range, not exact

From Mindmap:
- Performance optimization for java and node:
  - memory configuration -> cloud foundry specific: cpu share based on memory
  - database connection: max connetions 
  - java: thread pool configuration
  
- Node application:
  - can not efficiently use cpu according to CF's configuration
  - scale to reach better performance: scale at 80% cpu/memory usage

- Java application:
  - 1 instance with multiple cpus -> possible overhead
  - or more instance with single cpus
  - scale instance by adding more CPUs in it if cost is linear? for example, use 64CPU or 2 32CPU accoring to amazon picing

- bottlenecks:
  - proxy
  - router
  - database
  
- conclusions:
  - with one CPU(80% utilization), 1500 req/sec can be handled. Java and node have similar performance.
  - in enterprise applications, it is unlikely 100 CPUs can be utilized. (see bottleneck). Of course the implementation should be optimized and minimal with regard to cpu: carries out single transaction processing which is the most enterprise cases. there is not much logic on app layer and transaction into DB query very quickly. 
  
- future research:
  - computation heavy scenarios, ML. assumption Java is more efficient.
  - java: multiple instances work better that single big one, why?
  - does microservice architecture show any especially advantage in terms of scaling?
    - db becomes a bottleneck, assumption, future research
    - scale individually
    - deploy individually
    - use what fits best  

 