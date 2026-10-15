# Privacy (IMUIKit)

## 隐私清单

`IMUIKit/Resources/PrivacyInfo.xcprivacy`：

| Key | Value |
|-----|--------|
| `NSPrivacyTracking` | `false` |
| `NSPrivacyTrackingDomains` | 空 |
| `NSPrivacyCollectedDataTypes` | **照片或视频**（`NSPrivacyCollectedDataTypePhotosorVideos`），与用户关联，不用于追踪，目的为 App 功能。仅当宿主调用相册选择（`IMImagePicker`）或扫码页的相册识图时才会读到用户选中的图片 |
| `NSPrivacyAccessedAPITypes` | 空。本库不调用 UserDefaults、文件时间戳、开机时间、磁盘空间、键盘等需声明原因的 API |

二进制有两份同一清单：

1. 每个 XCFramework 切片里的 `IMUIKit.framework/PrivacyInfo.xcprivacy`
2. CocoaPods 资源包 `IMUIKit.bundle`（静态库不会被嵌入 App，只放在 framework 里时系统带不走这份清单）

IMBaseKit、Kingfisher、TZImagePickerController、RxSwift 等依赖各自带自己的隐私清单，不合并进本库。

## 宿主 Info.plist

| 能力 | Key |
|------|-----|
| 扫码 / 拍照 | `NSCameraUsageDescription` |
| 相册选图、相册识码 | `NSPhotoLibraryUsageDescription` |

## 其它

- 不采集 IDFA，不追踪。
- `WKWebView.im.configurationUserAgent()` 会在系统 UA 后追加 App 名、版本、`UIDevice` 机型、系统版本和屏幕倍率。这些值会随网页请求离开设备。宿主的 App 隐私营养标签要按实际上传内容填写，本清单只声明照片或视频。
- 导出合规（如页面里用到的系统加密）由宿主问卷填写。
