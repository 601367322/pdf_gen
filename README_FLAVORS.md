# 多产品风味打包指南

本项目支持多产品风味打包，可以根据不同的命令构建不同图标、应用名称和applicationId的应用。

## 设置步骤

1. 创建产品风味资源目录：

```bash
mkdir -p android/app/src/bwallet/res/mipmap-xxhdpi android/app/src/btcbox/res/mipmap-xxhdpi
```

2. 放置图标文件：

```bash
# 复制B-Wallet图标
cp android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png android/app/src/bwallet/res/mipmap-xxhdpi/

# 复制BTCBOX图标（将ic_launcher1.png复制并重命名为ic_launcher.png）
cp android/app/src/main/res/mipmap-xxhdpi/ic_launcher1.png android/app/src/btcbox/res/mipmap-xxhdpi/ic_launcher.png
```

3. 配置Firebase（重要）：

每个产品风味需要有自己的Firebase配置文件，否则Firebase功能将无法正常工作。

```bash
# 在Firebase控制台为每个应用包名创建项目并下载配置文件
# 将配置文件放在对应的目录中：

# B-Wallet的Firebase配置
# 包名: com.flutterflow.finwallet
cp 下载的google-services.json android/app/src/bwallet/google-services.json

# BTCBOX的Firebase配置
# 包名: com.flutterflow.finwallet1
cp 下载的google-services.json android/app/src/btcbox/google-services.json
```

## 构建应用

我们提供了构建脚本，可以轻松构建不同的产品风味：

```bash
# 构建B-Wallet版本
./build_variants.sh bwallet

# 构建BTCBOX版本
./build_variants.sh btcbox
```

## 注意事项

1. 确保已经将脚本设为可执行：
```bash
chmod +x build_variants.sh
```

2. 每个产品风味的配置：
   - **B-Wallet**:
     - 应用名称: B-Wallet
     - 应用ID: com.flutterflow.finwallet
     - 命名空间: com.flutterflow.finwallet
     - 图标: ic_launcher.png
   
   - **BTCBOX**:
     - 应用名称: BTCBOX
     - 应用ID: com.flutterflow.finwallet1
     - 命名空间: com.flutterflow.finwallet1
     - 图标: ic_launcher1.png (已重命名为ic_launcher.png)

3. Firebase配置：
   - 如果您使用Firebase服务，必须为每个包名在Firebase控制台创建单独的应用
   - 每个应用需要下载对应的`google-services.json`文件并放置在正确的目录中
   - 如果没有正确配置Firebase，相关功能将无法正常工作

## 开发调试

在开发调试时，可以指定产品风味：

```bash
# 调试B-Wallet版本
flutter run --flavor bwallet --dart-define=APP_FLAVOR=bwallet

# 调试BTCBOX版本
flutter run --flavor btcbox --dart-define=APP_FLAVOR=btcbox
``` 