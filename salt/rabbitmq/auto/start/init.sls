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
      - AUTOCLUSTER_TYPE: "consul"
      - CONSUL_HOST: "localhost"
      - CONSUL_PORT: "8500"
      - CLUSTER_NAME: rabbitcluster
      - CONSUL_SERVICE_TTL: "30"
      - RABBITMQ_ERLANG_COOKIE: "{{pillar['RABBITMQ_ERLANG_COOKIE']}}"
      - RABBITMQ_USE_LONGNAME: "true"
      - CONSUL_SERVICE_PORT: "5672"
      - AUTOCLUSTER_LOG_LEVEL: {{pillar['RABBITMQ_LOG_LEVEL']}}
      - RABBITMQ_DEFAULT_USER: {{pillar['RABBITMQ_DEFAULT_USER']}}
      - RABBITMQ_DEFAULT_PASS: {{pillar['RABBITMQ_DEFAULT_PASS']}}
      {% if "vagrant" in grains["role"] %}
      - RABBITMQ_NODENAME: rabbit@{{grains['ip_interfaces']['eth1'][0]}}
      - HOSTNAME: {{grains['ip_interfaces']['eth1'][0]}}
      - CONSUL_SVC_ADDR: {{grains['ip_interfaces']['eth1'][0]}}
      {% else %}
      - RABBITMQ_NODENAME: rabbit@{{grains['fqdn']}}
      - HOSTNAME: {{grains['fqdn']}}
      - CONSUL_SVC_ADDR: {{grains['fqdn']}}
      {% endif %}
