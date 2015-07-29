#!/bin/bash

docker rmi adgico/java-1.8.0-51
docker build -t adgico/java-1.8.0-51 .

# check java is working
echo
echo
docker run --rm adgico/java-1.8.0-51 java -version

