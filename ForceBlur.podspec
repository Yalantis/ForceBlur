Pod::Spec.new do |s|

  s.name             = "ForceBlur"
  s.version          = "1.0"
  s.summary          = "This component allows you to blur sensitive images and can be used for messaging in public places"

  s.homepage         = "https://github.com/Yalantis/ForceBlur"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "Yalantis"
  s.social_media_url = "http://twitter.com/yalantis"
  
  s.platform         = :ios, "9.0"
  s.source           = { :git => "https://github.com/Yalantis/ForceBlur.git", :tag => s.version }
  s.default_subspec  = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "ForceBlur/Classes/**/*.{swift}", "ForceBlur/Vendor/**/*.{swift}"
  end

  s.subspec "JSQMessagesViewController" do |ss|
    ss.source_files  = "ForceBlur/JSQMessagesViewController/*.swift"
    ss.dependency "ForceBlur/Core"
    ss.dependency "JSQMessagesViewController", "~> 7.0"
  end

end
