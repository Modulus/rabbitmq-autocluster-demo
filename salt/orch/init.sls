sync_all dev:
  salt.function:
    - tgt: "*"
    - tgt_type: compound
    - name: saltutil.sync_all
    - require_in:
      - salt: highstate consul follower
      - salt: highstate consul leader


highstate consul leader:
  salt.state:
    - tgt: "G@role:leader and G@role:mq"
    - tgt_type: compound
    - sls:
      - consul.leader

highstate consul follower:
  salt.state:
    - tgt: "G@role:mq not G@role:leader"
    - tgt_type: compound
    - sls:
      - consul.follower
    - require:
      - salt: highstate consul leader
