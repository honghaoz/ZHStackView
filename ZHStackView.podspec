Pod::Spec.new do |s|
  s.name         = "ZHStackView"
  s.version      = "0.0.1"
  s.summary      = "A simple container view that can hold any UIViews and stack them vertically"
  s.homepage     = "https://github.com/honghaoz/" + s.name
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Honghao Zhang" => "honghao.zhang@uwaterloo.ca" }
  s.source       = {
    :git => "https://github.com/honghaoz/" + s.name + ".git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'ZHStackView/*.swift'
  
  s.framework  = 'Foundation', 'UIKit'

end
