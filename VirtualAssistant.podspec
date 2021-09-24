
Pod::Spec.new do |spec|
    # 1
    spec.platform = :ios
    spec.ios.deployment_target = '13.0'
    spec.name         = "VirtualAssistant"
    spec.summary      = "VirtualAssistant framework written in swift."

    spec.description  = <<-DESC
    This library helps in in resolving queries by chatting with virtual assistant and live agents.
                        DESC
    # 2
    spec.version      = "0.0.1"
    # 3
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    # 4
    spec.author       = { "sanjeevkumar03" => "sanjeev.kumar03@telusinternational.com" }
    # 5
    spec.homepage = "https://github.com/sanjeevkumar03/VirtualAssistant"
    # 6
    spec.source = { :git => "https://github.com/sanjeevkumar03/VirtualAssistant.git",
             :tag => "#{spec.version}" }
             
    # 7
    spec.framework = "UIKit"
    spec.dependency 'CocoaAsyncSocket', '~> 7.6.5'
    spec.dependency 'CocoaLumberjack', '~> 3.7.0'
    spec.dependency 'KissXML', '~> 5.3.1'
    spec.dependency 'libidn', '~> 1.35'
    spec.dependency 'XMPPFramework', '~> 4.0.0'
    spec.dependency 'MBProgressHUD', '~> 1.2.0'
    spec.dependency 'Alamofire'
    spec.dependency 'AlamofireImage'
    # 8
    spec.source_files  = "TIChatBot/**/*.{h,m,swift}"
    #spec.source_files = '**/Classes/**/*.{h,m,swift}'
    # 9
    spec.resources = "TIChatBot/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
    #spec.resources = "**/Classes/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

    # 10
    spec.swift_version = "4.2"
    
    end
