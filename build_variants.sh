#!/bin/bash

# 脚本用于构建不同风味的应用

# 检查是否存在Firebase配置文件
check_firebase_config() {
  local flavor=$1
  if [ ! -f "android/app/src/$flavor/google-services.json" ]; then
    echo "警告: 未找到 $flavor 的Firebase配置文件"
    echo "请确保将对应包名的Firebase配置文件放置在 android/app/src/$flavor/google-services.json"
    
    # 如果用户希望继续构建，可以选择复制默认配置
    read -p "是否复制默认配置继续构建? (y/n): " answer
    if [ "$answer" == "y" ]; then
      cp android/app/google-services.json android/app/src/$flavor/google-services.json
      echo "已复制默认配置，请注意这可能导致Firebase功能无法正常工作"
    else
      echo "构建已取消"
      exit 1
    fi
  fi
}

case "$1" in
  "bwallet")
    echo "构建 B-Wallet 版本..."
    check_firebase_config "bwallet"
    flutter build apk --flavor bwallet --dart-define=APP_FLAVOR=bwallet -t lib/main.dart
    echo "构建完成! APK 位于: build/app/outputs/flutter-apk/app-bwallet-release.apk"
    ;;
  "btcbox")
    echo "构建 BTCBOX 版本..."
    check_firebase_config "btcbox"
    flutter build apk --flavor btcbox --dart-define=APP_FLAVOR=btcbox -t lib/main.dart
    echo "构建完成! APK 位于: build/app/outputs/flutter-apk/app-btcbox-release.apk"
    ;;
  "btcbox0727")
    echo "构建 BTCBOX0727 版本..."
    check_firebase_config "btcbox0727"
    flutter build apk --flavor btcbox0727 --dart-define=APP_FLAVOR=btcbox0727 -t lib/main.dart
    echo "构建完成! APK 位于: build/app/outputs/flutter-apk/app-btcbox0727-release.apk"
    ;;
  *)
    echo "使用方法: ./build_variants.sh [bwallet|btcbox|btcbox0727]"
    echo "  bwallet - 构建 B-Wallet 应用"
    echo "  btcbox  - 构建 BTCBOX 应用"
    echo "  btcbox0727 - 构建 BTCBOX0727 应用"
    echo ""
    echo "注意: 每个产品风味需要对应的Firebase配置文件"
    echo "  - B-Wallet: android/app/src/bwallet/google-services.json"
    echo "  - BTCBOX: android/app/src/btcbox/google-services.json"
    echo "  - BTCBOX0727: android/app/src/btcbox0727/google-services.json"
    ;;
esac 