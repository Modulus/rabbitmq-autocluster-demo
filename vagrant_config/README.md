#what is this?
Use of the rabbitmq autocluster plugin with docker containers, consul and registrator
containers, containers, container aaaaand containers

## Apply highstate
sudo salt "*" state.highstate

## Setup consul cluster
sudo salt-run state.orchestrate orch
