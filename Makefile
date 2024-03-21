# 定义变量
IMAGE_NAME := suricata-server
DOCKERFILE := Dockerfile

# 默认目标
all: build push

# 构建镜像
build:
	docker build -t $(IMAGE_NAME) -f $(DOCKERFILE) .

push:
	docker push $(IMAGE_NAME)

# 清理镜像
clean:
	docker rmi $(IMAGE_NAME)