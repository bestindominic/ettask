# ettask

Solution for https://github.com/haroonzone/hello-dropwizard.git

I have setup the java application as a docker container on ther server.
Here to redirect the requests to /hello I have used apache webserver as a proxy server. So when the user hits the application
url (http://54.254.128.48/hello), apache internally redirects requests to hello-dropwizard/hello-world which is deployed in the docker container. 
Apache config file is added in this repo (apache-test.conf).


Also the application build and deployed is automated using github, jenkins and ansible as below - 

 --> Here I am using ansible playbooks to build and deploy the application.
 --> Jenkins job is split into to two steps (app-build and app-deploy)
 --> During the build stage, ansible playbook builds the docker image by using the app code present in the jenkins workspace.
     app-build job will be cloning the latest app code to its workspace. Once the build is complete ansible-playbook will push
     the image to docker hub with a build tag. After this jenkins will trigger the deployment job (using jenkins plugin paramitarized trigger plugin).
 --> During the deploy stage, ansible playbook will pull the docker image from the docker hub (with the last build id from last build job)
     Docker will remove the exsiting container running on the server and then deploys the latest pulled image.
     
     
I have created a custom docker image (baseimage-dockerfile) for the application which has maven, java and other requirments installed. This will save time duirng every build.
This custom image is being used in build-deploy pipleline. 
