FROM debian:stable-slim
ADD entry-point.sh entry-point.sh
ADD rules/* /etc/suricata/rules/
RUN adduser --disabled-password --gecos '' suricata && \
    mkdir ~/.config/pip/ -p && \
    echo "[global]\nindex-url = https://mirrors.huaweicloud.com/repository/pypi/simple\nbreak-system-packages = true" > ~/.config/pip/pip.conf && \
    apt update && \
    apt install apt-transport-https ca-certificates -y && \
    sed -i "s@http://ftp.debian.org@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@http://security.debian.org@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@http://deb.debian.org@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list && \
    apt-get update -o Acquire::https::No-Cache=True -o Acquire::http::No-Cache=True --allow-unauthenticated && \
    apt-get install python3 python3-pip suricata libcap2-bin -y && \
    pip3 install --no-cache-dir requests && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chown -R suricata:suricata /etc/suricata && \
    setcap cap_net_raw=eip /usr/bin/suricata && \
    chmod 744 /var/log/suricata && chown suricata:suricata /var/log/suricata /var/run && \
    chmod 755 entry-point.sh

VOLUME [ "/var/log/suricata" ]
USER suricata
ENTRYPOINT [ "bash", "/entry-point.sh" ]