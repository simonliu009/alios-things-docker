# Docker file and scripts for AliOS Things Build Environment based on Ubuntu 18.04

How To Use this repository

1. Install && config docker first.

2. Clone this repository
	`git clone https://github.com/simonliu009/alios-things-docker` 
	`cd alios-things-docker`

3. Build your own docker image `docker build -t alios-things-docker:latest .`

4. Clone AliOS-Things to a different directory
	`git clone https://github.com/alibaba/AliOS-Things`

	5. Change directory to AliOS-Things
	`cd AliOS-Things`

	6. If you are running in powershell, please switch to command prompt window by typing `cmd`

7. Start the docker container 
        `docker run -it -v %cd%:/home/alios/AliOS-Things alios-things-docker`

		
# AliOS Things 编译环境的docker文件和脚本（基于Ubuntu 18.04）

使用方法:

1. 首先安装配置docker。

2. 克隆本仓库
	`git clone https://github.com/simonliu009/alios-things-docker` 
	`cd alios-things-docker`

3. Build your own docker image `docker build -t alios-things-docker:latest .`

4. Clone AliOS-Things to a different directory
	`git clone https://github.com/alibaba/AliOS-Things`

	5. Change directory to AliOS-Things
	`cd AliOS-Things`

	6. If you are running in powershell, please switch to command prompt window by typing `cmd`

7. Start the docker container 
        `docker run -it -v %cd%:/home/alios/AliOS-Things alios-things-docker`