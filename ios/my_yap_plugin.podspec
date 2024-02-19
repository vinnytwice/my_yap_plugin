#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint my_yap_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'my_yap_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '15.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.dependency 'Firebase/CoreOnly', '10.9.0' # possible breaking pod!!
  s.dependency 'Firebase/Analytics', '10.9.0' 
  s.dependency 'Firebase/Auth', '10.9.0'

  s.dependency 'Firebase/Crashlytics', '10.9.0'

 
  s.dependency 'MBProgressHUD', '1.2.0'
  s.dependency 'PanModal', '1.2.7'
  s.dependency 'TouchDraw', '2.1.2'
  s.dependency 'MaterialComponents/Snackbar', '122.0.1'
  s.dependency 'MaterialComponents/TextFields', '122.0.1'
  s.dependency 'MaterialComponents/TextFields+Theming', '122.0.1'
  s.dependency 'MaterialComponents/Cards', '122.0.1'
  s.dependency 'MaterialComponents/BottomNavigation', '122.0.1'
  s.dependency 'MaterialComponents/Chips', '122.0.1'
  s.dependency 'MaterialComponents/Chips+Theming', '122.0.1'
  s.dependency 'MaterialComponents/Tabs+TabBarView', '122.0.1'
  s.dependency 'MaterialComponents/Buttons', '122.0.1'
  s.dependency 'IGListKit', '4.0.0'
  s.dependency 'SwiftRichString', '3.7.2'
  s.dependency 'YPImagePicker', '5.2.2'
end
