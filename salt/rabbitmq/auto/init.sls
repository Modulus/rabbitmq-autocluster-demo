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

# Can be used for debugging builds
#coderpews/rabbitmq:latest:
#  cmd.run:
#    - cwd: /opt/rabbitmq/
#    - name: docker build -t coderpews/rabbitmq:latest .
#    - require:
#      - file: /opt/rabbitmq/Dockerfile
#      - archive: /opt/rabbitmq/autocluster
