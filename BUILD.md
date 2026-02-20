# HomeBox - 本地编译脚本

## 编译前准备

### 1. 安装 Android Studio
下载地址: https://developer.android.com/studio

安装后打开 Android Studio，它会自动安装 Android SDK。

### 2. 设置环境变量
```powershell
# 添加到系统环境变量
$env:ANDROID_HOME = "C:\Users\$env:USERNAME\AppData\Local\Android\Sdk"
$env:Path += ";$env:ANDROID_HOME\platform-tools"
$env:Path += ";$env:ANDROID_HOME\tools"
```

### 3. 接受 Android 许可证
```powershell
flutter doctor --android-licenses
```

---

## 编译命令

```powershell
# 进入项目目录
cd app

# 获取依赖
flutter pub get

# 编译 Debug APK
flutter build apk --debug

# 编译 Release APK
flutter build apk --release

# APK 输出位置
# build\app\outputs\flutter-apk\app-debug.apk
# build\app\outputs\flutter-apk\app-release.apk
```

---

## 快速编译脚本

```powershell
# build.ps1
cd $PSScriptRoot\app
flutter clean
flutter pub get
flutter build apk --release
Write-Host "APK 已生成: app\build\app\outputs\flutter-apk\app-release.apk"
```

---

## GitHub Actions 自动编译

项目已配置 GitHub Actions，每次推送代码都会自动编译 APK。

编译完成后可以在 GitHub 仓库的 Actions 页面下载 APK。

---

## 检查 Flutter 环境

```powershell
flutter doctor -v
```

确保所有项都有 ✅ 标记。
