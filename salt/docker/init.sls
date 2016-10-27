include:
  - python

dockerpy:
  pip.installed:
    - name: docker-py == 1.4.0
    - require:
      - sls: python
    - unless: pip list | grep docker-py

docker.dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
# Add this when docker.repository fails:
#curl -sSL https://get.docker.com/ | sh
#For ubuntu 14.x LTS
docker.repository:
  pkgrepo.managed:
    - humanname: Docker Repository
    - name: deb https://apt.dockerproject.org/repo ubuntu-trusty main
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - require_in:
      - pkg: docker.installed

{% set dockerscript = '/var/tmp/getdocker.sh' %}
download.docker.repository.script:
  cmd.run:
    - name: curl -o {{dockerscript}} -sSL https://get.docker.com
    - unless: docker ps

docker.repository.script:
  cmd.run:
    - name: sh {{dockerscript}}
    - unless: docker ps
    - require:
      - cmd:  download.docker.repository.script
    - onfail:
      - pkgrepo: docker.repository
      - pkg: docker.installed

# Remove old repo if it exists
docker.purge.lxc-docker:
  pkg.purged:
   - name: lxc-docker

docker.installed:
  pkg.installed:
    - name: docker-engine
    #- version:  1.12.2-0~trusty
    - require:
      - pkg: docker.dependencies
      - pkg: docker.purge.lxc-docker
