platform :ios, '9.0'
use_frameworks!


target 'Pokupalshik' do

pod 'SQLite.swift', '~> 0.11'
pod "MIBadgeButton-Swift", :git => 'https://github.com/mustafaibrahim989/MIBadgeButton-Swift.git', :branch => 'master'
pod 'Alamofire', '~> 4.0'
pod 'RxSwift', '~> 3.0'
pod 'RxCocoa', '~> 3.0'
pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift3'



end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end