{% from "grafana/map.jinja" import grafana with context %}

grafana_package:
  file.managed:
    - name: /root/{{ grafana.filename }}
    - source: https://grafanarel.s3.amazonaws.com/builds/{{ grafana.filename }}
    - source_hash: sha256={{ grafana.filename_sha256 }}

grafana_install:
  pkg.installed:
    - sources:
      - grafana: /root/{{ grafana.filename }}
    - require:
      - file: grafana_package

grafana_config:
  file.managed:
    - name: /etc/grafana/grafana.ini
    - source: salt://grafana/templates/grafana.ini.jinja
    - owner: root
    - group: grafana
    - mode: 640
    - template: jinja
    - require:
      - pkg: grafana_install

grafana_ldap_config:
  file.managed:
    - name: /etc/grafana/ldap.toml
    - source: salt://grafana/templates/ldap.toml.jinja
    - owner: root
    - group: grafana
    - mode: 640
    - template: jinja
    - require:
      - pkg: grafana_install

grafana_start:
  service.running:
    - name: grafana-server
    - enable: True
    - require:
      - pkg: grafana_install
      - file: grafana_config
      - file: grafana_ldap_config
