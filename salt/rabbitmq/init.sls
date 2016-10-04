/opt/rabbitmq/Dockerfile:
  file.managed:
    - source: salt://rabbitmq/Dockerfile

/opt/rabbitmq/autocluster-0.6.1.ez:
  file.managed:
    - source: salt://rabbitmq/autocluster-0.6.1.ez
    - require_in:
      - archive: /opt/rabbitmq/autocluster-plugin

build image:
  dockerng.image_preset:
    - build: /opt/rabbitmq
    - require:
      - file: /opt/rabbitmq/Dockerfile
      - file: /opt/rabbitmq/autocluster-0.6.1.ez
