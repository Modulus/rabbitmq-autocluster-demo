{% for server, addrs in salt["mine.get"]("role:mq", "network.ip_addrs", expr_form="grain").items() %}
{% if grains["id"] != server %}
add {{server}} with {{addrs[0]}} to hostsfile:
  host.present:
    - name: {{server}}
    - ip: {{addrs[0]}}
{% endif %}
{% endfor %}


{% if "vagrant" in grains["role"] %}

{% else %}
{% endif %}
