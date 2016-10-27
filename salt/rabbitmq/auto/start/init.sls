rabbitmq.running:
  dockerng.running:
    - name: rabbitmq
    - image: coderpews/rabbitmq
    - network_mode: host
    - port_bindings:
      - {{grains['fqdn_ip4'][0]}}:4369:4369
      - {{grains['fqdn_ip4'][0]}}:5672:5672
      - {{grains['fqdn_ip4'][0]}}:5671:5671
      - {{grains['fqdn_ip4'][0]}}:15672:15672
      - {{grains['fqdn_ip4'][0]}}:25672:25672
      - {{grains['fqdn_ip4'][0]}}:35197:35197
    - environment:
      - RABBITMQ_NODENAME: rabbit@{{grains['fqdn']}}
      - AUTOCLUSTER_TYPE: "consul"
      - CONSUL_HOST: "localhost"
      - CONSUL_PORT: '8500'
      - CLUSTER_NAME: PUSH-MQ-CLUSTER
      - CONSUL_SERVICE_TTL: "30"
      - RABBITMQ_ERLANG_COOKIE: "{{pillar['RABBITMQ_ERLANG_COOKIE']}}"
      - RABBITMQ_USE_LONGNAME: "true"
      - CONSUL_SERVICE_PORT: "5672"
      - AUTOCLUSTER_LOG_LEVEL: debug
      - RABBITMQ_DEFAULT_USER: guest
      - RABBITMQ_DEFAULT_PASS: guest
      - HOSTNAME: {{grains['fqdn']}}
      #- CONSUL_SVC_ADDR: {{grains['fqdn_ip4'][0]}}
      - CONSUL_SVC_ADDR_AUTO: "true"
