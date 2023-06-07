# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'testVideoGallery' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SnapKit', '~> 5.6.0'
  pod 'Alamofire', '~> 5.2'
  pod 'SwiftyJSON', '4.3.0'
  pod 'HydraAsync', '2.0.6'
  pod 'SDWebImage', '5.10.3'
  pod 'PromisesSwift'
  pod 'Logging'

  # Pods for testVideoGallery

end

post_install do |installer|
  installer.generated_projects.each do |proj|
    proj.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
  end
end
