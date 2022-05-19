echo '
 ________  ________  _____ ______   ________  ___  ___       _______
|\   ____\|\   __  \|\   _ \  _   \|\   __  \|\  \|\  \     |\  ___ \
\ \  \___|\ \  \|\  \ \  \\\__\ \  \ \  \|\  \ \  \ \  \    \ \   __/|
 \ \  \    \ \  \\\  \ \  \\|__| \  \ \   ____\ \  \ \  \    \ \  \_|/__
  \ \  \____\ \  \\\  \ \  \    \ \  \ \  \___|\ \  \ \  \____\ \  \_|\ \
   \ \_______\ \_______\ \__\    \ \__\ \__\    \ \__\ \_______\ \_______\
    \|_______|\|_______|\|__|     \|__|\|__|     \|__|\|_______|\|_______|

 ________  ________  ___  ________   ________  ___  ________  ________  ___
|\   __  \|\   __  \|\  \|\   ___  \|\   ____\|\  \|\   __  \|\   __  \|\  \
\ \  \|\  \ \  \|\  \ \  \ \  \\ \  \ \  \___|\ \  \ \  \|\  \ \  \|\  \ \  \
 \ \   ____\ \   _  _\ \  \ \  \\ \  \ \  \    \ \  \ \   ____\ \   __  \ \  \
  \ \  \___|\ \  \\  \\ \  \ \  \\ \  \ \  \____\ \  \ \  \___|\ \  \ \  \ \  \____
   \ \__\    \ \__\\ _\\ \__\ \__\\ \__\ \_______\ \__\ \__\    \ \__\ \__\ \_______\
    \|__|     \|__|\|__|\|__|\|__| \|__|\|_______|\|__|\|__|     \|__|\|__|\|_______|
    
    
'


