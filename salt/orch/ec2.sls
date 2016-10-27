sync_all dev:
  salt.function:
    - tgt: "*"
    - tgt_type: compound
    - name: saltutil.sync_all
    - require_in:
      - salt: highstate consul follower
      - salt: highstate consul leader

setup hosts:
  salt.state:
    - tgt: "G@role:mq"
    - tgt_type: compound
    - sls:
      - hosts.ec2
    - require_in:
      - salt: highstate consul follower
      - salt: highstate consul leader

build autocluster container image:
  salt.state:
    - tgt: "role:mq"
    - tgt_type: grain
    - sls:
      - rabbitmq.auto
    - require:
      - salt: setup hosts
    - require_in:
      - salt: highstate consul follower
      - salt: highstate consul leader


highstate consul leader:
  salt.state:
    - tgt: "G@role:leader and G@role:mq"
    - tgt_type: compound
    - sls:
      - consul.ec2.leader

highstate consul follower:
  salt.state:
    - tgt: "G@role:mq not G@role:leader"
    - tgt_type: compound
    - sls:
      - consul.ec2.follower
    - require:
      - salt: highstate consul leader
