# IMUIKit 使用指南

通过 CocoaPods 引入（`import IMUIKit`，颜色和本地化需要 `import IMBaseKit`）。安装见仓库根目录 [README.md](../README.md)，隐私清单见 [PRIVACY.md](PRIVACY.md)。可运行示例在 `Example/`。

二进制是 **static XCFramework**。IMBaseKit、Kingfisher、RxSwift、SnapKit 等不打进包，由宿主链接同一份。

图片在名为 **IMUIKit** 的 bundle 里：`ToastSuccess`、`ToastFailure`、`ToastInfo`、`ToastLoading`、`ArrowLeft`、`Album`。静态链接时这个 bundle 在主 App 里，库会先查类所在 bundle，再查主 bundle。不要重命名。

---

## Toast

主线程调用。加载态必须配对关闭。

```swift
showToast("消息")
showSuccessToast("成功")
showFailureToast("失败")
showInfoToast("提示")
showLoadingToast("加载中")
dismissToast()
```

成功 / 失败 / 提示用 bundle 里的图标。加载态用 `IMDotsLoadingView`，不依赖那张静态图。

## Alert / ActionSheet

```swift
showAlert(in: view, title: "标题", message: "内容", confirm: "确定", cancel: "取消") { _ in }
showSheet(in: view, title: "标题", message: nil, confirm: "确认", cancel: "取消") { _ in }
```

更多按钮用 `IMPopupAlertModel` + `showPopup(in:model:completion:)`。系统样式用 `UIAlertController` 的 `showAlert` / `showSheet`（iPad 会处理 popover）。

## 页面基类

| 类型 | 作用 |
|------|------|
| `IMBaseViewController` | 默认背景、导航栏钩子 |
| `IMBaseNavigationController` | 默认返回按钮，图标是 bundle 里的 `ArrowLeft` |
| `IMBaseTabBarController` | Tab 根控制器 |

## 列表

用 Data 描述行，View 里 `bind(to:)` 渲染。

- Table：`IMBaseTableCellData` / `IMBaseTableCellView`，信息行 `IMInfoTableCellData`，空态 `IMBlankTableCellData`
- Collection：同名 Collection 版本
- 注册：`tableView.im.registerCell` / `dequeueReusableCell`，复用标识用类型名

下拉刷新用 MJRefresh，由宿主链接，不在本二进制里。

## 图片

`UIImageView.im.setImage(with:)`、`UIImage.im.getImage(with:)`、`IMImagePrefetcher` 走 Kingfisher。网络图的缓存由 Kingfisher 自己的隐私清单覆盖。

## 相册与扫码

`IMImagePicker` 选图，单选自带圆形裁切。`IMScanViewController` 用 Vision 识别二维码 / 条码，也可以从相册识图。`IMCodeGenerator.generateQRCode(content:)` 生码，不访问相机。

宿主 Info.plist 需要相机和相册用途说明，见 [PRIVACY.md](PRIVACY.md)。

## WebView

`IMBaseWebViewController` 带进度条。启动时可选调用 `WKWebView.im.configurationUserAgent()`，会在系统 UA 后追加 App 版本和机型。

## 主题色

`UIColor.im.theme_color1` … `text_color7`，在 `UIColor+Theme.swift`。

## 启动

`IMUIKitLaunch` 实现 `IMLaunchRegistrant`。宿主调用 `IMLaunchManager` 的 SDK 启动项时，会注册 IMUIKit 的路由服务。

## 示例

`Example/` 列出六张 bundle 图片是否加载成功，并打开 Toast、Alert、ActionSheet，以及带默认返回按钮的下一页。
