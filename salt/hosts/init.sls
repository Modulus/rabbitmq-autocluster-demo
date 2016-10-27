#Apply this for vagrant
{% if "vagrant" in grains["role"] %}
{% for server, addrs in salt["mine.get"]("role:mq", "network.ip_vagrant", expr_form="grain").items() %}
{% if grains["id"] != server %}
add {{server}} with {{addrs[0]}} to hostsfile:
  host.present:
    - name: {{server}}
    - ip: {{addrs[0]}}
{% endif %}
{% endfor %}
# Apply this for ec2 or similar
{% else %}
{% for server, addrs in salt["mine.get"]("role:mq", "network.ip_addrs", expr_form="grain").items() %}
{% if grains["id"] != server %}
add {{server}} with {{addrs[0]}} to hostsfile:
  host.present:
    - name: {{server}}
    - ip: {{addrs[0]}}
{% endif %}
{% endfor %}

{% endif %}
