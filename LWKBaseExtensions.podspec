#
# Be sure to run `pod lib lint LWKBaseExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LWKBaseExtensions'
  s.version          = '1.0.0'
  s.summary          = '万能输入法的键盘基础扩展库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
LWKBaseExtensions，万能输入法键盘的基础扩展库.
                       DESC

  s.homepage         = 'https://github.com/luowei/LWKBaseExtensions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luowei' => 'luowei@wodedata.com' }
  s.source           = { :git => 'https://github.com/luowei/LWKBaseExtensions.git'}
  # s.source           = { :git => 'https://gitlab.com/ioslibraries1/lwkbaseextensions.git' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LWKBaseExtensions/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LWKBaseExtensions' => ['LWKBaseExtensions/Assets/*.png']
  # }

  s.public_header_files = 'LWKBaseExtensions/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
