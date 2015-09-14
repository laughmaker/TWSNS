Pod::Spec.new do |s|

  s.name         = "XTSNS"
  s.version      = "1.0.2"
  s.summary      = "小图社会化分享和第三方登录模块"
  s.homepage     = "https://coding.net/u/xiaotujieshu/p/XTSNS_iOS"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "hezhendong" => "wskrdfeai@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://git.coding.net/xiaotujieshu/XTSNS_iOS.git", :tag => "1.0.2" }
  s.source_files = "SNS/**"
  s.dependency  'OpenShare', '~> 0.0.1'
  s.dependency  'FXBlurView', '~> 1.6.4'
  s.resources = "SNS/Resources/*.png"

end
