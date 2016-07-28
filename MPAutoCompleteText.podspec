Pod::Spec.new do |s|
  s.name             = 'MPAutoCompleteText'
  s.version          = '0.1.0'
  s.summary          = 'Repository for Autocomplete Textfield from API, Coredata as well Json response you can manage it'
  s.description      = 'A framework which provides text field suggestions as a dropdown list. It is available with iOS 8 and later, Objective-C or Swift.'
  s.homepage         = 'https://github.com/mpatelCAS/MPAutoCompleteText'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mpatel' => 'mpatel@customapps.in' }
  s.source           = { :git => 'https://github.com/mpatelCAS/MPAutoCompleteText.git', :tag => '0.1.0'}
  s.platform         = :ios, '8.0'
  s.source_files     = 'MPAutoCompleteData/*'
  s.dependency 'AFNetworking', '~> 3.0'
end