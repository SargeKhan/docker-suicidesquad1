# Use Ubuntu image 
FROM ubuntu
# install curl
RUN sudo apt-get install -y curl
# install nodejs, npm
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
# run apt-get update
RUN apt-get update 
# install nodejs
RUN sudo apt-get install -y nodejs
# install forever
RUN npm install -g forever
# create a symlink for forever to run nodejs from node
RUN ln -s /usr/bin/nodejs /usr/sbin/node
# create folder
RUN mkdir /home/server
# Add source code to docker image
ADD . /home/server/
# Change directory 
WORKDIR "/home/server/"
# expose port 3000 for this image
EXPOSE 3000 
# start application
ENTRYPOINT ["node", "index.js"]
