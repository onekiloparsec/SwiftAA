Pod::Spec.new do |s|

  s.name         = "SwiftAA"
  s.version      = "2.1.0"
  s.summary      = "The most comprehensive and accurate collection of astronomical algorithms in Swift."

  s.description  = <<-DESC
SwiftAA aims to provide the most comprehensive collection of accurate astronomical algorithms in Swift.
That is, based on the reference textbook "Astronomical Algorithms" by Jean Meeus, SwiftAA provides modern
APIs about all things astronomical. It is based on the C++ layer developed since many years by J.P. Naughter.
SwiftAA is built upon this C++ layer, with an intermediate Objectice-C layer (respecting strictly the lower APIs),
on top of which modern and expressive API is crafted. It is also a lote more covered by Unit Tests, in order
to become the most reliable source of astronomical computations.
                   DESC

  s.homepage     = "https://www.onekiloparsec.dev/swiftaa"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  #s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "onekiloparsec (a.k.a. Cédric Foellmi)" => "cedric@onekiloparsec.dev" }
  # Or just: s.author    = "Cédric"
  # s.authors            = { "Cédric" => "cedric@onekiloparsec.dev" }
  s.social_media_url   = "http://twitter.com/onekiloparsec"

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = "10.11"
  s.watchos.deployment_target = "5.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/onekiloparsec/SwiftAA.git", :tag => "#{s.version}" }

  s.source_files  = "SwiftAA", "SwiftAA/**/*.{h,m,mm,swift}", "ObjCAA", "ObjCAA/**/*.{h,m,mm,swift}", "aaplus-*", "aaplus-*/**/*.{h,cpp}"
  s.exclude_files = "aaplus-*/AATest.cpp", "SwiftAA/main.swift"

  s.public_header_files = "SwiftAA/**/*.h", "ObjCAA/**/*.h"

  s.framework  = "Foundation"
  s.swift_version = "5"

end
