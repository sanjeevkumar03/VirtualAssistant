
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
    spec.dependency 'CocoaAsyncSocket'
    spec.dependency 'CocoaLumberjack'
    spec.dependency 'KissXML'
    spec.dependency 'libidn'
    spec.dependency 'XMPPFramework'
    spec.dependency 'MBProgressHUD'
    spec.dependency 'Alamofire'
    spec.dependency 'AlamofireImage'
    # 8
    spec.source_files  = "VirtualAssistant/**/*.{h,m,swift}"
    # 9
    #spec.resources = "VirtualAssistant/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

    # 10
    spec.swift_version = "4.2"
    
    end
