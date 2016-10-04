include:
  - docker.image.consul

consul.running:
  dockerng.running:
    - image: consul:v0.7.0
    - name: consul
    - hostname: {{grains['id']}}
    - restart_policy: always
    - unless: sudo docker ps | grep consul
    - binds:
      - /var/run/docker.sock:/tmp/docker.sock
    - require:
      - sls: docker.image.consul
    - port_bindings:
      - {{grains['fqdn_ip4'][0]}}:8300:8300/udp
      - {{grains['fqdn_ip4'][0]}}:8300:8300
      - {{grains['fqdn_ip4'][0]}}:8301:8301
      - {{grains['fqdn_ip4'][0]}}:8301:8301/udp
      - {{grains['fqdn_ip4'][0]}}:8302:8302
      - {{grains['fqdn_ip4'][0]}}:8302:8302/udp
      - {{grains['fqdn_ip4'][0]}}:8400:8400
      - {{grains['fqdn_ip4'][0]}}:8500:8500
      - {{grains['fqdn_ip4'][0]}}:8600:8600
      - {{grains['fqdn_ip4'][0]}}:8600:8600/udp
    - command:
      - agent
      - -server
      - -data-dir=/tmp/consul
      - -node={{grains["id"]}}
      - -advertise={{grains['fqdn_ip4'][0]}}
      {% for server, addrs in salt['mine.get']('G@role:mq and G@role:leader', 'network.ip_vagrant', expr_form='compound').items() %}
      - -retry-join={{addrs[0]}}
      {% endfor %}
