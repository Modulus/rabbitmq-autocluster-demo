FROM rabbitmq:3.6-management

ENV rabbitmq_version 3.6
ENV plugins_path /usr/lib/rabbitmq/lib/rabbitmq_server-${rabbitmq_version}/plugins/

COPY autocluster/plugins/*.ez ${plugins_path}
RUN chmod 644 ${plugins_path}/*.ez

RUN rabbitmq-plugins enable --offline autocluster
