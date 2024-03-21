#!/bin/sh
if [[ -n "${INTERFACE}" ]]; then
  suricata -c /etc/suricata/suricata.yaml -i ${INTERFACE}
else 
  suricata -c /etc/suricata/suricata.yaml -i lo
fi