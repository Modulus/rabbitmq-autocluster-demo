FROM rabbitmq:3.6.3-management

ENV rabbitmq_version 3.6.3
ENV plugins_path /usr/lib/rabbitmq/lib/rabbitmq_server-${rabbitmq_version}/plugins/

COPY *.ez ${plugins_path}
RUN chmod 644 ${plugins_path}/*.ez

RUN rabbitmq-plugins enable --offline autocluster
