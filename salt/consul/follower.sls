include:
  - docker.image.consul

consul.running:
  dockerng.running:
    - image: consul:v0.7.0
    - name: consul
    #- hostname: {{grains['id']}} cannot have hostname with host network_mode
    - restart_policy: always
    - unless: sudo docker ps | grep consul
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
    - command:
      - agent
      - -server
      - -data-dir=/tmp/consul
      - -node={{grains["id"]}}
      {% if "vagrant" in grains["role"] %}
      - -advertise={{grains['ip_interfaces']['eth1'][0]}}
      {% for server, addrs in salt['mine.get']('G@role:mq and G@role:leader', 'network.ip_vagrant', expr_form='compound').items() %}
      - -retry-join={{addrs[0]}}
      {% endfor %}
      {% else %}
      - -advertise={{grains['fqdn_ip4'][0]}}
      {% for server, addrs in salt['mine.get']('G@role:mq and G@role:leader', 'network.ip_addrs', expr_form='compound').items() %}
      - -retry-join={{addrs[0]}}
      {% endfor %}
      {% endif %}
