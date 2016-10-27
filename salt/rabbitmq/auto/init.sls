include:
  - docker

/opt/rabbitmq/Dockerfile:
  file.managed:
    - makedirs: True
    - source: salt://rabbitmq/auto/Dockerfile

/opt/rabbitmq/autocluster:
  archive.extracted:
    - source: salt://rabbitmq/auto/autocluster-0.6.1.tgz
    - archive_format: tar
    - tar_options: v

coderpews/rabbitmq:latest:
  dockerng.image_present:
    - build:  /opt/rabbitmq/
    - require:
      - file: /opt/rabbitmq/Dockerfile
      - archive: /opt/rabbitmq/autocluster
    - require_in:
      - dockerng: rabbitmq.running

rabbitmq.manual.build:
   cmd.run:
     - name: sudo docker build -t coderpews/rabbitmq .
     - cwd: /opt/rabbitmq
     - onfail:
       - dockerng: coderpews/rabbitmq:latest
     - require:
       - file: /opt/rabbitmq/Dockerfile
       - archive: /opt/rabbitmq/autocluster
     - require_in:
       - dockerng: rabbitmq.running

rabbitmq.running:
  dockerng.running:
    - name: rabbitmq
    - image: coderpews/rabbitmq
    - network_mode: host
    - port_bindings:
      - 4369:4369
      - 5672:5672
      - 5671:5671
      - 15672:15672
      - 25672:25672
      - 35197:35197
    - environment:
        RABBITMQ_NODENAME: {{grains["id"]}}
        AUTOCLUSTER_TYPE: consul
        CONSUL_HOST: "localhost"
        CONSUL_PORT: 8500
        CONSUL_SERVICE_TTL: 30
        RABBITMQ_ERLANG_COOKIE: {{pillar["RABBITMQ_ERLANG_COOKIE"]}}
