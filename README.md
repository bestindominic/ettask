# ettask


Solution for https://github.com/haroonzone/hello-dropwizard.git

I have setup the java application as a docker container on the server.
Here to redirect the requests to /hello I have used apache web server as a proxy server. So when the user hits the application
url (http://54.254.128.48/hello), apache internally redirects requests to hello-dropwizard/hello-world which is deployed in the docker container. 
Apache config file is added in this repo (apache-test.conf).


Also the application build and deployment is automated using github, jenkins and ansible as below - 

Here I am using ansible playbooks to build and deploy the application.

Jenkins job is split into to two steps (app-build and app-deploy)
 
During the build stage, ansible playbook builds the docker image by using the app code present in the jenkins workspace. app-build job will be cloning the latest app code to its workspace. Once the build is complete ansible-playbook will push the image to docker hub with a build tag. After this jenkins will trigger the deployment job (using jenkins plugin - parameterized trigger plugin).

During the deploy stage, ansible playbook will pull the docker image from the docker hub (with the last build id from last build job). Docker will remove the existing container running on the server and then deploys the latest pulled image.
     
Whenever there is a code push to the master branch of hello-dropwizard.git jenkins will automatically start the build and deployment cycle.


I have created a custom docker image (baseimage-dockerfile) for the application which has maven, java and other requirements installed. This will save time during every build. This custom image is being used in build-deploy pipeline. 


App build playbook → app-build.yml
App deploy playbook → app-deploy.yml
Apache config file → apache-test.conf
Application Dockerfile → Dockerfile
Custom ubuntu-java image →  baseimage-dockerfile

