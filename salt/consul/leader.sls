include:
  - docker.image.consul

consul.running:
  dockerng.running:
    - image: progrium/consul
    - name: consul
    #- hostname: {{grains['id']}} Cannot have hostname with host mode
    - restart_policy: always
    #- unless: sudo docker ps | grep consul
    - binds:
      - /var/run/docker.sock:/tmp/docker.sock
    - require:
      - sls: docker.image.consul
    - port_bindings:
      - 8300:8300/udp
      - 8300:8300
      - 8301:8301
      - 8301:8301/udp
      - 8302:8302
      - 8302:8302/udp
      - 8400:8400
      - 8500:8500
      - 8600:8600
      - 8600:8600/udp
    - environment:
      - GOMAXPROCS: '4'
    - command:
      - consul
      - agent
      - "-server"
      - "-h {{grains['id']}}"
      - "-advertise {{grains['ip_interfaces']['eth1'][0]}}"
      - "-bootstrap-expect 3"
