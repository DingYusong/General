#
# Be sure to run `pod lib lint General.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "General"
  s.version          = "0.1.0"
  s.summary          = "General app Function"
  s.description      = <<-DESC
                       基本集成。

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/DingYusong/General"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "丁玉松" => "dys90@qq.com" }
  s.source           = { :git => "https://github.com/DingYusong/General.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'General' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking', '~> 2.5.3'
    s.dependency 'libqrencode', '~> 3.4.2'
    s.dependency 'MBProgressHUD', '~> 0.9.1'
    s.dependency 'MJRefresh', '~> 2.2.1'
end
