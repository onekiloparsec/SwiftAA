Pod::Spec.new do |s|

  s.name         = "ObjCAA"
  s.version      = "2.3.0"
  s.summary      = "The most comprehensive and accurate collection of astronomical algorithms in Objective-C."

  s.description  = <<-DESC
ObjCAA aims to provide the most comprehensive collection of accurate astronomical algorithms in Objective-C.
That is, based on the reference textbook "Astronomical Algorithms" by Jean Meeus, ObjCAA provides modern
APIs about all things astronomical. It is based on the C++ layer developed since many years by J.P. Naughter.
ObjCAA is built upon this C++ layer (respecting strictly the lower APIs). It is the base upon which SwiftAA
is crafted.
                   DESC

  s.homepage     = "https://www.onekiloparsec.dev/SwiftAA"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "onekiloparsec (a.k.a. Cédric Foellmi)" => "cedric@onekiloparsec.dev" }
  s.social_media_url   = "http://twitter.com/onekiloparsec"

  #  When using multiple platforms
  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = "10.11"
  s.watchos.deployment_target = "5.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/onekiloparsec/SwiftAA.git", :tag => "#{s.version}" }

  s.framework    = "Foundation"
  s.swift_version = "5"

  s.name          = "ObjCAA"
  s.source_files  = "Sources/ObjCAA", "Sources/ObjCAA/**/*.{h,cpp}", "Sources/aaplus-v2.08", "Sources/aaplus-v2.08/**/*.{h,cpp}"
  s.public_header_files = "Sources/ObjCAA/include/*.h"
  s.exclude_files = "Sources/aaplus-v2.08/AATest.cpp"

end
