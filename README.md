<h3 align="center">
	<img src="http://onekilopars.ec/s/1kpcAstroComponents.png" width="100%" />
</h3>
<p align="center">
<b>SwiftAA</b> &bull;
<a href="https://github.com/onekiloparsec/QLFits">QLFits</a> &bull;
<a href="https://github.com/onekiloparsec/FITSImporter">FITSImporter</a> &bull; 
<a href="https://github.com/onekiloparsec/ObjCFITSIO">ObjCFITSIO</a> 
</p>

SwiftAA
============

![](https://img.shields.io/badge/Swift-3.0-blue.svg?style=flat)
![](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![](https://img.shields.io/badge/platform-osx-lightgrey.svg)
![](https://img.shields.io/badge/licence-MIT-blue.svg)
[![Travis](https://img.shields.io/travis/onekiloparsec/SwiftAA.svg)](https://travis-ci.org/onekiloparsec/SwiftAA/)
[![Codecov](https://img.shields.io/codecov/c/github/onekiloparsec/SwiftAA.svg)](https://codecov.io/gh/onekiloparsec/SwiftAA)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/onekiloparsec/SwiftAA)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fonekiloparsec%2FSwiftAA.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fonekiloparsec%2FSwiftAA?ref=badge_shield)
![](https://img.shields.io/cocoapods/v/SwiftAA.svg)
[![SayThanks](https://img.shields.io/badge/SayThanks.io-%E2%98%BC-1EAEDB.svg)](https://saythanks.io/to/onekiloparsec)

*The most comprehensive collection of accurate astronomical algorithms, in C++, Objective-C and Swift, all in one place.* 

SwiftAA provides everything you need to build our Solar System, compute length of seasons, moon phases, determine rise, transit and set times, get positions of large planetary moons, transform coordinates, determine physical details of planets, their illumination, distance etc. With a professional-grade accuracy.

**SwiftAA is already used in production apps.** In particular, 
[MeteorActive](https://itunes.apple.com/us/app/meteoractive/id1205712190?mt=8), a carefully crafted iOS app to get
everything about meteors.

SwiftAA is first built with an Objective-C(++) layer atop the C++ implementation by P.J. Naughter of the reference textbook
*Astronomical Algorithms*, by Jean Meeus (2nd ed., [Amazon](https://www.amazon.com/Astronomical-Algorithms-Jean-Meeus/dp/0943396611/ref=sr_1_1?ie=UTF8&qid=1506016222&sr=8-1&keywords=astronomical+algorithms+jean+meeus)). This C++ package is called **AA+** (see below). AA+ also includes additional algorithms of the
[VSOP87](https://en.wikipedia.org/wiki/VSOP_(planets)) framework, and includes the complete support for the ELP/MPP02 theory. 
Thus, SwiftAA, thanks to AA+, is the most complete and accurate collection of algorithms for all things astronomical in Swift.
Ongoing development is using AA+ version 1.91 (released August 1st, 2017). 

But **SwiftAA provides more modern and a lot more readable APIs**, taking advantage of the expressiveness of Swift and its various syntax elements, making it fun and easy of use. In fact, you simply can't use AA+ without having the AA book. While SwiftAA is precisely made to be accessible by anyone. Additional functions and algorithms are added to improve even more  the completeness and ease of use. In particular, **SwiftAA provides units safety** a lot stronger compared to C++ APIs. 

Moreover, **SwiftAA has a much larger unit tests coverage** (>90% for the Swift code!). In fact, unit tests are being carefully written with data directly taken from Jean Meeus' textbook, AA+ own tests, [USNO](http://www.usno.navy.mil), [SkySafari](https://skysafariastronomy.com) and [Xephem](http://www.clearskyinstitute.com/xephem/) (and thus trying to achieve a probably hypothetical consistency between these sources).


Documentation
=======

The documentation generated from the code itself is available at [http://onekiloparsec.github.io/SwiftAA](http://onekiloparsec.github.io/SwiftAA).



Installation
============

Using [Carthage](https://github.com/Carthage/Carthage): add `github "onekiloparsec/SwiftAA"` to your `Cartfile`, then run `carthage update`, and finally add the newly built `SwiftAA.framework` into your project (in `embedded binaries`).

Using [CocoaPods](http://cocoapods.org/): add `pod 'SwiftAA'` to your `Podfile` and then run `pod update`. 



Notes
============

AA+
---
The AA+ framework, written in C++ by PJ Naughter (Visual C++ MVP) is certainly the best and most complete implementation of the "Astronomical Algorithms", found in the reference textbook by Jean Meeus. To make the most of this code specifically, you have to have a copy of the book with you (APIs and method names are hardly understandable without knowing what they refer to).

Pull requests are accepted only about the Objective-C(++) and Swift code. The AA+ code changes must be directed (as I will personnaly do if I need to) to the original source (see the [AA+ website](http://www.naughter.com/aa.html)).


Caution on Coordinates
-----

The coordinates computations are key for modern astronomy. However, there is no mention to modern conventions (like ICRS) in the textbook of Jean Meeus, therefore in the AA+ code. Awaiting for such improvement, any user wanting to compute coordinates transformations should be careful. For a good example of a complete implementation of such transformations, see the 
[AstroPy excellent package](http://docs.astropy.org/en/stable/coordinates/index.html).


Prefixes & Conventions
----

Needless to say how different the syntax is between C, C++, Objective-C and Swift. The main guideline in writting SwiftAA was to build an Objective-C(++) layer that follow *strictly* the methods and interfaces of the underlying C++ library. Only the name of some variables were a bit "Objective-C-fied" (to avoid prefix them with the one-letter type, 'b' for boolean etc').

As Objective-C lacks namespaces, everything must be prefixed. It is a convention to use 3-letters prefixes in Objective-C. KPC stands for "kiloparsec" and is "my" usual prefix. I chose to keep the AA prefix that belongs to the C++ library as well. Hence the (rather long) 5-letters *KPCAA* prefix of all methods.

The constraint of having an Objective-C layer first comes from the fact that no C++ code can be written directly alongside Swift code (in the same file). And Swift doesn't have the header/implementation split into different files. Hence one must write a Objective-C++/C wrapper around it, with name prefixes.

Author
======
Cédric Foellmi, a.k.a. **[@onekiloparsec](https://twitter.com/onekiloparsec)** ([website](https://onekilopars.ec)). <br/>
(Ph.D. in astrophysics, and former *support astronomer* at the [European Southern Observatory](http://www.eso.org) in Chile). <br/> I am the author of the app iObserve (for [macOS](http://onekilopars.ec/apps#iobserve) and [iOS/iPad](http://www.onekilopars.ec/apps/#iobserve-touch)) and [arcsecond.io](https://www.arcsecond.io).



Licence
=======

The licence of this software is the [MIT](http://opensource.org/licenses/MIT) licence, which allows you to use it freely in open-source or commercial products. But it does not apply to the AA+ Framework, which retains its own licence. Quoting the [original](http://www.naughter.com/aa.html):

**AA+ Copyright :** 

* You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) when your product is released in binary form.
* You are allowed to modify the source code in any way you want except you cannot modify the copyright details at the top of each module.
* If you want to distribute source code with your application, then you are only allowed to distribute versions released by the author. This is to maintain a single distribution point for the source code.

## FOSSA

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fonekiloparsec%2FSwiftAA.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fonekiloparsec%2FSwiftAA?ref=badge_large)