wait() {
	echo -e "\033[32m[Info]\033[0m 即将在本机上配置本次编译原理大作业的环境..."
  	echo -e "\033[32m[Info]\033[0m 在正式开始之前，我们默认您已经阅读并且知悉了下面的内容"
	echo -e "\033[33m[Warn]\033[0m 如果发现存在不满足的条件,请按 Ctrl + C 立即终止程序"
	echo -e " 1- 虚拟机/实体机的操作系统是 Linux Ubuntu 20.04, 且操作系统处于新安装的全新状态"
	echo -e " 2- 我使用 sudo ./envStart 执行命令"
	echo -e " 3- 如果出现在 Git 中报错，请合理并科学的使用上网工具，例如支持Linux的某些工具"
	echo -e " 4- 物理宿主机科学上网，不代表虚拟机可以科学上网，Linux需要单独的加速器！"
	i=0
	str='#'
	ch=('|' '\' '-' '/')
	index=0
	while [ $i -le 50 ]
	do
		printf "[%-50s][%d%%][%c]\r" $str $(($i*2)) ${ch[$index]}
		str+='#'
		let i++
		let index=i%4
		sleep 0.2
	done
	echo ""
}

wait

echo -e "\033[32m[Info]\033[0m 检测到当前的操作用户是: $USER"

if [ -d "/home/$USER/Desktop" ]; then
  cd /home/$USER/Desktop
  echo -e "\033[32m[Info]\033[0m 检测到英文版操作系统"
else
  if [ -d "/home/$USER/桌面" ]; then
    cd /home/$USER/桌面
    echo -e "\033[32m[Info]\033[0m 检测到中文版操作系统"
  
  else
    echo -e "\033[32m[Info]\033[0m 操作系统既不是中文也不算英文，语言检测失败"
    exit -1
  fi
fi



echo -e "\033[32m[Info]\033[0m 当前用户:$USER桌面进入已成功"

echo -e "\033[32m[Info]\033[0m 即将安装Git,如有提示[Y/N],请按Y并回车"
sudo apt install git
echo -e "\033[32m[Info]\033[0m 安装Git完成"

echo -e "\033[32m[Info]\033[0m 即将安装cmake,如有提示[Y/N],请按Y并回车"
sudo apt install cmake
echo -e "\033[32m[Info]\033[0m 安装Git完成"

echo -e "\033[32m[Info]\033[0m 即将安装clang lld,如有提示[Y/N],请按Y并回车"
sudo apt-get install clang lld
echo -e "\033[32m[Info]\033[0m 安装clang lld完成"

echo -e "\033[32m[Info]\033[0m 即将安装ninja-build,如有提示[Y/N],请按Y并回车"
sudo apt install ninja-build
echo -e "\033[32m[Info]\033[0m 安装ninja-build完成"


echo -e "\033[32m[Info]\033[0m 即将Git拉取仓库,目标名称:llvm-project,地址 https://github.com/Jason048/llvm-project.git"
echo -e "\033[32m[Info]\033[0m Git过程如果有任何报错,基本都是由于网络原因,与本脚本无关,请检查网络条件是否科学"

git clone https://github.com/Jason048/llvm-project.git

if [ -d "./llvm-project" ]; then
	echo -e "\033[32m[Info]\033[0m git完美！"
else
	echo -e "\033[31m[Error]\033[0m git失败，中止！"
	exit -1;
fi



echo -e "\033[32m[Info]\033[0m 即将创建目录:llvm-project/build, 该文件在您的桌面上"
mkdir llvm-project/build
echo -e "\033[32m[Info]\033[0m 创建目录:llvm-project/build完成, 该文件在您的桌面上"

cd llvm-project/build
echo -e "\033[32m[Info]\033[0m 进入创建的build目录成功！"

echo -e "\033[32m[Info]\033[0m 接下来的两步会非常的漫长，请耐心等待"
echo -e "\033[32m[Info]\033[0m 第二步中，可能会有三千多个文件需要编译，时间约为10分钟-20分钟"

cmake -G Ninja ../llvm \
 -DLLVM_ENABLE_PROJECTS=mlir \
 -DLLVM_BUILD_EXAMPLES=ON \
 -DLLVM_TARGETS_TO_BUILD="X86;NVPTX;AMDGPU" \
 -DCMAKE_BUILD_TYPE=Release \
 -DLLVM_ENABLE_ASSERTIONS=ON \
 -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLLVM_ENABLE_LLD=ON
cmake --build . --target check-mlir

echo -e "\033[32m[Info]\033[0m 恭喜！最漫长的步骤已经完成啦！即将进行下一个安装:tiny_project："

echo -e "\033[32m[Info]\033[0m 检测到当前的操作用户是: $USER"
if [ -d "/home/$USER/Desktop" ]; then
  cd /home/$USER/Desktop
  echo -e "\033[32m[Info]\033[0m 检测到英文版操作系统"
else
  if [ -d "/home/$USER/桌面" ]; then
    cd /home/$USER/桌面
    echo -e "\033[32m[Info]\033[0m 检测到中文版操作系统"
  
  else
    echo -e "\033[31m[Error]\033[0m 操作系统既不是中文也不算英文，语言检测失败"
    exit -1
  fi
fi
echo -e "\033[32m[Info]\033[0m 当前用户:$USER桌面进入已成功"

echo -e "\033[32m[Info]\033[0m 即将Git拉取仓库,目标名称:tiny_project,地址 https://github.com/Jason048/tiny_project.git"
git clone https://github.com/Jason048/tiny_project.git




if [ -d "./tiny_project" ]; then
	echo -e "\033[32m[Info]\033[0m git完美！"
else
	echo -e "\033[31m[Error]\033[0m git失败，中止！"
	exit -1;
fi


mkdir tiny_project/build
cd tiny_project/build

echo -e "\033[32m[Info]\033[0m 最后一步！"

if [ -d "/home/$USER/Desktop" ]; then
	LLVM_DIR=/home/$USER/Desktop/llvm-project/build/lib/cmake/llvm \
	MLIR_DIR=/home/$USER/Desktop/llvm-project/build/lib/cmake/mlir \
	cmake -G Ninja ..
else
	if [ -d "/home/$USER/桌面" ]; then
	LLVM_DIR=/home/$USER/桌面/llvm-project/build/lib/cmake/llvm \
	MLIR_DIR=/home/$USER/桌面/llvm-project/build/lib/cmake/mlir \
	cmake -G Ninja ..
	
	else
		echo -e "\033[31m[Error]\033[0m 异常崩溃"
		exit -1;
	fi
fi


echo -e "\033[32m[Info]\033[0m 恭喜！安装已经全部完成！文件夹tiny_project应该出现在您的桌面，开始工作吧！"

echo '
 _________  ___  ___  ________  ________   ___  __    ________      
|\___   ___\\  \|\  \|\   __  \|\   ___  \|\  \|\  \ |\   ____\     
\|___ \  \_\ \  \\\  \ \  \|\  \ \  \\ \  \ \  \/  /|\ \  \___|_    
     \ \  \ \ \   __  \ \   __  \ \  \\ \  \ \   ___  \ \_____  \   
      \ \  \ \ \  \ \  \ \  \ \  \ \  \\ \  \ \  \\ \  \|____|\  \  
       \ \__\ \ \__\ \__\ \__\ \__\ \__\\ \__\ \__\\ \__\____\_\  \ 
        \|__|  \|__|\|__|\|__|\|__|\|__| \|__|\|__| \|__|\_________\
                                                        \|_________|

 ________ ________  ________          ___  ___  ________  _______
|\  _____\\   __  \|\   __  \        |\  \|\  \|\   ____\|\  ___ \
\ \  \__/\ \  \|\  \ \  \|\  \       \ \  \\\  \ \  \___|\ \   __/|
 \ \   __\\ \  \\\  \ \   _  _\       \ \  \\\  \ \_____  \ \  \_|/__
  \ \  \_| \ \  \\\  \ \  \\  \|       \ \  \\\  \|____|\  \ \  \_|\ \
   \ \__\   \ \_______\ \__\\ _\        \ \_______\____\_\  \ \_______\
    \|__|    \|_______|\|__|\|__|        \|_______|\_________\|_______|
                                                  \|_________|
                                                  
'