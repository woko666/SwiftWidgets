Pod::Spec.new do |s|

    s.platform = :ios
    s.ios.deployment_target = '10.0'
    s.name = 'SwiftWidgets'
    s.summary = 'SwiftWidgets is a UIKit widget framework focused on speed of development, reusability and composability.'
    s.version = '1.0.0'
    s.swift_version = '5.0'
    s.license = 'MIT'
    s.author = { 'Woko' => 'github@woko.info' }
    s.homepage = 'https://github.com/woko666/SwiftWidgets'
    s.source = { :git => "https://github.com/woko666/SwiftWidgets.git", :tag => "#{s.version}"}
    s.framework = 'UIKit'
    s.source_files = 'Source/**/*.swift'
    s.resource_bundles = { 'SW' => 'Source/**/*.xcassets' }
    s.frameworks = 'UIKit'
    s.dependency 'SnapKit'
    s.dependency 'Kingfisher'
    s.dependency 'DTCoreText'
    s.dependency 'Nantes'
    
end
