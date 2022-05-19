### 编译原理 2022 大作业 Tiny 语言编辑器

#### 【作业信息栏】

- **作业内容：** 实现一个`Tiny`语言的编译器
- **作业要求：** 参考要求文档
- **提交项目：** 实验报告、作业代码
- **截止日期：** 2022年6月20日 23:59分

#### 【环境部署快速开始指南】

##### 一、材料准备
- 需要 [VM WorkStation 虚拟机](https://www.vmware.com/company/labs-academic-software.html)，推荐交大的VMAP，不过由于最近一直都在申请，所以建议另外找比较规范的渠道获取最新的正版软件。
- 需要 [VS Code](https://code.visualstudio.com/)，用于SSH远程调试，`SSH`是一种远程连接到云主机/服务器的方式，链接之后，可以远程通过命令行执行命令，在VS Code上当然还可以进行一些代码编辑，以及程序的运行。
- 需要Ubuntu镜像，专业级选手可以直接选择服务器版本，全命令行无图形界面，初学者建议使用带有图形界面的版本。
  - 下载链接 [Ubuntu 20.04 官方镜像]([https://cn.ubuntu.com/download/alternative-downloads](https://releases.ubuntu.com/20.04.4/))
  - Desktop image 版本对应的是：**带有图形界面**的版本，有操作界面
  - Server install image 版本对应的是：**没有图形界面**的版本，纯命令行
  - 在安装过程中，您至少会输入一次密码，这个密码对应的是，Ubuntu的用户的密码，而不是 root（最高权限）的密码，最高权限的密码可以重置。
- 需要本仓库中的脚本
- 可能需要Linux版本的加速器，请根据个人网络条件酌情考虑

##### 二、Ubuntu root密码重置
若要重置 root（最高权限用户）的密码，执行下面的命令，然后输入新的密码，输入过程密码不可见，并且有一个重复输入的验证
root的用户的密码在初始化的时候，并不是第一次使用Ubuntu的系统用户的密码
```
sudo passwd root
```
在一般状态的时候，不要使用 root 账户，这是因为：
- 使用root账户时一旦错误操作，会导致全机崩溃，例如我初学的时候（亲身经历），在移动一个文件的时候，执行了下面的一条命令（错误）
```
root@ubuntu:~/testfileFolder$  mv /* /home/myusername/Desktop
```
- 上面这个命令的意思是，将虚拟机的所有的文件（包括系统文件等所有的磁盘文件），全部移动到桌面
- 显然这个会直接崩溃的，而我的本意是，只想把`testfileFolder`的文件夹下面的文件全部移动到桌面，也就是下面的正确命令，差异就是一个点
```
root@ubuntu:~/testfileFolder$  mv ./* /home/myusername/Desktop
```
- 所有由于绝对路径、相对路径的差异，造成的差别是灾难级的，例如这个主机是一台生产环境（例如我们校园的Canvas的服务器）
- 造成的是不仅是服务的终止、数据的丢失，还有严重的损失（就想象一下自己的作业全丢失了的后果，而这个是全校用户的数据 hhh）
- 所以牢记：一、及时备份重要文件；二、及时拍摄虚拟机快照；三、权限越大责任越大！


##### 三、Ubuntu 远程连接服务器
- 执行下面的语句，安装 `ssh` 服务
- 第一条语句的意思是安装程序，第二条语句的意思是启动服务
```
sudo apt-get install openssh-server
sudo /etc/init.d/ssh start
```

- 然后在虚拟机中，执行下面的命令，在输出的结果中查找 `192.168.XXX.XXX` 的IP地址，然后这个就是远程链接的地址
- 当然可能会看到好几条，所以可以都试一下，总有一个是对的，例如我的是 ens3 的对应的 IP
```
ip addr
```

- 在宿主机（也就是Windows/Mac）的实体机，打开终端执行下面的语句：
- 注意：`[username]` 需要用用户名代替，如果不记得用户名可以执行 `whoami`查看，[XXX.XXX.XXX.XXX]用上一步查看的ip进行
```
ssh [username]@[XXX.XXX.XXX.XXX]
```

- whoami的执行结果，我的用户名就叫server
```
server@ubuntu:~/Desktop$ whoami
server
```

##### 四、运行脚本






