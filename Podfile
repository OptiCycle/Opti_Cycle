# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'OptiCycle' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OptiCycle
pod 'Parse'
pod 'AlamofireImage'
pod 'TensorFlowLiteSwift'
pod 'lottie-ios'
pod 'MBCircularProgressBar'

  target 'OptiCycleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OptiCycleUITests' do
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end

end
