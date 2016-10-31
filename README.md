# RabbitMQ autocluster demo environment
======================================
*Tools used in this setup*
* vagrant
* saltstack
* rabbitmq
* docker

## What is this?
================
Use of the rabbitmq autocluster plugin with docker containers, consul and registrator
containers, containers, container aaaaand containers

##

## Apply highstate
==================
sudo salt "*" state.highstate

## Setup rabbitmq cluster
==========================
sudo salt-run state.orchestrate orch
