#
# Be sure to run `pod lib lint IDAlertController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "IDAlertController"
  s.version          = "0.1.1"
  s.summary          = "iOS7-safe AlertController"
  s.description      = <<-DESC


                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/i-dama/IDAlertController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Ivan Damjanović" => "ivan.damjanovic@infinum.hr" }
  s.source           = { :git => "https://github.com/i-dama/IDAlertController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/DamaOfficial'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'IDAlertController' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
