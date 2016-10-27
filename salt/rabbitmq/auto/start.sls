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
        RABBITMQ_NODENAME: {{grains["id"]}}
        AUTOCLUSTER_TYPE: consul
        CONSUL_HOST: "localhost"
        CONSUL_PORT: 8500
        CONSUL_SERVICE_TTL: 30
        RABBITMQ_ERLANG_COOKIE: {{pillar["RABBITMQ_ERLANG_COOKIE"]}}
