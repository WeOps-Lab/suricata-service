FROM debian:bullseye-slim
RUN adduser --disabled-password --gecos '' suricata
COPY entry-point.sh /usr/local/bin/
COPY rules /etc/suricata/rules
RUN apt update && \
    apt install -y suricata libcap2-bin && \
    apt clean
RUN chmod +x /usr/local/bin/entry-point.sh && \
    chown -R suricata:suricata /etc/suricata && \
    setcap cap_net_raw=eip /usr/bin/suricata
RUN chmod 744 /var/log/suricata && chown suricata:suricata /var/log/suricata /var/run
VOLUME [ "/var/log/suricata" ]

USER suricata
ENTRYPOINT [ "entry-point.sh" ]