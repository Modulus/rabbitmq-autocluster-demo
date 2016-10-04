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

#For ubuntu 14.x LTS
docker.repository:
  pkgrepo.managed:
    - humanname: Docker Repository
    - name: deb https://apt.dockerproject.org/repo ubuntu-trusty main
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D

# Remove old repo if it exists
docker.purge.lxc-docker:
  pkg.purged:
   - name: lxc-docker

docker.installed:
  pkg.installed:
    - name: docker-engine
    #- version:  1.11.0-0~trusty
    - require:
      - pkg: docker.dependencies
      - pkg: docker.purge.lxc-docker
      - pkgrepo: docker.repository
