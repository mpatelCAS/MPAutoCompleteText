Pod::Spec.new do |s|
  s.name             = 'MPAutoCompleteText'
  s.version          = '1.3'
  s.summary          = 'Repository for Autocomplete Textfield from API, Coredata as well Json response you can manage it'
  s.description      = 'A framework which provides text field suggestions as a dropdown list. It is available with iOS 8 and later, Objective-C or Swift.'
  s.homepage         = 'https://github.com/mpatelCAS/MPAutoCompleteText'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mpatel' => 'mpatel@customapps.in' }
  s.source           = { :git => 'https://github.com/mpatelCAS/MPAutoCompleteText.git',:tag => s.version.to_s }
  s.source_files     = "AutoCompletion.framework/Headers/*.h",'MPAutoCompleteData/*.{h,m}' , 'MPAutoCompleteData/**/*.{h,m}', 'MPAutoCompleteData/**/**/*.{h,m}'
  s.dependency 'AFNetworking', '~> 3.0'

  s.ios.frameworks = ["CoreData"]
  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'AutoCompletion.framework'
end
