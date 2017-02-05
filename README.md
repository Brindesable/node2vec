===============================
Node2Vec Docker
===============================
forked from https://github.com/aditya-grover/node2vec

Launch node2vec in a docker image, then launch an email when the computation is finished.

* Put the graph in shared directory
``share/graph.edgelist``

* Build the docker image :
``./build-docker.sh``

* Edit the parameters for node2vec and mailgun in run-docker.sh

* Then run the docker image :
``./run-docker.sh``