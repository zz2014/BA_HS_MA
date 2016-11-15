#Define Application Testing Scenario 

- Test tool: 
	- [ApacheBench](http://httpd.apache.org/docs/2.4/programs/ab.html) 
	- [LoadRunner](http://www8.hp.com/us/en/software-solutions/loadrunner-load-testing/)			

- Parameters: (reference from [this] (references/AnalysisOfSoftwareSystemscalability.pdf))
	- Scaling dimensions: 
		- Number of requests per second
		- Number of instances in CF
	- Non-scaling variables: Available bandwidth
	- Dependent variables: Response time for a request

- Inspect:
	- Can application maintain a certain response time as the number of requests per second scale by varying the number of instance in CF?

	**ALSO:** Change the dependent variable and scaling dimension, like with fixed number of instances, how many requests can be handled.

- Scenarios:
	- I/O-intensive  
		- Bulletinboard 
	- compute-intensive
		- SAP use case: calculate payroll, bonus, promote
		- GEO Hashing
		- Pure mathematic question: Fibonacci
