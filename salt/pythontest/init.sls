include:
  - nginx

mercurial:
  pkg.installed

testdata-repo:
  hg.latest:
    - name: https://hg.python.org/pythontestdotnet
    - target: /srv/python-testdata/
    - user: www-data
  require:
    - pkg: mercurial

/etc/nginx/sites.d/pythontest.conf:
  file.managed:
    - source: salt://pythontest/config/nginx.pythontest.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
  require:
    - file: /etc/nginx/sites.d/
    - hg: testdata-repo
