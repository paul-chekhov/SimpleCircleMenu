Pod::Spec.new do |s|
    s.name             = 'SimpleCircleMenu'
    s.version          = '1.0.3'
    s.summary          = 'Simple circle menu for iOS developers'
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/pavel-chehov/SimpleCircleMenu.git'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Pavel Chehov' => 'pavel.chehov.personal@gmail.com' }
    s.source           = { :git => 'https://github.com/pavel-chehov/SimpleCircleMenu.git', :tag => s.version.to_s }
    s.social_media_url = 'https://www.facebook.com/pavel.chehov.9'
    
    s.ios.deployment_target = '11.0'
    
    s.source_files = 'SimpleCircleMenu/Classes/*.swift'
    s.ios.deployment_target = '11.0'
    s.swift_version = '4.2'
    
    s.resource_bundles = {
        'SimpleCircleMenu' => ['SimpleCircleMenu/Assets/*.json']
    }
    
    s.dependency 'lottie-ios'
    s.dependency 'PromiseKit', '~> 6.0'
end
