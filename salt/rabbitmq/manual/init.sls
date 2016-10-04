rabbitmq ubuntu repo:
  pkgrepo.managed:
    - humanname: rabbitmq.repo
    - name: deb http://www.rabbitmq.com/debian/ testing main
    - file: /etc/apt/sources.list.d/rabbitmq.list
    - key_url: https://www.rabbitmq.com/rabbitmq-release-signing-key.asc

rabbitmq-server:
  pkg.installed

/var/lib/rabbitmq/.erlang.cookie:
  file.managed:
    - contents:
      - d8d618ab8505a1fd02c201a6e79ecd08bdb744d1  
