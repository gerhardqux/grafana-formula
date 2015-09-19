# Grafana

Install and configure the [Grafana](http://grafana.org/) service.

## Synopsis

	git clone https://github.com/gerhardqux/grafana-formula /srv/grafana-formula
	mv /srv/grafana-formula/grafana /srv/salt
	cp /srv/salt/grafana/defaults.yaml /srv/pillar/grafana.sls

	# Edit the config to your needs
	vi /srv/pillar/grafana.sls 

	# Give your server access to grafana.sls
	cat >> /srv/pillar/top.sls << EOF
	  'yourserver':
	    - grafana
	EOF

	# Apply the state
	salt yourserver state.sls grafana

	# Log in to http://yourserver

## Available States

#### ``grafana``

Installs Grafana from the provided packages. Uses the Grafana [provided packages](http://docs.grafana.org/installation/).

## Author

[Gerhard Muntingh](https://github.com/gerhardqux) \<gerhard@qux.nl>

