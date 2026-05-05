# Uncomment the next line to define a global platform for your project
# platform :ios, '15.6'

target 'Speedo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Speedo
pod 'IQKeyboardManagerSwift'
pod 'Alamofire', '~> 4.9.1'
pod 'SDWebImage/WebP'
pod 'DropDown'
pod 'Cosmos'
#pod 'R.swift'
pod 'SkeletonView'
pod 'SlideMenuControllerSwift'
pod 'CountryPickerView'
pod 'SwiftyJSON'

pod 'Firebase/Core'
pod 'Firebase/Messaging'
pod 'Firebase/Storage'

  target 'SpeedoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SpeedoUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    # Fix libarclite_xxx.a file not found.
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
