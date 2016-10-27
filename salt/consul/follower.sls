include:
  - docker.image.consul
  - consul.base
  
extend:
  consul.running:
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
