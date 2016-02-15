FROM python:2
RUN easy_install locustio pyzmq statsd

COPY start.sh /usr/local/start.sh

ONBUILD COPY locustfile.py /usr/local/locustfile.py
ONBUILD COPY grafanaDashboard.json /usr/local/grafanaDashboard.json

CMD bash -C /usr/local/start.sh