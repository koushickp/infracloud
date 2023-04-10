
docker pull infracloudio/csvserver:latest
docker pull prom/prometheus:v2.22.0


1.Run the container image infracloudio/csvserver:latest in background and check if it's running.
docker run -d --name csvserver infracloudio/csvserver:latest


2.If it's failing then try to find the reason, once you find the reason, move to the next step.
docker logs csvserver
the input file is missing


3.Write a bash script gencsv.sh to generate a file named inputFile whose content looks like:
bash script to create inputFile
#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 [start_index] [end_index]"
  exit 1
fi

start=$1
end=$2

if (( start >= end )); then
  echo "Error: start index must be less than end index"
  exit 1
fi

for (( i=start; i<=end; i++ ))
do
  rand_num=$(( $RANDOM % 1000 ))
  echo "${i}, ${rand_num}" >> inputFile
done


4.Run the container again in the background with file generated in (3) available inside the container (remember the reason you found in (2)).
docker run -d --name csvserver  -v $(pwd)/inputFile:/csvserver/inputdata infracloudio/csvserver:latest


5.Get shell access to the container and find the port on which the application is listening
docker exec -it csvserver
sh-4.4# netstat -tuln
exit
docker stop csvserver
docker rm csvserver


6.Same as (4), run the container and make sure,The application is accessible on the host at http://localhost:9393 ,Set the environment variable CSVSERVER_BORDER to have value Orange.
docker run -d --name csvserver -p 9393:9300 -v $(pwd)/inputFile:/csvserver/inputdata -e CSVSERVER_BORDER=Orange infracloudio/csvserver:latest




