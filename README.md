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
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/onekiloparsec/SwiftAA)
![](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![](https://img.shields.io/badge/platform-osx-lightgrey.svg)
![](https://img.shields.io/badge/licence-MIT-blue.svg)

*The most comprehensive and accurate collection of astronomical algorithms written in Swift3.*

Using AA+ version 1.71 (released 28 April 2016)

SwiftAA is first built with an Objective-C(++) layer atop the C++ implementation of Astronomical Algorithms (see below).
These algorithms also make use of the VSOP87 framework making it the most complete and accurate collection of algorithms for all things astronomical.

On top of this, SwiftAA provides *modern APIs* taking advantage of the expressiveness of Swift and its various modern
syntax elements, making it fun and easy of use. Additional functions and algorithms are added to improve even more 
completeness and ease of use. Moreover, SwiftAA intends to provide a much improved unit tests coverage.

Finally, a Swift Playground is being written and made available for distribution. This playground could easily be used
**for educational purposes**, especially in the [Swift coding app on iPad](https://www.apple.com/swift/playgrounds/) coming with iOS10.
With SwiftAA, teachers and educators could easily propose exercices and fun little computations on stars, sun, moon, 
planets, seasons, coordinates etc.


Licence
=======

The licence of this software is the [MIT](http://opensource.org/licenses/MIT) licence. But it does not apply to the AA+ Framework,
which retains its own licence. Quoting the [original](http://www.naughter.com/aa.html):

**AA+ Copyright :** 

* You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) when your product is released in binary form.
* You are allowed to modify the source code in any way you want except you cannot modify the copyright details at the top of each module.
* If you want to distribute source code with your application, then you are only allowed to distribute versions released by the author. This is to maintain a single distribution point for the source code.

Introduction
============

The AA+ framework, written in C++ by PJ Naughter (Visual C++ MVP) is certainly the best and most complete implementation of the
"Astronomical Algorithms", by Jean Meeus (purchasable from [Amazon](http://www.amazon.com/exec/obidos/tg/detail/-/0943396611/103-5742735-0567011)).
To make the most of this code, you'd rather have a copy of the book with you.

As the author of the app iObserve (for [Mac](http://onekilopars.ec/apps#iobserve) and [iPad](http://www.onekilopars.ec/apps/#iobserve-touch)), I have
myself worked a lot on implementing some of the AA algorithms for my needs. However, to push iObserve to the next level,
I need to put a lot more work on these algorithms. And it is pointless (as well as very hard) to reach the fantastic level and quality the AA+ framework
has already reached, after years of development and tests. Moreover, AA+ make use of the VSOP87 framework, hence making it
the most complete and accurate collection of astronomical algorithms available.

P.J. Naughter has kindly agreed to let me create a public repo with his code. My intention is to write a wrapper around it,
to bring the AA+ framework to Apple's Swift realm (and Objective-C along the way). Pull requests will be accepted (if by any chance
it happens) only about the Objective-C and Swift code. The AA+ code changes must be directed (as I will personnaly do if I need to)
to the original source (see the [AA+ website](http://www.naughter.com/aa.html)).

One thing however that AA+ lacks are modern unit tests. The available tests do not assert anything, and appears only
to print out some values to be checked by eye. This is human-readable, hence error prone. Here, we intend to provide
such unit testing, all on top of the Swift layer.


Notes and Conventions
=====================

Needless to say how different the syntax is between C, C++, Objective-C and Swift. The main guideline in writting SwiftAA
is to build an Objective-C(++) layer that follow *strictly* the methods and interfaces of the underlying
C++ library. Only the name of some variables were a bit "Objective-C-fied" (to avoid prefix them with the one-letter type, 
'b' for boolean etc').

As Objective-C lacks namespaces, everything must be prefixed. It is a convention to use 3-letters prefixes in
Objective-C. KPC stands for "kiloparsec"... and is "my" usual prefix. I chose to keep the AA prefix that belongs to the C++
library as well. Hence the (rather long) 5-letters *KPCAA* prefix of all methods.

These naming constraints come from the fact that no C++ code can be written directly alongside Swift code (in the same file). 
And Swift doesn't have the header/implementation split into different files. Hence one must write a Objective-C++/C wrapper
around it, with name prefixes.

The first version of SwiftAA (tags 1.0+) was written with NSObject class methods, which is probably no more efficient 
that pure C-functions. It just happened that I wrote this with objects. However, it *is* totally inefficient to allocate 
thousands of coordinates instances one might need for plotting/storing some curves. Hence, I decided to remove 
KPCAA2DCoordinates and KPCAA3DCoordinates classes, and move from Objective-C class methods to pure C-functions wrappers 
and structs, everywhere it was possible. The most notable exception is KPCAADate which remains an NSObject subclass.

Upon completion, this new version will be tagged 2.0+. It will contain the AA+ v1.71 or later (with the new 
[VSOP](https://en.wikipedia.org/wiki/VSOP_(planets)) implementation!). The tagged versions 1.0+ will remain as such, 
with AA+ v1.60.
