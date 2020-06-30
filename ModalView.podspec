Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "ModalView"
  s.version      = "0.0.1"
  s.summary      = "Simple modal navigation for swiftUI"

  s.description  = "Modal navigation for swiftUI. For usage details visit source page."

  s.homepage     = "https://github.com/HereTrix/ModalView"

  s.license      = "MIT"

  s.author       = "HereTrix"

  s.platform     = :ios, "13.0"

  s.swift_version = '5.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  s.source       = { :git => "https://github.com/HereTrix/ModalView.git", :tag => 'v0.0.1'}

  s.source_files  = "Classes", "Sources/ModalView/*.{swift}"
end
