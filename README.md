<h3 align="center">
	<img src="http://onekilopars.ec/s/1kpcAstroComponents.png" width="100%" />
</h3>
<p align="center">
<a href="https://github.com/onekiloparsec/arcsecond.io">arcsecond.io</a> (backend) &bull;
<a href="https://github.com/onekiloparsec/arcsecond.swift">arcsecond.swift</a> (Swift SDK) &bull;
<a href="https://github.com/onekiloparsec/arcsecond.js">arcsecond.js</a> (JavaScript SDK) &bull; <br/>
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
[![SayThanks](https://img.shields.io/badge/SayThanks.io-%E2%98%BC-1EAEDB.svg)](https://saythanks.io/to/onekiloparsec)
[![Travis](https://img.shields.io/travis/onekiloparsec/SwiftAA.svg)](https://travis-ci.org/onekiloparsec/SwiftAA/)
[![Codecov](https://img.shields.io/codecov/c/github/onekiloparsec/SwiftAA.svg)](https://codecov.io/gh/onekiloparsec/SwiftAA)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/onekiloparsec/SwiftAA)
![](https://img.shields.io/cocoapods/v/SwiftAA.svg)

*The most comprehensive and accurate collection of astronomical algorithms, in C++, Objective-C and Swift3, all in one place.*

Ongoing development is written in Swift3 and using AA+ version 1.76 (released February 12th, 2017). It will soon reach
version 2.0. But it is already usable (and used) in production apps. 

SwiftAA is first built with an Objective-C(++) layer atop the C++ implementation of Astronomical Algorithms (see below).
These algorithms also make use of the [VSOP87](https://en.wikipedia.org/wiki/VSOP_(planets)) framework making it the
most complete and accurate collection of algorithms for all things astronomical.

On top of this, SwiftAA provides **modern APIs** taking advantage of the expressiveness of Swift and its various modern
syntax elements, making it fun and easy of use. Additional functions and algorithms are added to improve even more 
completeness and ease of use. In particular, SwiftAA provides **units safety** a lot stronger than C++ APIs. 

Moreover, SwiftAA intends to provide a much improved unit tests coverage. The target is about 50% of code coverage
for the milestone 2.0.


Documentation
=======

The documentation generated from the code itself is available at [http://onekiloparsec.github.io/SwiftAA](http://onekiloparsec.github.io/SwiftAA).


Licence
=======

The licence of this software is the [MIT](http://opensource.org/licenses/MIT) licence. But it does not apply to the AA+ Framework,
which retains its own licence. Quoting the [original](http://www.naughter.com/aa.html):

**AA+ Copyright :** 

* You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) when your product is released in binary form.
* You are allowed to modify the source code in any way you want except you cannot modify the copyright details at the top of each module.
* If you want to distribute source code with your application, then you are only allowed to distribute versions released by the author. This is to maintain a single distribution point for the source code.


Installation
============

Using [Carthage](https://github.com/Carthage/Carthage): add `github "onekiloparsec/SwiftAA"` to your `Cartfile` and then run `carthage update`.

Using [CocoaPods](http://cocoapods.org/): add `pod 'SwiftAA'` to your `Podfile` and then run `pod update`. 



Introduction
============

The AA+ framework, written in C++ by PJ Naughter (Visual C++ MVP) is certainly the best and most complete implementation of the
"Astronomical Algorithms", found in the reference textbook by Jean Meeus 
(purchasable from [Amazon](http://www.amazon.com/exec/obidos/tg/detail/-/0943396611/103-5742735-0567011)).
To make the most of this code, you'd rather have a copy of the book with you.

As the author of the app iObserve (for [Mac](http://onekilopars.ec/apps#iobserve) and [iPad](http://www.onekilopars.ec/apps/#iobserve-touch)), I have
myself worked a lot on implementing some of the AA algorithms for my needs. However, to push iObserve to the next level,
I need to put a lot more work on these algorithms. 

P.J. Naughter has kindly agreed to let me create a public repo with his code. My intention is to write a wrapper around it,
to bring the AA+ framework to Apple's Swift realm (and Objective-C along the way). Pull requests will be accepted 
only about the Objective-C and Swift code. The AA+ code changes must be directed (as I will personnaly do if I need to)
to the original source (see the [AA+ website](http://www.naughter.com/aa.html)).


Caution
========

The coordinates computations are key for modern astronomy. However, there is no mention to modern conventions (like ICRS) in the
textbook of Jean Meeus, therefore in the AA+ code. Awaiting for such improvement, any user wanting to compute coordinates transformations
should be careful. For a good example of a complete implementation of such transformations, see the 
[AstroPy excellent package](http://docs.astropy.org/en/stable/coordinates/index.html).

The implementation of modern convention for coordinates, as in AstroPy, is planned for v2.1.


Notes and Conventions
=====================

Needless to say how different the syntax is between C, C++, Objective-C and Swift. The main guideline in writting SwiftAA
is to build an Objective-C(++) layer that follow *strictly* the methods and interfaces of the underlying
C++ library. Only the name of some variables were a bit "Objective-C-fied" (to avoid prefix them with the one-letter type, 
'b' for boolean etc').

As Objective-C lacks namespaces, everything must be prefixed. It is a convention to use 3-letters prefixes in
Objective-C. KPC stands for "kiloparsec" and is "my" usual prefix. I chose to keep the AA prefix that belongs to the C++
library as well. Hence the (rather long) 5-letters *KPCAA* prefix of all methods.

These constraints come from the fact that no C++ code can be written directly alongside Swift code (in the same file). 
And Swift doesn't have the header/implementation split into different files. Hence one must write a Objective-C++/C wrapper
around it, with name prefixes.

Author
======
Cédric Foellmi, a.k.a. **[@onekiloparsec](https://twitter.com/onekiloparsec)** ([website](https://onekilopars.ec)). <br/>
(Ph.D. in astrophysics, and former *support astronomer* at the [European Southern Observatory](http://www.eso.org) in Chile).
