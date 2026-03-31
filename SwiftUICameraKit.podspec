Pod::Spec.new do |s|
    s.name                  = 'SwiftUICameraKit'
    s.summary               = 'Significantly reduces implementation time and effort. Keeps your code clean.'
    s.description           = <<-DESC
    Camera made simple. The ultimate camera library that significantly reduces implementation time and effort. Written with and for SwiftUI.
                            DESC

    s.version               = '3.0.1'
    s.ios.deployment_target = '14.0'
    s.swift_version         = '6.0'

    s.source_files          = 'Sources/**/*.{swift}'
    s.resources             = 'Sources/Internal/Assets/*.{xcassets, json}'
    s.dependency            'MijickTimer'
    s.frameworks            = 'SwiftUI', 'Foundation', 'AVKit', 'AVFoundation', 'MijickTimer'

    s.homepage              = 'https://github.com/Wonky-Wombat/SwiftUICameraKit'
    s.license               = { :type => 'Apache License 2.0', :file => 'LICENSE' }
    s.author                = { 'Wonky-Wombat' => '55361670+Wonky-Wombat@users.noreply.github.com' }
    s.source                = { :git => 'https://github.com/Wonky-Wombat/SwiftUICameraKit.git', :tag => s.version.to_s }
end
