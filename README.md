# docker-suicidesquad1
This is a test project which uses docker to create multiple instances of a Nodejs web application. It uses a script which monitors if a docker container has died/stopped. If so, it stops all the other containers as well.
### Run
To run the cluster, execute run_cluster.sh script, pass number of containers as a parameter.
```
./run_cluster.sh 5
```
To make requests to the http server running on each containers, check the port host port exposed by:
```
sudo docker ps
```
For-example, if you have an entry:

        PORTS   
        0.0.0.0:32783->3000/tcp

You can access the web app using:
```
curl localhost:32783
```

To check if all the containers terminate, stop one of the node image container
````
sudo docker stop <container_id>
# to see if all the other node containers are alive or dead run the following command or look at the output of ./run_cluster
sudo docker ps
````
