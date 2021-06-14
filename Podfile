
platform :ios, '13.0'
inhibit_all_warnings!
use_frameworks!

workspace 'StashChallenge'

def shared_pods
  pod 'PromiseKit', '~> 6.10.0'
  pod 'SDWebImage', '5.2.1'
  pod 'SwiftLint'
end

target 'AGViperKit' do
  project 'AGViperKit/AGViperKit.xcodeproj'
  shared_pods

  target 'AGViperKitTests' do
    inherit! :search_paths
    shared_pods
  end
end

target 'StashChallenge' do
  project 'StashChallenge/StashChallenge.xcodeproj'
  shared_pods

  target 'StashChallengeTests' do
    inherit! :search_paths
    shared_pods
  end
end

target 'StashChallengeSwiftUI' do
  project 'StashChallengeSwiftUI/StashChallengeSwiftUI.xcodeproj'
  shared_pods

  target 'StashChallengeSwiftUITests' do
    inherit! :search_paths
    shared_pods
  end
end

