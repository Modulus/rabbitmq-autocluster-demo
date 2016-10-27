consul.running:
  dockerng.running:
    - image: consul:v0.7.0
    - name: consul
    #- hostname: {{grains['id']}} Cannot have hostname with host mode
    - restart_policy: always
    - unless: sudo docker ps | grep consul
    - network_mode: host
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

registrator.running:
  dockerng.running:
    - image: gliderlabs/registrator
    - name: registrator
    - command: consul://localhost:8500
    - network_mode: host
    - restart_policy: always
    - binds: /var/run/docker.sock:/tmp/docker.sock
    - require:
      - dockerng: consul.running
