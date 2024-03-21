FROM debian:stable-slim
LABEL maintainrer="WeOpsLab"
ADD entry-point.sh entry-point.sh
RUN adduser --disabled-password --gecos '' suricata && \
    mkdir ~/.config/pip/ -p && \
    echo "[global]\nindex-url = https://repo.huaweicloud.com/repository/pypi/simple\nbreak-system-packages = true" > ~/.config/pip/pip.conf && \
    sed -i "s@ftp.debian.org@repo.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@security.debian.org@repo.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@deb.debian.org@repo.huaweicloud.com@g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install python3 python3-pip suricata libcap2-bin -y && \
    pip3 install --no-cache-dir requests && \
    pip3 install --upgrade suricata-update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chown -R suricata:suricata /etc/suricata && \
    setcap cap_net_raw=eip /usr/bin/suricata && \
    chmod 744 /var/log/suricata && chown suricata:suricata /var/log/suricata /var/run && \
    chmod 755 entry-point.sh && \
    chown -R suricata. /var/lib/suricata && \
    sed -i '/default-rule-path/s@/etc/suricata/rules@/var/lib/suricata/rules@' /etc/suricata/suricata.yaml && \
    suricata-update update-sources && \
    suricata-update

USER suricata
ENTRYPOINT [ "bash", "/entry-point.sh" ]