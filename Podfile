# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
workspace 'BazilPapers'

def external_pods
  pod 'Alamofire', '~> 5.0.0-rc.3'
  pod 'AlamofireNetworkActivityLogger'
  pod 'Firebase/Analytics'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
  pod 'FirebaseUI/Storage'
  pod 'SwiftyStoreKit'
  pod 'SVProgressHUD'
  pod 'NewPopMenu'
  pod 'Google-Mobile-Ads-SDK'
end

target 'BazilPapers' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BazilPapers
  external_pods

  target 'BazilPapersTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BazilPapersUITests' do
    # Pods for testing
  end

end
