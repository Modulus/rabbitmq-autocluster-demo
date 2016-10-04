{% for server, addrs in salt["mine.get"]("role:mq", "network.ip_vagrant", expr_form="grain").items() %}
add {{server}} with {{addrs[0]}} to hostsfile:
  host.present:
    - name: {{server}}
    - ip: {{addrs[0]}}
{% endfor %}
