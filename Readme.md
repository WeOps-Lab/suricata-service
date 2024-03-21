# Suricata Docker

提供suricata的Dockerfile，使用suricata-update更新最新的规则库

##### Quick Start

```bash
docker run -itd --network=host -e INTERFACE="ens192" suricata-server
```

#### Build

```bash
make build
```

