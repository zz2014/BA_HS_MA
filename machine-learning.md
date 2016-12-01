Machine Learning Scenario

- Current situation:
  - Java is widely used.
  - Node.js has also some implementations
- Algorithm can be simple but huge data has to be handles. e.g. 1 million rows, 1 thousand rows.
- If testing, use public data center
- Supervised training and unsupervised training. see here [references/ML_pseudocode.pdf]
  - Supervised training: 
    - number of epochs and number of batches decide number of loops. Iterate through data is expensive. Therefore if data size number of epoch is large, it is slow. 
  - Unsupervised training:
    - outlier-score method is complicated and needs a lot of time. 1 million records take up to 2 days. 

- Suggestion: find an existing algorithm.   
  K-means clustering
  - download data set from public libraries, eg. car evaluation ... 
  
http://archive.ics.uci.edu/ml/datasets.html
 
http://stanford.edu/~cpiech/cs221/handouts/kmeans.html
 
https://www.npmjs.com/package/node-kmeans
