# 定义变量
IMAGE_NAME := my-docker-image
DOCKERFILE := Dockerfile

# 默认目标
all: build

# 构建镜像
build:
	docker build -t $(IMAGE_NAME) -f $(DOCKERFILE) .

# 清理镜像
clean:
	docker rmi $(IMAGE_NAME)