# IMUIKit

INMO 私有 UI 组件库的 **静态 XCFramework**。在 IMBaseKit 之上提供页面基类、弹窗、Toast、列表、图片加载、相册、扫码和 WebView。

IMBaseKit、Kingfisher、RxSwift、SnapKit、ActiveLabel、Then、TZImagePickerController、MJRefresh **不打进包**，由宿主链接同一份。

---

## 环境要求

- iOS 15.0+
- Swift 5
- Xcode 15+
- CocoaPods，并开启 `use_frameworks!`

## 安装

```ruby
platform :ios, '15.0'
use_frameworks! :linkage => :static

target 'YourApp' do
  pod 'IMBaseKit', :git => 'https://github.com/INMO-X/IMBaseKit.git', :tag => '0.1.0'
  pod 'IMUIKit',   :git => 'https://github.com/INMO-X/IMUIKit.git', :tag => '0.1.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 15.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end
```

`pod install` 后图片在 **`IMUIKit.bundle`**（`ToastSuccess`、`ToastFailure`、`ToastInfo`、`ToastLoading`、`ArrowLeft`、`Album`）。不要重命名。静态链接时库会先查类所在 bundle，再查主 bundle。

页面基类和列表 cell / section 的 `deinit` 会在 `IMLogger.shared.enable == true` 时打日志。这段不靠编译期 `DEBUG`，Release 静态库里仍然在。

依赖版本与打这个包时一致：IMBaseKit 0.1.0、ActiveLabel 1.1.0、Kingfisher 8.12.0、RxSwift / RxCocoa 6.9.0、SnapKit 5.7.1、Then 3.0.0、TZImagePickerController 3.8.12、MJRefresh 3.7.9。

## 宿主 Info.plist

扫码或拍照需要 `NSCameraUsageDescription`，相册选图需要 `NSPhotoLibraryUsageDescription`。详见 [docs/PRIVACY.md](docs/PRIVACY.md)。

## 示例

[Example/](Example/) 用 tag `0.1.0` 检查 bundle 图片，并打开 Toast、Alert 和带返回按钮的下一页。

```bash
cd Example
pod install
open IMUIKit.xcworkspace
```

## 文档

| 文档 | 说明 |
|------|------|
| [docs/USAGE.md](docs/USAGE.md) | 场景用法 |
| [docs/PRIVACY.md](docs/PRIVACY.md) | 隐私清单与宿主配置 |
