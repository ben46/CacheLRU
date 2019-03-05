#
#  Be sure to run `pod spec lint CacheLRU.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec| 

  spec.name         = "CacheLRU"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of CacheLRU." 

  spec.homepage     = "http://EXAMPLE/CacheLRU" 
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" } 
  spec.static_framework = true

  spec.author             = { "周卓潜" => "ben02060846@gmail.com" } 

  spec.platform     = :ios
  spec.platform     = :ios, "9.0"
 

  spec.source       = { :git => "git@github.com:ben46/CacheLRU.git", :branch => "master" }
 

  spec.source_files  = "Classes", "Classes/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"
 

end
