Pod::Spec.new do |s|
  s.name         = "SimpleColorPicker"
  s.version      = "0.0.1"
  s.summary      = "SimpleColorPicker is color picker for for iOS."

  s.description  = <<-DESC
                   SimpleColorPicker will provide a color picker simple. You can add a color pattern using a plist file. It is possible to prepare a color pattern for each segment by providing a plist files. corresponding iOS7 SDK or later.
                   DESC

  s.homepage     = "https://github.com/notoroid/SimpleColorPicker"
  s.screenshots  = "https://raw.githubusercontent.com/notoroid/SimpleColorPicker/master/Screenshots/ss02.png"


  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "notoroid" => "noto@irimasu.com" }
  s.social_media_url   = "http://twitter.com/notoroid"
  s.platform     = :ios, "7.0"
  
  s.source       = { :git => "https://github.com/notoroid/SimpleColorPicker.git", :tag => "v0.0.1" }

  s.source_files  = "Classes", "Lib/**/*.{h,m}"
  s.public_header_files = "Lib/**/*.h"
  s.requires_arc = true

end
