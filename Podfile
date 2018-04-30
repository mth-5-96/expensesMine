# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'expensesMine' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for expensesMine
  pod 'RealmSwift', '~> 3.5'
  pod 'RxSwift', '~> 4.1'
  pod 'RxCocoa', '~> 4.1'
  pod 'Eureka', '~> 4.1'
  pod 'FontAwesome.swift', '~> 1.3'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
    end
  end
end  
