#
# Binary pod for the static XCFramework produced by Scripts/build_xcframeworks.sh.
# IMBaseKit and third-party pods stay dependencies of the host. They are not vendored.
#
Pod::Spec.new do |s|
  s.name             = 'IMUIKit'
  s.version          = '0.1.0'
  s.summary          = 'INMO X Project UI Components (static XCFramework)'
  s.description      = <<-DESC
  INMO X 项目私有 UI 组件库的静态二进制。
  IMBaseKit / ActiveLabel / Kingfisher / RxSwift / RxCocoa / SnapKit / Then /
  TZImagePickerController / MJRefresh 由宿主工程链接同一份，不打进本 XCFramework。
                       DESC

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jiangqi' => 'jiangqi@inmolens.com' }
  s.homepage         = 'https://github.com/INMO-X/IMUIKit'
  s.source           = { :git => 'https://github.com/INMO-X/IMUIKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.swift_version    = '5.0'
  s.static_framework = true

  s.vendored_frameworks = 'XCFrameworks/IMUIKit.xcframework'

  s.frameworks = [
    'UIKit',
    'Foundation',
    'CoreGraphics',
    'QuartzCore',
    'WebKit',
    'Photos',
    'PhotosUI',
    'AVFoundation',
    'Vision',
    'CoreImage',
    'ImageIO'
  ]

  # 图片与隐私清单。运行时只在名为 IMUIKit 的 bundle 里查图。
  s.resource_bundles = {
    'IMUIKit' => [
      'IMUIKit/Resources/**/*.{xcassets,lproj}',
      'IMUIKit/Resources/PrivacyInfo.xcprivacy'
    ]
  }

  s.dependency 'IMBaseKit', '0.1.0'
  s.dependency 'ActiveLabel', '1.1.0'
  s.dependency 'Kingfisher', '8.12.0'
  s.dependency 'RxCocoa', '6.9.0'
  s.dependency 'RxSwift', '6.9.0'
  s.dependency 'SnapKit', '5.7.1'
  s.dependency 'Then', '3.0.0'
  s.dependency 'TZImagePickerController', '3.8.12'
  s.dependency 'MJRefresh', '3.7.9'
end
