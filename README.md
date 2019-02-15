# Docker file and scripts for AliOS Things Build Environment based on Ubuntu 18.04

How To Use this repository

1. Install && config docker first.

2. Clone this repository
	`git clone https://github.com/simonliu009/alios-things-docker` 
	`cd alios-things-docker`

3. Build your own docker image `docker build -t alios-things-docker:latest .`

4. Clone AliOS-Things to a different directory and change directory to AliOS-Things
	`git clone https://github.com/alibaba/AliOS-Things`
	`cd AliOS-Things`

5. If you are running in `powershell`, please switch to command prompt window by typing `cmd`

6. Start the docker container 
        `docker run -it -v %cd%:/home/alios/AliOS-Things alios-things-docker`

		
# AliOS Things 编译环境的docker文件和脚本（基于Ubuntu 18.04）

使用方法:

1. 首先安装配置docker。

2. 克隆本仓库并切换到仓库目录
	`git clone https://github.com/simonliu009/alios-things-docker` 
	`cd alios-things-docker`

3. 构建镜像
   `docker build -t alios-things-docker:latest .`

4.  克隆 AliOS-Things 仓库并切换到仓库目录
     
	`git clone https://github.com/alibaba/AliOS-Things`
     Change directory to AliOS-Things
	`cd AliOS-Things`

5.如果你当前运行的是`powershell`，输入 `cmd`切换到命令行提示符

6. 运行容器并加载当前文件夹 
        `docker run -it -v %cd%:/home/alios/AliOS-Things alios-things-docker`