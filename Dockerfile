 # Base on a Jenkins agent image - see https://github.com/jenkinsci/docker-jnlp-slave
FROM jenkins/jnlp-slave:latest

# Install some stuff as root
USER root

# Make sudo work to easier be able to work with the image itself
RUN apt-get install -y sudo
#COPY jenkins.sudo /etc/sudoers.d/jenkins

# Install Ansible and other tools
RUN apt-get update && apt-get install -y git nano

# install cmake and JRE for gradle and cmake
RUN apt-get install -y gcc g++ default-jre swig mingw-w64 cmake gcc-multilib g++-multilib

# Back to Jenkins
USER jenkins

# For some reason installing Ansible this way via pip doesn't get it on PATH
ENV PATH="~/.local/bin:${PATH}"

# Set the working directory
ENV JENKINS_AGENT_WORKDIR /home/jenkins/agent

ENTRYPOINT ["jenkins-slave"]
