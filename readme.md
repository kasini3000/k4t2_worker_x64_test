
------

# 项目名称 : k4t2_worker_x64_test 试用版 测试版

## 项目目的：

本软件目的是:

* 测试

* 公众预览

* 培训教学

### 不得用于生产环境!

------

# 项目包含

* linux 版 k4t v2 worker 相关工具 、 脚本。

------

# 使用方法：

```
#worker 被控机 网卡 主ip ：192.168.2.11  # 雏形版1 必须设定为 此ip

setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
#关闭selinux后，必须重启 1次 linux 系统

mkdir /etc/k4t
cd /etc/k4t
git clone https://github.com/kasini3000/k4t2_worker_x64_test.git
cp /etc/k4t/k4t2w_11111/k4t2workerd.service /usr/lib/systemd/system/k4t2workerd.service
chmod 755 /etc/k4t/k4t2w_11111/k4t2workerd
systemctl daemon-reload 
systemctl enable k4t2workerd
```

#### 试用版教程：  

https://kasini3000.github.io/k4t2/k4t2%E8%AF%95%E7%94%A8%E7%89%88%E5%AE%89%E8%A3%85%E6%95%99%E7%A8%8B

#### k4t v2 元数据目录：   

https://github.com/kasini3000/k4t2_worker_x64_test/blob/main/k4t2w_11111/apps/abc/

apps 是：元数据（配置文件）总目录。

abc 是：应用名。每个应用占一个目录名。目录名可以是中文（或其他unicode）

k4t2_app_11111.xlsx 是： 主配置文件。

未来将提供此工具，用于在终端内显示excel内容： excel2txt.ps1

------


## 项目协议：

1 本项目引用的外部的开源产品，遵守原有开源协议。含网关，dns，《kasini3000》等。

2 外部的powershell脚本，内部的powershell脚本，shell脚本，yaml，配置文件等。除已有著作权之外的，初步考虑采用 **mit** 协议开源。

总结：
整个 k4t2 项目是由众多（开源，或商业）软件产品，组件，搭建、组合而成的。

------




## 免责声明 Disclaimer

* 使用本软件前，用户应该做好充分测试。

* 本软件对用户造成的任何后果、损失，概不负责。

------


## 相关网址

# 手册：https://gitee.com/chuanjiao10/k4t2/tree/master/docs

