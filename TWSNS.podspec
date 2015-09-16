Pod::Spec.new do |s|

  s.name         = "TWSNS"
  s.version      = "1.0.7"
  s.summary      = "社会化分享和第三方登录模块"
  s.homepage     = "https://github.com/laughmaker/TWSNS"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "hezhendong" => "wskrdfeai@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/laughmaker/TWSNS.git", :tag => "1.0.7" }
  s.source_files = "SNS/**"
  s.resources 	 = "SNS/Resources/*.png"
  s.frameworks   = "UIKit", "CoreGraphics", "Foundation"
  # s.libraries 	 = "commoncrypto"
  s.dependency  'OpenShare', '~> 0.0.1'
  s.dependency  'FXBlurView', '~> 1.6.4'

end
