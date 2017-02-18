Pod::Spec.new do |s|

  s.name         = "SwiftAA"
  s.version      = "2.0-alpha2"
  s.summary      = "The most comprehensive and accurate collection of astronomical algorithms in Swift."

  s.description  = <<-DESC
SwiftAA aims to provide the most comprehensive and accurate collection of astronomical algorithms in Swift.
That is, based on the reference textbook "Astronomical Algorithms" by Jean Meeus, SwiftAA provides modern
APIs about all things astronomical. It is based on the C++ layer developed since many years by J.P. Naughter.
SwiftAA is built upon this C++ layer, with an intermediate Objectice-C layer (respecting strictly the lower APIs),
on top of which modern and expressive API is crafted. It also intends to be largely covered by Unit Tests, in order
to become the most reliable source of astronomical computations.
                   DESC

  s.homepage     = "https://www.onekilopars.ec/swiftaa"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  #s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "MIT-LICENSE.txt" }


  s.author             = { "onekiloparsec (a.k.a. Cédric Foellmi)" => "cedric@onekilopars.ec" }
  # Or just: s.author    = "Cédric"
  # s.authors            = { "Cédric" => "cedric@onekilopars.ec" }
  s.social_media_url   = "http://twitter.com/onekiloparsec"

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/onekiloparsec/SwiftAA.git", :tag => "#{s.version}" }

  s.source_files  = "SwiftAA", "SwiftAA/**/*.{h,m,mm,swift}", "aaplus-*", "aaplus-*/**/*.{h,cpp}"
  s.exclude_files = "aaplus-*/AATest.cpp", "SwiftAA/main.swift"

  s.public_header_files = "SwiftAA/**/*.h"


  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  s.framework  = "Foundation"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
