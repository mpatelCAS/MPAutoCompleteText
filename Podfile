# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'MPAutoComplete' do
    
    pod 'AFNetworking', '~> 3.0'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'  ## or '3.0'
            end
        end
    end
end
