# IMUIKit Example

可运行 Demo，依赖公开仓 tag `0.1.0` 的 IMBaseKit 和 IMUIKit 静态库。

```bash
cd Example
pod install
open IMUIKit.xcworkspace
```

选择 scheme **IMUIKit_Example**。首页列出 `IMUIKit.bundle` 里的图片是否能加载，并可以打开 Toast、Alert、ActionSheet，以及带默认返回按钮的下一页。

本地未推送 tag 时，把 Podfile 里的 `:git` 行换成注释中的 `:path`。
