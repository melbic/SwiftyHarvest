#
#  Be sure to run `pod spec lint SwiftyHarvest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SwiftyHarvest"
  s.version      = "0.0.1"
  s.summary      = "Swift API for getharvest.com."
  s.homepage     = "https://github.com/melbic/SwiftyHarvest"
  s.license      = "MIT"
  s.author       = { "Samuel Bichsel" => "samuel.bichsel@dreipol.ch" }
  s.source       = { :git => "https://github.com/melbic/SwiftyHarvest.git", :tag => "#{s.version}" }

  s.source_files = 'Sources/**/*.swift'

  s.dependency 'Alamofire', '~> 4'

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '11.0'
end
