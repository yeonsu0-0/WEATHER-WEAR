# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Weather-Wear' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Weather-Wear
  pod 'KakaoSDKAuth'
  pod 'KakaoSDKUser'
  pod 'KakaoSDKCommon'
pod "YoutubePlayer-in-WKWebView", "~> 0.3.0"
post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
  end

end
