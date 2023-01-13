Pod::Spec.new do |s|

  s.name         = "ObjCAA"
  s.version      = "2.4.0"
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
  s.ios.deployment_target = "12.0"
  s.osx.deployment_target = "10.13"
  s.watchos.deployment_target = "6.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/onekiloparsec/SwiftAA.git", :tag => "#{s.version}" }

  s.framework    = "Foundation"
  s.swift_version = "5"

  s.name          = "ObjCAA"
  s.source_files  = "Sources/ObjCAA", "Sources/ObjCAA/**/*.{h,cpp}", "Sources/aaplus-v2.44", "Sources/aaplus-v2.44/**/*.{h,cpp}"
  s.public_header_files = "Sources/ObjCAA/include/*.h"
  s.exclude_files = "Sources/aaplus-v2.44/AATest.cpp", "Sources/aaplus-v2.44/include/AAVSOP2013.h", "Sources/aaplus-v2.44/AAVSOP2013.cpp"
  
  s.library = 'c++'
  s.xcconfig = {
       'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
       'CLANG_CXX_LIBRARY' => 'libc++'
  }

end
