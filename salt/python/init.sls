python-pip-whl-removed:
  pkg.removed:
    - name: python-pip-whl

python-pip-installed:
  pkg.installed:
    - name: python-pip
    - require:
      - pkg: python-pip-whl-removed

pip upgrade:
  cmd.run:
    - name: pip install -U pip
    - require:
      - pkg: python-pip-installed
