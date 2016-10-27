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
      - -bootstrap-expect=3
      {% if "vagrant" in grains["role"] %}
      - -advertise={{grains['ip_interfaces']['eth1'][0]}}
      {% else %}
      - -advertise={{grains['fqdn_ip4'][0]}}
      {% endif %}
