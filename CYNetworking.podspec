Pod::Spec.new do |s|

  s.name         = "CYNetworking"
  s.version      = "1.0.0"
  s.summary      = "CYNetworking"
  s.description  = "Used for APP Request, Depends on AFNetworking"
  s.homepage     = "https://github.com/chrisYooh/CYNetworking.git"
  s.license      = "MIT"
  s.author       = { "Chris" => "340019109@qq.com" }

  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.source       = { :git => "https://github.com/chrisYooh/CYNetworking.git", :tag => s.version }

  s.source_files = "CYNetworking/Classes/**/*"
  s.public_header_files = "CYNetworking/Classes/**/*.h"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "z"
  # s.libraries = "iconv", "xml2"
  
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "AFNetworking", "~> 3.2.1"

end
