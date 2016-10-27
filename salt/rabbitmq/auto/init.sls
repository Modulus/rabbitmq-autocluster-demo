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
