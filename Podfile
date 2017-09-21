# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'expensesMine' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for expensesMine
  pod 'RealmSwift'
  pod 'RxSwift', '~> 3.0'
  pod 'RxCocoa', '~> 3.0'
  # pod 'Eureka', '~> 3.0'
  pod 'Eureka', :git => 'https://github.com/xmartlabs/Eureka.git', :branch => 'feature/Xcode9-Swift4'
  pod 'FontAwesome.swift'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = target.name == 'Eureka' ? '4.0' : '3.2'
    end
  end
end  
